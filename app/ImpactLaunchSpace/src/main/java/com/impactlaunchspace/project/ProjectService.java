package com.impactlaunchspace.project;

import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.DocumentsProjectDAO;
import com.impactlaunchspace.dao.OrganizationAccountDAO;
import com.impactlaunchspace.dao.ProjectBanListDAO;
import com.impactlaunchspace.dao.ProjectDAO;
import com.impactlaunchspace.dao.ProjectMemberListDAO;
import com.impactlaunchspace.dao.ProjectRequestedResourceDAO;
import com.impactlaunchspace.dao.ProjectResourceCategoryDAO;
import com.impactlaunchspace.dao.ProjectTargetAreaDAO;
import com.impactlaunchspace.dao.ProjectUpdateDAO;
import com.impactlaunchspace.entity.Project;
import com.impactlaunchspace.entity.ProjectBanList;
import com.impactlaunchspace.entity.ProjectMemberList;
import com.impactlaunchspace.entity.ProjectRequestedResource;
import com.impactlaunchspace.entity.ProjectResourceCategory;
import com.impactlaunchspace.entity.ProjectTargetArea;
import com.impactlaunchspace.entity.ProjectUpdate;

@Service
public class ProjectService {

	public void setupProject(Project project, ArrayList<String> project_banlist,
			ArrayList<String> selected_projectareas, ArrayList<ProjectResourceCategory> selected_resourceCategories,
			ArrayList<ProjectRequestedResource> selected_requestedResources) {
		
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectDAO projectDAO = (ProjectDAO) context.getBean("projectDAO");
		OrganizationAccountDAO organizationAccountDAO = (OrganizationAccountDAO) context.getBean("organizationAccountDAO");
		ProjectBanListDAO projectBanListDAO = (ProjectBanListDAO) context.getBean("projectBanListDAO");
		ProjectMemberListDAO projectMemberListDAO = (ProjectMemberListDAO) context.getBean("projectMemberListDAO");
		ProjectTargetAreaDAO projectTargetAreaDAO = (ProjectTargetAreaDAO) context.getBean("projectTargetAreaDAO");
		ProjectResourceCategoryDAO projectResourceCategoryDAO = (ProjectResourceCategoryDAO) context.getBean("projectResourceCategoryDAO");
		ProjectRequestedResourceDAO projectRequestedResourceDAO = (ProjectRequestedResourceDAO) context.getBean("projectRequestedResourceDAO");

		projectDAO.insert(project);
		
		projectMemberListDAO.insert(new ProjectMemberList(project.getProject_name(), project.getProject_proposer(), 
				project.getProject_proposer(), "admin", new Timestamp(Calendar.getInstance().getTime().getTime()).toString()));
		
		String organization = project.getOrganization();
		if(organization != null){
			String organizationAccountUsername = organizationAccountDAO.findByCompanyName(organization).getUsername();
			if(projectMemberListDAO.retrieveSpecificMember(project.getProject_name(), project.getProject_proposer(), organizationAccountUsername) == null){ 
		        projectMemberListDAO.insert(new ProjectMemberList(project.getProject_name(), project.getProject_proposer(), 
		        		organizationAccountUsername,"admin",new Timestamp(Calendar.getInstance().getTime().getTime()).toString())); 
		    } 
		}
		
		if(project_banlist != null){
			for (String ban_username : project_banlist) {
				projectBanListDAO.insert(new ProjectBanList(project.getProject_name(), ban_username, project.getProject_proposer()));
			}
		}
		
		if(selected_projectareas != null){
			for (String target_area : selected_projectareas) {
				projectTargetAreaDAO.insert(new ProjectTargetArea(project.getProject_name(), target_area, project.getProject_proposer()));
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
		ProjectMemberListDAO projectMemberListDAO = (ProjectMemberListDAO) context.getBean("projectMemberListDAO");

		projectDAO.updateProject(project_name, description, purpose, duration, location, isPublic, hiddenToOutsiders,
				hiddenToAll, old_project_name, project_proposer);

		projectBanListDAO.deleteProjectBanList(old_project_name, project_proposer);
		projectTargetAreaDAO.deleteProjectTargetAreas(old_project_name, project_proposer);
		
		if(updated_projectBanList.size() > 0 && updated_projectBanList != null){
			for (ProjectBanList projectBanList : updated_projectBanList) {
				projectBanListDAO.insert(projectBanList);
			}
		}
		
		ArrayList<ProjectMemberList> currentMembers = projectMemberListDAO.retrieveMemberList(old_project_name, project_proposer);
		
		for(ProjectMemberList member : currentMembers){
			
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
	
	public ArrayList<Project> retrieveProjectByUser(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectDAO projectDAO = (ProjectDAO) context.getBean("projectDAO");
		return projectDAO.retrieveProjectByUser(username);
	}
	
	public ArrayList<Project> retrieveProjectByOrganization(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectDAO projectDAO = (ProjectDAO) context.getBean("projectDAO");
		return projectDAO.retrieveProjectByOrganization(username);
	
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

	public void deleteDocument(String project_name, String project_proposer, File file) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		DocumentsProjectDAO documentProjectDAO = (DocumentsProjectDAO) context.getBean("documentsProjectDAO");
		documentProjectDAO.delete(project_name, project_proposer, file);
	}
	
	public void addNewMemberToTeam(ProjectMemberList projectMemberList) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectMemberListDAO projectMemberListDAO = (ProjectMemberListDAO) context.getBean("projectMemberListDAO");
		projectMemberListDAO.insert(projectMemberList);
	}
	
	public ArrayList<ProjectMemberList> retrieveMemberList(String project_name, String project_proposer){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectMemberListDAO projectMemberListDAO = (ProjectMemberListDAO) context.getBean("projectMemberListDAO");
		return projectMemberListDAO.retrieveMemberList(project_name, project_proposer);
	}
	
	public ProjectMemberList retrieveSpecificMember(String project_name, String project_proposer,
			String project_member_username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectMemberListDAO projectMemberListDAO = (ProjectMemberListDAO) context.getBean("projectMemberListDAO");
		return projectMemberListDAO.retrieveSpecificMember(project_name, project_proposer,
				project_member_username);
	}
	
	public void removeSpecificMember(String project_name, String project_proposer,
			String project_member_username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectMemberListDAO projectMemberListDAO = (ProjectMemberListDAO) context.getBean("projectMemberListDAO");
		projectMemberListDAO.remove(project_name, project_proposer, project_member_username);
	}
	
	public double returnPercentageOfRecruitmentProgress(String project_name, String project_proposer){
		double count = 0.0;
		double MIN_PERCENTAGE = Project.MIN_PERCENTAGE;
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectRequestedResourceDAO projectRequestedResourceDAO = (ProjectRequestedResourceDAO) context
				.getBean("projectRequestedResourceDAO");
		
		ArrayList<ProjectRequestedResource> projectRequestedResources = projectRequestedResourceDAO.retrieveAllProjectRequestedResource(project_name, project_proposer);
		int size = projectRequestedResources.size();
		
		for(ProjectRequestedResource requestedResource: projectRequestedResources){
			if(requestedResource.getConfirmed_offerer() != null){
				count++;
			}
		}
		
		if (count==0){
			return 0.0;
		}else{
			return count/size;
		}

	}
	
	public void startProject(String project_name, String project_proposer){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectDAO projectDAO = (ProjectDAO) context.getBean("projectDAO");
		
		projectDAO.updateProjectStatus(project_name, project_proposer, "started");
	}
	
	public ArrayList<ArrayList<String>> retrieveJoinedProjects(String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectMemberListDAO projectMemberListDAO = (ProjectMemberListDAO) context.getBean("projectMemberListDAO");
		
		return projectMemberListDAO.retrieveJoinedProjects(username);
	}
	
	public void publishUpdate(ProjectUpdate projectUpdate){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectUpdateDAO projectUpdateDAO = (ProjectUpdateDAO) context.getBean("projectUpdateDAO");
		
		projectUpdateDAO.insert(projectUpdate);
	}
	
	public void deleteUpdate(String project_name, String project_proposer, String update_title, String posted_time){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectUpdateDAO projectUpdateDAO = (ProjectUpdateDAO) context.getBean("projectUpdateDAO");
		
		projectUpdateDAO.remove(project_name, project_proposer, update_title, posted_time);
	}
	
	public ArrayList<ProjectUpdate> retrieveProjectUpdates(String project_name, String project_proposer){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectUpdateDAO projectUpdateDAO = (ProjectUpdateDAO) context.getBean("projectUpdateDAO");
		
		return projectUpdateDAO.retrieveProjectUpdates(project_name, project_proposer);
	}
	
	public void editUpdate(String update_contents, String project_name, String project_proposer, String update_title, String posted_time){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectUpdateDAO projectUpdateDAO = (ProjectUpdateDAO) context.getBean("projectUpdateDAO");
		
		projectUpdateDAO.editUpdate(update_contents, project_name, project_proposer, update_title, posted_time);
	}

}
