package com.impactlaunchspace.resource;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.impactlaunchspace.entity.UserOfferedResource;
import com.impactlaunchspace.profile.ProfileService;
import com.impactlaunchspace.users.UserService;

@Controller
public class ResourceController {
	
	@Autowired
	ResourceService resourceService;
	
	@Autowired
	ProfileService profileService;
	
	@Autowired
	UserService userService;
	
	//Show Manage User Resource Page
	@RequestMapping(value = "/manageUserResource", method = RequestMethod.GET)
	public String showEditUserResourcePage(HttpServletRequest request, ModelMap model) {
		String username = (String)request.getSession().getAttribute("username");
		model.addAttribute("user_resource_offering", resourceService.getUserResourceOffering(username));
		model.addAttribute("resource_category_list", profileService.retrieveSkillsetList());
		return "manageResources";
	}
	
	@RequestMapping(value = "/addUserResource", method = RequestMethod.POST)
	public String addUserResource(@RequestParam String modalResourceName, @RequestParam String modalResourceCategory, 
			@RequestParam String modalResourceDescription, HttpServletRequest request){
		String username = (String)request.getSession().getAttribute("username");
		username = "xiaowei";
		UserOfferedResource userOfferedResource = new UserOfferedResource(username, modalResourceCategory, modalResourceName, modalResourceDescription);
		resourceService.insertUserResourceOffering(userOfferedResource);
		return "redirect:"+"manageUserResource";
	}
	
	
	
}
