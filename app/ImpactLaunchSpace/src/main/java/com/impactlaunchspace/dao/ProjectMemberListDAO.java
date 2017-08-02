package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.ProjectMemberList;

public interface ProjectMemberListDAO {
	public void insert(ProjectMemberList projectMemberList);
	public void remove(ProjectMemberList projectMemberList);
	public ArrayList<ProjectMemberList> retrieveMemberList(String project_name, String project_proposer);
}
