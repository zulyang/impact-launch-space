package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.JobSectorIndividual;

public interface JobSectorIndividualDAO {
	public void insert(JobSectorIndividual jobSectorIndividual);
	public ArrayList<JobSectorIndividual> retrieveIndividualJobSectors(String username);
	public void deleteUserJobSectorIndividual(String username);
}

