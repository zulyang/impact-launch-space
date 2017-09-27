package com.impactlaunchspace.dao;

public interface CardDocumentDAO {
	//Insert new documents into database
	public void insertDocuments(int cardId, String fileNames);

	//Remove all documents from database
	public void deleteAll(int cardId);

	//Retrieve list of documents linked to this card
	public String[] retrieveList(int cardId);
		
}
