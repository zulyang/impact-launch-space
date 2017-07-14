package com.impactlaunchspace.entity;

import java.sql.Date;

public class Project {
	private String project_name;
	private String description;
	private String purpose;
	private int duration;
	private String location;
	private String project_proposer;
	private String organization;
	private boolean isPublic;
	private boolean hiddenToOutsiders;
	private boolean hiddenToAll;
	private String project_status;
	private Date created_date;

	public Project(String project_name, String description, String purpose, int duration, String location,
			String project_proposer, String organization, boolean isPublic, boolean hiddenToOutsiders,
			boolean hiddenToAll, String project_status, Date created_date) {
		super();
		this.project_name = project_name;
		this.description = description;
		this.purpose = purpose;
		this.duration = duration;
		this.location = location;
		this.project_proposer = project_proposer;
		this.organization = organization;
		this.isPublic = isPublic;
		this.hiddenToOutsiders = hiddenToOutsiders;
		this.hiddenToAll = hiddenToAll;
		this.project_status = project_status;
		this.created_date = created_date;
	}

	public String getProject_name() {
		return project_name;
	}

	public String getDescription() {
		return description;
	}

	public String getPurpose() {
		return purpose;
	}

	public int getDuration() {
		return duration;
	}

	public String getLocation() {
		return location;
	}

	public String getProject_proposer() {
		return project_proposer;
	}

	public String getOrganization() {
		return organization;
	}

	public boolean isPublic() {
		return isPublic;
	}

	public boolean isHiddenToOutsiders() {
		return hiddenToOutsiders;
	}

	public boolean isHiddenToAll() {
		return hiddenToAll;
	}

	public String getProject_status() {
		return project_status;
	}

	public Date getCreated_date() {
		return created_date;
	}

}
