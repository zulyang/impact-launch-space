package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.ProjectUpdateDAO;
import com.impactlaunchspace.entity.ProjectUpdate;

public class JdbcProjectUpdateDAO implements ProjectUpdateDAO{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	public void insert(ProjectUpdate projectUpdate){
		String sql = "INSERT INTO PROJECT_UPDATES "
				+ "(project_name, project_proposer, update_title, update_contents, posted_time) VALUES (?, ?, ?, ?, ?)";
		Connection conn = null;

		try {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			java.util.Date utilDate = dateFormat.parse(projectUpdate.getPosted_time());
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			long time = sqlDate.getTime();

			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, projectUpdate.getProject_name());
			ps.setString(2, projectUpdate.getProject_proposer());
			ps.setString(3, projectUpdate.getUpdate_title());
			ps.setString(4, projectUpdate.getUpdate_contents());
			ps.setTimestamp(5, new Timestamp(time));
			ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			throw new RuntimeException(e);

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}
	public void remove(int update_id){
		String sql = "DELETE FROM PROJECT_UPDATES WHERE update_id = ?";
		Connection conn = null;

		try {

			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, update_id);
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
	
	public ArrayList<ProjectUpdate> retrieveProjectUpdates(String project_name, String project_proposer) {
		ArrayList<ProjectUpdate> output = new ArrayList<ProjectUpdate>();

		String sql = "SELECT * FROM PROJECT_UPDATES WHERE project_name = ? AND project_proposer = ? ORDER BY POSTED_TIME DESC";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, project_name);
			ps.setString(2, project_proposer);
			ProjectUpdate projectUpdate = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				projectUpdate = new ProjectUpdate(rs.getString(1), rs.getString(2), rs.getString(4), rs.getString(5), rs.getTimestamp(6).toString());
				output.add(projectUpdate);
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
