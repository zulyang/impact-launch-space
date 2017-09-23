package com.impactlaunchspace.pm;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.Writer;
import java.nio.file.Files;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.impactlaunchspace.entity.Card;
import com.impactlaunchspace.entity.ProjectMemberList;
import com.impactlaunchspace.entity.ProjectRequestedResource;
import com.impactlaunchspace.project.ProjectService;

@Controller
public class ProjectManagementController {

	@Autowired
	ProjectService projectService;

	@Autowired
	ProjectManagementService pmService;

	// Access Project Management Page
	@RequestMapping(value = "/project-management", method = RequestMethod.GET)
	public String projectManagement(@RequestParam("project-name") String project_name,
			@RequestParam("project-proposer") String project_proposer, HttpServletRequest request, ModelMap model) {

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
		ArrayList<ProjectRequestedResource> categories = projectService.retrieveAllProjectRequestedResource(project_name, project_proposer);
		ArrayList<String> cat = new ArrayList<String>();
		
		for(int i =0 ; i<categories.size(); i++){
			cat.add(categories.get(i).getResource_category());
		}
		
	    //add the memberlist for populating the sidebar 
	    ArrayList<ProjectMemberList> member_list = projectService.retrieveMemberList(project_name, project_proposer); 
	     
	    ArrayList<String> member_list_string = new ArrayList<String>(); 
	     
	    for(ProjectMemberList member : member_list){ 
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
		
		//Upon initializing, display the activity log
		ArrayList<String> activitylog = pmService.retrieveActivityLog(board_id);
		Collections.reverse(activitylog);
		model.addAttribute("activitylog", activitylog);
		
		File folder = new File("src/main/webapp/resources/storage/" + "1");
		File[] listOfFiles = folder.listFiles();
		model.addAttribute("filesList", listOfFiles);
		
		return "projectmanagement";
	}

	@RequestMapping(value = "/add-card", method = RequestMethod.POST)
	public void addCard(@RequestParam String modalCardTitle, @RequestParam String modalCardDescription,
			@RequestParam(required = false) String tags, @RequestParam(required = false) String modalCardAssignee, @RequestParam String board_id,
			@RequestParam(required = false) Date start_date, @RequestParam(required = false) Date due_date,
			HttpServletRequest request, ModelMap model) {
		
		String username = (String) request.getSession().getAttribute("username"); // owner
		Timestamp timestamp = new Timestamp(System.currentTimeMillis()); // timestamp
		
		pmService.addCard(modalCardTitle, modalCardDescription, "todo", tags, Integer.parseInt(board_id), username, modalCardAssignee, timestamp, start_date, due_date);
		
		String activity = username + " added " + modalCardTitle + " to Todo on " + timestamp ; 
		
		pmService.updateActivity(activity, board_id, username);
	}
	
	@RequestMapping(value = "/edit-card", method = RequestMethod.POST)
	public void editCard(@RequestParam String modalCardTitle, @RequestParam String modalCardDescription,
			 @RequestParam(required = false) String tags, @RequestParam(required = false) String modalCardAssignee, String board_id, Date start_date, Date due_date, String card_id_view,
			HttpServletRequest request, ModelMap model) {
		
		String username = (String) request.getSession().getAttribute("username"); // owner
		Timestamp timestamp = new Timestamp(System.currentTimeMillis()); // timestamp
		int card_id_view2 = Integer.parseInt(card_id_view);
		
		pmService.edit(modalCardTitle, modalCardDescription, tags, modalCardAssignee, start_date, due_date, card_id_view2);
		String activity = username + " edited " + modalCardTitle + " on " + timestamp; 
		pmService.updateActivity(activity, board_id, username);
	}

	@RequestMapping(value = "/delete-card", method = RequestMethod.POST)
	public void deleteCard(@RequestParam String card_id, HttpServletRequest request, ModelMap model) {
		
		Card c = pmService.retrieveProjectCardById(Integer.parseInt(card_id));	
		String card_title = c.getCard_title();
		int board_id = c.getBoard_id();
		String cardstatus = c.getStatus();
		pmService.deleteCard(Integer.parseInt(card_id));
		
		String username = (String) request.getSession().getAttribute("username"); // owner
		Timestamp timestamp = new Timestamp(System.currentTimeMillis()); // timestamp
			
		if(cardstatus.equals("todo")){
			cardstatus = "Todo";
		}else if(cardstatus.equals("inprogress")){
			cardstatus = "In Progress";
		}else{
			cardstatus = "Done";
		}
		String activity = username + " deleted " + card_title + " from  " + cardstatus + " at " + timestamp; 
		pmService.updateActivity(activity, Integer.toString(board_id), username);
	}

	@RequestMapping(value = "/update-card-order", method = RequestMethod.POST)
	public void updateCardOrder(@RequestParam String id, @RequestParam String status,
			@RequestParam String order, HttpServletRequest request) {
		
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
	
	//Create new method for detecting change between lists. 
	@RequestMapping(value = "/detect-status-change", method = RequestMethod.POST)
	public void detectstatuschange(@RequestParam String from, @RequestParam String to, @RequestParam String card_id, HttpServletRequest request, ModelMap model) {
		
		Card c = pmService.retrieveProjectCardById(Integer.parseInt(card_id));	
		String card_title = c.getCard_title();
		int board_id = c.getBoard_id();
		String username = (String) request.getSession().getAttribute("username"); // owner
		Timestamp timestamp = new Timestamp(System.currentTimeMillis()); // timestamp
		
		if(from.equals("sortableInProgress")){
			from = "In Progress";
		}else if(from.equals("sortableToDo")){
			from = "Todo";
		}else{
			from = "Done";
		}
		
		if(to.equals("sortableInProgress")){
			to = "In Progress";
		}else if(to.equals("sortableToDo")){
			to = "Todo";
		}else{
			to = "Done";
		}
		
		String activity = username + " moved " + card_title + " from " + from + " to " + to + " at "+ timestamp ; 
		pmService.updateActivity(activity, Integer.toString(board_id), username);
	}
	
	@RequestMapping(value = "/uploadProjectFiles", method = RequestMethod.POST)
	public String processUploadProjectFiles(@RequestParam("files") MultipartFile[] files) {
		for(MultipartFile mpf:files){	
			Writer output = null; 
			try {
				// change 1 to project id in the future
				mpf.transferTo(new File("src/main/webapp/resources/storage/" + "1" + "/" + mpf.getOriginalFilename()));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return "projectmanagement";
	}
	
	@RequestMapping(value = "/saveFile", method = RequestMethod.GET)
	public void saveFile(@RequestParam File file, HttpServletResponse response, HttpServletRequest request)
			throws ServletException {
		FileInputStream inputStream;
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
	
	@RequestMapping(value = "/deleFile", method = RequestMethod.POST)
	public void deleteFile(@RequestParam File file, HttpServletResponse response, HttpServletRequest request)
			throws ServletException {
		try {
			Files.delete(file.toPath());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
