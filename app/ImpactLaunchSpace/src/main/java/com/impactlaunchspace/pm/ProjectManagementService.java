package com.impactlaunchspace.pm;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.sql.Date;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.BoardDAO;
import com.impactlaunchspace.dao.CardDAO;
import com.impactlaunchspace.entity.Card;

@Service
public class ProjectManagementService {

	public ArrayList<Card> retrieveProjectCards(int board_id){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		CardDAO cardDAO = (CardDAO) context.getBean("cardDAO");
		return cardDAO.retrieveCards(board_id);	
	}
	
	public ArrayList<Card> retrieveProjectCardsByStatus(int board_id, String status){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		CardDAO cardDAO = (CardDAO) context.getBean("cardDAO");
		return cardDAO.retrieveCardsByStatus(board_id, status);	
	}
	
	public int retrieveBoardId(String Project_Name, String Project_Proposer){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		BoardDAO boardDAO = (BoardDAO) context.getBean("boardDAO");
		return boardDAO.retrieveBoardId(Project_Name, Project_Proposer);
	}
	
	public void addCard(String modalCardTitle, String modalCardDescription, String status, String tags, int board_id, String username, String assignee, Timestamp timestamp, Date start_date, Date due_date) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		CardDAO cardDAO = (CardDAO) context.getBean("cardDAO");
		cardDAO.insert(new Card(board_id, modalCardTitle, modalCardDescription, username, assignee, timestamp, tags, status, start_date, due_date));
	}
	
	public void deleteCard(int card_id) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		CardDAO cardDAO = (CardDAO) context.getBean("cardDAO");
		cardDAO.delete(card_id);
	}
	
	public void updateOrder(int card_id, String status, int order) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		CardDAO cardDAO = (CardDAO) context.getBean("cardDAO");
		cardDAO.updateOrder(card_id, status, order);
	}
	
	public void edit(String card_title, String description, String tags, String assignee) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		CardDAO cardDAO = (CardDAO) context.getBean("cardDAO");
		cardDAO.edit(card_title, description, tags, assignee);
	}
	
	public Card retrieveProjectCardById(int card_id){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		CardDAO cardDAO = (CardDAO) context.getBean("cardDAO");
		return cardDAO.retrieveProjectCardById(card_id);	
	}
	
	public void updateActivity(String activity, String board_id, String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		BoardDAO boardDAO = (BoardDAO) context.getBean("boardDAO");
	}
	
}
