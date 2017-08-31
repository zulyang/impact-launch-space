package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.Card;

public interface CardDAO {
	public void insert(Card card);
	public void update(String card_title, String description, String tags, String status);
	public ArrayList<Card> retrieveCards(int board_id);
	public ArrayList<Card> retrieveCardsByStatus(int board_id, String status);
	public void delete(int card_id);
	public void updateOrder(int card_id, String status,int order);
}
