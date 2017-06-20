package com.impactlaunchspace.dao;

import com.impactlaunchspace.entity.ResetToken;

public interface ResetTokenDAO {
	public void insert(ResetToken reset_token);
	public String retrieveResetCode(String username);
	public void updateResetCode(String resetCode, String username);
}
