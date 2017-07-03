package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.OrganizationAccount;

public interface OrganizationAccountDAO {
	public void insert(OrganizationAccount organizationAccount);
	public OrganizationAccount findByUsername(String username);
	public OrganizationAccount findByEmail(String email);
	public ArrayList<OrganizationAccount> retrieveOrganizationsNeedingSupport();
	public ArrayList<OrganizationAccount> retrieveOrganizationsOfferingSupport();
	public void update(OrganizationAccount updatedOrganizationAccount, String username);
}
