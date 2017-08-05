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

import com.google.gson.Gson;
import com.impactlaunchspace.entity.UserOfferedResource;
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
			@RequestParam String selected_resource_category, @RequestParam String selected_resource_name,
			@RequestParam String selected_resource_desc, @RequestParam String personal_note, HttpServletRequest request,
			ModelMap model) {
		String username = (String) request.getSession().getAttribute("username");
		requestService.createUserRequest(project_name, selected_resource_category, "Environmental Lawyers x 3",
				project_proposer, username, selected_resource_category, selected_resource_name, selected_resource_desc,
				personal_note);

		return "applyRequestSuccess";
	}
	
	//AJAX METHODS BELOW
	@RequestMapping(value = "/obtainUserResources", method = RequestMethod.POST)
	public void obtainUserResources(@RequestParam String selected_resource_category, HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws IOException {
		String username = (String) request.getSession().getAttribute("username");
		// for now legal is hard-coded
		ArrayList<UserOfferedResource> userOfferedResources = resourceService.retrieveResourcesInCategory(username,
				selected_resource_category);
		System.out.println("entering this method with " + userOfferedResources.size() + " objects");
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
