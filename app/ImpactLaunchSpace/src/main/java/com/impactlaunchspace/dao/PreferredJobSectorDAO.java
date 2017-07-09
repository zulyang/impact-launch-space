package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.PreferredJobSector;

public interface PreferredJobSectorDAO {
	public void insert(PreferredJobSector preferredJobSector);
	public ArrayList<PreferredJobSector> retrievePreferredJobSectors(String username);
	public void deleteUserPreferredJobSector(String username);
}
