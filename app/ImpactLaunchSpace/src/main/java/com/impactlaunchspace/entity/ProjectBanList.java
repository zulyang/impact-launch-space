package com.impactlaunchspace.entity;

public class ProjectBanList {
	private String project_name;
	private String banned_username;
	private String project_proposer;
	
	public ProjectBanList(String project_name, String banned_username, String project_proposer) {
		super();
		this.project_name = project_name;
		this.banned_username = banned_username;
		this.project_proposer = project_proposer;
	}

	public String getProject_name() {
		return project_name;
	}

	public String getBanned_username() {
		return banned_username;
	}
	
	public String getProject_proposer() {
		return project_proposer;
	}
	
}
