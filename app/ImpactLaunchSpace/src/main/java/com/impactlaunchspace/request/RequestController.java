package com.impactlaunchspace.request;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.impactlaunchspace.entity.Notification;
import com.impactlaunchspace.entity.OrganizationAccount;
import com.impactlaunchspace.entity.Project;
import com.impactlaunchspace.entity.ProjectMemberList;
import com.impactlaunchspace.entity.UserOfferedResource;
import com.impactlaunchspace.notification.NotificationService;
import com.impactlaunchspace.profile.ProfileService;
import com.impactlaunchspace.project.ProjectService;
import com.impactlaunchspace.resource.ResourceService;
import com.impactlaunchspace.users.UserService;

@Controller
public class RequestController {
	@Autowired
	ProjectService projectService;

	@Autowired
	ProfileService profileService;

	@Autowired
	UserService userService;

	@Autowired
	ResourceService resourceService;

	@Autowired
	RequestService requestService;

	@Autowired
	NotificationService notificationService;

	@RequestMapping(value = "/applyProjectModal", method = RequestMethod.GET)
	public String showProjectPage(HttpServletRequest request, ModelMap model) {
		model.addAttribute("project_area_list", profileService.retrieveProjectAreaList());
		model.addAttribute("country_list", profileService.retrieveCountryList());
		model.addAttribute("resource_category_list", profileService.retrieveSkillsetList());
		model.addAttribute("user_list", userService.retrieveUsernameList());
		model.addAttribute("organization_list", userService.retrieveOrganizationNamelist());

		String username = (String) request.getSession().getAttribute("username");
		// for now legal is hard-coded
		ArrayList<UserOfferedResource> userOfferedResources = resourceService.retrieveResourcesInCategory(username,
				"Legal");

		model.addAttribute("user_offered_resources", userOfferedResources);
		model.addAttribute("selected_resource_category", "Legal");
		return "applyProjectModal";
	}

	@RequestMapping(value = "/sendApplyRequest", method = RequestMethod.POST)
	public String processApplyRequest(@RequestParam String project_name, @RequestParam String project_proposer,
			@RequestParam String selected_requested_resource, @RequestParam String selected_resource_category,
			@RequestParam String selected_resource_name, @RequestParam String selected_resource_desc,
			@RequestParam String personal_note, HttpServletRequest request, RedirectAttributes redirectAttributes,
			ModelMap model) {
		String username = (String) request.getSession().getAttribute("username");
		requestService.createUserRequest(project_name, selected_resource_category, selected_requested_resource,
				project_proposer, username, selected_resource_category, selected_resource_name, selected_resource_desc,
				personal_note);

		// building the notification message string
		String notification_message = "The following user: " + username + " has applied to offer his support for "
				+ project_name;
		notification_message += "%n";
		notification_message += "%n";
		notification_message += "DETAILS OF OFFERED RESOURCE";
		notification_message += "%n";
		notification_message += "%n";
		notification_message += "Resource Name: " + selected_resource_name;
		notification_message += "%n";
		notification_message += "%n";
		notification_message += "Resource Description: " + selected_resource_desc;

		if (personal_note.length() != 0) {
			notification_message += "%n";
			notification_message += "%n";
			notification_message += "Personal Note from User:";
			notification_message += "%n";
			notification_message += personal_note;
		}

		Notification notification = new Notification(project_proposer, "admin",
				"A user has applied to offer his support for " + project_name, notification_message, "message", "inbox");
		notificationService.sendNotification(notification);

		Project selected_project = projectService.retrieveProject(project_name, project_proposer);

		if (selected_project.getOrganization() != null) {
			if (selected_project.getOrganization().isEmpty() != true) {
				OrganizationAccount organizationObj = profileService
						.findByCompanyName(selected_project.getOrganization());

				Notification notification2 = new Notification(organizationObj.getUsername(), "admin",
						"A user has applied to offer his support for " + project_name, notification_message, "message", "inbox");

				notificationService.sendNotification(notification2);
			}
		}

		redirectAttributes.addAttribute("project-name", project_name);
		redirectAttributes.addAttribute("project-proposer", project_proposer);

		return "redirect:" + "view-project";

	}

	@RequestMapping(value = "/notifications/requests/process-request", method = RequestMethod.POST)
	public String processRequest(@RequestParam String actiontype, @RequestParam String modalOfferedResourceName,
			@RequestParam String modalRequestedResourceName, @RequestParam String modalProjName,
			@RequestParam String modalOfferer, @RequestParam String modalResourceCategory,
			@RequestParam String modalProjectProposer, HttpServletRequest request, ModelMap model) {

		if (actiontype.equals("approve")) {
			requestService.acceptRequest(modalProjName, modalResourceCategory, modalRequestedResourceName,
					modalProjectProposer, modalOfferer, modalResourceCategory, modalOfferedResourceName);

			// trigger sending of acceptance to user
			String notification_message = "Congratulations!";
			notification_message += "%n";
			notification_message += "%n";
			notification_message += "The project creator of " + modalProjName
					+ " has accepted your offer to help in the project.";
			notification_message += "%n";
			notification_message += "%n";
			notification_message += "Proceed to your Requests Tabs to confirm your acceptance into the project.";

			Notification notification = new Notification(modalOfferer, "admin",
					"Your request to help " + modalProjName + " was accepted by the Project Creator!",
					notification_message, "message", "inbox");

			notificationService.sendNotification(notification);
			
		} else {
			requestService.rejectRequest(modalProjName, modalResourceCategory, modalRequestedResourceName,
					modalProjectProposer, modalOfferer, modalResourceCategory, modalOfferedResourceName);

			// trigger sending of rejection to user
			String notification_message = "Sorry!";
			notification_message += "%n";
			notification_message += "%n";
			notification_message += "The project creator of " + modalProjName
					+ " has unfortunately decided to decline your offer to help in the project.";

			Notification notification = new Notification(modalOfferer, "admin",
					"Your request to help " + modalProjName + " was rejected by the Project Creator!",
					notification_message, "message", "inbox");

			notificationService.sendNotification(notification);
		}

		return "redirect:" + "inbox";
	}
	
	@RequestMapping(value = "/notifications/requests/process-confirmation", method = RequestMethod.POST)
	public String processResourceConfirmation(@RequestParam String actiontype, @RequestParam String modalOfferedResourceName,
			@RequestParam String modalRequestedResourceName, @RequestParam String modalProjName,
			@RequestParam String modalOfferer, @RequestParam String modalResourceCategory,
			@RequestParam String modalProjectProposer, HttpServletRequest request, ModelMap model) {
		
		if (actiontype.equals("confirm")) {
			requestService.confirmRequest(modalProjName, modalResourceCategory, modalRequestedResourceName,
					modalProjectProposer, modalOfferer, modalResourceCategory, modalOfferedResourceName);

			// trigger sending of confirmation to proposer
			String notification_message = "Congratulations, you have a new team member for " + modalProjName + "!";
			notification_message += "%n";
			notification_message += "%n";
			notification_message += "The user: " + modalOfferer + " has successfully confirmed his enrollment in your project! He has now basic member privileges to your project.";
			notification_message += "%n";
			notification_message += "%n";
			notification_message += "You can manage his rights/privileges in the Project Management page.";

			Notification notification = new Notification(modalProjectProposer, "admin",
					"The user: " + modalOfferer + " has successfully confirmed his enrollment in your project : " + modalProjName + ".",
					notification_message, "message", "inbox");

			notificationService.sendNotification(notification);
			requestService.tagProjectRequestedResource(modalRequestedResourceName, modalOfferer, modalResourceCategory, modalProjName, modalProjectProposer);
		
			
			//adds new member to team, if he isnt am member before
			if(projectService.retrieveSpecificMember(modalProjName, modalProjectProposer, modalOfferer) == null){
				ProjectMemberList projectMemberList = new ProjectMemberList(modalProjName, modalProjectProposer, modalOfferer,
					"member");
				projectService.addNewMemberToTeam(projectMemberList);
			}
				
			
		} else {
			requestService.cancelRequest(modalProjName, modalResourceCategory, modalRequestedResourceName,
					modalProjectProposer, modalOfferer, modalResourceCategory, modalOfferedResourceName);

			// trigger sending of rejection to user
			String notification_message = "Sorry!";
			notification_message += "%n";
			notification_message += "%n";
			notification_message += "The resource offerer: " + modalOfferer
					+ " has unfortunately decided to cancel his offer to help in the project.";

			Notification notification = new Notification(modalProjectProposer, "admin",
					"Your request to recruit " + modalOfferer + " was rejected.",
					notification_message, "message", "inbox");

			notificationService.sendNotification(notification);
		}
		
		return "redirect:" + "sent";
	}

	// AJAX METHODS BELOW
	@RequestMapping(value = "/obtainUserResources", method = RequestMethod.POST)
	public void obtainUserResources(@RequestParam String selected_resource_category, HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws IOException {
		String username = (String) request.getSession().getAttribute("username");
		// for now legal is hard-coded
		ArrayList<UserOfferedResource> userOfferedResources = resourceService.retrieveResourcesInCategory(username,
				selected_resource_category);
		String json = null;
		json = new Gson().toJson(userOfferedResources);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
	}

	@RequestMapping(value = "/getResourceDescription", method = RequestMethod.POST)
	public void getResourceDescriptionAjax(@RequestParam String resourceName, @RequestParam String resourceCategory,
			HttpServletRequest request, ModelMap model, HttpServletResponse response) throws IOException {
		String username = (String) request.getSession().getAttribute("username");

		UserOfferedResource selected_resource = resourceService.retrieveOfferedResource(username, resourceCategory,
				resourceName);
		String desc = "";
		if (selected_resource != null) {
			desc = selected_resource.getResourceDescription();
		}

		response.getWriter().write(desc);
	}

}
