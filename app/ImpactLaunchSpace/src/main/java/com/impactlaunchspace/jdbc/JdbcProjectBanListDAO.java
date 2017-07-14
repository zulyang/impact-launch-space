package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.ProjectBanListDAO;
import com.impactlaunchspace.entity.ProjectBanList;
import com.impactlaunchspace.entity.ProjectRequestedResource;

public class JdbcProjectBanListDAO implements ProjectBanListDAO {
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void insert(ProjectBanList projectBanList) {
		String sql = "INSERT INTO PROJECT_BAN_LIST " + "(project_name, banned_username, project_proposer) VALUES (?, ?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, projectBanList.getProject_name());
			ps.setString(2, projectBanList.getBanned_username());
			ps.setString(3, projectBanList.getProject_proposer());

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

	public ArrayList<ProjectBanList> retrieveProjectBanList(String project_name) {
		ArrayList<ProjectBanList> output = new ArrayList<ProjectBanList>();

		String sql = "SELECT * FROM PROJECT_BAN_LIST WHERE project_name = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, project_name);
			ProjectBanList projectBanList = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				projectBanList = new ProjectBanList(rs.getString("project_name"), rs.getString("banned_username"), rs.getString("project_proposer"));
				output.add(projectBanList);
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
