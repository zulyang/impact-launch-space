package com.impactlaunchspace.jdbc;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
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
			ps.setBlob(6, new FileInputStream(organizationAccount.getProfilePicture()));
			ps.setString(7, organizationAccount.getCompanyBio());
			ps.setString(8, organizationAccount.getContactDetails());
			ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			throw new RuntimeException(e);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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

				File temp = File.createTempFile("temp-file-name", ".jpeg");
				Blob blob = rs.getBlob("profilePicture");
				InputStream in = blob.getBinaryStream();
				OutputStream out = new FileOutputStream(temp);
				byte[] buff = new byte[4096]; // how much of the blob to
												// read/write at a time
				int len = 0;

				while ((len = in.read(buff)) != -1) {
					out.write(buff, 0, len);
				}

				organizationAccount = new OrganizationAccount(rs.getString("username"), rs.getString("email"),
						rs.getString("companyName"), rs.getBoolean("needsSupport"), rs.getBoolean("offeringSupport"),
						temp, rs.getString("companyBio"), rs.getString("contactDetails"));
			}
			rs.close();
			ps.close();
			return organizationAccount;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
		return null;
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
				File temp = File.createTempFile("temp-file-name", ".jpeg");
				Blob blob = rs.getBlob("profilePicture");
				InputStream in = blob.getBinaryStream();
				OutputStream out = new FileOutputStream(temp);
				byte[] buff = new byte[4096]; // how much of the blob to
												// read/write at a time
				int len = 0;

				while ((len = in.read(buff)) != -1) {
					out.write(buff, 0, len);
				}

				organizationAccount = new OrganizationAccount(rs.getString("username"), rs.getString("email"),
						rs.getString("companyName"), rs.getBoolean("needsSupport"), rs.getBoolean("offeringSupport"),
						temp, rs.getString("companyBio"), rs.getString("contactDetails"));
			}
			rs.close();
			ps.close();
			return organizationAccount;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
		return null;

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
				File temp = File.createTempFile("temp-file-name", ".jpeg");
				Blob blob = rs.getBlob("profilePicture");
				InputStream in = blob.getBinaryStream();
				OutputStream out = new FileOutputStream(temp);
				byte[] buff = new byte[4096]; // how much of the blob to
												// read/write at a time
				int len = 0;

				while ((len = in.read(buff)) != -1) {
					out.write(buff, 0, len);
				}

				organizationAccount = new OrganizationAccount(rs.getString("username"), rs.getString("email"),
						rs.getString("companyName"), rs.getBoolean("needsSupport"), rs.getBoolean("offeringSupport"),
						temp, rs.getString("companyBio"), rs.getString("contactDetails"));

				output.add(organizationAccount);
			}
			rs.close();
			ps.close();
			return output;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
		return output;
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
				File temp = File.createTempFile("temp-file-name", ".jpeg");
				Blob blob = rs.getBlob("profilePicture");
				InputStream in = blob.getBinaryStream();
				OutputStream out = new FileOutputStream(temp);
				byte[] buff = new byte[4096]; // how much of the blob to
												// read/write at a time
				int len = 0;

				while ((len = in.read(buff)) != -1) {
					out.write(buff, 0, len);
				}

				organizationAccount = new OrganizationAccount(rs.getString("username"), rs.getString("email"),
						rs.getString("companyName"), rs.getBoolean("needsSupport"), rs.getBoolean("offeringSupport"),
						temp, rs.getString("companyBio"), rs.getString("contactDetails"));

				output.add(organizationAccount);
			}
			rs.close();
			ps.close();
			return output;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
		return output;
	}

}
