package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.ProjectResourceCategory;

public interface ProjectResourceCategoryDAO {
	public void insert(ProjectResourceCategory projectResourceCategory);
	public ArrayList<ProjectResourceCategory> retrieveProjectResourceCategories(String project_name, String project_proposer);
	public void closeResourceCategory(String project_name, String project_proposer, String resource_category);
}
