package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.ProjectRequestedResource;

public interface ProjectRequestedResourceDAO {
	public void insert(ProjectRequestedResource projectRequestedResource);

	public ArrayList<ProjectRequestedResource> retrieveProjectRequestedResource(String project_name,
			String resource_category, String project_proposer);

	public void remove(String project_name, String project_proposer, String resource_category, String resource_name);
	
	public ArrayList<ProjectRequestedResource> retrieveAllProjectRequestedResource(String project_name, String project_proposer);
	
	public void update(String new_resource_name, String new_resource_category, String new_request_description,
			String project_name, String old_resource_name, String old_resource_category, String project_proposer);
	
	public void tagResourceOfferer(String project_name,String resource_name, String project_proposer, String confirmed_offeror);
}
