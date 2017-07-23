package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.UserOfferedResource;

public interface UserOfferedResourceDAO {
	public void insert(UserOfferedResource userOfferedResource);
	public void remove(UserOfferedResource userOfferedResource);
	public void update(UserOfferedResource userOfferedResource);
	public ArrayList<UserOfferedResource> retrieveAll(String username);
	public void removeAll(String username);
}