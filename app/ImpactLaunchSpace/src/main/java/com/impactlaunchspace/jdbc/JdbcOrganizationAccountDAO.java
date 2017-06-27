package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.OrganizationAccountDAO;
import com.impactlaunchspace.entity.OrganizationAccount;

public class JdbcOrganizationAccountDAO implements OrganizationAccountDAO {
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void insert(OrganizationAccount organizationAccount) {
		String sql = "INSERT INTO ORGANIZATION_ACCOUNTS "
				+ "(username,  email, companyName, needsSupport, offeringSupport, profilePicture, companyBio, contactDetails) VALUES (?, ?, ?, ?, ? ,? ,? ,?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, organizationAccount.getUsername());
			ps.setString(2, organizationAccount.getEmail());
			ps.setString(3, organizationAccount.getCompanyName());
			ps.setBoolean(4, organizationAccount.isNeedsSupport());
			ps.setBoolean(5, organizationAccount.isOfferingSupport());
			ps.setBlob(6, organizationAccount.getProfilePicture());
			ps.setString(7, organizationAccount.getCompanyBio());
			ps.setString(8, organizationAccount.getContactDetails());
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

	public OrganizationAccount findByUsername(String username) {

		String sql = "SELECT * FROM ORGANIZATION_ACCOUNTS WHERE username = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			OrganizationAccount organizationAccount = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				organizationAccount = new OrganizationAccount(rs.getString("username"), rs.getString("email"),rs.getString("companyName"),
						rs.getBoolean("needsSupport"), rs.getBoolean("offeringSupport"), rs.getBlob("profilePicture"),
						rs.getString("companyBio"), rs.getString("contactDetails"));
			}
			rs.close();
			ps.close();
			return organizationAccount;
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

	public OrganizationAccount findByEmail(String email) {

		String sql = "SELECT * FROM ORGANIZATION_ACCOUNTS WHERE email = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			OrganizationAccount organizationAccount = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				organizationAccount = new OrganizationAccount(rs.getString("username"), rs.getString("email"),rs.getString("companyName"),
						rs.getBoolean("needsSupport"), rs.getBoolean("offeringSupport"), rs.getBlob("profilePicture"),
						rs.getString("companyBio"), rs.getString("contactDetails"));
			}
			rs.close();
			ps.close();
			return organizationAccount;
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

	public ArrayList<OrganizationAccount> retrieveOrganizationsNeedingSupport() {

		ArrayList<OrganizationAccount> output = new ArrayList<OrganizationAccount>();
		String sql = "SELECT * FROM ORGANIZATION_ACCOUNTS WHERE needsSupport = true";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			OrganizationAccount organizationAccount = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				organizationAccount = new OrganizationAccount(rs.getString("username"), rs.getString("email"),rs.getString("companyName"),
						rs.getBoolean("needsSupport"), rs.getBoolean("offeringSupport"), rs.getBlob("profilePicture"),
						rs.getString("companyBio"), rs.getString("contactDetails"));

				output.add(organizationAccount);
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

	public ArrayList<OrganizationAccount> retrieveOrganizationsOfferingSupport() {

		ArrayList<OrganizationAccount> output = new ArrayList<OrganizationAccount>();
		String sql = "SELECT * FROM ORGANIZATION_ACCOUNTS WHERE offeringSupport = true";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			OrganizationAccount organizationAccount = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				organizationAccount = new OrganizationAccount(rs.getString("username"), rs.getString("email"),rs.getString("companyName"),
						rs.getBoolean("needsSupport"), rs.getBoolean("offeringSupport"), rs.getBlob("profilePicture"),
						rs.getString("companyBio"), rs.getString("contactDetails"));

				output.add(organizationAccount);
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
