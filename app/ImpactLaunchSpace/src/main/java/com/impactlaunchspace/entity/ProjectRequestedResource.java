package com.impactlaunchspace.entity;

public class ProjectRequestedResource {
	private String project_name;
	private String resource_category;
	private String resource_name;
	private String request_description;
	
	public ProjectRequestedResource(String project_name, String resource_category, String resource_name,
			String request_description) {
		super();
		this.project_name = project_name;
		this.resource_category = resource_category;
		this.resource_name = resource_name;
		this.request_description = request_description;
	}

	public String getProject_name() {
		return project_name;
	}

	public String getResource_category() {
		return resource_category;
	}

	public String getResource_name() {
		return resource_name;
	}

	public String getRequest_description() {
		return request_description;
	}

	
}
