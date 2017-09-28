package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.JobSector;

public interface JobSectorDAO {
	public void insert(JobSector jobSector);
	public void remove(JobSector jobSector);
	public ArrayList<JobSector> retrieveAll();
}
