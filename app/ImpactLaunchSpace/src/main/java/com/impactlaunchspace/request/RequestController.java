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
	
	@RequestMapping(value = "/applyProjectModal", method = RequestMethod.GET)
	public String showProjectPage(HttpServletRequest request, ModelMap model) {
		model.addAttribute("project_area_list", profileService.retrieveProjectAreaList());
		model.addAttribute("country_list", profileService.retrieveCountryList());
		model.addAttribute("resource_category_list", profileService.retrieveSkillsetList());
		model.addAttribute("user_list", userService.retrieveUsernameList());
		model.addAttribute("organization_list", userService.retrieveOrganizationNamelist());
		
		String username = (String) request.getSession().getAttribute("username");
		ArrayList<UserOfferedResource> userOfferedResources = resourceService.getUserResourceOffering(username);
		
		model.addAttribute("user_offered_resources", userOfferedResources);
		
		return "applyProjectModal";
	}
	
	@RequestMapping(value = "/getResourceDescription", method = RequestMethod.POST)
	public void getResourceDescriptionAjax(@RequestParam String resourceName, @RequestParam String resourceCategory, HttpServletRequest request, ModelMap model, HttpServletResponse response) throws IOException {
		String username = (String) request.getSession().getAttribute("username");
		
		UserOfferedResource selected_resource = resourceService.retrieveOfferedResource(username, resourceCategory, resourceName);
		String desc = "";
		if(selected_resource != null){
			desc = selected_resource.getResourceDescription();
		}

		response.getWriter().write(desc); 
	}
}
