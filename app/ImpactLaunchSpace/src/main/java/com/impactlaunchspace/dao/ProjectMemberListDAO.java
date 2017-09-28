package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.ProjectMemberList;

public interface ProjectMemberListDAO {
	public void insert(ProjectMemberList projectMemberList);

	public void remove(String project_name, String project_proposer, String project_member_username) ;

	public ArrayList<ProjectMemberList> retrieveMemberList(String project_name, String project_proposer);

	public ProjectMemberList retrieveSpecificMember(String project_name, String project_proposer,
			String project_member_username);
	
	public ArrayList<ArrayList<String>> retrieveJoinedProjects(String username);
}
