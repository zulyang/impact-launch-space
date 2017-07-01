package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.PreferredProjectAreaDAO;
import com.impactlaunchspace.entity.PreferredProjectArea;

public class JdbcPreferredProjectAreaDAO implements PreferredProjectAreaDAO {
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void insert(PreferredProjectArea preferredProjectArea) {
		String sql = "INSERT INTO PREFERRED_PROJECT_AREAS " + "(project_area, username) VALUES (?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, preferredProjectArea.getProject_area());
			ps.setString(2, preferredProjectArea.getUsername());
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

	public ArrayList<PreferredProjectArea> retrievePreferredProjectArea(String username) {
		ArrayList<PreferredProjectArea> output = new ArrayList<PreferredProjectArea>();

		String sql = "SELECT * FROM PREFERRED_PROJECT_AREAS WHERE username = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			PreferredProjectArea preferredProjectArea = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				preferredProjectArea = new PreferredProjectArea(rs.getString(1), rs.getString(2));
				output.add(preferredProjectArea);
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
