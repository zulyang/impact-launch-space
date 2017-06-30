package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.PreferredCountryDAO;
import com.impactlaunchspace.entity.PreferredCountry;

public class JdbcPreferredCountryDAO implements PreferredCountryDAO{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	public void insert(PreferredCountry preferredCountry){
		String sql = "INSERT INTO PREFERRED_COUNTRIES " + "(country_name, username) VALUES (?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, preferredCountry.getCountry_name());
			ps.setString(2, preferredCountry.getUsername());
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
	public ArrayList<PreferredCountry> retrievePreferredCountries(String username){
		ArrayList<PreferredCountry> output = new ArrayList<PreferredCountry>();
		
		String sql = "SELECT * FROM PREFERRED_COUNTRIES WHERE username = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			PreferredCountry preferredCountry = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				preferredCountry = new PreferredCountry(rs.getString(1),rs.getString(2));
				output.add(preferredCountry);
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
