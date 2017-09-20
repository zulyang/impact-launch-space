package com.impactlaunchspace.entity;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.sql.Date;

public class Card {
	private int card_id;
	private int board_id;
	private String card_title;
	private String description;
	private String owner;
	private String assignee;
	private Timestamp date_created;
	private String tags;
	private String status;
	private int card_order; 
	private Date start_date;
	private Date due_date; 
	
	

	public Card(int card_id, int board_id, String card_title, String description, String owner, String assignee, Timestamp date_created, String tags, String status ) {
		super();
		this.card_id = card_id;
		this.board_id = board_id;
		this.card_title = card_title;
		this.description = description;
		this.owner = owner;
		this.assignee = assignee;
		this.date_created = date_created;
		this.tags = tags; 
		this.status = status;
	}
	
	//this constructor is to be inserted into the database
	public Card(int board_id, String card_title, String description, String owner, String assignee, Timestamp date_created, String tags, String status, Date start_date, Date due_date) {
		super();
		this.board_id = board_id;
		this.card_title = card_title;
		this.description = description;
		this.owner = owner;
		this.assignee = assignee;
		this.date_created = date_created;
		this.tags = tags; 
		this.status = status;
		this.start_date = start_date;
		this.due_date = due_date;
	}
	
	public Card(int card_id, int board_id, String card_title, String description, String owner, String assignee, Timestamp date_created, String tags, String status, int card_order, Date start_date, Date due_date ) {
		super();
		this.card_id = card_id;
		this.board_id = board_id;
		this.card_title = card_title;
		this.description = description;
		this.owner = owner;
		this.assignee = assignee;
		this.date_created = date_created;
		this.tags = tags; 
		this.status = status;
		this.card_order = card_order;
		this.start_date = start_date;
		this.due_date = due_date;
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


	public String getAssignee() {
		return assignee;
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

	public Date getStart_date() {
		return start_date;
	}

	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}

	public Date getDue_date() {
		return due_date;
	}

	public void setDue_date(Date due_date) {
		this.due_date = due_date;
	}

	public void setAssignee(String assignee) {
		this.assignee = assignee;
	}
	
	
	
	
}
