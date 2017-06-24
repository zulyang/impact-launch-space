package com.impactlaunchspace.dao;

import com.impactlaunchspace.entity.VerificationToken;

public interface VerificationTokenDAO {
	  public void insert(VerificationToken verification_token);
	  public VerificationToken retrieveVerificationToken(String username);
	  public void updateVerificationCode(String verificationCode, String username, String expiryDate);
}