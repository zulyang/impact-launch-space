package com.impactlaunchspace.dao;

import com.impactlaunchspace.entity.Board;

public interface BoardDAO {
	public void insert(Board board);
	public void update(String card_title, String description, String tags, String status);
	public int retrieveBoardId(String Project_Name, String Project_Proposer);
	public void updateActivityLog(String activity, String board_id, String username);
}
