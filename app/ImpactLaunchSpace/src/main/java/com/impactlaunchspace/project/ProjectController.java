package com.impactlaunchspace.project;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.impactlaunchspace.entity.IndividualAccount;
import com.impactlaunchspace.entity.OrganizationAccount;
import com.impactlaunchspace.entity.Project;
import com.impactlaunchspace.entity.ProjectTargetArea;
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

	// Show Create Project Page
	@RequestMapping(value = "/create-project", method = RequestMethod.GET)
	public String showCreateProjectPage(HttpServletRequest request, ModelMap model) {
		request.getSession().setAttribute("project_area_list", profileService.retrieveProjectAreaList());
		request.getSession().setAttribute("country_list", profileService.retrieveCountryList());
		request.getSession().setAttribute("resource_category_list", profileService.retrieveSkillsetList());
		request.getSession().setAttribute("user_list", userService.retrieveUsernameList());
		request.getSession().setAttribute("organization_list", userService.retrieveOrganizationNamelist());

		profileService.retrieveJobSectorList();
		profileService.retrieveSkillsetList();

		IndividualAccount indi = (IndividualAccount) request.getSession().getAttribute("individual");
		OrganizationAccount org = (OrganizationAccount) request.getSession().getAttribute("organization");

		String indi_org = "";

		String user_type = "";
		if (indi == null) {
			user_type = "org";
		} else {
			user_type = "indi";
			indi_org = indi.getOrganization();
		}

		model.addAttribute("user_type", user_type);
		model.addAttribute("indi_org", indi_org);
		System.out.println("indi: " + indi);
		System.out.println("indi_org: " + indi_org);
		System.out.println("org: " + org);
		System.out.println("usertype: " + user_type);

		return "createproject";
	}

	// Show Create Project Page
	@RequestMapping(value = "/create-project", method = RequestMethod.POST)
	public String processCreateProject(@RequestParam String projectTitle, @RequestParam String projectPurpose,
			@RequestParam ArrayList<String> selected_projectareas, @RequestParam String projectOwner,
			@RequestParam String projectLocation, @RequestParam String projectDescription,
			@RequestParam String projectPrivacy, @RequestParam int projectDuration,
			@RequestParam ArrayList<String> selected_banlist, HttpServletRequest request) {

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

		if (projectPrivacy.equals("public")) {
			isPublic = true;
		} else if (projectPrivacy.equals("private")) {
			hiddenToOutsiders = true;
		} else if (projectPrivacy.equals("hidden")) {
			hiddenToAll = true;
		}

		String username = (String) request.getSession().getAttribute("username");

		if (projectOwner.equals("individual")) {
			project_proposer = username;
		} else if (projectOwner.equals("organization")) {
			project_proposer = username;
			if (profileService.getIndividualAccountDetails(username).getOrganization() != null
					|| profileService.getIndividualAccountDetails(username).getOrganization().length() > 0) {
				organization = profileService.getIndividualAccountDetails(username).getOrganization(); // replace
																										// this
																										// too
			}
		}

		projectService.setupProject(project_name, description, purpose, duration, location, project_proposer,
				organization, isPublic, hiddenToOutsiders, hiddenToAll, project_status, selected_banlist,
				selected_projectareas);

		return "testSelect2";
	}

	@RequestMapping(value = "/edit-project", method = RequestMethod.GET)
	public String showEditProjectPage(HttpServletRequest request, ModelMap model) {
		request.getSession().setAttribute("project_area_list", profileService.retrieveProjectAreaList());
		request.getSession().setAttribute("country_list", profileService.retrieveCountryList());
		request.getSession().setAttribute("resource_category_list", profileService.retrieveSkillsetList());
		request.getSession().setAttribute("user_list", userService.retrieveUsernameList());
		request.getSession().setAttribute("organization_list", userService.retrieveOrganizationNamelist());

		profileService.retrieveJobSectorList();
		profileService.retrieveSkillsetList();

		IndividualAccount indi = (IndividualAccount) request.getSession().getAttribute("individual");
		OrganizationAccount org = (OrganizationAccount) request.getSession().getAttribute("organization");

		// insert dummy project to test functionality
		Project sampleProject = projectService.retrieveProject("Water the kids", "edward");
		model.addAttribute("sample_project", sampleProject);

		ArrayList<ProjectTargetArea> project_target_areas_objs = projectService.retrieveTargetProjectAreas("Water the kids",
				"edward");
		ArrayList<String> project_target_areas = new ArrayList<String>();
		
		for(ProjectTargetArea project_target_area : project_target_areas_objs){
			project_target_areas.add(project_target_area.getProject_area());
		}
		
		model.addAttribute("project_target_areas", project_target_areas);

		return "edit-project";
	}

}
