package com.impactlaunchspace.entity;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class Notification {
	private String recipient_username;
	private String sender_username;
	private String notification_subject;
	private String notification_message;
	private String sent_time;
	private boolean isRead;
	private String notification_type;
	private String copy_type;

	public Notification(String recipient_username, String sender_username, String notification_subject,
			String notification_message, String notification_type, String copy_type) {
		super();
		this.recipient_username = recipient_username;
		this.sender_username = sender_username;
		this.notification_subject = notification_subject;
		this.notification_message = notification_message;
		this.sent_time = calculateSentTime();
		this.isRead = false;
		this.notification_type = notification_type;
		this.copy_type = copy_type;
	}

	public Notification(String recipient_username, String sender_username, String notification_subject,
			String notification_message, String sent_time, boolean isRead, String notification_type,
			String copy_type) {
		super();
		this.recipient_username = recipient_username;
		this.sender_username = sender_username;
		this.notification_subject = notification_subject;
		this.notification_message = notification_message;
		this.sent_time = sent_time;
		this.isRead = isRead;
		this.notification_type = notification_type;
		this.copy_type = copy_type;
	}


	public String getCopy_type() {
		return copy_type;
	}
	
	public String getRecipient_username() {
		return recipient_username;
	}

	public String getSender_username() {
		return sender_username;
	}

	public String getNotification_subject() {
		return notification_subject;
	}

	public String getNotification_message() {
		return notification_message;
	}

	public String getSent_time() {
		return sent_time;
	}

	public boolean isRead() {
		return isRead;
	}
	

	public String getNotification_type() {
		return notification_type;
	}

	private String calculateSentTime() {
		Calendar now = Calendar.getInstance();
		Date dt = now.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String sentTime = sdf.format(dt);
		return sentTime;
	}

}
