package com.impactlaunchspace.request;

import java.util.ArrayList;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.ProjectDAO;
import com.impactlaunchspace.dao.ProjectRequestedResourceDAO;
import com.impactlaunchspace.dao.ProjectUserRequestDAO;
import com.impactlaunchspace.entity.ProjectUserRequest;

@Service
public class RequestService {

	public void createUserRequest(String project_name, String requested_resource_category,
			String requested_resource_name, String project_proposer, String resource_offerer,
			String offered_resource_category, String offered_resource_name, String offered_request_description,
			String offer_comments) {

		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectDAO projectDAO = (ProjectDAO) context.getBean("projectDAO");
		ProjectUserRequestDAO projectUserRequestDAO = (ProjectUserRequestDAO) context.getBean("projectUserRequestDAO");
		ProjectRequestedResourceDAO projectRequestedResourceDAO = (ProjectRequestedResourceDAO) context
				.getBean("projectRequestedResourceDAO");

		ProjectUserRequest projectUserRequest = new ProjectUserRequest(project_name, requested_resource_category,
				requested_resource_name, project_proposer, resource_offerer, offered_resource_category,
				offered_resource_name, offered_request_description, offer_comments, "pending");

		ProjectUserRequest checkForExistingObject = projectUserRequestDAO.retrieveParticularUserRequest(project_name,
				project_proposer, resource_offerer, requested_resource_category, requested_resource_name,
				offered_resource_category, offered_resource_name);

		if (checkForExistingObject == null) {
			projectUserRequestDAO.insert(projectUserRequest);
		}
	}

	public void removeUserRequest(ProjectUserRequest projectUserRequest) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectDAO projectDAO = (ProjectDAO) context.getBean("projectDAO");
		ProjectUserRequestDAO projectUserRequestDAO = (ProjectUserRequestDAO) context.getBean("projectUserRequestDAO");

		projectUserRequestDAO.remove(projectUserRequest);
	}

	public ArrayList<ProjectUserRequest> retrieveAllUserRequestsForRequestedResourceName(String project_name,
			String project_proposer, String requested_resource_category, String requested_resource_name) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectUserRequestDAO projectUserRequestDAO = (ProjectUserRequestDAO) context.getBean("projectUserRequestDAO");

		return projectUserRequestDAO.retrieveAllUserRequestsForRequestedResourceName(project_name, project_proposer,
				requested_resource_category, requested_resource_name);
	}

	public ArrayList<ProjectUserRequest> retrieveAllUserRequestsForRequestedResourceCategory(String project_name,
			String project_proposer, String requested_resource_category) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectUserRequestDAO projectUserRequestDAO = (ProjectUserRequestDAO) context.getBean("projectUserRequestDAO");

		return projectUserRequestDAO.retrieveAllUserRequestsForRequestedResourceCategory(project_name, project_proposer,
				requested_resource_category);
	}

	public ProjectUserRequest retrieveParticularUserRequest(String project_name, String project_proposer,
			String resource_offerer, String requested_resource_category, String requested_resource_name,
			String offered_resource_category, String offered_resource_name) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectUserRequestDAO projectUserRequestDAO = (ProjectUserRequestDAO) context.getBean("projectUserRequestDAO");

		return projectUserRequestDAO.retrieveParticularUserRequest(project_name, project_proposer, resource_offerer,
				requested_resource_category, requested_resource_name, offered_resource_category, offered_resource_name);
	}

	public ArrayList<ProjectUserRequest> retrieveProjectRequestsOfUser(String project_name, String project_proposer,
			String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectUserRequestDAO projectUserRequestDAO = (ProjectUserRequestDAO) context.getBean("projectUserRequestDAO");

		return projectUserRequestDAO.retrieveProjectRequestsOfUser(project_name, project_proposer, username);

	}
	
	public void acceptRequest(String project_name, String project_proposer,
			String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectUserRequestDAO projectUserRequestDAO = (ProjectUserRequestDAO) context.getBean("projectUserRequestDAO");

		projectUserRequestDAO.retrieveProjectRequestsOfUser(project_name, project_proposer, username);

	}

}
