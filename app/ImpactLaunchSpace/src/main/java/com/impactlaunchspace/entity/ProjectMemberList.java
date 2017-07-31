package com.impactlaunchspace.entity;

public class ProjectMemberList {
	private String project_name;
	private String project_proposer;
	private String project_member_username;
	private String project_role;
	
	public ProjectMemberList(String project_name, String project_proposer, String project_member_username,
			String project_role) {
		super();
		this.project_name = project_name;
		this.project_proposer = project_proposer;
		this.project_member_username = project_member_username;
		this.project_role = project_role;
	}

	public String getProject_name() {
		return project_name;
	}

	public String getProject_proposer() {
		return project_proposer;
	}

	public String getProject_member_username() {
		return project_member_username;
	}

	public String getProject_role() {
		return project_role;
	}
	
	
}
