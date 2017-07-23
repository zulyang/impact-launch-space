package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.impactlaunchspace.dao.UserOfferedResourceDAO;
import com.impactlaunchspace.entity.UserOfferedResource;

public class JdbcUserOfferedResourceDAO implements UserOfferedResourceDAO {

	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	@Override
	public void insert(UserOfferedResource userOfferedResource) {
		String sql = "INSERT INTO `user_offered_resources`(`username`, `resource_category`, `resource_name`,`request_description`) VALUES (?,?,?,?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, userOfferedResource.getUsername());
			ps.setString(2, userOfferedResource.getResourceCategory());
			ps.setString(3, userOfferedResource.getResourceName());
			ps.setString(4, userOfferedResource.getResourceDescription());
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
	public void remove(UserOfferedResource userOfferedResource) {
		String sql = "DELETE FROM `user_offered_resources` WHERE `username` = ? and `resource_category` = ? and `resource_name` = ?";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, userOfferedResource.getUsername());
			ps.setString(2, userOfferedResource.getResourceCategory());
			ps.setString(3, userOfferedResource.getResourceName());
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
	public void removeAll(String username) {
		String sql = "DELETE FROM `user_offered_resources` WHERE `username` = ? ";
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
	
	@Override
	public ArrayList<UserOfferedResource> retrieveAll(String username) {
		ArrayList<UserOfferedResource> output = new ArrayList<UserOfferedResource>();

		System.out.println(username);
		
		String sql = "SELECT * FROM `user_offered_resources` WHERE `username` = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			UserOfferedResource userOfferedResource = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				userOfferedResource = new UserOfferedResource(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4));
				output.add(userOfferedResource);
				System.out.println(userOfferedResource);
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

	@Override
	public void update(UserOfferedResource userOfferedResource) {
		String sql = "UPDATE `user_offered_resources` SET `resource_category`= ?,`resource_name`= ?,`request_description`= ? WHERE `username`= ?";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, userOfferedResource.getResourceCategory());
			ps.setString(2, userOfferedResource.getResourceName());
			ps.setString(3, userOfferedResource.getResourceDescription());
			ps.setString(4, userOfferedResource.getUsername());
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