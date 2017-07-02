package com.impactlaunchspace.entity;

import java.io.File;
import java.sql.Blob;
import java.sql.Date;

public class IndividualAccount{
	//primary key is username
	private String username;
	private String email;
	
	private String first_name;
	private String last_name;
	
	private Date dateOfBirth;
	private String country;
	private String jobTitle;
	
	//takes the values from a range an puts them in integers e.g. 1-2 hours
	private int minimumVolunteerHours;
	private int maximumVolunteerHours;

	//ONLY 1 ORGANIZATION CAN BE CHOSEN
	private String organization;
	
	//checking this makes the profile visible to others for chatting/headhunting
	private boolean isPublicProfile;
	
	//profile based information (optional fields that can be deferred till after creation)
	private File profilePicture;
	private String personalBio;
	private String contactDetails;
	
	//Default constructor, some fields can accept null values
	public IndividualAccount(String username, String email,Date dateOfBirth,String first_name, 
			String last_name,  String country, String jobTitle,
			int minimumVolunteerHours, int maximumVolunteerHours, String organization,
			boolean isPublicProfile, File profilePicture, String personalBio, String contactDetails) {
		super();
		this.username = username;
		this.email = email;
		this.first_name = first_name;
		this.last_name = last_name;
		this.dateOfBirth = dateOfBirth;
		this.country = country;
		this.jobTitle = jobTitle;
		
		this.minimumVolunteerHours = minimumVolunteerHours;
		this.maximumVolunteerHours = maximumVolunteerHours;
		this.organization = organization;
		this.isPublicProfile = isPublicProfile;
		
		//these can also be null
		this.profilePicture = profilePicture;
		this.personalBio = personalBio;
		this.contactDetails = contactDetails;
	}
	
	
	public String getUsername() {
		return username;
	}
	
	public String getEmail() {
		return email;
	}
	
	public String getFirst_name() {
		return first_name;
	}
	
	public String getLast_name() {
		return last_name;
	}
	
	public Date getDateOfBirth() {
		return dateOfBirth;
	}
	public String getCountry() {
		return country;
	}
	public String getJobTitle() {
		return jobTitle;
	}
	
	public int getMinimumVolunteerHours() {
		return minimumVolunteerHours;
	}
	public int getMaximumVolunteerHours() {
		return maximumVolunteerHours;
	}
	public String getOrganization() {
		return organization;
	}
	public boolean isPublicProfile() {
		return isPublicProfile;
	}
	public File getProfilePicture() {
		return profilePicture;
	}
	public String getPersonalBio() {
		return personalBio;
	}
	public String getContactDetails() {
		return contactDetails;
	}
	
	
}
