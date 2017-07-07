package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.ProjectTargetAreaDAO;
import com.impactlaunchspace.entity.ProjectRequestedResource;
import com.impactlaunchspace.entity.ProjectTargetArea;

public class JdbcProjectTargetAreaDAO implements ProjectTargetAreaDAO {
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void insert(ProjectTargetArea projectTargetArea) {
		String sql = "INSERT INTO PROJECT_TARGET_AREAS " + "(project_name, project_area) VALUES (?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, projectTargetArea.getProject_name());
			ps.setString(2, projectTargetArea.getProject_area());

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

	public ArrayList<ProjectTargetArea> retrieveProjectTargetAreas(String project_name){
		ArrayList<ProjectTargetArea> output = new ArrayList<ProjectTargetArea>();

		String sql = "SELECT * FROM PROJECT_TARGET_AREAS WHERE project_name = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, project_name);
			ProjectTargetArea projectTargetArea = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				projectTargetArea = new ProjectTargetArea(rs.getString("project_name"), rs.getString("project_area"));
				output.add(projectTargetArea);
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
