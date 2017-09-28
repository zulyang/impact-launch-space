package com.impactlaunchspace.entity;

public class ProjectResourceCategory {
	private String project_name;
	private String resource_category;
	private String project_proposer;
	
	public ProjectResourceCategory(String project_name, String resource_category, String project_proposer) {
		super();
		this.project_name = project_name;
		this.resource_category = resource_category;
		this.project_proposer = project_proposer;
	}

	public String getProject_name() {
		return project_name;
	}

	public String getResource_category() {
		return resource_category;
	}
	
	public String getProject_proposer() {
		return project_proposer;
	}
	
}
