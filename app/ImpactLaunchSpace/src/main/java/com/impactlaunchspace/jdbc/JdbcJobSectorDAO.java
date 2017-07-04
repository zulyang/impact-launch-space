package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.JobSectorDAO;
import com.impactlaunchspace.entity.JobSector;

public class JdbcJobSectorDAO implements JobSectorDAO{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	public void insert(JobSector jobSector){
		String sql = "INSERT INTO JOB_SECTORS_LIST " + "(job_sector) VALUES (?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, jobSector.getJob_sector());
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
	
	public void remove(JobSector jobSector){
		String sql = "DELETE FROM JOB_SECTORS_LIST WHERE job_sector = ?";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, jobSector.getJob_sector());
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
	
	public ArrayList<JobSector> retrieveAll(){
		ArrayList<JobSector> output = new ArrayList<JobSector>();
		
		String sql = "SELECT * FROM JOB_SECTORS_LIST";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			JobSector jobSector = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				jobSector = new JobSector(rs.getString(1));
				output.add(jobSector);
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
