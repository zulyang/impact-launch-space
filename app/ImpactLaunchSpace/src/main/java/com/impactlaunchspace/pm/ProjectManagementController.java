package com.impactlaunchspace.pm;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.impactlaunchspace.entity.Card;
import com.impactlaunchspace.entity.IndividualAccount;
import com.impactlaunchspace.entity.OrganizationAccount;
import com.impactlaunchspace.entity.Project;
import com.impactlaunchspace.entity.ProjectBanList;
import com.impactlaunchspace.entity.ProjectRequestedResource;
import com.impactlaunchspace.entity.ProjectResourceCategory;
import com.impactlaunchspace.entity.ProjectTargetArea;
import com.impactlaunchspace.entity.ProjectUserRequest;
import com.impactlaunchspace.profile.ProfileService;
import com.impactlaunchspace.project.ProjectService;
import com.impactlaunchspace.request.RequestService;
import com.impactlaunchspace.users.UserService;

@Controller
public class ProjectManagementController {
	
	@Autowired
	ProjectService projectService;
	
	@Autowired
	ProjectManagementService pmService; 
	
	//Access Project Management Page 	
	@RequestMapping(value = "/project-management", method = RequestMethod.GET)
	public String projectManagement(@RequestParam("project-name") String project_name,
			@RequestParam("project-proposer") String project_proposer, HttpServletRequest request, ModelMap model){
		
		//Add a boolean for project to see whether it's started or not. If not started,cannot access projectManagement page
		String username = (String) request.getSession().getAttribute("username");
		//Project selected_project = projectService.retrieveProject(project_name, project_proposer);
		//retrieve board_id for project
		int board_id = pmService.retrieveBoardId(project_name, project_proposer);
		ArrayList<Card> projectCards = pmService.retrieveProjectCards(board_id);
		//retrieve cards from database. 
		//probably have to split the cards into 3 seperate arrays. 
		model.addAttribute("user", username);
		model.addAttribute("cards", projectCards);
		model.addAttribute("projectName", project_name);
		int size = projectCards.size(); 
		
		//Check the cards attribute and sort by status
		ArrayList<Card> todoList = new ArrayList<Card>();
		ArrayList<Card> inprogressList = new ArrayList<Card>();
		ArrayList<Card> doneList = new ArrayList<Card>();
		
		for(int i = 0; i< projectCards.size(); i++){
			Card c = projectCards.get(i);
			if(c.getStatus().equals("todo")){
				todoList.add(c);
			}
			
			if(c.getStatus().equals("inprogress")){
				inprogressList.add(c);
			}
			
			if(c.getStatus().equals("done")){
				doneList.add(c);
			}
			
		}
		
		//Check the ordering of the card and display based on ordering. 
		model.addAttribute("todoList", todoList);
		model.addAttribute("inprogressList", inprogressList);
		model.addAttribute("doneList", doneList);
		
		return "projectmanagement";
	}
	
	@RequestMapping(value = "/create-card", method = RequestMethod.GET)
	public String createCard(@RequestParam("project-name") String project_name,
			@RequestParam("project-proposer") String project_proposer, HttpServletRequest request, ModelMap model){
		String username = (String) request.getSession().getAttribute("username");
		//retrieve cards from database. 
		return "projectmanagement";
	}
	
	@RequestMapping(value = "/edit-card", method = RequestMethod.GET)
	public String editCard(@RequestParam("project-name") String project_name,
			@RequestParam("project-proposer") String project_proposer, HttpServletRequest request, ModelMap model){
		String username = (String) request.getSession().getAttribute("username");
		//retrieve cards from database. 
		return "projectmanagement";
	}
	
	

}
