package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.ProjectTargetArea;

public interface ProjectTargetAreaDAO {
	public void insert(ProjectTargetArea projectTargetArea);
	public ArrayList<ProjectTargetArea> retrieveProjectTargetAreas(String project_name, String project_proposer);
}
