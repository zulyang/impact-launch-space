package com.impactlaunchspace.entity;

public class PreferredJobSector {
	private String job_sector;
	private String username;
	
	public PreferredJobSector(String job_sector, String username) {
		super();
		this.job_sector = job_sector;
		this.username = username;
	}

	public String getJob_sector() {
		return job_sector;
	}

	public String getUsername() {
		return username;
	}
	
	
}
