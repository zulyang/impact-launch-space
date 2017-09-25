package com.impactlaunchspace.pm;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.Writer;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.impactlaunchspace.entity.Card;
import com.impactlaunchspace.entity.Notification;
import com.impactlaunchspace.entity.ProjectMemberList;
import com.impactlaunchspace.entity.ProjectRequestedResource;
import com.impactlaunchspace.notification.NotificationService;
import com.impactlaunchspace.project.ProjectService;

@Controller
public class ProjectManagementController {

	@Autowired
	ProjectService projectService;

	@Autowired
	ProjectManagementService pmService;

	@Autowired
	NotificationService notificationService;

	// Access Project Management Page
	@RequestMapping(value = "/project-management", method = RequestMethod.GET)
	public String projectManagement(@RequestParam("project-name") String project_name,
			@RequestParam("project-proposer") String project_proposer, HttpServletRequest request, ModelMap model)
			throws JSONException {

		// Add a boolean for project to see whether it's started or not. If not
		// started,cannot access projectManagement page
		String username = (String) request.getSession().getAttribute("username");
		// Project selected_project =
		// projectService.retrieveProject(project_name, project_proposer);
		// retrieve board_id for project
		int board_id = pmService.retrieveBoardId(project_name, project_proposer);

		// retrieve cards from database.
		// probably have to split the cards into 3 seperate arrays.

		ArrayList<ProjectMemberList> members = projectService.retrieveMemberList(project_name, project_proposer);
		// Should check and remove the current user

		for (int i = 0; i < members.size(); i++) {
			if (members.get(i).getProject_member_username().equals(username)) {
				members.remove(i);
			}
		}

		ArrayList<ProjectRequestedResource> categories = projectService
				.retrieveAllProjectRequestedResource(project_name, project_proposer);
		ArrayList<String> cat = new ArrayList<String>();

		for (int i = 0; i < categories.size(); i++) {
			cat.add(categories.get(i).getResource_category());
		}

		// add the memberlist for populating the sidebar (WITH THE ADMIN)
		ArrayList<ProjectMemberList> member_list = projectService.retrieveMemberList(project_name, project_proposer);

		ArrayList<String> member_list_string = new ArrayList<String>();

		for (ProjectMemberList member : member_list) {
			member_list_string.add(member.getProject_member_username());
		}
		model.addAttribute("member_list", member_list);
		model.addAttribute("member_list_string", member_list_string);

		model.addAttribute("user", username);
		model.addAttribute("projectName", project_name);
		model.addAttribute("project_proposer", project_proposer);
		model.addAttribute("categories", categories);
		model.addAttribute("members", members);
		model.addAttribute("board_id", board_id);

		// Check the cards attribute and sort by status
		ArrayList<Card> todoList = pmService.retrieveProjectCardsByStatus(board_id, "todo");
		ArrayList<Card> inprogressList = pmService.retrieveProjectCardsByStatus(board_id, "inprogress");
		ArrayList<Card> doneList = pmService.retrieveProjectCardsByStatus(board_id, "done");

		// Check the ordering of the card and display based on ordering.
		model.addAttribute("todoList", todoList);
		model.addAttribute("inprogressList", inprogressList);
		model.addAttribute("doneList", doneList);

		// Upon initializing, display the activity log
		ArrayList<String> activitylog = pmService.retrieveActivityLog(board_id);
		Collections.reverse(activitylog);
		model.addAttribute("activitylog", activitylog);

		// Cards to be displayed on the the calendar
		// Only display cards that have only Start Date and both Start Date and
		// Due Date,

		ArrayList<Card> calendarList = pmService.retrieveProjectCards(board_id);
		JSONArray toReturn = new JSONArray();

		for (int i = 0; i < calendarList.size(); i++) {
			Card c = calendarList.get(i);
			Date sd = c.getStart_date();
			Date dd = c.getDue_date();

			if (sd != null && dd != null) {
				String title = c.getCard_title();
				JSONObject j = new JSONObject();
				j.put("title", title);
				j.put("start", sd);
				j.put("end", dd);
				toReturn.put(j);
			}

			if (sd != null && dd == null) {
				String title = c.getCard_title();
				JSONObject j = new JSONObject();
				j.put("title", title);
				j.put("start", sd);
				toReturn.put(j);
			}
		}

		model.addAttribute("calendarList", toReturn);

		File folder = new File("src/main/webapp/resources/storage/" + project_name + "_" + project_proposer);
		File[] listOfFiles = folder.listFiles();
		model.addAttribute("filesList", listOfFiles);

		return "projectmanagement";
	}

	@RequestMapping(value = "/add-card", method = RequestMethod.POST)
	public void addCard(@RequestParam String modalCardTitle, @RequestParam String modalCardDescription,
			@RequestParam(required = false) String tags, @RequestParam(required = false) String modalCardAssignee,
			@RequestParam String board_id,
			@RequestParam(required = false) String start_date,
			@RequestParam(required = false) String due_date, String projectName,
			HttpServletRequest request, ModelMap model) throws ParseException {
		
		if(start_date.equals("")){
		      start_date = null;
		    }
		if(due_date.equals("")){
		      due_date = null;
		    }
		
		String username = (String) request.getSession().getAttribute("username"); // owner
		Timestamp timestamp = new Timestamp(System.currentTimeMillis()); // timestamp
		SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd"); 
		Date start_date1 = null;
		Date due_date1 = null;
		    if(start_date != null){
		        start_date1 = new java.sql.Date(dt.parse(start_date).getTime()); 
		      }
		      if(due_date != null){
		        due_date1 = new java.sql.Date(dt.parse(due_date).getTime());
		      }
		      
			//A task can have a start date with no due date

		SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd");
		Date start_date1 = null;
		Date due_date1 = null;
		if (start_date != null) {
			start_date1 = new java.sql.Date(dt.parse(start_date).getTime());
		}
		if (due_date != null) {
			due_date1 = new java.sql.Date(dt.parse(due_date).getTime());
		}

		// A task can have a start date with no due date

		if (due_date != null && start_date != null) {
			pmService.addCard(modalCardTitle, modalCardDescription, "todo", tags, Integer.parseInt(board_id), username,
					modalCardAssignee, timestamp, start_date1, due_date1);
		} else if (due_date == null && start_date != null) {
			pmService.addCard(modalCardTitle, modalCardDescription, "todo", tags, Integer.parseInt(board_id), username,
					modalCardAssignee, timestamp, start_date1, null);
		} else {
			pmService.addCard(modalCardTitle, modalCardDescription, "todo", tags, Integer.parseInt(board_id), username,
					modalCardAssignee, timestamp, null, null);
		}

		String timestamptostring = timestamp.toString();
		String date = timestamptostring.substring(0, 10);
		String time = timestamptostring.substring(11, 16);
		String activity = username + " added " + modalCardTitle + " to Todo on " + date + " at " + time;

		pmService.updateActivity(activity, board_id, username);
		
		String message = username + " has assigned you the task " + modalCardTitle + " on " + date;
		Notification notification = new Notification(modalCardAssignee, username,
				"The user " + username + " has assigned you a task for " + projectName, message, "message", "inbox");
		notificationService.sendNotification(notification);
	}

	@RequestMapping(value = "/edit-card", method = RequestMethod.POST)
	public void editCard(@RequestParam String modalCardTitle, @RequestParam String modalCardDescription,
			@RequestParam(required = false) String tags, @RequestParam(required = false) String modalCardAssignee,
			String board_id, @RequestParam(required = false) String start_date,
			@RequestParam(required = false) String due_date, String card_id_view, String projectName,
			HttpServletRequest request, ModelMap model) throws ParseException {

		if (start_date.equals("")) {
			start_date = null;
		}
		if (due_date.equals("")) {
			due_date = null;
		}

		SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd");
		Date start_date1 = null;
		Date due_date1 = null;
		if (start_date != null) {
			start_date1 = new java.sql.Date(dt.parse(start_date).getTime());
		}

		if (due_date != null) {
			due_date1 = new java.sql.Date(dt.parse(due_date).getTime());
		}

		String username = (String) request.getSession().getAttribute("username"); // owner
		Timestamp timestamp = new Timestamp(System.currentTimeMillis()); // timestamp
		int card_id_view2 = Integer.parseInt(card_id_view);
		String timestamptostring = timestamp.toString();
		String date = timestamptostring.substring(0, 10);
		String time = timestamptostring.substring(11, 16);

		// A task can have a start date with no due date
		if (due_date != null && start_date != null) {
			pmService.edit(modalCardTitle, modalCardDescription, tags, modalCardAssignee, start_date1, due_date1,
					card_id_view2);
		} else if (due_date == null && start_date != null) {
			pmService.edit(modalCardTitle, modalCardDescription, tags, modalCardAssignee, start_date1, null,
					card_id_view2);
		} else {
			pmService.edit(modalCardTitle, modalCardDescription, tags, modalCardAssignee, null, null, card_id_view2);
		}

		String activity = username + " edited " + modalCardTitle + " on " + date + " at " + time;
		pmService.updateActivity(activity, board_id, username);

		String message = username + " has edited the task " + modalCardTitle + " on " + date;
		Notification notification = new Notification(modalCardAssignee, username,
				"The user " + username + " has edited you the task " + modalCardTitle + " in the board " + projectName,
				message, "message", "inbox");
		notificationService.sendNotification(notification);
	}

	@RequestMapping(value = "/delete-card", method = RequestMethod.POST)
	public void deleteCard(@RequestParam String card_id, @RequestParam String projectName, HttpServletRequest request,
			ModelMap model) {

		Card c = pmService.retrieveProjectCardById(Integer.parseInt(card_id));
		String card_title = c.getCard_title();
		int board_id = c.getBoard_id();
		String cardstatus = c.getStatus();
		String modalCardAssignee = c.getAssignee();
		pmService.deleteCard(Integer.parseInt(card_id));

		String username = (String) request.getSession().getAttribute("username"); // owner
		Timestamp timestamp = new Timestamp(System.currentTimeMillis()); // timestamp

		String timestamptostring = timestamp.toString();
		String date = timestamptostring.substring(0, 10);
		String time = timestamptostring.substring(11, 16);

		if (cardstatus.equals("todo")) {
			cardstatus = "Todo";
		} else if (cardstatus.equals("inprogress")) {
			cardstatus = "In Progress";
		} else {
			cardstatus = "Done";
		}

		String activity = username + " deleted " + card_title + " from  " + cardstatus + " on " + date + " at " + time;
		pmService.updateActivity(activity, Integer.toString(board_id), username);

		String message = username + " has deleted the task " + card_title + " on " + date;
		Notification notification = new Notification(modalCardAssignee, username,
				"The user " + username + " has deleted the task " + card_title + " in the board " + projectName,
				message, "message", "inbox");
		notificationService.sendNotification(notification);
	}

	@RequestMapping(value = "/update-card-order", method = RequestMethod.POST)
	public void updateCardOrder(@RequestParam String id, @RequestParam String status, @RequestParam String order,
			HttpServletRequest request) {
		String username = (String) request.getSession().getAttribute("username"); // owner
		Timestamp timestamp = new Timestamp(System.currentTimeMillis()); // timestamp

		int newId = Integer.parseInt(id);
		int newOrder = Integer.parseInt(order);
		pmService.updateOrder(newId, status, newOrder);
	}

	@RequestMapping(value = "/retrieve-activity", method = RequestMethod.POST)
	public void retrieveActivity(@RequestParam int board_id, HttpServletRequest request, ModelMap model) {

		String username = (String) request.getSession().getAttribute("username"); // owner
		Timestamp timestamp = new Timestamp(System.currentTimeMillis()); // timestamp
		ArrayList<String> activitylog = pmService.retrieveActivityLog(board_id);
		Collections.reverse(activitylog);
		model.addAttribute("activitylog", board_id);
	}

	// Create new method for detecting change between lists.
	@RequestMapping(value = "/detect-status-change", method = RequestMethod.POST)
	public void detectstatuschange(@RequestParam String from, @RequestParam String to, @RequestParam String card_id,
			@RequestParam String projectName, HttpServletRequest request, ModelMap model) {

		Card c = pmService.retrieveProjectCardById(Integer.parseInt(card_id));
		String card_title = c.getCard_title();
		int board_id = c.getBoard_id();
		String assignee = c.getAssignee();
		String username = (String) request.getSession().getAttribute("username"); // owner
		Timestamp timestamp = new Timestamp(System.currentTimeMillis()); // timestamp

		String timestamptostring = timestamp.toString();
		String date = timestamptostring.substring(0, 10);
		String time = timestamptostring.substring(11, 16);

		if (from.equals("sortableInProgress")) {
			from = "In Progress";
		} else if (from.equals("sortableToDo")) {
			from = "Todo";
		} else {
			from = "Done";
		}

		if (to.equals("sortableInProgress")) {
			to = "In Progress";
		} else if (to.equals("sortableToDo")) {
			to = "Todo";
		} else {
			to = "Done";
		}

		String activity = username + " moved " + card_title + " from " + from + " to " + to + " on " + date + " at "
				+ time;
		pmService.updateActivity(activity, Integer.toString(board_id), username);

		String message = username + " has moved the card " + card_title + " from " + from + " to " + to + " on " + date;
		Notification notification = new Notification(assignee, username,
				"The user " + username + " has moved the card " + card_title + " in the board " + projectName, message,
				"message", "inbox");
		notificationService.sendNotification(notification);
	}

	@RequestMapping(value = "/uploadProjectFiles", method = RequestMethod.POST)
	public String processUploadProjectFiles(@RequestParam("project_name") String project_name,
			@RequestParam("project_proposer") String project_proposer, @RequestParam("username") String username,
			@RequestParam String board_id, @RequestParam("files") MultipartFile[] files) {

		if (projectService.retrieveSpecificMember(project_name, project_proposer, username) != null) {
			Timestamp timestamp = new Timestamp(System.currentTimeMillis()); // timestamp
			String filesName = "";
			for (MultipartFile mpf : files) {
				Writer output = null;
				try {
					filesName += mpf.getOriginalFilename() + ";";
					mpf.transferTo(new File("src/main/webapp/resources/storage/" + project_name + "_" + project_proposer
							+ "/" + mpf.getOriginalFilename()));
				} catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			String activity = username + " uploaded " + files.length + "files (" + filesName + ") at " + timestamp;
			pmService.updateActivity(activity, board_id, username);
		}
		return "projectmanagement";
	}

	@RequestMapping(value = "/saveFile", method = RequestMethod.GET)
	public void saveFile(@RequestParam File file, @RequestParam("project_name") String project_name,
			@RequestParam("project_proposer") String project_proposer, @RequestParam("username") String username,
			HttpServletResponse response, HttpServletRequest request) {
		FileInputStream inputStream;
		if (projectService.retrieveSpecificMember(project_name, project_proposer, username) != null) {
			try {
				inputStream = new FileInputStream(file);
				response.setHeader("Content-Disposition", "attachment; filename=" + file.getName());
				response.setHeader("Content-Length", String.valueOf(file.length()));
				FileCopyUtils.copy(inputStream, response.getOutputStream());
				inputStream.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@RequestMapping(value = "/deleFile", method = RequestMethod.POST)
	public void deleteFile(@RequestParam File file, @RequestParam("project_name") String project_name,
			@RequestParam("project_proposer") String project_proposer, @RequestParam("username") String username,
			@RequestParam String board_id, HttpServletResponse response, HttpServletRequest request) {
		if (projectService.retrieveSpecificMember(project_name, project_proposer, username) != null) {
			Timestamp timestamp = new Timestamp(System.currentTimeMillis()); // timestamp
			try {
				Path path = Paths.get(file.getPath());
				Files.delete(path);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String activity = username + " deleted file (" + file.getName() + ") at " + timestamp;
			pmService.updateActivity(activity, board_id, username);
		}
	}
}