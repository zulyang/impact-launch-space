package com.impactlaunchspace.dao;

import java.io.File;
import java.util.ArrayList;

import com.impactlaunchspace.entity.IndividualAccount;

public interface IndividualAccountDAO {
	public void insert(IndividualAccount individualAccount);
	public IndividualAccount findByUsername(String username);
	public IndividualAccount findByEmail(String email);
	public void update(IndividualAccount updatedIndividualAccount, String username);
}
