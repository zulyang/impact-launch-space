package com.impactlaunchspace.entity;

public class PreferredCountry {
	private String country_name;
	private String username;
	
	public PreferredCountry(String country_name, String username) {
		super();
		this.country_name = country_name;
		this.username = username;
	}
	
	public String getCountry_name() {
		return country_name;
	}
	public String getUsername() {
		return username;
	}
	
}
