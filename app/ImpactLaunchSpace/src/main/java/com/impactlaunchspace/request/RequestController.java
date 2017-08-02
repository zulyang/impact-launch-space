package com.impactlaunchspace.request;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.impactlaunchspace.profile.ProfileService;
import com.impactlaunchspace.project.ProjectService;
import com.impactlaunchspace.users.UserService;

@Controller
public class RequestController {
	@Autowired
	ProjectService projectService;

	@Autowired
	ProfileService profileService;

	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/applyProjectModal", method = RequestMethod.GET)
	public String showProjectPage(HttpServletRequest request, ModelMap model) {
		request.getSession().setAttribute("project_area_list", profileService.retrieveProjectAreaList());
		request.getSession().setAttribute("country_list", profileService.retrieveCountryList());
		request.getSession().setAttribute("resource_category_list", profileService.retrieveSkillsetList());
		request.getSession().setAttribute("user_list", userService.retrieveUsernameList());
		request.getSession().setAttribute("organization_list", userService.retrieveOrganizationNamelist());

		return "applyProjectModal";
	}
}
