package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.ResetTokenDAO;
import com.impactlaunchspace.entity.ResetToken;

public class JdbcResetTokenDAO implements ResetTokenDAO {
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void insert(ResetToken reset_token) {
		String sql = "INSERT INTO reset_tokens " + "(reset_code, username, expiry_date) VALUES (?, ?, ?)";
		Connection conn = null;

		try {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			java.util.Date utilDate = dateFormat.parse(reset_token.getExpiryDate());
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			long time = sqlDate.getTime();

			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, reset_token.getReset_code());
			ps.setString(2, reset_token.getUsername());
			ps.setTimestamp(3, new Timestamp(time));
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

	public ResetToken retrieveResetToken(String username) {
		String sql = "SELECT * FROM reset_tokens WHERE username = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ResetToken reset_token = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				reset_token = new ResetToken(rs.getString("reset_code"), rs.getString("username"),
						rs.getTimestamp("expiry_date").toString());
			}
			rs.close();
			ps.close();
			return reset_token;
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

	public void updateResetCode(String resetCode, String username, String expiryDate) {
		// this method is used to update the verification code in the VT DB

		String sql = "UPDATE reset_tokens SET reset_code = ?, expiry_date = ? WHERE username = ?";

		Connection conn = null;

		try {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			java.util.Date utilDate = dateFormat.parse(expiryDate);
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			long time = sqlDate.getTime();

			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, resetCode);
			ps.setString(3, username);
			ps.setTimestamp(2, new Timestamp(time));
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

}