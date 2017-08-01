package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.Notification;

public interface NotificationDAO {
	public void insert(Notification notification);
	public void remove(Notification notification);
	public ArrayList<Notification> retrieveRecievedNotificationsOfUser(String username);
	public ArrayList<Notification> retrieveSentNotificationsOfUser(String username);
	public int countTotalNotificationsOfUser(String username);
	public int countUnreadNotificationsOfUser(String username);
}
