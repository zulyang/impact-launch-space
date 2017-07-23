package com.impactlaunchspace.search;

import com.google.gson.Gson;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.impactlaunchspace.project.ProjectService;
import com.impactlaunchspace.users.UserService;

@Controller
public class SearchController {

	@Autowired
	ProjectService projectService;

	// Search For Project Based On Causes
	@RequestMapping(value = "/searchproject", method = RequestMethod.GET)
	public void searchForProject(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws IOException{

		//Get the Causes. This method should return the Project.
		String causes = request.getParameter("causeName");
		String location = request.getParameter("locationName");
		String misc = request.getParameter("miscName");

		//Get the list of projects based on the causes.
		ArrayList<Project> projects = new ArrayList<Project>();
		projects = projectService.searchProjects(causes, location);
		
		//Use LinkedHashMap to keep the order of the Json Objects. 
		Map<Integer, String> list = new LinkedHashMap<Integer, String>();


		if(misc.equals("Popularity")){
			//method to sort by popularity
			Collections.sort(projects, Project.getProjectByDescPopularity());;
		}

		if(misc.equals("Newest")){
			//method to sort by Date
			Collections.sort(projects, Project.getProjectByAscDate());
		}

		if(misc.equals("Duration")){
			//method to sort by duration
			Collections.sort(projects, Project.getProjectByDescDuration());
		}

		for(int i = 0; i<projects.size(); i++){
			//Display Projects in Order
			/*Map<Integer, String > projectdetails = new LinkedHashMap<Integer, String>();
			projectdetails.put(i, projects.get(i).getProject_name());
			projectdetails.put(i, projects.get(i).getPurpose());
			projectdetails.put(i, Integer.toString(projects.get(i).getDuration()));
			projectdetails.put(i, projects.get(i).getLocation());
			projectdetails.put(i, projects.get(i).getProject_status());			
			list.put(i+1, projectdetails);*/
			
			
			String projname = projects.get(i).getProject_name();
			String projpurpose = projects.get(i).getPurpose();
			int projDuration = projects.get(i).getDuration();
			String projLocation = projects.get(i).getLocation();
			String projStatus = projects.get(i).getProject_status();
			String toReturn = projname + "," + projpurpose + "," + Integer.toString(projDuration) + "," + projLocation + ","+  projStatus; 
			list.put(i+1, toReturn);
		}

		String json = null;
		json = new Gson().toJson(list);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
	}
}
