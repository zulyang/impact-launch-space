package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.mindrot.jbcrypt.BCrypt;

import com.impactlaunchspace.dao.UserDAO;
import com.impactlaunchspace.entity.User;

public class JdbcUserDAO implements UserDAO{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void insert(User user) {

		String sql = "INSERT INTO USERS " + "(username, password, email, keep_me_signed_in, enabled, user_type, login_attempts, user_role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getEmail());
			ps.setBoolean(4, user.isKeep_me_signed_in());
			ps.setBoolean(5, user.isEnabled());
			ps.setString(6, user.getUser_type());
			ps.setInt(7, user.getLogin_attempts());
			ps.setString(8, user.getUser_role());
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

	public User findByUsername(String username) {

		String sql = "SELECT * FROM USERS WHERE username = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			User user = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				user = new User(rs.getString("username"), rs.getString("password"), rs.getString("email"),
						rs.getBoolean("keep_me_signed_in"), rs.getBoolean("enabled"),rs.getString("user_type")
						,rs.getInt("login_attempts"),rs.getString("user_role"));
			}
			rs.close();
			ps.close();
			return user;
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
	
	public User findByEmail(String email) {

		String sql = "SELECT * FROM USERS WHERE email = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			User user = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				user = new User(rs.getString("username"), rs.getString("password"), rs.getString("email"),
						rs.getBoolean("keep_me_signed_in"), rs.getBoolean("enabled"),rs.getString("user_type")
						,rs.getInt("login_attempts"),rs.getString("user_role"));
			}
			rs.close();
			ps.close();
			return user;
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
	
	public void updatePasswordInDB(String username, String plaintextPw) {
		//this method is used predominantly to restore variable salt
		//the password is hashed with a salt and stored into the database
		//after each login
		
		//this method is also used to change password/reset pw etc
		String sql = "UPDATE users SET password = ? WHERE username = ?";
		
		//hash the plaintext pw
		String newCipherTextPw = BCrypt.hashpw(plaintextPw, BCrypt.gensalt());
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, newCipherTextPw);
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
	
	public void unlockAccount(String username){
		//this method is for setting account status to be enabled
		
		//this method is also used to change password/reset pw etc
		String sql = "UPDATE users SET enabled = true WHERE username = ?";
		
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
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
	
	public void lockAccount(String username){
		//this method is for setting account status to be enabled
		
		//this method is also used to change password/reset pw etc
		String sql = "UPDATE users SET enabled = false WHERE username = ?";
		
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
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
	
	
	public int getLoginAttempts(String username){
		//this method retrieves the login attempts for a particular username
		String sql = "SELECT login_attempts FROM USERS WHERE username = ?";
		
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			int result = 0;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				result = rs.getInt("login_attempts");
			}
			rs.close();
			ps.close();
			return result;
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
	
	public void resetLoginAttempts(String username){
		//this method resets the login attempts for a user, 
		String sql = "UPDATE users SET login_attempts = 0 WHERE username = ?";
		
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
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
	
	public void increaseLoginAttempts(String username){
		//this method resets the login attempts for a user, 
		String sql = "UPDATE users SET login_attempts = login_attempts+1 WHERE username = ?";
		
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
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