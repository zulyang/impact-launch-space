package com.impactlaunchspace.pm;

import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.impactlaunchspace.entity.Card;
import com.impactlaunchspace.entity.UserOfferedResource;
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
		model.addAttribute("user", username);
		model.addAttribute("projectName", project_name);

		// Check the cards attribute and sort by status
		ArrayList<Card> todoList = pmService.retrieveProjectCardsByStatus(board_id, "todo");
		ArrayList<Card> inprogressList = pmService.retrieveProjectCardsByStatus(board_id, "inprogress");
		ArrayList<Card> doneList = pmService.retrieveProjectCardsByStatus(board_id, "done");
		
		// Check the ordering of the card and display based on ordering.
		model.addAttribute("todoList", todoList);
		model.addAttribute("inprogressList", inprogressList);
		model.addAttribute("doneList", doneList);

		return "projectmanagement";
	}

	@RequestMapping(value = "/add-card", method = RequestMethod.POST)
	public void addCard(@RequestParam String modalCardTitle, @RequestParam String modalCardDescription,
			@RequestParam String tags, @RequestParam int board_id, @RequestParam int card_order,
			HttpServletRequest request, ModelMap model) {
		String username = (String) request.getSession().getAttribute("username"); // owner
		Timestamp timestamp = new Timestamp(System.currentTimeMillis()); // timestamp

		pmService.addCard(modalCardTitle, modalCardDescription, "todo", tags, board_id, card_order, username,
				timestamp);
	}

	@RequestMapping(value = "/edit-card", method = RequestMethod.GET)
	public void editCard(@RequestParam String modalCardTitle, @RequestParam String modalCardDescription,
			@RequestParam String status, @RequestParam String tags, @RequestParam int card_order,
			HttpServletRequest request, ModelMap model) {
		String username = (String) request.getSession().getAttribute("username"); // owner
		Timestamp timestamp = new Timestamp(System.currentTimeMillis()); // timestamp

	}

	@RequestMapping(value = "/delete-card", method = RequestMethod.GET)
	public void deleteCard(@RequestParam Card c, HttpServletRequest request, ModelMap model) {
		int card_id = c.getCard_id();
		pmService.deleteCard(card_id);
	}

	@RequestMapping(value = "/update-card-order", method = RequestMethod.POST)
	public void updateCardOrder(@RequestParam String id, @RequestParam String status,
			@RequestParam String order, HttpServletRequest request) {
		pmService.updateOrder(Integer.parseInt(id), status, Integer.parseInt(order));
	}
}
