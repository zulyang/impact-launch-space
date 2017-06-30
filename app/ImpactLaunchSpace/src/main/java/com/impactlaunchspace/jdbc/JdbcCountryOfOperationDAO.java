package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.CountryOfOperationDAO;
import com.impactlaunchspace.entity.CountryOfOperation;

public class JdbcCountryOfOperationDAO implements CountryOfOperationDAO{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	
	public void insert(CountryOfOperation countryOfOperation){
		String sql = "INSERT INTO COUNTRIES_OF_OPERATIONS " + "(country_name, username) VALUES (?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, countryOfOperation.getCountry_name());
			ps.setString(2, countryOfOperation.getUsername());
			ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			throw new RuntimeException(e);

		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}
	
	public ArrayList<CountryOfOperation> retrieveCountriesOfOperations(String username){
		ArrayList<CountryOfOperation> output = new ArrayList<CountryOfOperation>();
		
		String sql = "SELECT * FROM COUNTRIES_OF_OPERATIONS WHERE username = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			CountryOfOperation countryOfOperation = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				countryOfOperation = new CountryOfOperation(rs.getString(1),rs.getString(2));
				output.add(countryOfOperation);
			}
			rs.close();
			ps.close();
			return output;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}
	
	
}
