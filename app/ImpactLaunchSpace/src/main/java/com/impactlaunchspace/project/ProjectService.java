package com.impactlaunchspace.project;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.ProjectBanListDAO;
import com.impactlaunchspace.dao.ProjectDAO;
import com.impactlaunchspace.dao.ProjectRequestedResourceDAO;
import com.impactlaunchspace.dao.ProjectResourceCategoryDAO;
import com.impactlaunchspace.dao.ProjectTargetAreaDAO;
import com.impactlaunchspace.entity.Project;
import com.impactlaunchspace.entity.ProjectBanList;
import com.impactlaunchspace.entity.ProjectRequestedResource;
import com.impactlaunchspace.entity.ProjectResourceCategory;
import com.impactlaunchspace.entity.ProjectTargetArea;

@Service
public class ProjectService {

	public void setupProject(String project_name, String description, String purpose, int duration, String location,
			String project_proposer, String organization, boolean isPublic, boolean hiddenToOutsiders,
			boolean hiddenToAll, String project_status, ArrayList<String> project_banlist,
			ArrayList<String> selected_projectareas, ArrayList<ProjectResourceCategory> selected_resourceCategories,
			ArrayList<ProjectRequestedResource> selected_requestedResources) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectDAO projectDAO = (ProjectDAO) context.getBean("projectDAO");
		ProjectBanListDAO projectBanListDAO = (ProjectBanListDAO) context.getBean("projectBanListDAO");
		ProjectTargetAreaDAO projectTargetAreaDAO = (ProjectTargetAreaDAO) context.getBean("projectTargetAreaDAO");
		ProjectResourceCategoryDAO projectResourceCategoryDAO = (ProjectResourceCategoryDAO) context.getBean("projectResourceCategoryDAO");
		ProjectRequestedResourceDAO projectRequestedResourceDAO = (ProjectRequestedResourceDAO) context.getBean("projectRequestedResourceDAO");

		Project project = new Project(project_name, description, purpose, duration, location, project_proposer,
				organization, isPublic, hiddenToOutsiders, hiddenToAll, project_status,
				new Timestamp(Calendar.getInstance().getTime().getTime()), 0);

		projectDAO.insert(project);
		
		if(project_banlist != null){
			for (String ban_username : project_banlist) {
				projectBanListDAO.insert(new ProjectBanList(project_name, ban_username, project_proposer));
			}
		}
		
		if(selected_projectareas != null){
			for (String target_area : selected_projectareas) {
				projectTargetAreaDAO.insert(new ProjectTargetArea(project_name, target_area, project_proposer));
			}	
		}
		
		if(selected_resourceCategories != null){
			for(ProjectResourceCategory project_resource_category : selected_resourceCategories){
				projectResourceCategoryDAO.insert(project_resource_category);
			}
		}
		
		if(selected_requestedResources != null){
			for(ProjectRequestedResource project_requested_resource : selected_requestedResources){
				projectRequestedResourceDAO.insert(project_requested_resource);
			}
		}

	}

	public void updateProjectDetails(String project_name, String description, String purpose, int duration,
			String location, boolean isPublic, boolean hiddenToOutsiders, boolean hiddenToAll, String old_project_name,
			String project_proposer, ArrayList<ProjectBanList> updated_projectBanList,
			ArrayList<ProjectTargetArea> updated_targetAreas) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectDAO projectDAO = (ProjectDAO) context.getBean("projectDAO");
		ProjectBanListDAO projectBanListDAO = (ProjectBanListDAO) context.getBean("projectBanListDAO");
		ProjectTargetAreaDAO projectTargetAreaDAO = (ProjectTargetAreaDAO) context.getBean("projectTargetAreaDAO");

		projectDAO.updateProject(project_name, description, purpose, duration, location, isPublic, hiddenToOutsiders,
				hiddenToAll, old_project_name, project_proposer);

		projectBanListDAO.deleteProjectBanList(old_project_name, project_proposer);
		projectTargetAreaDAO.deleteProjectTargetAreas(old_project_name, project_proposer);
		
		if(updated_projectBanList.size() > 0 && updated_projectBanList != null){
			for (ProjectBanList projectBanList : updated_projectBanList) {
				projectBanListDAO.insert(projectBanList);
			}
		}
		

		for (ProjectTargetArea projectTargetArea : updated_targetAreas) {
			projectTargetAreaDAO.insert(projectTargetArea);
		}

	}

	public Project retrieveProject(String project_name, String project_proposer) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectDAO projectDAO = (ProjectDAO) context.getBean("projectDAO");
		return projectDAO.retrieveProject(project_name, project_proposer);
	}

	public ArrayList<ProjectTargetArea> retrieveTargetProjectAreas(String project_name, String project_proposer) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectTargetAreaDAO projectTargetAreaDAO = (ProjectTargetAreaDAO) context.getBean("projectTargetAreaDAO");
		return projectTargetAreaDAO.retrieveProjectTargetAreas(project_name, project_proposer);
	}

	public ArrayList<ProjectBanList> retrieveProjectBanList(String project_name, String project_proposer) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectBanListDAO projectBanListDAO = (ProjectBanListDAO) context.getBean("projectBanListDAO");
		return projectBanListDAO.retrieveProjectBanList(project_name, project_proposer);
	}
	
	public ArrayList<ProjectResourceCategory> retrieveProjectResourceCategories(String project_name, String project_proposer) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectResourceCategoryDAO projectResourceCategoryDAO = (ProjectResourceCategoryDAO) context.getBean("projectResourceCategoryDAO");
		return projectResourceCategoryDAO.retrieveProjectResourceCategories(project_name, project_proposer);
	}
	
	public ArrayList<ProjectRequestedResource> retrieveRequestedResources(String project_name, String resource_category, String project_proposer) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectRequestedResourceDAO projectRequestedResourceDAO = (ProjectRequestedResourceDAO) context.getBean("projectRequestedResourceDAO");
		return projectRequestedResourceDAO.retrieveProjectRequestedResource(project_name, resource_category, project_proposer);
		
	}
	
	public ArrayList<Project> searchProjects(String causes, String location, String searchbox) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectDAO projectDAO = (ProjectDAO) context.getBean("projectDAO");
		return projectDAO.retrieveProjectsBySearch(causes, location, searchbox);
	}
	
	public void remove(String project_name, String project_proposer,
			String resource_category, String resource_name){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectRequestedResourceDAO projectRequestedResourceDAO = (ProjectRequestedResourceDAO) context.getBean("projectRequestedResourceDAO");
		projectRequestedResourceDAO.remove(project_name, project_proposer, resource_category, resource_name);
	}
	
	public ArrayList<ProjectRequestedResource> retrieveAllProjectRequestedResource(String project_name, String project_proposer){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectRequestedResourceDAO projectRequestedResourceDAO = (ProjectRequestedResourceDAO) context.getBean("projectRequestedResourceDAO");
		return projectRequestedResourceDAO.retrieveAllProjectRequestedResource(project_name, project_proposer);
	}
	
	public void updateProjectRequestedResource(String new_resource_name, String new_resource_category, String new_request_description, String project_name, String old_resource_name, String old_resource_category,String project_proposer){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectRequestedResourceDAO projectRequestedResourceDAO = (ProjectRequestedResourceDAO) context.getBean("projectRequestedResourceDAO");
		projectRequestedResourceDAO.update(new_resource_name, new_resource_category, new_request_description, project_name, old_resource_name, old_resource_category, project_proposer);
	}
	
	public void addProjectRequestedResource(String project_name, String project_proposer, String resource_category, String resource_name, String request_description) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectRequestedResourceDAO projectRequestedResourceDAO = (ProjectRequestedResourceDAO) context.getBean("projectRequestedResourceDAO");
		projectRequestedResourceDAO.insert(new ProjectRequestedResource(project_name, resource_category, resource_name,	request_description, project_proposer));
	}
	
	//The below two methods add a new resource/remove a resource category for a project	
	public void openNewResourceCategory(String project_name, String project_proposer, String resource_category) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectResourceCategoryDAO projectResourceCategoryDAO = (ProjectResourceCategoryDAO) context.getBean("projectResourceCategoryDAO");
		projectResourceCategoryDAO.insert(new ProjectResourceCategory(project_name,resource_category, project_proposer));
	}
	
	public void closeResourceCategory(String project_name, String project_proposer, String resource_category) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectResourceCategoryDAO projectResourceCategoryDAO = (ProjectResourceCategoryDAO) context.getBean("projectResourceCategoryDAO");
		projectResourceCategoryDAO.closeResourceCategory(project_name, project_proposer, resource_category);
	}
}
