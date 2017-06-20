package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.impactlaunchspace.entity.ResetToken;

public class JdbcResetTokenDAO {
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	public void insert(ResetToken reset_token){
		String sql = "INSERT INTO reset_tokens " + "(reset_code, username) VALUES (?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, reset_token.getReset_code());
			ps.setString(2,  reset_token.getUsername());
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
		String sql = "SELECT * FROM reset_tokens WHERE username = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ResetToken reset_token = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				reset_token = new ResetToken(rs.getString("reset_code"), rs.getString("username"));
			}
			rs.close();
			ps.close();
			return reset_token.getReset_code();
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
	
	public void updateVerificationCode(String resetCode, String username) {
		//this method is used to update the verification code in the VT DB

		String sql = "UPDATE reset_tokens SET reset_code = ? WHERE username = ?";

		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, resetCode);
			ps.setString(2, username);
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
}
