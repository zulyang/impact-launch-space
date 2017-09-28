package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.Country;

public interface CountryDAO {
	public void insert(Country country);
	public void remove(Country country);
	public ArrayList<Country> retrieveAll();
}
