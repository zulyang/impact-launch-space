package com.impactlaunchspace.dao;

import com.impactlaunchspace.entity.OrganizationAccount;

public interface OrganizationAccountDAO {
	public void insert(OrganizationAccount organizationAccount);
	public OrganizationAccount findByUsername(String username);
	public OrganizationAccount findByEmail(String email);
}
