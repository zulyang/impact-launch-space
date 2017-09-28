package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.JobSectorOrganizationDAO;
import com.impactlaunchspace.entity.JobSectorOrganization;

public class JdbcJobSectorOrganizationDAO implements JobSectorOrganizationDAO{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	
	public void insert(JobSectorOrganization jobSectorOrganization){
		String sql = "INSERT INTO JOB_SECTORS_ORGANIZATION " + "(job_sector, username) VALUES (?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, jobSectorOrganization.getJob_sector());
			ps.setString(2, jobSectorOrganization.getUsername());
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
	
	public ArrayList<JobSectorOrganization> retrieveOrganizationJobSectors(String username){
		ArrayList<JobSectorOrganization> output = new ArrayList<JobSectorOrganization>();
		
		String sql = "SELECT * FROM JOB_SECTORS_ORGANIZATION WHERE username = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			JobSectorOrganization jobSectorOrganization = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				jobSectorOrganization = new JobSectorOrganization(rs.getString(1),rs.getString(2));
				output.add(jobSectorOrganization);
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
	
	public void deleteUserJobSectorOrganization(String username){
		String sql = "DELETE FROM JOB_SECTORS_ORGANIZATION WHERE username = ?";
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
