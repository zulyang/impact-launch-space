package com.impactlaunchspace.entity;

public class ResetToken {
	private String reset_code;
	private String username;
		
	public ResetToken(String reset_code, String username) {
		super();
		this.reset_code = reset_code;
		this.username = username;
	}

	public String getReset_code() {
		return reset_code;
	}
	public String getUsername() {
		return username;
	}
}
