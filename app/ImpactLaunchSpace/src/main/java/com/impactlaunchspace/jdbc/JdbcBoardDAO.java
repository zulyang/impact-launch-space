package com.impactlaunchspace.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.impactlaunchspace.dao.BoardDAO;
import com.impactlaunchspace.entity.Board;
import com.impactlaunchspace.entity.Project;

public class JdbcBoardDAO implements BoardDAO {
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	public void insert(Board board) {
		// TODO Auto-generated method stub
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		String sql = "INSERT INTO PROJECT_BOARD "
				+ "(project_name, project_proposer) VALUES (?, ?)";
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, board.getProject_name());
			ps.setString(2, board.getProject_proposer());
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
	
	public void update(String card_title, String description, String tags, String status) {
		// TODO Auto-generated method stub
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		String sql = "UPDATE PROJECT_BOARD SET "
				+ "card_title = ?,  description = ?, tags = ?, status = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, card_title);
			ps.setString(2, description);
			ps.setString(3, tags);
			ps.setString(4, status);
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
	
	public int retrieveBoardId(String project_name, String project_proposer) {
		// TODO Auto-generated method stub
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		String sql = "SELECT * FROM PROJECT_BOARD WHERE PROJECT_NAME = ? AND PROJECT_PROPOSER = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, project_name);
			ps.setString(2, project_proposer);
			
			int board_id = 0;
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				board_id = rs.getInt("board_id");
			}
			
			return board_id;
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
