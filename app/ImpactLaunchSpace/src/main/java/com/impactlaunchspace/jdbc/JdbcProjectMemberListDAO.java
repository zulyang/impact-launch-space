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
import com.impactlaunchspace.dao.ProjectMemberListDAO;
import com.impactlaunchspace.entity.Notification;
import com.impactlaunchspace.entity.ProjectMemberList;

public class JdbcProjectMemberListDAO implements ProjectMemberListDAO {

	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void insert(ProjectMemberList projectMemberList) {
		String sql = "INSERT INTO PROJECT_MEMBER_LIST "
				+ "(project_name, project_proposer, project_member_username, project_role, joined_timestamp) VALUES (?, ?, ?, ?, ?)";
		Connection conn = null;

		try {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			java.util.Date utilDate = dateFormat.parse(projectMemberList.getJoined_timestamp());
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			long time = sqlDate.getTime();

			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, projectMemberList.getProject_name());
			ps.setString(2, projectMemberList.getProject_proposer());
			ps.setString(3, projectMemberList.getProject_member_username());
			ps.setString(4, projectMemberList.getProject_role());
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

	public void remove(ProjectMemberList projectMemberList) {
		String sql = "DELETE FROM PROJECT_MEMBER_LIST WHERE project_name = ? AND project_proposer = ? AND project_member_username = ?";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, projectMemberList.getProject_name());
			ps.setString(2, projectMemberList.getProject_proposer());
			ps.setString(3, projectMemberList.getProject_member_username());
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

	public ArrayList<ProjectMemberList> retrieveMemberList(String project_name, String project_proposer) {
		ArrayList<ProjectMemberList> output = new ArrayList<ProjectMemberList>();

		String sql = "SELECT * FROM PROJECT_MEMBER_LIST WHERE project_name = ? AND project_proposer = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, project_name);
			ps.setString(2, project_proposer);
			ProjectMemberList projectMemberList = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				projectMemberList = new ProjectMemberList(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getTimestamp(5).toString());
				output.add(projectMemberList);
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
