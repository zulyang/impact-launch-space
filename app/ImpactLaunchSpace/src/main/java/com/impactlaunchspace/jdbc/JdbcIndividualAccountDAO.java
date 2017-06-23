package com.impactlaunchspace.jdbc;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.IndividualAccountDAO;
import com.impactlaunchspace.entity.IndividualAccount;

public class JdbcIndividualAccountDAO implements IndividualAccountDAO{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	public void insert(IndividualAccount individualAccount){
		
	}
	public IndividualAccount findByUsername(String username){
		return null;
	}
	public IndividualAccount findByEmail(String email){
		return null;
	}
}
