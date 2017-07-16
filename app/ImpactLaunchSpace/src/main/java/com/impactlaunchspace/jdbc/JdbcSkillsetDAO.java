package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.SkillsetDAO;
import com.impactlaunchspace.entity.Skillset;

public class JdbcSkillsetDAO implements SkillsetDAO {

	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void insert(Skillset skillset) {
		String sql = "INSERT INTO SKILLSET_LIST " + "(skillset) VALUES (?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, skillset.getSkillset());
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

	public void remove(Skillset skillset) {
		String sql = "DELETE FROM SKILLSET_LIST WHERE skillset = ?";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, skillset.getSkillset());
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

	public ArrayList<Skillset> retrieveAll() {
		ArrayList<Skillset> output = new ArrayList<Skillset>();

		String sql = "SELECT * FROM SKILLSET_LIST";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			Skillset skillset = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				skillset = new Skillset(rs.getString(1));
				output.add(skillset);
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
