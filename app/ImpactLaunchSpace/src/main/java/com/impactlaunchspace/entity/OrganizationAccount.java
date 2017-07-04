package com.impactlaunchspace.entity;

import java.io.File;

public class OrganizationAccount {
	// primary key is username, this is also the company name
	private String username;
	private String email;
	private String companyName;

	// Organization profiles can align their profile to either these 2 options
	// or both.
	// Selecting the appropriate options will chase this value in db accordingly
	private boolean needsSupport;
	private boolean offeringSupport;

	// profile based information (optional fields that can be deferred till
	// after creation)
	private File profilePicture;
	private String companyBio;
	private String contactDetails;

	public OrganizationAccount(String username, String email, String companyName, boolean needsSupport,
			boolean offeringSupport, File profilePicture, String companyBio, String contactDetails) {
		super();
		this.username = username;
		this.email = email;
		this.companyName = companyName;
		this.needsSupport = needsSupport;
		this.offeringSupport = offeringSupport;
		this.profilePicture = profilePicture;
		this.companyBio = companyBio;
		this.contactDetails = contactDetails;
	}

	public String getUsername() {
		return username;
	}

	public String getEmail() {
		return email;
	}

	public String getCompanyName() {
		return companyName;
	}

	public boolean isNeedsSupport() {
		return needsSupport;
	}

	public boolean isOfferingSupport() {
		return offeringSupport;
	}

	public File getProfilePicture() {
		return profilePicture;
	}

	public String getCompanyBio() {
		return companyBio;
	}

	public String getContactDetails() {
		return contactDetails;
	}
}
