package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.JobSectorOrganization;

public interface JobSectorOrganizationDAO {
	public void insert(JobSectorOrganization jobSectorOrganization);
	public ArrayList<JobSectorOrganization> retrieveOrganizationJobSectors(String username);
	public void deleteUserJobSectorOrganization(String username);
}

