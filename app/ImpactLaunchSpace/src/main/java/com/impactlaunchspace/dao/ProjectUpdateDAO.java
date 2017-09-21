package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.ProjectUpdate;

public interface ProjectUpdateDAO {
	public void insert(ProjectUpdate projectUpdate);

	public void remove(int update_id);
	
	public ArrayList<ProjectUpdate> retrieveProjectUpdates(String project_name, String project_proposer);
}
