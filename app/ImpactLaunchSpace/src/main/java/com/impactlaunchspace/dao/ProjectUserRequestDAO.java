package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.ProjectUserRequest;

public interface ProjectUserRequestDAO {
	public void insert(ProjectUserRequest projectUserRequest);
	public void remove(ProjectUserRequest projectUserRequest);
	public ArrayList<ProjectUserRequest> retrieveAll(String project_name, String project_proposer);
	public ArrayList<ProjectUserRequest> retrieveAllUserRequestsForRequestedResourceCategory(String project_name, String project_proposer, String requested_resource_category);
	public ArrayList<ProjectUserRequest> retrieveAllUserRequestsForRequestedResourceName(String project_name, String project_proposer, String requested_resource_category, String requested_resource_name);
}
