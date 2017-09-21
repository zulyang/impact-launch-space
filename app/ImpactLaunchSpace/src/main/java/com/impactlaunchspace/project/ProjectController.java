package com.impactlaunchspace.project;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
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

import com.impactlaunchspace.entity.IndividualAccount;
import com.impactlaunchspace.entity.Notification;
import com.impactlaunchspace.entity.OrganizationAccount;
import com.impactlaunchspace.entity.Project;
import com.impactlaunchspace.entity.ProjectBanList;
import com.impactlaunchspace.entity.ProjectMemberList;
import com.impactlaunchspace.entity.ProjectRequestedResource;
import com.impactlaunchspace.entity.ProjectResourceCategory;
import com.impactlaunchspace.entity.ProjectTargetArea;
import com.impactlaunchspace.entity.ProjectUserRequest;
import com.impactlaunchspace.notification.NotificationService;
import com.impactlaunchspace.profile.ProfileService;
import com.impactlaunchspace.request.RequestService;
import com.impactlaunchspace.users.UserService;

@Controller
public class ProjectController {

	@Autowired
	ProjectService projectService;
	
	@Autowired
	NotificationService notificationService;

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

		return "project/" + "create_project";
	}

	// Insert Project Record to DB
	@RequestMapping(value = "/create-project", method = RequestMethod.POST)
	public String processCreateProject(@RequestParam String projectTitle, @RequestParam String projectPurpose,
			@RequestParam ArrayList<String> selected_projectareas, @RequestParam String projectOwner,
			@RequestParam String projectLocation, @RequestParam String projectDescription,
			@RequestParam String projectPrivacy, @RequestParam int projectDuration,
			@RequestParam("projectImage") MultipartFile projectImage,
			@RequestParam("documents") MultipartFile[] documents,
			@RequestParam(required = false) ArrayList<String> selected_banlist,
			@RequestParam(required = false) ArrayList<String> resourceCategory,
			@RequestParam(required = false) ArrayList<String> resourceName,
			@RequestParam(required = false) ArrayList<String> resourceDescription,
			@RequestParam(required = false) String projectVideo, HttpServletRequest request,
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
		
		if(projectVideo.isEmpty()){
			projectVideo = "";
		}else{
			projectVideo = projectVideo.replace("watch?v=", "embed/");
		}

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
			if (profileService.getIndividualAccountDetails(username) != null) {
				if (profileService.getIndividualAccountDetails(username).getOrganization() != null
						|| profileService.getIndividualAccountDetails(username).getOrganization().length() > 0) {
					organization = profileService.getIndividualAccountDetails(username).getOrganization();
				}
			} else {
				organization = profileService.getOrganizationAccountDetails(username).getCompanyName();
			}
		}
		
		ArrayList<ProjectResourceCategory> selected_resourceCategories = new ArrayList<ProjectResourceCategory>();
		ArrayList<ProjectRequestedResource> selected_requestedResources = new ArrayList<ProjectRequestedResource>();
		ArrayList<String> resourceCategoryStrings = new ArrayList<String>();

		for (String resourceCategory_string : resourceCategory) {
			ProjectResourceCategory projectResourceCategoryObj = new ProjectResourceCategory(project_name,
					resourceCategory_string, project_proposer);
			if (!resourceCategoryStrings.contains(resourceCategory_string)) {
				selected_resourceCategories.add(projectResourceCategoryObj);
				resourceCategoryStrings.add(resourceCategory_string);
			}
		}

		for (int i = 0; i < resourceName.size(); i++) {
			ProjectRequestedResource projectRequestedResourceObj = new ProjectRequestedResource(project_name,
					resourceCategory.get(i), resourceName.get(i), resourceDescription.get(i), project_proposer);
			selected_requestedResources.add(projectRequestedResourceObj);
		}

		File projectImageFile = null;
		if (projectImage.getOriginalFilename().isEmpty()) {
			projectImageFile = new File("src/main/webapp/resources/img/earth.png");
		} else {
			projectImageFile = new File(projectImage.getOriginalFilename());
			try {
				projectImage.transferTo(projectImageFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		ArrayList<File> documentList = new ArrayList<>();
		if (documents != null) {
			for (MultipartFile document : documents) {
				File documentFile = new File(document.getOriginalFilename());
				try {
					document.transferTo(documentFile);
				} catch (IllegalStateException | IOException e) {
					//first document error
				}
				documentList.add(documentFile);
			}
		}

		Project project = new Project(project_name, description, purpose, duration, location, project_proposer,
				organization, isPublic, hiddenToOutsiders, hiddenToAll, project_status,
				new Timestamp(Calendar.getInstance().getTime().getTime()), 0, projectImageFile, documentList, projectVideo);

		projectService.setupProject(project, selected_banlist, selected_projectareas, selected_resourceCategories,
				selected_requestedResources);
		
		projectImageFile.deleteOnExit();
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

		String username = (String) request.getSession().getAttribute("username");

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
		ArrayList<ProjectTargetArea> project_target_areas_objs = projectService.retrieveTargetProjectAreas(project_name,
				project_proposer);
		ArrayList<String> project_target_areas = new ArrayList<String>();

		for (ProjectTargetArea project_target_area : project_target_areas_objs) {
			project_target_areas.add(project_target_area.getProject_area());
		}

		model.addAttribute("project_target_areas", project_target_areas);

		// populates the edit profile page with the list of banned users its
		// banned user in the DB
		ArrayList<ProjectBanList> project_ban_list_objs = projectService.retrieveProjectBanList(project_name,
				project_proposer);
		ArrayList<String> project_ban_list = new ArrayList<String>();

		for (ProjectBanList project_ban_username : project_ban_list_objs) {
			project_ban_list.add(project_ban_username.getBanned_username());
		}

		model.addAttribute("project_ban_list", project_ban_list);

		// populates the edit page with the requested resources for the user to
		// edit
		model.addAttribute("project_requested_resources",
				projectService.retrieveAllProjectRequestedResource(project_name, project_proposer));

		return "project/" + "edit_project";
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
		String username = (String) request.getSession().getAttribute("username");

		model.addAttribute("project_area_list", profileService.retrieveProjectAreaList());
		model.addAttribute("country_list", profileService.retrieveCountryList());
		model.addAttribute("resource_category_list", profileService.retrieveSkillsetList());
		model.addAttribute("user_list", userService.retrieveUsernameList());
		model.addAttribute("organization_list", userService.retrieveOrganizationNamelist());

		Project selected_project = projectService.retrieveProject(project_name, project_proposer);
		String projectPrivacy = "public";
		ArrayList<ProjectMemberList> projectMemberList = projectService.retrieveMemberList(project_name, project_proposer);
		ArrayList<String> member_usernames = new ArrayList<String>();
		
		for(ProjectMemberList projectMember: projectMemberList){
			member_usernames.add(projectMember.getProject_member_username());
		}
		
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
				if(requestedResource.getConfirmed_offerer() == null){
					resourceDetails.add("Unfilled Position");
				}else{
					resourceDetails.add(requestedResource.getConfirmed_offerer());
				}
				
				resourcenames.add(resourceDetails);
			}
			projectRequestedResources.put(projectResourceCategoryObj.getResource_category(), resourcenames);
		}

		ArrayList<ProjectUserRequest> userRequestsForProjectObjs = requestService
				.retrieveNonRejectedProjectRequestsOfUser(project_name, project_proposer, username);
		ArrayList<String> userRequestsForProject = new ArrayList<String>();

		for (ProjectUserRequest userRequestsForProjectObj : userRequestsForProjectObjs) {
			userRequestsForProject.add(userRequestsForProjectObj.getRequested_resource_name());
		}

		model.addAttribute("userRequestsForProject", userRequestsForProject);
		model.addAttribute("userRequestsForProjectObjs", userRequestsForProjectObjs);
		
		DecimalFormat df = new DecimalFormat("#.00"); 
		double progressPercentage = projectService.returnPercentageOfRecruitmentProgress(project_name, project_proposer) * 100;

		model.addAttribute("progressPercentage",  df.format(progressPercentage));

		model.addAttribute("project_target_areas", projectTargetAreas);
		model.addAttribute("creator_name", userService.retrieveFullNameOrCompanyName(project_proposer));
		model.addAttribute("selected_project", selected_project);
		model.addAttribute("member_usernames", member_usernames);
		model.addAttribute("project_resource_categories", projectResourceCategories);
		model.addAttribute("project_requested_resources", projectRequestedResources);

		if (selected_project.getOrganization() != null) {
			OrganizationAccount organizationAccount = profileService
					.findByCompanyName(selected_project.getOrganization());
			model.addAttribute("project_organization", organizationAccount.getUsername());
		}

		if (projectPrivacy.equals("hidden")) {
			if (username.equals(project_proposer)) {
				return "project/" + "view_project_public";
			} else if (selected_project.getOrganization() != null) {
				System.out.println("username now: " + username);
				OrganizationAccount organizationAccount = profileService
						.findByCompanyName(selected_project.getOrganization());

				if (username.equals(organizationAccount.getUsername())) {
					return "project/" + "view_project_public";
				} else {
					return "project/" + "view_project_private";
				}

			} else {
				return "project/" + "view_project_private";
			}
		}

		// for now if u are not the project creator or organization u will see
		// the private page
		else if (projectPrivacy.equals("private")) {
			if (username.equals(project_proposer)) {
				return "project/" + "view_project_public";
			} else if (selected_project.getOrganization() != null) {
				OrganizationAccount organizationAccount = profileService
						.findByCompanyName(selected_project.getOrganization());
				if (username.equals(organizationAccount.getUsername())) {
					return "project/" + "view_project_public";
				} else {
					return "project/" + "view_project_private";
				}

			} else {
				return "project/" + "view_project_private";
			}
		}

		else if (projectPrivacy.equals("public")) {
			return "project/" + "view_project_public";
		}
		return "project/" + "view_project_public";
	}

	@RequestMapping(value = "/view-privateproject", method = RequestMethod.GET)
	public String showProjProjectViewPage(@RequestParam("project-name") String project_name,
			@RequestParam("project-proposer") String project_proposer, HttpServletRequest request, ModelMap model) {
		model.addAttribute("project_area_list", profileService.retrieveProjectAreaList());
		model.addAttribute("country_list", profileService.retrieveCountryList());
		model.addAttribute("resource_category_list", profileService.retrieveSkillsetList());
		model.addAttribute("user_list", userService.retrieveUsernameList());
		model.addAttribute("organization_list", userService.retrieveOrganizationNamelist());

		return "project/" + "view_project_private";
	}

	@RequestMapping(value = "/saveProjectResource", method = RequestMethod.POST)
	public void saveUserResource(@RequestParam String oldProjectTitle, @RequestParam String resourceName,
			@RequestParam String resourceCategory, @RequestParam String resourceDescription,
			@RequestParam String oldResourceCategory, @RequestParam String oldResourceName,
			@RequestParam String oldResourceDescription, HttpServletRequest request) {
		String project_proposer = (String) request.getSession().getAttribute("username");

		// this handles logic if the update removes an existing category the
		// user has or if it creates a new one
		boolean isSame = resourceCategory.equals(oldResourceCategory);
		int resourceCategorySizeFrom = projectService
				.retrieveRequestedResources(oldProjectTitle, oldResourceCategory, project_proposer).size();
		int resourceCategorySizeTo = projectService
				.retrieveRequestedResources(oldProjectTitle, resourceCategory, project_proposer).size();

		if (!isSame) {
			// if the update removes from the category with only 1 resource in
			// it
			if (resourceCategorySizeFrom == 1) {
				projectService.closeResourceCategory(oldProjectTitle, project_proposer, oldResourceCategory);
			}

			// if the update involves a new category
			if (resourceCategorySizeTo == 0) {
				projectService.openNewResourceCategory(oldProjectTitle, project_proposer, resourceCategory);
			}
		}
		projectService.updateProjectRequestedResource(resourceName, resourceCategory, resourceDescription,
				oldProjectTitle, oldResourceName, oldResourceCategory, project_proposer);

	}

	@RequestMapping(value = "/deleteProjectResource", method = RequestMethod.POST)
	public void processAjaxDelete(@RequestParam String resourceName, @RequestParam String resourceCategory,
			@RequestParam String resourceDescription, @RequestParam String oldProjectTitle, HttpServletRequest request)
			throws IOException {

		String project_proposer = (String) request.getSession().getAttribute("username");

		// this validation checks if the resource category would be empty upon
		// deletion, if yes... close the reso category as well
		int resourceCategorySize = projectService
				.retrieveRequestedResources(oldProjectTitle, resourceCategory, project_proposer).size();

		if (resourceCategorySize == 1) {
			projectService.closeResourceCategory(oldProjectTitle, project_proposer, resourceCategory);
		}
		projectService.remove(oldProjectTitle, project_proposer, resourceCategory, resourceName);

	}

	@RequestMapping(value = "/addProjectResource", method = RequestMethod.POST)
	public void addProjectResource(@RequestParam String modalResourceName, @RequestParam String modalResourceCategory,
			@RequestParam String modalResourceDescription, @RequestParam String oldProjectTitle,
			HttpServletRequest request) {
		String project_proposer = (String) request.getSession().getAttribute("username");

		int resourceCategorySize = projectService
				.retrieveRequestedResources(oldProjectTitle, modalResourceCategory, project_proposer).size();

		if (resourceCategorySize == 0) {
			projectService.openNewResourceCategory(oldProjectTitle, project_proposer, modalResourceCategory);
		}

		projectService.addProjectRequestedResource(oldProjectTitle, project_proposer, modalResourceCategory,
				modalResourceName, modalResourceDescription);
	}
	
	@RequestMapping(value = "/startProject", method = RequestMethod.POST)
	public void startProject(@RequestParam String project_name, @RequestParam String project_proposer,
			HttpServletRequest request) {
		String proposer = (String) request.getSession().getAttribute("username");

		projectService.startProject(project_name, project_proposer);
	}

	@RequestMapping(value = "/projectImageDisplay", method = RequestMethod.GET)
	public void showImage(@RequestParam("project-name") String project_name,
			@RequestParam("project-proposer") String project_proposer, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		Project project = projectService.retrieveProject(project_name, project_proposer);
		File file = project.getProjectImage();
		response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
		byte[] bytesArray = new byte[(int) file.length()];
		FileInputStream fis = new FileInputStream(file);
		fis.read(bytesArray); // read file into bytes[]
		fis.close();
		response.getOutputStream().write(bytesArray);
		response.getOutputStream().close();
	}

	@RequestMapping(value = "/downloadProjectFile", method = RequestMethod.GET)
	public void showFiles(@RequestParam File file, HttpServletResponse response, HttpServletRequest request)
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

	@RequestMapping(value = "/deleteProjectFile", method = RequestMethod.GET)
	public String deleteFile(@RequestParam("project-name") String project_name,
			@RequestParam("project-proposer") String project_proposer, @RequestParam File file,
			HttpServletResponse response, HttpServletRequest request) throws ServletException {
		projectService.deleteDocument(project_name, project_proposer, file);
		return "editIndiProfileForm";
	}
	@RequestMapping(value = "/my-projects", method = RequestMethod.GET)
	public String showMyProjects(HttpServletRequest request, ModelMap model) {
		String username = (String) request.getSession().getAttribute("username");

		ArrayList<Project> projectsByUser = new ArrayList<Project>(); 
		projectsByUser = projectService.retrieveProjectByUser(username);
		model.put("projectsByUser", projectsByUser);
		
		ArrayList<ArrayList<String>> joined_project_string = projectService.retrieveJoinedProjects(username);
		ArrayList<Project> projectsJoinedByUser = new ArrayList<Project>(); 
		
		for(ArrayList<String> project_string : joined_project_string){
			Project project = projectService.retrieveProject(project_string.get(0), project_string.get(1));
			projectsJoinedByUser.add(project);
		}
		
		model.put("projectsJoinedByUser", projectsJoinedByUser);
		
		return "project/" + "my_projects";
	}
	
	@RequestMapping(value = "/manage-project-users", method = RequestMethod.GET)
	public String showManageProjectUsersPage(@RequestParam("project-name") String project_name,
			@RequestParam("project-proposer") String project_proposer, HttpServletRequest request, ModelMap model) {
		model.addAttribute("user_list", userService.retrieveUsernameList());
		
		Project project = projectService.retrieveProject(project_name, project_proposer);
		model.addAttribute("project", project);
		model.addAttribute("project_proposer", project_proposer);
		ArrayList<ProjectMemberList> member_list = projectService.retrieveMemberList(project_name, project_proposer);
		
		ArrayList<String> member_list_string = new ArrayList<String>();
		
		for(ProjectMemberList member : member_list){
			member_list_string.add(member.getProject_member_username());
		}
		
		model.addAttribute("member_list", member_list);
		model.addAttribute("member_list_string", member_list_string);
		
		return "project/" + "manage_project_users";
	}
	
	@RequestMapping(value = "/send-invite", method = RequestMethod.POST)
	public String inviteUsersToProject(@RequestParam String project_name,
			@RequestParam String project_proposer,@RequestParam ArrayList<String> invited_users, HttpServletRequest request, ModelMap model, RedirectAttributes redirectAttributes) {
		
		for(String invited_username : invited_users){
			ProjectMemberList projectMemberList = new ProjectMemberList(project_name, project_proposer, invited_username,
					"invited");

			projectService.addNewMemberToTeam(projectMemberList);
			
			String subject = "You have been given access rights to " + project_name;
			
			String message_content = "You have been given access rights to " + project_name;
			message_content += "%n";
			message_content += "%n";
			message_content += "You can proceed to the My Projects page to access the project.";
			
			Notification message = new Notification(invited_username, "admin", subject,
					message_content, "message", "inbox");
			notificationService.sendNotification(message);

		}
		
		redirectAttributes.addAttribute("project-name", project_name);
		redirectAttributes.addAttribute("project-proposer", project_proposer);
		return "redirect:" + "manage-project-users";
	}
	
	@RequestMapping(value = "/remove-member", method = RequestMethod.POST)
	public void removeMemberFromProject(@RequestParam String project_name,
			@RequestParam String project_proposer,@RequestParam String member_username, HttpServletRequest request, ModelMap model) {
		projectService.removeSpecificMember(project_name, project_proposer, member_username);
	}

	@RequestMapping(value = "/publish-update", method = RequestMethod.GET)
	public String showPublishUpdatePage(@RequestParam("project-name") String project_name,
			@RequestParam("project-proposer") String project_proposer, HttpServletRequest request, ModelMap model) {
		return "project/" + "publish_update";
	}
	
	
}
