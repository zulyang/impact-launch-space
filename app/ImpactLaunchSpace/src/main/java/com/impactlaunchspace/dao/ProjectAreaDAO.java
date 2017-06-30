package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.ProjectArea;

public interface ProjectAreaDAO {
	public void insert(ProjectArea projectArea);
	public void remove(ProjectArea projectArea);
	public ArrayList<ProjectArea> retrieveAll();
}
