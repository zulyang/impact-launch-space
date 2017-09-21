package com.impactlaunchspace.entity;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class ProjectUpdate {
	private String project_name;
	private String project_proposer;
	private String update_title;
	private String update_contents;
	private String posted_time;
	
	
	public ProjectUpdate(String project_name, String project_proposer, String update_title,
			String update_contents) {
		super();
		this.project_name = project_name;
		this.project_proposer = project_proposer;
		this.update_title = update_title;
		this.update_contents = update_contents;
		this.posted_time = calculateUpdateTime();;
	}
	
	public ProjectUpdate(String project_name, String project_proposer, String update_title, String update_contents,
			String posted_time) {
		super();
		this.project_name = project_name;
		this.project_proposer = project_proposer;
		this.update_title = update_title;
		this.update_contents = update_contents;
		this.posted_time = posted_time;
	}
	
	public String getProject_name() {
		return project_name;
	}
	public String getProject_proposer() {
		return project_proposer;
	}
	public String getUpdate_title() {
		return update_title;
	}
	public String getUpdate_contents() {
		return update_contents;
	}
	public String getPosted_time() {
		return posted_time;
	}
	
	private String calculateUpdateTime() {
		Calendar now = Calendar.getInstance();
		Date dt = now.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatedTime = sdf.format(dt);
		return updatedTime;
	}
}

