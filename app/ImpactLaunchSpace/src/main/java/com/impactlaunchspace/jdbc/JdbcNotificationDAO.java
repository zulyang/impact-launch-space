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

import com.impactlaunchspace.dao.NotificationDAO;
import com.impactlaunchspace.entity.Notification;

public class JdbcNotificationDAO implements NotificationDAO {

	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void insert(Notification notification) {
		String sql = "INSERT INTO NOTIFICATIONS "
				+ "(recipient_username, sender_username, notification_subject, notification_message, sent_time, isRead, notification_type, copy_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;

		try {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			java.util.Date utilDate = dateFormat.parse(notification.getSent_time());
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			long time = sqlDate.getTime();

			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, notification.getRecipient_username());
			ps.setString(2, notification.getSender_username());
			ps.setString(3, notification.getNotification_subject());
			ps.setString(4, notification.getNotification_message());
			ps.setTimestamp(5, new Timestamp(time));
			ps.setBoolean(6, notification.isRead());
			ps.setString(7, notification.getNotification_type());
			ps.setString(8, notification.getCopy_type());
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

	public void remove(String recipient_username, String sender_username, String notification_subject, String sent_time, String copy_type) {
		String sql = "DELETE FROM NOTIFICATIONS WHERE recipient_username = ? AND sender_username = ? AND notification_subject = ? and sent_time = ? AND copy_type = ?";
		Connection conn = null;

		try {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			java.util.Date utilDate = dateFormat.parse(sent_time);
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			long time = sqlDate.getTime();

			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, recipient_username);
			ps.setString(2, sender_username);
			ps.setString(3, notification_subject);
			ps.setTimestamp(4, new Timestamp(time));
			ps.setString(5, copy_type);
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

	
	public ArrayList<Notification> retrieveReceivedNotificationsOfUser(String username) {
		ArrayList<Notification> output = new ArrayList<Notification>();

		String sql = "SELECT * FROM NOTIFICATIONS WHERE recipient_username = ? AND copy_type = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(1, "inbox");
			Notification notification = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				notification = new Notification(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getTimestamp(5).toString(), rs.getBoolean(6), rs.getString(7), rs.getString(8));
				output.add(notification);
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

	public ArrayList<Notification> retrieveSentNotificationsOfUser(String username) {
		ArrayList<Notification> output = new ArrayList<Notification>();

		String sql = "SELECT * FROM NOTIFICATIONS WHERE sender_username = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			Notification notification = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				notification = new Notification(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getTimestamp(5).toString(), rs.getBoolean(6) , rs.getString(7), rs.getString(8));
				output.add(notification);
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

	public int countTotalNotificationsOfUser(String username) {
		int output = 0;
		String sql = "SELECT COUNT(*) FROM NOTIFICATIONS WHERE recipient_username = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				output = rs.getInt(1);
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

	public int countUnreadNotificationsOfUser(String username) {
		int output = 0;
		String sql = "SELECT COUNT(*) FROM NOTIFICATIONS WHERE recipient_username = ? AND isRead = false";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				output = rs.getInt(1);
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
