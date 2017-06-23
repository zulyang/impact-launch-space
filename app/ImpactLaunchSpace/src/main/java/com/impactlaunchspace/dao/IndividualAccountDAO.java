package com.impactlaunchspace.dao;

import com.impactlaunchspace.entity.IndividualAccount;

public interface IndividualAccountDAO {
	public void insert(IndividualAccount individualAccount);
	public IndividualAccount findByUsername(String username);
	public IndividualAccount findByEmail(String email);
}
