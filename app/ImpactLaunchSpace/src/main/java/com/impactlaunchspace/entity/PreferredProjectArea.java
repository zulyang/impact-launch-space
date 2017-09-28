package com.impactlaunchspace.entity;

public class PreferredProjectArea {
	private String project_area;
	private String username;
	
	public PreferredProjectArea(String project_area, String username) {
		super();
		this.project_area = project_area;
		this.username = username;
	}

	public String getProject_area() {
		return project_area;
	}

	public String getUsername() {
		return username;
	}
	
	
}
