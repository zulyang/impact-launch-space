package com.impactlaunchspace.project;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.impactlaunchspace.entity.IndividualAccount;
import com.impactlaunchspace.entity.OrganizationAccount;
import com.impactlaunchspace.entity.Project;
import com.impactlaunchspace.entity.ProjectBanList;
import com.impactlaunchspace.entity.ProjectRequestedResource;
import com.impactlaunchspace.entity.ProjectResourceCategory;
import com.impactlaunchspace.entity.ProjectTargetArea;
import com.impactlaunchspace.entity.ProjectUserRequest;
import com.impactlaunchspace.profile.ProfileService;
import com.impactlaunchspace.request.RequestService;
import com.impactlaunchspace.users.UserService;

@Controller
public class ProjectController {

	@Autowired
	ProjectService projectService;

	@Autowired
	ProfileService profileService;

	@Autowired
	UserService userService;
	
	@Autowired
	RequestService requestService;

	// Show Create Project Page
	@RequestMapping(value = "/create-project", method = RequestMethod.GET)
	public String showCreateProjectPage(HttpServletRequest request, ModelMap model) {
		model.addAttribute("project_area_list", profileService.retrieveProjectAreaList());
		model.addAttribute("country_list", profileService.retrieveCountryList());
		model.addAttribute("resource_category_list", profileService.retrieveSkillsetList());
		model.addAttribute("user_list", userService.retrieveUsernameList());
		model.addAttribute("organization_list", userService.retrieveOrganizationNamelist());

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

		return "createproject";
	}

	// Show Create Project Page
	@RequestMapping(value = "/create-project", method = RequestMethod.POST)
	public String processCreateProject(@RequestParam String projectTitle, @RequestParam String projectPurpose,
			@RequestParam ArrayList<String> selected_projectareas, @RequestParam String projectOwner,
			@RequestParam String projectLocation, @RequestParam String projectDescription,
			@RequestParam String projectPrivacy, @RequestParam int projectDuration,
			@RequestParam(required = false) ArrayList<String> selected_banlist,
			@RequestParam(required = false) ArrayList<String> resourceCategory,
			@RequestParam(required = false) ArrayList<String> resourceName,
			@RequestParam(required = false) ArrayList<String> resourceDescription, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {

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

		ArrayList<ProjectResourceCategory> selected_resourceCategories = new ArrayList<ProjectResourceCategory>();
		ArrayList<ProjectRequestedResource> selected_requestedResources = new ArrayList<ProjectRequestedResource>();

		for (String resourceCategory_string : resourceCategory) {
			ProjectResourceCategory projectResourceCategoryObj = new ProjectResourceCategory(project_name,
					resourceCategory_string, project_proposer);
			if (!resourceCategory.contains(projectResourceCategoryObj)) {
				selected_resourceCategories.add(projectResourceCategoryObj);
			}

		}

		for (int i = 0; i < resourceName.size(); i++) {
			ProjectRequestedResource projectRequestedResourceObj = new ProjectRequestedResource(project_name,
					resourceCategory.get(i), resourceName.get(i), resourceDescription.get(i), project_proposer);
			selected_requestedResources.add(projectRequestedResourceObj);
		}

		projectService.setupProject(project_name, description, purpose, duration, location, project_proposer,
				organization, isPublic, hiddenToOutsiders, hiddenToAll, project_status, selected_banlist,
				selected_projectareas, selected_resourceCategories, selected_requestedResources);

		redirectAttributes.addAttribute("project-name", project_name);
		redirectAttributes.addAttribute("project-proposer", project_proposer);

		return "redirect:" + "view-project";
	}

	@RequestMapping(value = "/edit-project", method = RequestMethod.GET)
	public String showEditProjectPage(@RequestParam("project-name") String project_name,
			@RequestParam("project-proposer") String project_proposer, HttpServletRequest request, ModelMap model) {
		model.addAttribute("project_area_list", profileService.retrieveProjectAreaList());
		model.addAttribute("country_list", profileService.retrieveCountryList());
		model.addAttribute("resource_category_list", profileService.retrieveSkillsetList());
		model.addAttribute("user_list", userService.retrieveUsernameList());
		model.addAttribute("organization_list", userService.retrieveOrganizationNamelist());
		model.addAttribute("username", "edward");

		profileService.retrieveJobSectorList();
		profileService.retrieveSkillsetList();

		IndividualAccount indi = (IndividualAccount) request.getSession().getAttribute("individual");
		OrganizationAccount org = (OrganizationAccount) request.getSession().getAttribute("organization");

		// insert dummy project and username to test functionality
		Project sampleProject = projectService.retrieveProject(project_name, project_proposer);
		model.addAttribute("sample_project", sampleProject);
		model.addAttribute("project_proposer", project_proposer);

		// populates the edit profile page with project areas its project areas
		// in the DB
		ArrayList<ProjectTargetArea> project_target_areas_objs = projectService
				.retrieveTargetProjectAreas("Water the kids", "edward");
		ArrayList<String> project_target_areas = new ArrayList<String>();

		for (ProjectTargetArea project_target_area : project_target_areas_objs) {
			project_target_areas.add(project_target_area.getProject_area());
		}

		model.addAttribute("project_target_areas", project_target_areas);

		// populates the edit profile page with the list of banned users its
		// banned user in the DB
		ArrayList<ProjectBanList> project_ban_list_objs = projectService.retrieveProjectBanList("Water the kids",
				"edward");
		ArrayList<String> project_ban_list = new ArrayList<String>();

		for (ProjectBanList project_ban_username : project_ban_list_objs) {
			project_ban_list.add(project_ban_username.getBanned_username());
		}

		model.addAttribute("project_ban_list", project_ban_list);

		// populates the edit page with the requested resources for the user to
		// edit
		model.addAttribute("project_requested_resources",
				projectService.retrieveAllProjectRequestedResource(project_name, project_proposer));

		return "edit-project";
	}

	@RequestMapping(value = "/edit-project", method = RequestMethod.POST)
	public String processEditProject(@RequestParam String oldProjectTitle, @RequestParam String projectTitle,
			@RequestParam String projectPurpose, @RequestParam ArrayList<String> selected_projectareas,
			@RequestParam String projectLocation, @RequestParam String projectDescription,
			@RequestParam String projectPrivacy, @RequestParam int projectDuration,
			@RequestParam(required = false) ArrayList<String> selected_banlist, HttpServletRequest request,
			ModelMap model, RedirectAttributes redirectAttributes) {

		String project_proposer = (String) request.getSession().getAttribute("username");

		boolean isPublic = false;
		boolean hiddenToOutsiders = false;
		boolean hiddenToAll = false;

		if (projectPrivacy.equals("public")) {
			isPublic = true;
		} else if (projectPrivacy.equals("private")) {
			hiddenToOutsiders = true;
		} else if (projectPrivacy.equals("hidden")) {
			hiddenToAll = true;
		}

		ArrayList<ProjectBanList> updated_projectBanList = new ArrayList<ProjectBanList>();
		if (selected_banlist != null) {
			for (String banned_username : selected_banlist) {
				updated_projectBanList.add(new ProjectBanList(projectTitle, banned_username, project_proposer));
			}
		}

		ArrayList<ProjectTargetArea> updated_targetAreas = new ArrayList<ProjectTargetArea>();
		for (String project_area : selected_projectareas) {
			updated_targetAreas.add(new ProjectTargetArea(projectTitle, project_area, project_proposer));
		}

		projectService.updateProjectDetails(projectTitle, projectDescription, projectPurpose, projectDuration,
				projectLocation, isPublic, hiddenToOutsiders, hiddenToAll, oldProjectTitle, project_proposer,
				updated_projectBanList, updated_targetAreas);

		redirectAttributes.addAttribute("project-name", projectTitle);
		redirectAttributes.addAttribute("project-proposer", project_proposer);

		return "redirect:" + "view-project";

	}

	@RequestMapping(value = "/view-project", method = RequestMethod.GET)
	public String showProjectViewPage(@RequestParam("project-name") String project_name,
			@RequestParam("project-proposer") String project_proposer, HttpServletRequest request, ModelMap model) {
		model.addAttribute("project_area_list", profileService.retrieveProjectAreaList());
		model.addAttribute("country_list", profileService.retrieveCountryList());
		model.addAttribute("resource_category_list", profileService.retrieveSkillsetList());
		model.addAttribute("user_list", userService.retrieveUsernameList());
		model.addAttribute("organization_list", userService.retrieveOrganizationNamelist());

		Project selected_project = projectService.retrieveProject(project_name, project_proposer);
		String projectPrivacy = "public";
		String username = (String)request.getSession().getAttribute("username");

		if (selected_project.isHiddenToAll()) {
			projectPrivacy = "hidden";
		}

		if (selected_project.isHiddenToOutsiders()) {
			projectPrivacy = "private";
		}

		ArrayList<ProjectTargetArea> projectTargetAreasObj = projectService.retrieveTargetProjectAreas(project_name,
				project_proposer);
		ArrayList<String> projectTargetAreas = new ArrayList<String>();

		for (ProjectTargetArea projectTargetAreaObj : projectTargetAreasObj) {
			projectTargetAreas.add(projectTargetAreaObj.getProject_area());
		}

		ArrayList<ProjectResourceCategory> projectResourceCategoriesObj = projectService
				.retrieveProjectResourceCategories(project_name, project_proposer);
		ArrayList<String> projectResourceCategories = new ArrayList<String>();

		HashMap<String, ArrayList<ArrayList<String>>> projectRequestedResources = new HashMap<String, ArrayList<ArrayList<String>>>();

		for (ProjectResourceCategory projectResourceCategoryObj : projectResourceCategoriesObj) {
			projectResourceCategories.add(projectResourceCategoryObj.getResource_category());
			ArrayList<ProjectRequestedResource> requestedResourceObjs = projectService.retrieveRequestedResources(
					project_name, projectResourceCategoryObj.getResource_category(), project_proposer);

			ArrayList<ArrayList<String>> resourcenames = new ArrayList<ArrayList<String>>();

			for (ProjectRequestedResource requestedResource : requestedResourceObjs) {
				ArrayList<String> resourceDetails = new ArrayList<String>();
				resourceDetails.add(requestedResource.getResource_name());
				resourceDetails.add(requestedResource.getRequest_description());

				resourcenames.add(resourceDetails);

			}
			projectRequestedResources.put(projectResourceCategoryObj.getResource_category(), resourcenames);
		}
		
		ArrayList<ProjectUserRequest> userRequestsForProjectObjs = requestService.retrieveProjectRequestsOfUser(project_name, project_proposer, username);
		ArrayList<String> userRequestsForProject = new ArrayList<String>();
		
		for(ProjectUserRequest userRequestsForProjectObj : userRequestsForProjectObjs){
			userRequestsForProject.add(userRequestsForProjectObj.getRequested_resource_name());
		}
		
		model.addAttribute("userRequestsForProject", userRequestsForProject);
		model.addAttribute("project_target_areas", projectTargetAreas);
		model.addAttribute("creator_name", userService.retrieveFullNameOrCompanyName(project_proposer));
		model.addAttribute("selected_project", selected_project);
		model.addAttribute("project_resource_categories", projectResourceCategories);
		model.addAttribute("project_requested_resources", projectRequestedResources);

		if (projectPrivacy.equals("hidden")) {
			if (request.getSession().getAttribute("username").equals(project_proposer)) {
				return "viewProject";
			} else {
				return "viewProjectPrivate";
			}
		}

		// for now if u are not the project creator u will see the private page
		if (projectPrivacy.equals("private")) {
			if (request.getSession().getAttribute("username").equals(project_proposer)) {
				return "viewProject";
			} else {
				return "viewProjectPrivate";
			}
		}

		if (projectPrivacy.equals("public")) {
			return "viewProject";
		}
		return "viewProject";
	}

	@RequestMapping(value = "/view-privateproject", method = RequestMethod.GET)
	public String showProjProjectViewPage(@RequestParam("project-name") String project_name,
			@RequestParam("project-proposer") String project_proposer, HttpServletRequest request, ModelMap model) {
		model.addAttribute("project_area_list", profileService.retrieveProjectAreaList());
		model.addAttribute("country_list", profileService.retrieveCountryList());
		model.addAttribute("resource_category_list", profileService.retrieveSkillsetList());
		model.addAttribute("user_list", userService.retrieveUsernameList());
		model.addAttribute("organization_list", userService.retrieveOrganizationNamelist());

		return "viewProjectPrivate";
	}

	@RequestMapping(value = "/edward-processajax", method = RequestMethod.GET)
	public void showAjaxPage2(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			RedirectAttributes redirectAttributes) throws IOException {
		String name = null;
		name = "Hello " + request.getParameter("user");
		if (request.getParameter("user") != null) {
			if (request.getParameter("user").toString().equals("")) {
				name = "Hello User";
			}
		}

		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(name);

	}
	
	@RequestMapping(value = "/saveProjectResource", method = RequestMethod.POST)
	public void saveUserResource(@RequestParam String oldProjectTitle, @RequestParam String resourceName, @RequestParam String resourceCategory, 
			@RequestParam String resourceDescription, @RequestParam String oldResourceCategory, 
			@RequestParam String oldResourceName, @RequestParam String oldResourceDescription, HttpServletRequest request){
		String project_proposer = (String)request.getSession().getAttribute("username");
		
		//this handles logic if the update removes an existing category the user has or if it creates a new one
		boolean isSame = resourceCategory.equals(oldResourceCategory);
		int resourceCategorySizeFrom = projectService.retrieveRequestedResources(oldProjectTitle, oldResourceCategory, project_proposer).size();
		int resourceCategorySizeTo = projectService.retrieveRequestedResources(oldProjectTitle, resourceCategory, project_proposer).size();
		
		if(!isSame){
			//if the update removes from the category with only 1 resource in it
			if(resourceCategorySizeFrom == 1){
				projectService.closeResourceCategory(oldProjectTitle, project_proposer, oldResourceCategory);
			}
			
			//if the update involves a new category
			if(resourceCategorySizeTo == 0){
				projectService.openNewResourceCategory(oldProjectTitle, project_proposer, resourceCategory);
			}
		}
		projectService.updateProjectRequestedResource(resourceName, resourceCategory, resourceDescription, oldProjectTitle, oldResourceName, oldResourceCategory, project_proposer);
		
	}

	@RequestMapping(value = "/deleteProjectResource", method = RequestMethod.POST)
	public void processAjaxDelete(@RequestParam String resourceName, @RequestParam String resourceCategory, 
			@RequestParam String resourceDescription, @RequestParam String oldProjectTitle, HttpServletRequest request) throws IOException {
		
		String project_proposer = (String)request.getSession().getAttribute("username");
		
		//this validation checks if the resource category would be empty upon deletion, if yes... close the reso category as well
		int resourceCategorySize = projectService.retrieveRequestedResources(oldProjectTitle, resourceCategory, project_proposer).size();
		
		if(resourceCategorySize == 1){
			projectService.closeResourceCategory(oldProjectTitle, project_proposer, resourceCategory);
		}
		projectService.remove(oldProjectTitle, project_proposer, resourceCategory, resourceName);

	}
	
	@RequestMapping(value = "/addProjectResource", method = RequestMethod.POST)
	public void addProjectResource(@RequestParam String modalResourceName, @RequestParam String modalResourceCategory, 
			@RequestParam String modalResourceDescription, @RequestParam String oldProjectTitle, HttpServletRequest request){
		String project_proposer = (String)request.getSession().getAttribute("username");
		
		int resourceCategorySize = projectService.retrieveRequestedResources(oldProjectTitle, modalResourceCategory, project_proposer).size();
		
		if(resourceCategorySize == 0){
			projectService.openNewResourceCategory(oldProjectTitle, project_proposer, modalResourceCategory);
		}
		
		projectService.addProjectRequestedResource(oldProjectTitle, project_proposer, modalResourceCategory, modalResourceName, modalResourceDescription);
	}
	
}
