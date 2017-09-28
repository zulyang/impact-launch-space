package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.ProjectResourceCategoryDAO;
import com.impactlaunchspace.entity.ProjectResourceCategory;
import com.impactlaunchspace.entity.ProjectTargetArea;

public class JdbcProjectResourceCategoryDAO implements ProjectResourceCategoryDAO {
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void insert(ProjectResourceCategory projectResourceCategory) {
		String sql = "INSERT INTO PROJECT_RESOURCE_CATEGORIES " + "(project_name, resource_category, project_proposer) VALUES (?, ?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, projectResourceCategory.getProject_name());
			ps.setString(2, projectResourceCategory.getResource_category());
			ps.setString(3, projectResourceCategory.getProject_proposer());

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

	public ArrayList<ProjectResourceCategory> retrieveProjectResourceCategories(String project_name, String project_proposer) {
		ArrayList<ProjectResourceCategory> output = new ArrayList<ProjectResourceCategory>();

		String sql = "SELECT * FROM PROJECT_RESOURCE_CATEGORIES WHERE project_name = ? AND project_proposer = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, project_name);
			ps.setString(2, project_proposer);
			ProjectResourceCategory projectResourceCategory = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				projectResourceCategory = new ProjectResourceCategory(rs.getString("project_name"),
						rs.getString("resource_category"), rs.getString("project_proposer"));
				output.add(projectResourceCategory);
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
	
	public void closeResourceCategory(String project_name, String project_proposer, String resource_category) {
		String sql = "DELETE FROM PROJECT_RESOURCE_CATEGORIES WHERE resource_category = ? AND project_proposer = ? AND project_name = ?";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, resource_category);
			ps.setString(2, project_proposer);
			ps.setString(3, project_name);
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
