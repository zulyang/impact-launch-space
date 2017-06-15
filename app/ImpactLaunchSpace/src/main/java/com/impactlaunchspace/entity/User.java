package com.impactlaunchspace.entity;


import javax.validation.constraints.Size;

import org.springframework.security.crypto.bcrypt.BCrypt;

public class User {
	@Size(min=6, message="Username must contain at least 6 characters")
	private String username;
	
	@Size(min=8, message="Password must contain at least 8 characters")
	private String password;
	
	@Size(min=1, message="Email cannot be empty")
	private String email;
	
	private boolean keep_me_signed_in;
	
	private boolean enabled;
	
	private String user_type;
	
	private int login_attempts;
	
	public static final int MAX_LOGIN_ATTEMPTS = 5;
	
	public User(){
		
	}
	

	public User(String username, String password, String email, 
			boolean keep_me_signed_in, boolean enabled, String user_type,
			int login_attempts){
		this.username = username;
		this.password = password;
		this.email = email;
		this.keep_me_signed_in = keep_me_signed_in;
		this.enabled = enabled;
		this.user_type = user_type;
	}
	
	//this constructor is used for initializing account
	public User(String username, String password, String email, String user_type) {
		super();
		this.username = username;
		this.password = password;
		this.email = email;
		//by default don't keep user in session
		this.keep_me_signed_in = false;
		//by default not enabled
		this.enabled = false;
		this.user_type = user_type;
		this.login_attempts = 0;
	}
	
	public String getUsername() {
		return username;
	}
	public String getPassword() {
		return password;
	}
	public String getEmail() {
		return email;
	}
	public boolean isKeep_me_signed_in() {
		return keep_me_signed_in;
	}
	
	public boolean isEnabled() {
		return enabled;
	}

	public String getUser_type() {
		return user_type;
	}

	public int getLogin_attempts() {
		return login_attempts;
	}

}