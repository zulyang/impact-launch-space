package com.impactlaunchspace.entity;

public class JobSectorIndividual {
	private String job_sector;
	private String username;
	private int yearsOfExperience;
	
	public JobSectorIndividual(String job_sector, String username, int yearsOfExperience) {
		super();
		this.job_sector = job_sector;
		this.username = username;
		this.yearsOfExperience = yearsOfExperience;
	}

	public int getYearsOfExperience() {
		return yearsOfExperience;
	}

	public String getJob_sector() {
		return job_sector;
	}

	public String getUsername() {
		return username;
	}
	
	
}
