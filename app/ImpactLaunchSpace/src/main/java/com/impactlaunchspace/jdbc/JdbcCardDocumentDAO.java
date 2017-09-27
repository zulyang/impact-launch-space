package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.CardDocumentDAO;

public class JdbcCardDocumentDAO implements CardDocumentDAO{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	@Override
	public void insertDocuments(int cardId, String fileName) {
		String sql = "INSERT INTO `card_documents`(`card_id`, `document_name`) VALUES (?,?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, cardId);
			ps.setString(2, fileName);
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

	@Override
	public void deleteAll(int cardId) {
		String sql = "DELETE FROM card_documents WHERE card_id = ?";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, cardId);
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

	@Override
	public String[] retrieveList(int cardId) {
		ArrayList<String> output = new ArrayList<String>();
		
		String sql = "SELECT * FROM card_documents WHERE card_id = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, cardId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				output.add(rs.getString(2));
			}
			rs.close();
			ps.close();
			String[] arr = output.toArray(new String[output.size()]);
			return arr;
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
