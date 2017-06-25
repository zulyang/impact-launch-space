package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.CountryOfOperation;

public interface CountryOfOperationDAO {
	public void insert(CountryOfOperation countryOfOperation);
	public ArrayList<CountryOfOperation> retrieveCountriesOfOperations(String username);
}
