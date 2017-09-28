package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.JobSectorIndividualDAO;
import com.impactlaunchspace.entity.JobSectorIndividual;
import com.impactlaunchspace.entity.JobSectorOrganization;

public class JdbcJobSectorIndividualDAO implements JobSectorIndividualDAO{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	
	public void insert(JobSectorIndividual jobSectorIndividual){
		String sql = "INSERT INTO JOB_SECTORS_INDIVIDUAL " + "(job_sector, username, yearsOfExperience) VALUES (?, ?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, jobSectorIndividual.getJob_sector());
			ps.setString(2, jobSectorIndividual.getUsername());
			ps.setInt(3, jobSectorIndividual.getYearsOfExperience());
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
	
	public ArrayList<JobSectorIndividual> retrieveIndividualJobSectors(String username){
		ArrayList<JobSectorIndividual> output = new ArrayList<JobSectorIndividual>();
		
		String sql = "SELECT * FROM JOB_SECTORS_INDIVIDUAL WHERE username = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			JobSectorIndividual jobSectorIndividual = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				jobSectorIndividual = new JobSectorIndividual(rs.getString(1),rs.getString(2),rs.getInt(3));
				output.add(jobSectorIndividual);
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
	
	public void deleteUserJobSectorIndividual(String username){
		String sql = "DELETE FROM JOB_SECTORS_INDIVIDUAL WHERE username = ?";
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
