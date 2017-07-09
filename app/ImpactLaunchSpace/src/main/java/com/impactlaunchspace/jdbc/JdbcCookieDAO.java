package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

import javax.sql.DataSource;

import org.mindrot.jbcrypt.BCrypt;

import com.impactlaunchspace.dao.CookieDAO;

public class JdbcCookieDAO implements CookieDAO {
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void insert(String username, String secret) {

		String sql = "INSERT INTO REMEMBER_ME_COOKIES " + "(username, secret) VALUES (?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, secret);
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

	public void delete(String username) {

		String sql = "UPDATE REMEMBER_ME_COOKIES SET SECRET=? WHERE USERNAME=?";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, "null");
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

	public String validateCookie(String token) {

		String sql = "SELECT USERNAME FROM REMEMBER_ME_COOKIES WHERE SECRET = ?";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, token);
			String username = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				username = rs.getString("username");
			}
			rs.close();
			ps.close();
			return username;

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

	public void update(String username, String secret) {
		String sql = "UPDATE REMEMBER_ME_COOKIES SET SECRET = ? WHERE USERNAME = ?";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, secret);
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

	public boolean haveRecord(String username){
		String sql = "SELECT SECRET FROM REMEMBER_ME_COOKIES WHERE USERNAME = ?";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			String secret = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				secret = rs.getString("secret");
			}
			if(secret != null){
				return true;
			}else{
				return false;
			}
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
