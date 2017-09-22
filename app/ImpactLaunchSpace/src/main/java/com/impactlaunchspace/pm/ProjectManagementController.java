package com.impactlaunchspace.pm;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.impactlaunchspace.entity.Card;
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
			@RequestParam("project-proposer") String project_proposer, HttpServletRequest request, ModelMap model) {

		// Add a boolean for project to see whether it's started or not. If not
		// started,cannot access projectManagement page
		String username = (String) request.getSession().getAttribute("username");
		int unreadCount = notificationService.countUnreadNotifications(username);
	    model.addAttribute("unreadCount", unreadCount);
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
}
