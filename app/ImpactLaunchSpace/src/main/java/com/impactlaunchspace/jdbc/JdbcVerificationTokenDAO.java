package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.VerificationTokenDAO;
import com.impactlaunchspace.entity.VerificationToken;
import com.impactlaunchspace.login.LoginService;

public class JdbcVerificationTokenDAO implements VerificationTokenDAO {
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	LoginService loginService = new LoginService();

	public void insert(VerificationToken verification_token) {
		String sql = "INSERT INTO verification_tokens " + "(verification_code, username, expiry_date) VALUES (?, ?, ?)";
		Connection conn = null;

		try {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			java.util.Date utilDate = dateFormat.parse(verification_token.getExpiryDate());
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			long time = sqlDate.getTime();

			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, verification_token.getVerification_code());
			ps.setString(2, verification_token.getUsername());
			ps.setTimestamp(3, new Timestamp(time));
			ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			throw new RuntimeException(e);

		} catch (ParseException e) {
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

	public VerificationToken retrieveVerificationToken(String usernameemail) {
		String sql = "SELECT * FROM verification_tokens WHERE username = ?";
		Connection conn = null;
		System.out.println(usernameemail + '3');

		System.out.println(loginService + "hahaha");
		String username = loginService.returnUsernameFromEmail(usernameemail);
		System.out.println(usernameemail);
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			VerificationToken verification_token = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				verification_token = new VerificationToken(rs.getString("verification_code"), rs.getString("username"),
						rs.getTimestamp("expiry_date").toString());
			}
			rs.close();
			ps.close();
			return verification_token;
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

	public void updateVerificationCode(String verificationCode, String username, String expiryDate) {
		// this method is used to update the verification code in the VT DB

		String sql = "UPDATE verification_tokens SET verification_code = ?, expiry_date = ? WHERE username = ?";

		Connection conn = null;

		try {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			java.util.Date utilDate = dateFormat.parse(expiryDate);
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			long time = sqlDate.getTime();

			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, verificationCode);
			ps.setTimestamp(2, new Timestamp(time));
			ps.setString(3, username);
			ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			throw new RuntimeException(e);

		} catch (ParseException e) {
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
