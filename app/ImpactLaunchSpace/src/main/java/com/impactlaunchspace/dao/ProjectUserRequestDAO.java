package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.ProjectUserRequest;

public interface ProjectUserRequestDAO {
	public void insert(ProjectUserRequest projectUserRequest);

	public void remove(ProjectUserRequest projectUserRequest);

	public ArrayList<ProjectUserRequest> retrieveAll(String project_name, String project_proposer);

	public ArrayList<ProjectUserRequest> retrieveAllUserRequestsForRequestedResourceCategory(String project_name,
			String project_proposer, String requested_resource_category);

	public ArrayList<ProjectUserRequest> retrieveAllUserRequestsForRequestedResourceName(String project_name,
			String project_proposer, String requested_resource_category, String requested_resource_name);

	public ProjectUserRequest retrieveParticularUserRequest(String project_name, String project_proposer,
			String resource_offerer, String requested_resource_category, String requested_resource_name,
			String offered_resource_category, String offered_resource_name);
	
	public ArrayList<ProjectUserRequest> retrieveProjectRequestsOfUser(String project_name, String project_proposer, String username);
	
	public void confirmRequest(String project_name, String requested_resource_category, String requested_resource_name, String project_proposer, String resource_offerer, String offered_resource_category, String offered_resource_name);
	
	public void rejectRequest(String project_name, String requested_resource_category, String requested_resource_name, String project_proposer, String resource_offerer, String offered_resource_category, String offered_resource_name);
	
	public void cancelRequest(String project_name, String requested_resource_category, String requested_resource_name, String project_proposer, String resource_offerer, String offered_resource_category, String offered_resource_name);
	
}
