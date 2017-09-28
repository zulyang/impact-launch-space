package com.impactlaunchspace.dao;

import java.sql.Date;
import java.util.ArrayList;

import com.impactlaunchspace.entity.Card;

public interface CardDAO {
	public int insert(Card card);
	public void edit(String card_title, String description, String tags, String assignee, Date start_date, Date due_date, int card_id);
	public ArrayList<Card> retrieveCards(int board_id);
	public ArrayList<Card> retrieveCardsByStatus(int board_id, String status);
	public void delete(int card_id);
	public void updateOrder(int card_id, String status,int order);
	public Card retrieveProjectCardById(int card_id);
}
