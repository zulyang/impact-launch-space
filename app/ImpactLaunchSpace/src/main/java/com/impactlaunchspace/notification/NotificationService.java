package com.impactlaunchspace.notification;

import java.util.ArrayList;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.NotificationDAO;
import com.impactlaunchspace.entity.Notification;

@Service
public class NotificationService {
	public void sendNotification(Notification notification) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		NotificationDAO notificationDAO = (NotificationDAO) context.getBean("notificationDAO");

		notificationDAO.insert(notification);
	}
	
	public int countUnreadNotifications(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		NotificationDAO notificationDAO = (NotificationDAO) context.getBean("notificationDAO");

		return notificationDAO.countUnreadNotificationsOfUser(username);
	}
	
	public int countTotalNotifications(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		NotificationDAO notificationDAO = (NotificationDAO) context.getBean("notificationDAO");

		return notificationDAO.countTotalNotificationsOfUser(username);
	}
	
	public ArrayList<Notification> getInbox(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		NotificationDAO notificationDAO = (NotificationDAO) context.getBean("notificationDAO");

		return notificationDAO.retrieveReceivedNotificationsOfUser(username);
	}
	
	public ArrayList<Notification> getSent(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		NotificationDAO notificationDAO = (NotificationDAO) context.getBean("notificationDAO");

		return notificationDAO.retrieveSentNotificationsOfUser(username);
	}
	
	public void deleteNotificationFromInbox(String recipient_username, String sender_username, String notification_subject, String sent_time, String copy_type) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		NotificationDAO notificationDAO = (NotificationDAO) context.getBean("notificationDAO");
		notificationDAO.remove(recipient_username, sender_username,notification_subject, sent_time, copy_type);
	}
}
