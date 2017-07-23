package com.impactlaunchspace.entity;

public class UserOfferedResource {
	private String username;
	private String resourceCategory;
	private String resourceName;
	private String resourceDescription;
	
	public UserOfferedResource(String username, String resourceCategory, String resourceName, String resourceDescription){
		this.username = username;
		this.resourceCategory = resourceCategory;
		this.resourceName = resourceName;
		this.resourceDescription = resourceDescription;
	}

	public String getUsername() {
		return username;
	}

	public String getResourceCategory() {
		return resourceCategory;
	}
	
	public String getResourceName() {
		return resourceName;
	}
	
	public String getResourceDescription() {
		return resourceDescription;
	}
}
