package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.Project;

public interface ProjectDAO {
	public void insert(Project project);

	public Project retrieveProject(String project_name, String project_proposer);

	public ArrayList<Project> retrieveProjectByUser(String username);

	public ArrayList<Project> retrievePublicProjects();

	public void updateProject(String project_name, String description, String purpose, int duration, String location,
			boolean isPublic, boolean hiddenToOutsiders, boolean hiddenToAll, String old_project_name,
			String project_proposer);
	
	public ArrayList<Project> retrieveProjectsBySearch(String causes, String location, String searchbox);
	
	public void updateProjectStatus(String project_name, String project_proposer, String project_status);
	
	public ArrayList<Project> retrieveProjectByOrganization(String username);
}
