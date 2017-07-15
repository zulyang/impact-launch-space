package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.ProjectDAO;
import com.impactlaunchspace.entity.Country;
import com.impactlaunchspace.entity.Project;

public class JdbcProjectDAO implements ProjectDAO {
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void insert(Project project) {
		String sql = "INSERT INTO PROJECTS "
				+ "(project_name, description, purpose, duration, location, project_proposer, organization, isPublic, hiddenToOutsiders, hiddenToAll, project_status, created_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, project.getProject_name());
			ps.setString(2, project.getDescription());
			ps.setString(3, project.getPurpose());
			ps.setInt(4, project.getDuration());
			ps.setString(5, project.getLocation());
			ps.setString(6, project.getProject_proposer());
			ps.setString(7, project.getOrganization());
			ps.setBoolean(8, project.isPublic());
			ps.setBoolean(9, project.isHiddenToOutsiders());
			ps.setBoolean(10, project.isHiddenToAll());
			ps.setString(11, project.getProject_status());
			ps.setDate(12, project.getCreated_date());

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

	public Project retrieveProject(String project_name, String project_proposer) {
		String sql = "SELECT * FROM PROJECTS WHERE PROJECT_NAME = ? AND PROJECT_PROPOSER = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, project_name);
			ps.setString(2, project_proposer);
			Project project = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				project = new Project(rs.getString("project_name"), rs.getString("description"),
						rs.getString("purpose"), rs.getInt("duration"), rs.getString("location"),
						rs.getString("project_proposer"), rs.getString("organization"),
						rs.getBoolean("isPublic"), rs.getBoolean("hiddenToOutsiders"), rs.getBoolean("hiddenToAll"),
						rs.getString("project_status"), rs.getDate("created_date"));
			}
			rs.close();
			ps.close();
			return project;
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

	public ArrayList<Project> retrieveProjectByUser(String username) {
		ArrayList<Project> output = new ArrayList<Project>();

		String sql = "SELECT * FROM PROJECTS WHERE project_proposer = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			Project project = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				project = new Project(rs.getString("project_name"), rs.getString("description"),
						rs.getString("purpose"), rs.getInt("duration"), rs.getString("location"),
						rs.getString("project_proposer"), rs.getString("organization"),
						rs.getBoolean("isPublic"), rs.getBoolean("hiddenToOutsiders"), rs.getBoolean("hiddenToAll"),
						rs.getString("project_status"), rs.getDate("created_date"));
				output.add(project);
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

	public ArrayList<Project> retrievePublicProjects(){
		ArrayList<Project> output = new ArrayList<Project>();

		String sql = "SELECT * FROM PROJECTS WHERE isPublic = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setBoolean(1, true);
			Project project = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				project = new Project(rs.getString("project_name"), rs.getString("description"),
						rs.getString("purpose"), rs.getInt("duration"), rs.getString("location"),
						rs.getString("project_proposer"), rs.getString("organization"),
						rs.getBoolean("isPublic"), rs.getBoolean("hiddenToOutsiders"), rs.getBoolean("hiddenToAll"),
						rs.getString("project_status"), rs.getDate("created_date"));
				output.add(project);
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
