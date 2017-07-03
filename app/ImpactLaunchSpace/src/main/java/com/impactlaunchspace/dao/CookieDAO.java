package com.impactlaunchspace.dao;

public interface CookieDAO {
	//Insert new cookie into database
	public void insert(String username, String secret);

	//Validate cookie from database
	public String validateCookie(String secret);

	//Remove cookie from database
	public void delete(String username);
	

}