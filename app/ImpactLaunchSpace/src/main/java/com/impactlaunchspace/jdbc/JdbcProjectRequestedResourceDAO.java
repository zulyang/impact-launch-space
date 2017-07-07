package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.ProjectRequestedResourceDAO;
import com.impactlaunchspace.entity.Project;
import com.impactlaunchspace.entity.ProjectRequestedResource;

public class JdbcProjectRequestedResourceDAO implements ProjectRequestedResourceDAO{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	public void insert(ProjectRequestedResource projectRequestedResource){
		String sql = "INSERT INTO PROJECT_REQUESTED_RESOURCES "
				+ "(project_name, resource_category, resource_name, resource_description) VALUES (?, ?, ?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, projectRequestedResource.getProject_name());
			ps.setString(2, projectRequestedResource.getResource_category());
			ps.setString(3, projectRequestedResource.getResource_name());
			ps.setString(4, projectRequestedResource.getRequest_description());

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
	
	public ArrayList<ProjectRequestedResource> retrieveProjectRequestedResource(String project_name, String resource_category){
		ArrayList<ProjectRequestedResource> output = new ArrayList<ProjectRequestedResource>();

		String sql = "SELECT * FROM PROJECT_REQUESTED_RESOURCES WHERE project_name = ? and resource_category = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, project_name);
			ProjectRequestedResource projectRequestedResource = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				projectRequestedResource = new ProjectRequestedResource(rs.getString("project_name"), rs.getString("resource_category"),
						rs.getString("resource_name"), rs.getString("request_description"));
				output.add(projectRequestedResource);
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
