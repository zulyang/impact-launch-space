package com.impactlaunchspace.project;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.impactlaunchspace.profile.ProfileService;
import com.impactlaunchspace.users.UserService;

@Controller
public class ProjectController {
	
	@Autowired
	ProjectService projectService;
	
	@Autowired
	ProfileService profileService;
	
	@Autowired
	UserService userService;
	
	//Show Create Project Page
	@RequestMapping(value = "/create-project", method = RequestMethod.GET)
	public String showCreateProjectPage(HttpServletRequest request) {
		request.getSession().setAttribute("project_area_list", profileService.retrieveProjectAreaList());
		request.getSession().setAttribute("country_list", profileService.retrieveCountryList());
		request.getSession().setAttribute("resource_category_list", profileService.retrieveSkillsetList());
		request.getSession().setAttribute("user_list", userService.retrieveUsernameList());
		request.getSession().setAttribute("organization_list", userService.retrieveOrganizationNamelist());
				
		profileService.retrieveJobSectorList();
		profileService.retrieveSkillsetList();
		
		
		return "createproject";
	}
	
	//Show Create Project Page
	@RequestMapping(value = "/create-project", method = RequestMethod.POST)
	public String processCreateProject(@RequestParam String projectTitle, @RequestParam String projectPurpose,
			@RequestParam ArrayList<String> selected_projectareas, @RequestParam String projectOwner, 
			@RequestParam String projectLocation, @RequestParam String projectDescription
			, @RequestParam String projectPrivacy, @RequestParam int projectDuration,
			@RequestParam ArrayList<String> selected_banlist) {
		
		String project_name = projectTitle;
		String description = projectDescription; 
		String purpose = projectPurpose;
		int duration = projectDuration; 
		String location = projectLocation; 
		String project_proposer = null; 
		String organization = null; 
		boolean isPublic = false; 
		boolean hiddenToOutsiders = false; 
		boolean hiddenToAll = false; 
		String project_status = "new";
		
		if(projectPrivacy.equals("public")){
			isPublic = true;
		}else if(projectPrivacy.equals("private")){
			hiddenToOutsiders = true;
		}else if(projectPrivacy.equals("hidden")){
			hiddenToAll= true;
		}
		
		if(projectOwner.equals("individual")){
			project_proposer = "edwardo"; //replace it
		}else if(projectOwner.equals("organization")){
			project_proposer = "edwardo"; //replace it
			organization = "Edward Pte Ltd"; //replace this too
		}
		
		projectService.setupProject(project_name, description, purpose, duration, location, project_proposer, organization, isPublic, hiddenToOutsiders, hiddenToAll, project_status, selected_banlist);
		
				
		return "testSelect2";
	}
}
