package com.impactlaunchspace.entity;

public class VerificationToken {
	private String verification_code;
	private String username;
		
	public VerificationToken(String verification_code, String username) {
		super();
		this.verification_code = verification_code;
		this.username = username;
	}

	public String getVerification_code() {
		return verification_code;
	}
	public String getUsername() {
		return username;
	}

}
