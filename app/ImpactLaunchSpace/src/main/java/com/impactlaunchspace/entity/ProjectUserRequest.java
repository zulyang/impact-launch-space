package com.impactlaunchspace.entity;

public class ProjectUserRequest {
	private String project_name;
	private String requested_resource_category;
	private String requested_resource_name;
	private String project_proposer;
	private String resource_offerer;
	private String offered_resource_category;
	private String offered_resource_name;
	private String offered_request_description;
	private String offer_comments;
	private String request_status;
	
	public ProjectUserRequest(String project_name, String requested_resource_category, String requested_resource_name,
			String project_proposer, String resource_offerer, String offered_resource_category,
			String offered_resource_name, String offered_request_description, String offer_comments, String request_status) {
		super();
		this.project_name = project_name;
		this.requested_resource_category = requested_resource_category;
		this.requested_resource_name = requested_resource_name;
		this.project_proposer = project_proposer;
		this.resource_offerer = resource_offerer;
		this.offered_resource_category = offered_resource_category;
		this.offered_resource_name = offered_resource_name;
		this.offered_request_description = offered_request_description;
		this.offer_comments = offer_comments;
		this.request_status = request_status;
	}
	
	
	public String getProject_name() {
		return project_name;
	}
	public String getRequested_resource_category() {
		return requested_resource_category;
	}
	public String getRequested_resource_name() {
		return requested_resource_name;
	}
	public String getProject_proposer() {
		return project_proposer;
	}
	public String getResource_offerer() {
		return resource_offerer;
	}
	public String getOffered_resource_category() {
		return offered_resource_category;
	}
	public String getOffered_resource_name() {
		return offered_resource_name;
	}
	public String getOffered_request_description() {
		return offered_request_description;
	}
	public String getOffer_comments() {
		return offer_comments;
	}

	public String getRequest_status() {
		return request_status;
	}

	
}
