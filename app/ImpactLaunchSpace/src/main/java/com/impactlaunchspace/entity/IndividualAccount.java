package com.impactlaunchspace.entity;

import java.sql.Blob;
import java.sql.Date;

public class IndividualAccount{
	//primary key is username
	private String username;
	
	private Date dateOfBirth;
	private String country;
	private String jobTitle;
	
	//at least 1 job sector, and up to 3
	private String jobSector1;
	private int js1YearsOfExperience;
	
	private String jobSector2;
	private int js2YearsOfExperience;
	private String jobSector3;
	private int js3YearsOfExperience;
	
	//Multiple skills are separated with commas
	private String skills;
	
	//Multiple sectors that the user is interested to 
	//contribute in can be defined, separated with commas
	private String interestedSectorsToUser;
	
	//Client says could filter in another way ways
	private String importantSectorsToUser;
	
	//takes the values from a range an puts them in integers e.g. 1-2 hours
	private int minimumVolunteerHours;
	private int maximumVolunteerHours;
	
	//Multiple countries that the user is interested to work in
	private String interestedCountries;
	
	//ONLY 1 ORGANIZATION CAN BE CHOSEN
	private String organization;
	
	//checking this makes the profile visible to others for chatting/headhunting
	private boolean isPublicProfile;
	
	//profile based information (optional fields that can be deferred till after creation)
	private Blob profilePicture;
	private String personalBio;
	private String contactDetails;
	
	//Default constructor, some fields can accept null values
	public IndividualAccount(String username, Date dateOfBirth, String country, String jobTitle, String jobSector1,
			int js1YearsOfExperience, String jobSector2, int js2YearsOfExperience, String jobSector3,
			int js3YearsOfExperience, String skills, String interestedSectorsToUser, String importantSectorsToUser,
			int minimumVolunteerHours, int maximumVolunteerHours, String interestedCountries, String organization,
			boolean isPublicProfile, Blob profilePicture, String personalBio, String contactDetails) {
		super();
		this.username = username;
		this.dateOfBirth = dateOfBirth;
		this.country = country;
		this.jobTitle = jobTitle;
		this.jobSector1 = jobSector1;
		this.js1YearsOfExperience = js1YearsOfExperience;
		
		//these can be null:
		this.jobSector2 = jobSector2;
		this.js2YearsOfExperience = js2YearsOfExperience;
		this.jobSector3 = jobSector3;
		this.js3YearsOfExperience = js3YearsOfExperience;
		//end of comment
		
		this.skills = skills;
		this.interestedSectorsToUser = interestedSectorsToUser;
		this.importantSectorsToUser = importantSectorsToUser;
		this.minimumVolunteerHours = minimumVolunteerHours;
		this.maximumVolunteerHours = maximumVolunteerHours;
		this.interestedCountries = interestedCountries;
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
	public Date getDateOfBirth() {
		return dateOfBirth;
	}
	public String getCountry() {
		return country;
	}
	public String getJobTitle() {
		return jobTitle;
	}
	public String getJobSector1() {
		return jobSector1;
	}
	public int getJs1YearsOfExperience() {
		return js1YearsOfExperience;
	}
	public String getJobSector2() {
		return jobSector2;
	}
	public int getJs2YearsOfExperience() {
		return js2YearsOfExperience;
	}
	public String getJobSector3() {
		return jobSector3;
	}
	public int getJs3YearsOfExperience() {
		return js3YearsOfExperience;
	}
	public String getSkills() {
		return skills;
	}
	public String getInterestedSectorsToUser() {
		return interestedSectorsToUser;
	}
	public String getImportantSectorsToUser() {
		return importantSectorsToUser;
	}
	public int getMinimumVolunteerHours() {
		return minimumVolunteerHours;
	}
	public int getMaximumVolunteerHours() {
		return maximumVolunteerHours;
	}
	public String getInterestedCountries() {
		return interestedCountries;
	}
	public String getOrganization() {
		return organization;
	}
	public boolean isPublicProfile() {
		return isPublicProfile;
	}
	public Blob getProfilePicture() {
		return profilePicture;
	}
	public String getPersonalBio() {
		return personalBio;
	}
	public String getContactDetails() {
		return contactDetails;
	}
	
	
}
