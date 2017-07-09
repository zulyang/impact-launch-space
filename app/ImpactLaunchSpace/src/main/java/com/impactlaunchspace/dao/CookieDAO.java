package com.impactlaunchspace.dao;

public interface CookieDAO {
	//Insert new cookie into database
	public void insert(String username, String secret);

	//Validate cookie from database
	public String validateCookie(String secret);

	//Remove cookie from database
	public void delete(String username);
	
	//Update cookie from database
	public void update(String username ,String secret);

	//Check whether there is a record in the database.
	public boolean haveRecord(String username);
	

}