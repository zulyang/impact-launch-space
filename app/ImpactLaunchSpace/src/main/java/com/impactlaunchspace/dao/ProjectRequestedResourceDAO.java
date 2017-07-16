package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.ProjectRequestedResource;

public interface ProjectRequestedResourceDAO {
	public void insert(ProjectRequestedResource projectRequestedResource);
	public ArrayList<ProjectRequestedResource> retrieveProjectRequestedResource(String project_name, String resource_category, String project_proposer);
}
