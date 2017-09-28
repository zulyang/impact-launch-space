package com.impactlaunchspace.entity;

public class ProjectTargetArea {
	private String project_name;
	private String project_area;
	private String project_proposer;
	
	public ProjectTargetArea(String project_name, String project_area, String project_proposer) {
		super();
		this.project_name = project_name;
		this.project_area = project_area;
		this.project_proposer = project_proposer;
	}
	
	public String getProject_name() {
		return project_name;
	}
	public String getProject_area() {
		return project_area;
	}
	public String getProject_proposer() {
		return project_proposer;
	}
	
}
