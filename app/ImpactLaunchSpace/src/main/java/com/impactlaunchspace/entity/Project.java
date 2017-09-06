package com.impactlaunchspace.entity;

import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Comparator;

public class Project{
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
	private Timestamp created_date;
	private int page_views;
	private File projectImage;
	private ArrayList<File> documentList;
	private String projectVideo;

	public Project(String project_name, String description, String purpose, int duration, String location,
			String project_proposer, String organization, boolean isPublic, boolean hiddenToOutsiders,
			boolean hiddenToAll, String project_status, Timestamp created_date, int page_views, 
			File projectImage, ArrayList<File> documentList, String projectVideo) {
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
		this.page_views = page_views;
		this.projectImage = projectImage;
		this.documentList = documentList;
		this.projectVideo = projectVideo;
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

	public Timestamp getCreated_date() {
		return created_date;
	}

	public int getPage_Views(){
		return page_views;
	}
	
	public File getProjectImage() {
		return projectImage;
	}
	
	public ArrayList<File> getDocumentList() {
		return documentList;
	}
	
	public String getProjectVideo() {
		return projectVideo;
	}

	//Comparator Methods

	//Popularity
	public static Comparator<Project> getProjectByAscPopularity() {
		Comparator<Project> comp = new Comparator<Project>() {
			@Override
			public int compare(Project p1, Project p2) {

				return Integer.valueOf(p1.getPage_Views()).compareTo(p2.getPage_Views());
			}
		};
		return comp;
	}

	public static Comparator<Project> getProjectByDescPopularity() {
		Comparator<Project> comp = new Comparator<Project>() {
			@Override
			public int compare(Project p1, Project p2) {

				return Integer.valueOf(p2.getPage_Views()).compareTo(p1.getPage_Views());
			}
		};
		return comp;
	}

	//Duration
	public static Comparator<Project> getProjectByAscDuration() {
		Comparator<Project> comp = new Comparator<Project>() {
			@Override
			public int compare(Project p1, Project p2) {

				return Integer.valueOf(p1.getDuration()).compareTo(p2.getDuration());
			}
		};
		return comp;
	}

	public static Comparator<Project> getProjectByDescDuration() {
		Comparator<Project> comp = new Comparator<Project>() {
			@Override
			public int compare(Project p1, Project p2) {

				return Integer.valueOf(p2.getDuration()).compareTo(p1.getDuration());
			}
		};
		return comp;
	}

	//Date
	public static Comparator<Project> getProjectByAscDate() {
		Comparator<Project> comp = new Comparator<Project>() {
			@Override
			public int compare(Project p1, Project p2) {

				return p1.getCreated_date().compareTo(p2.getCreated_date());
			}
		};
		return comp;
	}

	public static Comparator<Project> getProjectByDescDate() {
		Comparator<Project> comp = new Comparator<Project>() {
			@Override
			public int compare(Project p1, Project p2) {

				return p2.getCreated_date().compareTo(p1.getCreated_date());
			}
		};
		return comp;
	}
}
