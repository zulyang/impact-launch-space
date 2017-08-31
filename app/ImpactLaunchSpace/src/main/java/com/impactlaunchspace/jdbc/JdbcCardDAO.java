package com.impactlaunchspace.jdbc;

import java.util.ArrayList;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.apache.tika.io.IOUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.impactlaunchspace.dao.CardDAO;
import com.impactlaunchspace.dao.DocumentsProjectDAO;
import com.impactlaunchspace.entity.Card;
import com.impactlaunchspace.entity.Project;
import com.impactlaunchspace.exception.ContentTypeException;
import com.impactlaunchspace.utility.FileTypeUtils;

public class JdbcCardDAO implements CardDAO{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	@Override
	public void insert(Card card) {
		// TODO Auto-generated method stub
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		String sql = "INSERT INTO PROJECT_CARD "
				+ "(board_id, title, description, owner, date_created, tags, status, order) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, card.getBoard_id());
			ps.setString(2, card.getCard_title());
			ps.setString(3, card.getDescription());
			ps.setString(4, card.getOwner());
			ps.setTimestamp(5, card.getDate_created());
			ps.setString(6,card.getTags());
			ps.setString(7, card.getStatus());
			ps.setInt(8, card.getCard_order());
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
	public void update(String card_title, String description, String tags, String status) {
		// TODO Auto-generated method stub
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		String sql = "UPDATE PROJECT_CARD SET "
				+ "card_title = ?, description = ?, tags = ?, status = ?";
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
	
	@Override
	public ArrayList<Card> retrieveCards(int board_id) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ArrayList<Card> toReturn = new ArrayList<Card>();
		String sql = "SELECT * FROM project_card WHERE board_id= ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, board_id);
			Card card = null;
			ResultSet rs = ps.executeQuery();
	
			while (rs.next()) {
				card = new Card(rs.getInt("card_id"), rs.getInt("board_id"),
						rs.getString("title"), rs.getString("description"), rs.getString("owner"),
						rs.getTimestamp("date_created"), rs.getString("tags"), rs.getString("status"), rs.getInt("order")
						);
				
				toReturn.add(card);
			}
			
			rs.close();
			ps.close();
			return toReturn;
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
	public ArrayList<Card> retrieveCardsByStatus(int board_id, String status) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ArrayList<Card> toReturn = new ArrayList<Card>();
		String sql = "SELECT * FROM `project_card` WHERE `board_id`= ? AND `status`= ? ORDER BY `order`";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, board_id);
			ps.setString(2, status);
			Card card = null;
			ResultSet rs = ps.executeQuery();
	
			while (rs.next()) {
				card = new Card(rs.getInt("card_id"), rs.getInt("board_id"),
						rs.getString("title"), rs.getString("description"), rs.getString("owner"),
						rs.getTimestamp("date_created"), rs.getString("tags"), rs.getString("status"), rs.getInt("order")
						);
				
				toReturn.add(card);
			}
			
			rs.close();
			ps.close();
			return toReturn;
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
	
	//Delete Card 
	@Override
	public void delete(int card_id) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		String sql = "DELETE FROM project_card WHERE card_id = ?";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, card_id);
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
	public void updateOrder(int card_id, String status, int order) {
		// TODO Auto-generated method stub
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		String sql = "UPDATE PROJECT_CARD SET `order` = ?, `status` = ? WHERE `card_id` = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, order);
			ps.setString(2, status);
			ps.setInt(3, card_id);
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
