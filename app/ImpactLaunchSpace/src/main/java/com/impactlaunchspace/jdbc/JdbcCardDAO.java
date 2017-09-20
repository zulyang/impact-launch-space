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
import java.sql.Date;
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
				+ "(board_id, title, description, owner, assignee, date_created, tags, card_status, card_order, start_date, due_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ? ,? ,? )";
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, card.getBoard_id());
			ps.setString(2, card.getCard_title());
			ps.setString(3, card.getDescription());
			ps.setString(4, card.getOwner());
			ps.setString(5, card.getAssignee());
			ps.setTimestamp(6, card.getDate_created());
			ps.setString(7,card.getTags());
			ps.setString(8, card.getStatus());
			ps.setInt(9, retrieveCardsByStatus(card.getBoard_id(),"todo").size());
			ps.setDate(10, card.getStart_date());
			ps.setDate(11, card.getDue_date());
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
	public void edit(String card_title, String description, String tags, String assignee) {
		// TODO Auto-generated method stub
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		String sql = "UPDATE PROJECT_CARD SET "
				+ "card_title = ?, description = ?, tags = ?, assignee = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, card_title);
			ps.setString(2, description);
			ps.setString(3, tags);
			ps.setString(4, assignee);
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
						rs.getString("title"), rs.getString("description"), rs.getString("owner"), rs.getString("assignee"),
						rs.getTimestamp("date_created"), rs.getString("tags"), rs.getString("card_status"), rs.getInt("card_order"), rs.getDate("start_date"), rs.getDate("due_date")
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
		String sql = "SELECT * FROM `project_card` WHERE `board_id`= ? AND `card_status`= ? ORDER BY `card_order`";
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
						rs.getString("title"), rs.getString("description"), rs.getString("owner"), rs.getString("assignee"),
						rs.getTimestamp("date_created"), rs.getString("tags"), rs.getString("card_status"), rs.getInt("card_order"),rs.getDate("start_date"), rs.getDate("due_date")
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
		String sql = "UPDATE PROJECT_CARD SET `card_order` = ?, `card_status` = ? WHERE `card_id` = ?";
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
	
	
	@Override
	public Card retrieveProjectCardById(int card_id) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		String sql = "SELECT * FROM project_card WHERE card_id= ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, card_id);
			Card card = null;
			ResultSet rs = ps.executeQuery();
	
			while (rs.next()) {
				card = new Card(rs.getInt("card_id"), rs.getInt("board_id"),
						rs.getString("title"), rs.getString("description"), rs.getString("owner"), rs.getString("assignee"),
						rs.getTimestamp("date_created"), rs.getString("tags"), rs.getString("card_status"), rs.getInt("card_order"), rs.getDate("start_date"), rs.getDate("due_date")
						);
				
			}
			
			rs.close();
			ps.close();
			return card;
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
