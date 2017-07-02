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

import javax.sql.DataSource;

import com.impactlaunchspace.dao.IndividualAccountDAO;
import com.impactlaunchspace.entity.IndividualAccount;
import com.impactlaunchspace.entity.OrganizationAccount;

public class JdbcIndividualAccountDAO implements IndividualAccountDAO{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	public void insert(IndividualAccount individualAccount){
		String sql = "INSERT INTO INDIVIDUAL_ACCOUNTS "
				+ "(username,  email, dateOfBirth, first_name, last_name, country, jobTitle, minimumVolunteerHours, maximumVolunteerHours, organization, isPublicProfile, profilePicture, personalBio, contactDetails) VALUES (?, ?, ?, ?, ? ,? ,? ,? ,? ,? ,? ,? ,? ,?)";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, individualAccount.getUsername());
			ps.setString(2, individualAccount.getEmail());
			ps.setDate(3, individualAccount.getDateOfBirth());
			ps.setString(4, individualAccount.getFirst_name());
			ps.setString(5, individualAccount.getLast_name());
			ps.setString(6, individualAccount.getCountry());
			ps.setString(7, individualAccount.getJobTitle());
			ps.setInt(8, individualAccount.getMinimumVolunteerHours());
			ps.setInt(9, individualAccount.getMaximumVolunteerHours());
			ps.setString(10, individualAccount.getOrganization());
			ps.setBoolean(11, individualAccount.isPublicProfile());
			ps.setBlob(12, new FileInputStream(individualAccount.getProfilePicture()));
			ps.setString(13, individualAccount.getPersonalBio());
			ps.setString(14, individualAccount.getContactDetails());
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
	public IndividualAccount findByUsername(String username){
		String sql = "SELECT * FROM INDIVIDUAL_ACCOUNTS WHERE username = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			IndividualAccount individualAccount = null;
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

				individualAccount = new IndividualAccount(rs.getString("username"), rs.getString("email"),
						rs.getDate("dateOfBirth"), rs.getString("first_name"),rs.getString("last_name"),
						rs.getString("country"), rs.getString("jobTitle"),rs.getInt("minimumVolunteerHours"),
						rs.getInt("maximumVolunteerHours"), rs.getString("organization"),
						rs.getBoolean("isPublicProfile"), temp, rs.getString("personalBio"), rs.getString("contactDetails"));
			}
			rs.close();
			ps.close();
			return individualAccount;
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
	public IndividualAccount findByEmail(String email){
		String sql = "SELECT * FROM INDIVIDUAL_ACCOUNTS WHERE email = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			IndividualAccount individualAccount = null;
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

				individualAccount = new IndividualAccount(rs.getString("username"), rs.getString("email"),
						rs.getDate("dateOfBirth"), rs.getString("first_name"),rs.getString("last_name"),
						rs.getString("country"), rs.getString("jobTitle"),rs.getInt("minimumVolunteerHours"),
						rs.getInt("maximumVolunteerHours"), rs.getString("organization"),
						rs.getBoolean("isPublicProfile"), temp, rs.getString("personalBio"), rs.getString("contactDetails"));
			}
			rs.close();
			ps.close();
			return individualAccount;
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
	
	
	public void update(IndividualAccount updatedIndividualAccount, String username){
		String sql = "UPDATE INDIVIDUAL_ACCOUNTS SET "
				+ "username = ?,  email = ?, dateOfBirth = ?, first_name = ?, last_name = ?, country = ?, jobTitle = ?, minimumVolunteerHours = ?, maximumVolunteerHours = ?, organization = ?, isPublicProfile = ?, profilePicture = ?, personalBio = ?, contactDetails = ?) WHERE username = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, updatedIndividualAccount.getUsername());
			ps.setString(2, updatedIndividualAccount.getEmail());
			ps.setDate(3, updatedIndividualAccount.getDateOfBirth());
			ps.setString(4, updatedIndividualAccount.getFirst_name());
			ps.setString(5, updatedIndividualAccount.getLast_name());
			ps.setString(6, updatedIndividualAccount.getCountry());
			ps.setString(7, updatedIndividualAccount.getJobTitle());
			ps.setInt(8, updatedIndividualAccount.getMinimumVolunteerHours());
			ps.setInt(9, updatedIndividualAccount.getMaximumVolunteerHours());
			ps.setString(10, updatedIndividualAccount.getOrganization());
			ps.setBoolean(11, updatedIndividualAccount.isPublicProfile());
			ps.setBlob(12, new FileInputStream(updatedIndividualAccount.getProfilePicture()));
			ps.setString(13, updatedIndividualAccount.getPersonalBio());
			ps.setString(14, updatedIndividualAccount.getContactDetails());
			ps.setString(15, username);
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
}
