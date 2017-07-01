package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.PreferredJobSectorDAO;
import com.impactlaunchspace.entity.PreferredJobSector;

public class JdbcPreferredJobSectorDAO implements PreferredJobSectorDAO {

	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void insert(PreferredJobSector preferredJobSector) {
		String sql = "INSERT INTO PREFERRED_JOB_SECTORS " + "(job_sector, username) VALUES (?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, preferredJobSector.getJob_sector());
			ps.setString(2, preferredJobSector.getUsername());
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

	public ArrayList<PreferredJobSector> retrievePreferredJobSectors(String username) {
		ArrayList<PreferredJobSector> output = new ArrayList<PreferredJobSector>();

		String sql = "SELECT * FROM PREFERRED_JOB_SECTORS WHERE username = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			PreferredJobSector preferredJobSector = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				preferredJobSector = new PreferredJobSector(rs.getString(1), rs.getString(2));
				output.add(preferredJobSector);
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
