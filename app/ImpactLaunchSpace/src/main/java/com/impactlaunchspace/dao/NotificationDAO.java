package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.Notification;

public interface NotificationDAO {
	public void insert(Notification notification);
	public void remove(String recipient_username, String sender_username, String notification_subject, String sent_time, String copy_type);
	public ArrayList<Notification> retrieveReceivedNotificationsOfUser(String username);
	public ArrayList<Notification> retrieveSentNotificationsOfUser(String username);
	public int countTotalNotificationsOfUser(String username);
	public int countUnreadNotificationsOfUser(String username);
	public void markRead(String recipient_username, String sender_username, String notification_subject, String sent_time, String copy_type);
}
