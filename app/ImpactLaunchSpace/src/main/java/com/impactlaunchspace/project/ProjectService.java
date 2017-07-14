package com.impactlaunchspace.project;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.ProjectBanListDAO;
import com.impactlaunchspace.dao.ProjectDAO;
import com.impactlaunchspace.entity.Project;
import com.impactlaunchspace.entity.ProjectBanList;

@Service
public class ProjectService {

	public void setupProject(String project_name, String description, String purpose, int duration, String location,
			String project_proposer, String organization, boolean isPublic, boolean hiddenToOutsiders,
			boolean hiddenToAll, String project_status, ArrayList<String> project_banlist) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectDAO projectDAO = (ProjectDAO) context.getBean("projectDAO");
		ProjectBanListDAO projectBanListDAO = (ProjectBanListDAO) context.getBean("projectBanListDAO");

		Project project = new Project(project_name, description, purpose, duration, location, project_proposer,
				organization, isPublic, hiddenToOutsiders, hiddenToAll, project_status,
				new Date(Calendar.getInstance().getTime().getTime()));

		projectDAO.insert(project);

		for (String ban_username : project_banlist) {
			projectBanListDAO.insert(new ProjectBanList(project_name, ban_username, project_proposer));
		}
		
	}

}
