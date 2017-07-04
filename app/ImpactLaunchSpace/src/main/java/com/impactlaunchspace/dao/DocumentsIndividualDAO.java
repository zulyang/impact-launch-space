package com.impactlaunchspace.dao;

import java.io.File;
import java.util.ArrayList;

public interface DocumentsIndividualDAO {
	public void insert(String username, File document);
	public void delete(String username, File document);
	public ArrayList<File> retrieveAll(String username);
}
