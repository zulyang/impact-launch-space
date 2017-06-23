package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.OrganizationAccountDAO;
import com.impactlaunchspace.entity.OrganizationAccount;

public class JdbcOrganizationAccountDAO implements OrganizationAccountDAO{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	public void insert(OrganizationAccount organizationAccount){
		String sql = "INSERT INTO ORGANIZATION_ACCOUNTS " + "(username,  email, countriesOfOperation, jobSector1, jobSector2, jobSector3, needsSupport, offeringSupport, profilePicture, companyBio, contactDetails) VALUES (?, ?, ?, ?, ?, ?, ?, ? ,? ,? ,?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, organizationAccount.getUsername());
			ps.setString(2, organizationAccount.getEmail());
			ps.setString(3, organizationAccount.getCountriesOfOperation());
			ps.setString(4, organizationAccount.getJobSector1());
			ps.setString(5, organizationAccount.getJobSector2());
			ps.setString(6, organizationAccount.getJobSector3());
			ps.setBoolean(7, organizationAccount.isNeedsSupport());
			ps.setBoolean(8, organizationAccount.isOfferingSupport());
			ps.setBlob(9, organizationAccount.getProfilePicture());
			ps.setString(10, organizationAccount.getCompanyBio());
			ps.setString(11, organizationAccount.getContactDetails());
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
	public OrganizationAccount findByUsername(String username){

		return null;
	}
	public OrganizationAccount findByEmail(String email){
		return null;
	}
}
