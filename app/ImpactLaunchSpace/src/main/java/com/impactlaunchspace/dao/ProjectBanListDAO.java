package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.ProjectBanList;

public interface ProjectBanListDAO {
	public void insert(ProjectBanList projectBanList);
	public ArrayList<ProjectBanList> retrieveProjectBanList(String project_name, String project_proposer);
	public void deleteProjectBanList(String project_name, String project_proposer);
}
