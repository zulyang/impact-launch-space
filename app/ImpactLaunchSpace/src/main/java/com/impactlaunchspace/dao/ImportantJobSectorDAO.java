package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.ImportantJobSector;

public interface ImportantJobSectorDAO {
	public void insert(ImportantJobSector importantJobSector);
	public ArrayList<ImportantJobSector> retrieveImportantJobSectors(String username);
}
