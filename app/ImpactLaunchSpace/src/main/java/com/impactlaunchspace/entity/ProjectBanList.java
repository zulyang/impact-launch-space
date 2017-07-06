package com.impactlaunchspace.entity;

public class ProjectBanList {
	private String project_name;
	private String banned_username;
	
	public ProjectBanList(String project_name, String banned_username) {
		super();
		this.project_name = project_name;
		this.banned_username = banned_username;
	}

	public String getProject_name() {
		return project_name;
	}

	public String getBanned_username() {
		return banned_username;
	}
	
}
