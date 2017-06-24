package com.impactlaunchspace.dao;

import com.impactlaunchspace.entity.ResetToken;

public interface ResetTokenDAO {
		public void insert(ResetToken reset_token);
	    public ResetToken retrieveResetToken(String username);
	    public void updateResetCode(String resetCode, String username, String expiryDate);
}
