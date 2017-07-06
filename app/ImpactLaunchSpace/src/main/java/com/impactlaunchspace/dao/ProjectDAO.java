package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.Project;

public interface ProjectDAO {
	public void insert(Project project);
	public ArrayList<Project> retrieveProject(String project_name);
}
