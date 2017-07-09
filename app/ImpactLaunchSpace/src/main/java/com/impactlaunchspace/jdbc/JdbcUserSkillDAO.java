package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.UserSkillDAO;
import com.impactlaunchspace.entity.UserSkill;

public class JdbcUserSkillDAO implements UserSkillDAO{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	
	public void insert(UserSkill userSkill){
		String sql = "INSERT INTO user_skills " + "(skillset, username) VALUES (?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, userSkill.getSkillset());
			ps.setString(2, userSkill.getUsername());
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
	public ArrayList<UserSkill> retrieveAllSkillsOfUser(String username){
		ArrayList<UserSkill> output = new ArrayList<UserSkill>();
		
		String sql = "SELECT * FROM user_skills WHERE username = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			UserSkill userSkill = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				userSkill = new UserSkill(rs.getString(1),rs.getString(2));
				output.add(userSkill);
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
	
	public void deleteUserSkillset(String username){
		String sql = "DELETE FROM user_skills WHERE username = ?";
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
