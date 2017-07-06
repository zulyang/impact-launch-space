package com.impactlaunchspace.entity;

public class ProjectTargetArea {
	private String project_name;
	private String project_area;
	
	public ProjectTargetArea(String project_name, String project_area) {
		super();
		this.project_name = project_name;
		this.project_area = project_area;
	}
	
	public String getProject_name() {
		return project_name;
	}
	public String getProject_area() {
		return project_area;
	}
	
}
