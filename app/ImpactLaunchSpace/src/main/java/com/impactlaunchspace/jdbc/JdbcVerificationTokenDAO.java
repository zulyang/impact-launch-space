package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.VerificationTokenDAO;
import com.impactlaunchspace.entity.User;
import com.impactlaunchspace.login.VerificationToken;

public class JdbcVerificationTokenDAO implements VerificationTokenDAO{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	public void insert(VerificationToken verification_token){
		String sql = "INSERT INTO verification_tokens " + "(verification_code, username) VALUES (?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, verification_token.getVerification_code());
			ps.setString(2,  verification_token.getUsername());
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
	public String retrieveVerificationCode(String username){
		String sql = "SELECT * FROM verification_tokens WHERE username = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			VerificationToken verification_token = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				verification_token = new VerificationToken(rs.getString("verification_code"), rs.getString("username"));
			}
			rs.close();
			ps.close();
			return verification_token.getVerification_code();
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
