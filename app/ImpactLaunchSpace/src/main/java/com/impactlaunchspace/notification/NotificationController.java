package com.impactlaunchspace.notification;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.impactlaunchspace.entity.Notification;
import com.impactlaunchspace.entity.ProjectUserRequest;
import com.impactlaunchspace.project.ProjectService;
import com.impactlaunchspace.request.RequestService;
import com.impactlaunchspace.resource.ResourceService;

@Controller
public class NotificationController {

	@Autowired
	ProjectService projectService;
	
	@Autowired
	ResourceService resourceService;
	
	@Autowired
	RequestService requestService;

	@Autowired
	NotificationService notificationService;
	
	@RequestMapping(value = "/notifications/messages/inbox", method = RequestMethod.GET)
	public String viewMsgInboxPage(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws IOException{
		String username = (String) request.getSession().getAttribute("username");
		ArrayList<Notification> inbox = notificationService.getInbox(username);
		ArrayList<Notification> sent = notificationService.getSent(username);
		
		ArrayList<ProjectUserRequest> userRequests = requestService.retrieveAllForUser(username);
		ArrayList<ProjectUserRequest> userSentRequests = requestService.retrieveAllSentForUser(username);

		model.addAttribute("inbox", inbox);
		model.addAttribute("inboxSize", inbox.size());
		model.addAttribute("sentSize", sent.size());
		model.addAttribute("userRequestsSize", userRequests.size());
		model.addAttribute("userSentRequestsSize", userSentRequests.size());
		return "notifications/" + "view_notifications_msg_inbox";
	}
	
	@RequestMapping(value = "/notifications/messages/sent", method = RequestMethod.GET)
	public String viewMsgSentPage(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws IOException{
		String username = (String) request.getSession().getAttribute("username");
		ArrayList<Notification> inbox = notificationService.getInbox(username);
		ArrayList<Notification> sent = notificationService.getSent(username);
		
		ArrayList<ProjectUserRequest> userRequests = requestService.retrieveAllForUser(username);
		ArrayList<ProjectUserRequest> userSentRequests = requestService.retrieveAllSentForUser(username);

		model.addAttribute("sent", sent);
		model.addAttribute("inboxSize", inbox.size());
		model.addAttribute("sentSize", sent.size());	
		model.addAttribute("userRequestsSize", userRequests.size());
		model.addAttribute("userSentRequestsSize", userSentRequests.size());
		return "notifications/" + "view_notifications_msg_sent";
	}
	@RequestMapping(value = "/notifications/requests/inbox", method = RequestMethod.GET)
	public String viewReqInboxPage(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws IOException{
		String username = (String) request.getSession().getAttribute("username");
		ArrayList<Notification> inbox = notificationService.getInbox(username);
		ArrayList<Notification> sent = notificationService.getSent(username);
		
		ArrayList<ProjectUserRequest> userRequests = requestService.retrieveAllForUser(username);
		ArrayList<ProjectUserRequest> userSentRequests = requestService.retrieveAllSentForUser(username);
		
		model.addAttribute("inboxSize", inbox.size());
		model.addAttribute("sentSize", sent.size());
		model.addAttribute("userRequests", userRequests);
		model.addAttribute("userRequestsSize", userRequests.size());
		model.addAttribute("userSentRequestsSize", userSentRequests.size());
		
		
		return "notifications/" + "view_notifications_req_inbox";
	}
	
	@RequestMapping(value = "/notifications/requests/sent", method = RequestMethod.GET)
	public String viewReqSentPage(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws IOException{
		String username = (String) request.getSession().getAttribute("username");
		ArrayList<Notification> inbox = notificationService.getInbox(username);
		ArrayList<Notification> sent = notificationService.getSent(username);
		
		ArrayList<ProjectUserRequest> userRequests = requestService.retrieveAllForUser(username);
		ArrayList<ProjectUserRequest> userSentRequests = requestService.retrieveAllSentForUser(username);

		model.addAttribute("inboxSize", inbox.size());
		model.addAttribute("sentSize", sent.size());
		model.addAttribute("userRequestsSize", userRequests.size());
		model.addAttribute("userSentRequestsSize", userSentRequests.size());
		model.addAttribute("userSentRequests", userSentRequests);
		
		return "notifications/" + "view_notifications_req_sent";
	}
	
	@RequestMapping(value = "/send-message", method = RequestMethod.POST)
	public void sendPersonalMessage(@RequestParam String recipient,@RequestParam String modalMessage,@RequestParam String modalSubject,
			HttpServletResponse response,HttpServletRequest request){
		
		String sender = (String) request.getSession().getAttribute("username");
		Notification message = new Notification(recipient, sender, modalSubject,
				modalMessage, "message", "inbox");
		Notification message2 = new Notification(recipient, sender, modalSubject,
				modalMessage, "message", "sent");
		notificationService.sendNotification(message);
		notificationService.sendNotification(message2);

	}
	

	@RequestMapping(value = "/notifications/messages/delete-notification", method = RequestMethod.POST)
	public void deleteNotification(@RequestParam(required = false) String senderUsername,@RequestParam(required = false) String recipientUsername,
			@RequestParam String subj,	@RequestParam String time, @RequestParam String copy_type, HttpServletResponse response,HttpServletRequest request){
		String recipient = null;
		String sender = null;
		
		if(senderUsername != null){
			recipient = (String) request.getSession().getAttribute("username");
			sender = senderUsername;
		}else if (recipientUsername != null){
			sender = (String) request.getSession().getAttribute("username");
			recipient = recipientUsername;
		}

		notificationService.deleteNotification(recipient, sender, subj, time, copy_type);

	}
}
