package com.impactlaunchspace.entity;

public class UserSkill {
	private String skillset;
	private String username;
	
	public UserSkill(String skillset, String username) {
		super();
		this.skillset = skillset;
		this.username = username;
	}
	public String getSkillset() {
		return skillset;
	}
	public String getUsername() {
		return username;
	}
	
	
}
