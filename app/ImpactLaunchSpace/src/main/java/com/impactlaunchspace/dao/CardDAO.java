package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.Card;

public interface CardDAO {
	public void insert(Card card);
	public void update(String card_title, String description, String tags, String status);
	public ArrayList<Card> retrieveCards(int board_id);
	public void delete(int card_id);

}
