package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.PreferredCountry;

public interface PreferredCountryDAO {
	public void insert(PreferredCountry preferredCountry);
	public ArrayList<PreferredCountry> retrievePreferredCountries(String username);
	public void deleteUserPreferredCountry(String username);
}
