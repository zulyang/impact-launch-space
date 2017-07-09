package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.PreferredProjectArea;

public interface PreferredProjectAreaDAO {
	public void insert(PreferredProjectArea preferredProjectArea);
	public ArrayList<PreferredProjectArea> retrievePreferredProjectArea(String username);
	public void deleteUserPreferredProjectArea(String username);
}
