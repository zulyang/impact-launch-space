package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.Project;

public interface ProjectDAO {
	public void insert(Project project);
	public Project retrieveProject(String project_name, String project_proposer);
	public ArrayList<Project> retrieveProjectByUser(String username);
	public ArrayList<Project> retrievePublicProjects();
}
