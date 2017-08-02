package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.ProjectUserRequestDAO;
import com.impactlaunchspace.entity.ProjectUserRequest;

public class JdbcProjectUserRequestDAO implements ProjectUserRequestDAO{
	
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	public void insert(ProjectUserRequest projectUserRequest){
		String sql = "INSERT INTO PROJECT_USER_REQUESTS "
				+ "(project_name, requested_resource_category, requested_resource_name, project_proposer, resource_offerer, offered_resource_category, offered_resource_name, offered_request_description, offer_comments) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, projectUserRequest.getProject_name());
			ps.setString(2, projectUserRequest.getRequested_resource_category());
			ps.setString(3, projectUserRequest.getRequested_resource_name());
			ps.setString(4, projectUserRequest.getProject_proposer());
			ps.setString(5, projectUserRequest.getResource_offerer());
			ps.setString(6, projectUserRequest.getOffered_resource_category());
			ps.setString(7, projectUserRequest.getOffered_resource_name());
			ps.setString(8, projectUserRequest.getOffered_request_description());
			ps.setString(9, projectUserRequest.getOffer_comments());
			
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
	public void remove(ProjectUserRequest projectUserRequest){
		String sql = "DELETE FROM PROJECT_USER_REQUESTS WHERE project_name = ? AND requested_resource_category = ? AND requested_resource_name = ? AND project_proposer = ? AND resource_offerer = ? AND offered_resource_category = ? AND offered_resource_name = ?";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, projectUserRequest.getProject_name());
			ps.setString(2, projectUserRequest.getRequested_resource_category());
			ps.setString(3, projectUserRequest.getRequested_resource_name());
			ps.setString(4, projectUserRequest.getProject_proposer());
			ps.setString(5, projectUserRequest.getResource_offerer());
			ps.setString(6, projectUserRequest.getOffered_resource_category());
			ps.setString(7, projectUserRequest.getOffered_resource_name());
			
			ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			throw new RuntimeException(e);

		}  finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}
	public ArrayList<ProjectUserRequest> retrieveAll(String project_name, String project_proposer){
		ArrayList<ProjectUserRequest> output = new ArrayList<ProjectUserRequest>();

		String sql = "SELECT * FROM PROJECT_USER_REQUESTS WHERE project_name = ? AND project_proposer = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, project_name);
			ps.setString(2, project_proposer);
			ProjectUserRequest projectUserRequest = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				projectUserRequest = new ProjectUserRequest(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9));
				output.add(projectUserRequest);
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
	
	public ArrayList<ProjectUserRequest> retrieveAllUserRequestsForRequestedResourceCategory(String project_name, String project_proposer, String requested_resource_category){
		ArrayList<ProjectUserRequest> output = new ArrayList<ProjectUserRequest>();

		String sql = "SELECT * FROM PROJECT_USER_REQUESTS WHERE project_name = ? AND project_proposer = ? AND requested_resource_category = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, project_name);
			ps.setString(2, project_proposer);
			ps.setString(3, requested_resource_category);
			ProjectUserRequest projectUserRequest = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				projectUserRequest = new ProjectUserRequest(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9));
				output.add(projectUserRequest);
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
	public ArrayList<ProjectUserRequest> retrieveAllUserRequestsForRequestedResourceName(String project_name, String project_proposer, String requested_resource_category, String requested_resource_name){
		ArrayList<ProjectUserRequest> output = new ArrayList<ProjectUserRequest>();

		String sql = "SELECT * FROM PROJECT_USER_REQUESTS WHERE project_name = ? AND project_proposer = ? AND requested_resource_category = ? AND requested_resource_name = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, project_name);
			ps.setString(2, project_proposer);
			ps.setString(3, requested_resource_category);
			ProjectUserRequest projectUserRequest = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				projectUserRequest = new ProjectUserRequest(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9));
				output.add(projectUserRequest);
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
