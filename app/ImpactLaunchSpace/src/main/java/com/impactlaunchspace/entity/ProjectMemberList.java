package com.impactlaunchspace.entity;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class ProjectMemberList {
	private String project_name;
	private String project_proposer;
	private String project_member_username;
	private String project_role;
	private String joined_timestamp;
	
	public ProjectMemberList(String project_name, String project_proposer, String project_member_username,
			String project_role) {
		super();
		this.project_name = project_name;
		this.project_proposer = project_proposer;
		this.project_member_username = project_member_username;
		this.project_role = project_role;
		this.joined_timestamp = calculateJoinedTime();
	}

	public ProjectMemberList(String project_name, String project_proposer, String project_member_username,
			String project_role, String joined_timestamp) {
		super();
		this.project_name = project_name;
		this.project_proposer = project_proposer;
		this.project_member_username = project_member_username;
		this.project_role = project_role;
		this.joined_timestamp = joined_timestamp;
	}

	public String getProject_name() {
		return project_name;
	}

	public String getProject_proposer() {
		return project_proposer;
	}

	public String getProject_member_username() {
		return project_member_username;
	}

	public String getProject_role() {
		return project_role;
	}
	
	public String getJoined_timestamp() {
		return joined_timestamp;
	}
	
	private String calculateJoinedTime() {
		Calendar now = Calendar.getInstance();
		Date dt = now.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String joinedTime = sdf.format(dt);
		return joinedTime;
	}
	
}
