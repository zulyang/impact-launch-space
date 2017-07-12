package com.impactlaunchspace.project;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.ProjectDAO;
import com.impactlaunchspace.entity.Project;

@Service
public class ProjectService {

	public void setupProject(String project_name, String description, String purpose,int duration, 
			String location, String project_proposer, String organization, boolean isPublic, 
			boolean hiddenToOutsiders, boolean hiddenToAll, String project_status) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectDAO projectDAO = (ProjectDAO) context.getBean("projectDAO");
		
		Project project = new Project(project_name, description, purpose, duration, location,
				project_proposer, organization, isPublic,hiddenToOutsiders, hiddenToAll, project_status,null);
		
		projectDAO.insert(project);
	}

}
