package com.impactlaunchspace.entity;

import java.sql.Blob;

public class OrganizationAccount{
	//primary key is username, this is also the company name
	private String username;
	
	//Multiple countries are available for input, seperated with commas
	private String countriesOfOperation;
	
	//at least 1 job sector, and up to 3
	private String jobSector1;
	
	private String jobSector2;
	private String jobSector3;
	
	//Organization profiles can align their profile to either these 2 options or both. 
	//Selecting the appropriate options will chase this value in db accordingly 
	private boolean needsSupport;
	private boolean offeringSupport;
	
	//profile based information (optional fields that can be deferred till after creation)
	private Blob profilePicture;
	private String companyBio;
	private String contactDetails;
	
	
	public OrganizationAccount(String username, String countriesOfOperation, String jobSector1, String jobSector2,
			String jobSector3, boolean needsSupport, boolean offeringSupport, Blob profilePicture, String companyBio,
			String contactDetails) {
		super();
		this.username = username;
		this.countriesOfOperation = countriesOfOperation;
		this.jobSector1 = jobSector1;
		this.jobSector2 = jobSector2;
		this.jobSector3 = jobSector3;
		this.needsSupport = needsSupport;
		this.offeringSupport = offeringSupport;
		this.profilePicture = profilePicture;
		this.companyBio = companyBio;
		this.contactDetails = contactDetails;
	}
	
	public String getUsername() {
		return username;
	}
	public String getCountriesOfOperation() {
		return countriesOfOperation;
	}
	public String getJobSector1() {
		return jobSector1;
	}
	public String getJobSector2() {
		return jobSector2;
	}
	public String getJobSector3() {
		return jobSector3;
	}
	public boolean isNeedsSupport() {
		return needsSupport;
	}
	public boolean isOfferingSupport() {
		return offeringSupport;
	}
	public Blob getProfilePicture() {
		return profilePicture;
	}
	public String getCompanyBio() {
		return companyBio;
	}
	public String getContactDetails() {
		return contactDetails;
	}
}
