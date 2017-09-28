package com.impactlaunchspace.dao;

import java.io.File;
import java.util.ArrayList;

public interface DocumentsProjectDAO {
	public void insert(String projectName, String projectProposer, File document);
	public void delete(String projectName, String projectProposer, File document);
	public ArrayList<File> retrieveAll(String projectName, String projectProposer);
}
