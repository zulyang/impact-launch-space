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
	@RequestMapping(value = "/manage-user-resources", method = RequestMethod.GET)
	public String showEditUserResourcePage(HttpServletRequest request, ModelMap model) {
		String username = (String)request.getSession().getAttribute("username");
		model.addAttribute("user_resource_offering", resourceService.getUserResourceOffering(username));
		model.addAttribute("resource_category_list", profileService.retrieveSkillsetList());
		return "resource/" + "manage_user_resources";
	}
	
	@RequestMapping(value = "/add-user-resource", method = RequestMethod.POST)
	public void addUserResource(@RequestParam String modalResourceName, @RequestParam String modalResourceCategory, 
			@RequestParam String modalResourceDescription, HttpServletRequest request){
		String username = (String)request.getSession().getAttribute("username");
		UserOfferedResource userOfferedResource = new UserOfferedResource(username, modalResourceCategory, modalResourceName, modalResourceDescription);
		resourceService.insertUserResourceOffering(userOfferedResource);
	}
	
	@RequestMapping(value = "/remove-user-resource", method = RequestMethod.POST)
	public void removeUserResource(@RequestParam String resourceName, @RequestParam String resourceCategory, 
			@RequestParam String resourceDescription, HttpServletRequest request){
		String username = (String)request.getSession().getAttribute("username");
		UserOfferedResource userOfferedResource = new UserOfferedResource(username, resourceCategory, resourceName, resourceDescription);
		resourceService.removeUserResourceOffering(userOfferedResource);
	}
	
	@RequestMapping(value = "/save-user-resource", method = RequestMethod.POST)
	public void saveUserResource(@RequestParam String resourceName, @RequestParam String resourceCategory, 
			@RequestParam String resourceDescription, @RequestParam String oldResourceCategory, 
			@RequestParam String oldResourceName, @RequestParam String oldResourceDescription, HttpServletRequest request){
		String username = (String)request.getSession().getAttribute("username");
		UserOfferedResource oldUserOfferedResource = new UserOfferedResource(username, oldResourceCategory, oldResourceName, oldResourceDescription);
		UserOfferedResource userOfferedResource = new UserOfferedResource(username, resourceCategory, resourceName, resourceDescription);
		resourceService.updateUserResourceOffering(oldUserOfferedResource, userOfferedResource);
	}
}
