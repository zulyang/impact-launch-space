package com.impactlaunchspace.dao;

import com.impactlaunchspace.entity.User;
import com.impactlaunchspace.login.VerificationToken;

public interface VerificationTokenDAO {
	public void insert(VerificationToken verification_token);
	public String retrieveVerificationCode(String username);
}