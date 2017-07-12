package com.impactlaunchspace.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProjectController {
	
	@Autowired
	ProjectService projectService;
	
	//Show Create Project Page
	@RequestMapping(value = "/create-project", method = RequestMethod.GET)
	public String showCreateProjectPage() {
		return "createproject";
	}
	
	//Show Create Project Page
	@RequestMapping(value = "/create-project", method = RequestMethod.POST)
	public String processCreateProject(@RequestParam String projectTitle, @RequestParam String projectPurpose,
			@RequestParam String socialImpactType, @RequestParam String projectOwner, 
			@RequestParam String projectLocation, @RequestParam String projectDescription
			,@RequestParam String projectPrivacy, @RequestParam int projectDuration) {
		
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
		
		if(project_proposer.equals("individual")){
			project_proposer = "edwardo"; //replace it
		}else if(project_proposer.equals("organization")){
			project_proposer = "edwardo"; //replace it
			organization = "Edward Pte Ltd"; //replace this too
		}
		
		projectService.setupProject(project_name, description, purpose, duration, location, project_proposer, organization, isPublic, hiddenToOutsiders, hiddenToAll, project_status);
		
		return "testSelect2";
	}
}
