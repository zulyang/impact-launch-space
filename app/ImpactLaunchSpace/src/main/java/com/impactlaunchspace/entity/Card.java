package com.impactlaunchspace.entity;

import java.sql.Timestamp;
import java.util.ArrayList;

public class Card {
	private int card_id;
	private int board_id;
	private String card_title;
	private String description;
	private String owner;
	private ArrayList<User> assignees;
	private Timestamp date_created;
	private String tags;
	private String status;
	private int card_order; 
	
	

	public Card(int card_id, int board_id, String card_title, String description, String owner, ArrayList<User> assignees, Timestamp date_created, String tags, String status ) {
		super();
		this.card_id = card_id;
		this.board_id = board_id;
		this.card_title = card_title;
		this.description = description;
		this.owner = owner;
		this.assignees = assignees;
		this.date_created = date_created;
		this.tags = tags; 
		this.status = status;
	}
	
	//this constructor is to be inserted into the database
	public Card(int board_id, String card_title, String description, String owner, Timestamp date_created, String tags, String status, int card_order ) {
		super();
		this.board_id = board_id;
		this.card_title = card_title;
		this.description = description;
		this.owner = owner;
		this.date_created = date_created;
		this.tags = tags; 
		this.status = status;
		this.card_order = card_order;
	}
	
	public Card(int card_id, int board_id, String card_title, String description, String owner, Timestamp date_created, String tags, String status, int card_order ) {
		super();
		this.card_id = card_id;
		this.board_id = board_id;
		this.card_title = card_title;
		this.description = description;
		this.owner = owner;
		this.date_created = date_created;
		this.tags = tags; 
		this.status = status;
		this.card_order = card_order;
	}
	
	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public int getCard_id() {
		return card_id;
	}


	public void setCard_id(int card_id) {
		this.card_id = card_id;
	}


	public int getBoard_id() {
		return board_id;
	}


	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}


	public String getCard_title() {
		return card_title;
	}


	public void setCard_title(String card_title) {
		this.card_title = card_title;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public String getOwner() {
		return owner;
	}


	public void setOwner(String owner) {
		this.owner = owner;
	}


	public ArrayList<User> getAssignees() {
		return assignees;
	}


	public void setAssignees(ArrayList<User> assignees) {
		this.assignees = assignees;
	}


	public Timestamp getDate_created() {
		return date_created;
	}


	public void setDate_created(Timestamp date_created) {
		this.date_created = date_created;
	}


	public String getTags() {
		return tags;
	}


	public void setTags(String tags) {
		this.tags = tags;
	}
	
	public int getCard_order() {
		return card_order;
	}

	public void setCard_order(int card_order) {
		this.card_order = card_order;
	}
	
	
	
	
}
