package com.impactlaunchspace.notification;

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
}
