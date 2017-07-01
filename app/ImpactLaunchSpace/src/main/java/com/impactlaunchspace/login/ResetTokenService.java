package com.impactlaunchspace.login;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.ResetTokenDAO;
import com.impactlaunchspace.dao.UserDAO;
import com.impactlaunchspace.entity.ResetToken;
import com.sendgrid.Content;
import com.sendgrid.Email;
import com.sendgrid.Mail;
import com.sendgrid.Method;
import com.sendgrid.Request;
import com.sendgrid.Response;
import com.sendgrid.SendGrid;

@Service
public class ResetTokenService {
	LoginService loginService;
	private static final int EXPIRATION = 60 * 24; // minutes (1day)

	// this method generates a 6 digit random number
	public String generateToken() {
		Random rand = new Random();
		String token = "";

		for (int i = 0; i < 6; i++) {
			token += rand.nextInt(10);
		}

		return token;
	}

	public boolean verifyToken(String token, String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

		ResetTokenDAO resetTokenDAO = (ResetTokenDAO) context.getBean("resetTokenDAO");

		ResetToken rt = resetTokenDAO.retrieveResetToken(username);

		String resetCode = rt.getReset_code();
		String expiryDate = rt.getExpiryDate();

		if (resetCode == null) {
			return false;
		}

		if (token.equals(resetCode)) {
			return true;
		}

		return false;
	}

	public void unlock(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

		UserDAO userDAO = (UserDAO) context.getBean("userDAO");

		userDAO.unlockAccount(username);
	}

	public void lock(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

		UserDAO userDAO = (UserDAO) context.getBean("userDAO");

		userDAO.lockAccount(username);
	}

	public void sendResetEmail(String resetCode, String email) {
		Email from = new Email("admin@impactlaunchspace.com");
		String subject = "Reset Password at ImpactLaunch.Space";
		Email to = new Email(email);
		Content content = new Content();
		content.setType("text/html");
		content.setValue("<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>"
			+ "<html xmlns='http://www.w3.org/1999/xhtml' data-dnd='true'><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' />"
			+ "<meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1' />"
			+ "<style type='text/css'>body {color: #626262;} body a {color: #0088cd;text-decoration: none;}"
			+ "p { margin: 0; padding: 0; }table[class='wrapper'] {width:100% !important;table-layout: fixed;-webkit-font-smoothing: antialiased;-webkit-text-size-adjust: 100%;-moz-text-size-adjust: 100%;-ms-text-size-adjust: 100%;}"
			+ "img[class='max-width'] {max-width: 100% !important;}@media screen and (max-width:480px) {.preheader .rightColumnContent,.footer .rightColumnContent {text-align: left !important;}"
			+ ".preheader .rightColumnContent div,.preheader .rightColumnContent span,.footer .rightColumnContent div,.footer .rightColumnContent span {text-align: left !important;}"
			+ ".preheader .rightColumnContent,.preheader .leftColumnContent {font-size: 80% !important;padding: 5px 0;}table[class='wrapper-mobile'] {width: 100% !important;table-layout: fixed;}img[class='max-width'] {height: auto !important;}"
			+ "a[class='bulletproof-button'] {display: block !important;width: auto !important;font-size: 80%;padding-left: 0 !important;padding-right: 0 !important;}"
			+ "#templateColumns{width:100% !important;}.templateColumnContainer{display:block !important;width:100% !important;padding-left: 0 !important;padding-right: 0 !important;}}"
			+ "</style><style>body, p, div { font-family: helvetica,arial,sans-serif; }</style><style>body, p, div { font-size: 15px; }</style></head>"
			+ "<body yahoofix='true' style='min-width: 100%; margin: 0; padding: 0; font-size: 15px; font-family: helvetica,arial,sans-serif; color: #626262; background-color: #F4F4F4; color: #626262;' data-attributes='%7B%22dropped%22%3Atrue%2C%22bodybackground%22%3A%22%23F4F4F4%22%2C%22bodyfontname%22%3A%22helvetica%2Carial%2Csans-serif%22%2C%22bodytextcolor%22%3A%22%23626262%22%2C%22bodylinkcolor%22%3A%22%230088cd%22%2C%22bodyfontsize%22%3A15%7D'>"
			+ "<center class='wrapper'><div class='webkit'><table cellpadding='0' cellspacing='0' border='0' width='100%' class='wrapper' bgcolor='#F4F4F4'>"
			+ "<tr><td valign='top' bgcolor='#F4F4F4' width='100%'><table width='100%' role='content-container' class='outer' data-attributes='%7B%22dropped%22%3Atrue%2C%22containerpadding%22%3A%220%2C0%2C0%2C0%22%2C%22containerwidth%22%3A600%2C%22containerbackground%22%3A%22%23F4F4F4%22%7D' align='center' cellpadding='0' cellspacing='0' border='0'>"
			+ "<tr><td width='100%'><table width='100%' cellpadding='0' cellspacing='0' border='0'><tr><td> <table width='100%' cellpadding='0' cellspacing='0' border='0' style='width: 100%; max-width:600px;' align='center'>"
			+ "<tr><td role='modules-container' style='padding: 0px 0px 0px 0px; color: #626262; text-align: left;' bgcolor='#F4F4F4' width='100%' align='left'>"
			+ "<table border='0' cellpadding='0' cellspacing='0' align='center' width='100%' style='display:none !important; visibility:hidden; opacity:0; color:transparent; height:0; width:0;' class='module preheader preheader-hide' role='module' data-type='preheader'>"
			+ "<tr><td role='module-content'><p>Don't worry, we all forget sometimes</p></td></tr></table>"
			+ "<table class='module' role='module' data-type='text' border='0' cellpadding='0' cellspacing='0'  width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22child%22%3Afalse%2C%22padding%22%3A%220%2C0%2C0%2C0%22%2C%22containerbackground%22%3A%22%22%7D'>"
			+ "<tr><td role='module-content'  valign='top' height='100%' style='padding: 0px 0px 0px 0px;' bgcolor=''><div style='text-align: right;'><span style='font-family:verdana,geneva,sans-serif;'><span style='font-size:10px;'>Email not displaying correctly? <a href='[weblink]'>View it</a> in your browser.</span></span></div> </td></tr></table>"
			+ "<table role='module' data-type='image' border='0' align='center' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' class='wrapper' data-attributes='%7B%22child%22%3Afalse%2C%22link%22%3A%22%22%2C%22width%22%3A%22300%22%2C%22height%22%3A%22120%22%2C%22imagebackground%22%3A%22%23151b3b%22%2C%22url%22%3A%22https%3A//marketing-image-production.s3.amazonaws.com/uploads/e6f5005a99d36af1be11c21e38fd9a0d1511e6ef482fc9627616042eaea82e2ff36e106b1f57991e1c17c9cae8b289a919adf1a24c3f2aa28db8df7d3a88c0e4.png%22%2C%22alt_text%22%3A%22%22%2C%22dropped%22%3Atrue%2C%22imagemargin%22%3A%2234%2C0%2C34%2C150%22%2C%22alignment%22%3A%22%22%2C%22responsive%22%3Atrue%7D'>"
			+ "<tr><td style='font-size:6px;line-height:10px;background-color:#151b3b;padding: 34px 0px 34px 150px;' valign='top' align='' role='module-content'>"
			+ "<img class='max-width'  width='300'   height=''  src='https://marketing-image-production.s3.amazonaws.com/uploads/e6f5005a99d36af1be11c21e38fd9a0d1511e6ef482fc9627616042eaea82e2ff36e106b1f57991e1c17c9cae8b289a919adf1a24c3f2aa28db8df7d3a88c0e4.png' alt='' border='0' style='display: block; color: #000; text-decoration: none; font-family: Helvetica, arial, sans-serif; font-size: 16px;  max-width: 300px !important; width: 100% !important; height: auto !important; ' /></td></tr></table>"
			+ "<table class='module' role='module' data-type='text' border='0' cellpadding='0' cellspacing='0'  width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22child%22%3Afalse%2C%22padding%22%3A%2234%2C23%2C34%2C23%22%2C%22containerbackground%22%3A%22%23ffffff%22%7D'>"
			+ "<tr><td role='module-content'  valign='top' height='100%' style='padding: 34px 23px 34px 23px;' bgcolor='#ffffff'><h1 style='text-align: center;'><font color='#2d2d2d'>Don't worry, we all forget sometimes</font></h1>  <div style='text-align: center;'>You recently requested to reset your&nbsp;password for your account.<br> ​Click the button below and enter the following PIN number to reset your password.&nbsp;</div>  <div style='text-align: center;'>&nbsp;</div>  <div style='text-align: center;'><span style='font-size:26px;'><strong>"
			+ resetCode
			+ "</strong></span></div> </td></tr></table>"
			+ "<table class='module' role='module' data-type='button' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22borderradius%22%3A0%2C%22buttonpadding%22%3A%2214%2C56%2C13%2C56%22%2C%22text%22%3A%22Reset%2520Password%22%2C%22alignment%22%3A%22center%22%2C%22fontsize%22%3A15%2C%22url%22%3A%22localhost%253A8080/verifyaccount%22%2C%22height%22%3A%22%22%2C%22width%22%3A%22%22%2C%22containerbackground%22%3A%22%23ffffff%22%2C%22padding%22%3A%220%2C0%2C51%2C0%22%2C%22buttoncolor%22%3A%22%232f8646%22%2C%22textcolor%22%3A%22%23ffffff%22%2C%22bordercolor%22%3A%22%232f8646%22%7D'>"
			+ "<tr><td style='padding: 0px 0px 51px 0px;' align='center' bgcolor='#ffffff'><table border='0' cellpadding='0' cellspacing='0' class='wrapper-mobile'>"
			+ "<tr><td align='center' style='-webkit-border-radius: 0px; -moz-border-radius: 0px; border-radius: 0px; font-size: 15px;' bgcolor='#2f8646'>"
			+ "<a href='http://localhost:8080/forgotpassord' class='bulletproof-button' target='_blank' style='height: px; width: px; font-size: 15px; line-height: px; font-family: Helvetica, Arial, sans-serif; color: #ffffff; padding: 14px 56px 13px 56px; text-decoration: none; color: #ffffff; text-decoration: none; -webkit-border-radius: 0px; -moz-border-radius: 0px; border-radius: 0px; border: 1px solid #2f8646; display: inline-block;'>Reset Password</a>"
			+ "</td></tr></table></td></tr></table>"
			+ "<table class='module' role='module' data-type='text' border='0' cellpadding='0' cellspacing='0'  width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22child%22%3Afalse%2C%22padding%22%3A%220%2C0%2C20%2C0%22%2C%22containerbackground%22%3A%22%23ffffff%22%7D'>"
			+ "<tr><td role='module-content'  valign='top' height='100%' style='padding: 0px 0px 20px 0px;' bgcolor='#ffffff'><div style='text-align: center;'>This password reset is only valid for today.&nbsp;</div>  <div style='text-align: center;'>If you did not request for a password reset, you can safely ignore this email.</div> </td></tr></table>"
			+ "<table class='module' role='module' data-type='spacer' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22spacing%22%3A3%2C%22containerbackground%22%3A%22%23151b3b%22%7D'>"
			+ "<tr><td role='module-content' style='padding: 0px 0px 3px 0px;' bgcolor='#151b3b'></td></tr></table>"
			+ "<table class='module' role='module' data-type='spacer' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22spacing%22%3A34%2C%22containerbackground%22%3A%22%22%7D'>"
			+ "<tr><td role='module-content' style='padding: 0px 0px 34px 0px;' bgcolor=''></td></tr></table>"
			+ "<table class='module' role='module' data-type='spacer' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22spacing%22%3A3%2C%22containerbackground%22%3A%22%23151b3b%22%7D'>"
			+ "<tr><td role='module-content' style='padding: 0px 0px 3px 0px;' bgcolor='#151b3b'></td></tr></table>"
			+ "<table border='0' cellpadding='0' cellspacing='0' align='center' width='100%' class='module footer' role='module' data-type='footer' data-attributes='%7B%22dropped%22%3Atrue%2C%22columns%22%3A%222%22%2C%22padding%22%3A%2248%2C34%2C17%2C34%22%2C%22containerbackground%22%3A%22%23151b3b%22%7D'>"
			+ "<tr><td style='padding: 48px 34px 17px 34px;' bgcolor='#151b3b'><table border='0' cellpadding='0' cellspacing='0' align='center' width='100%'>"
			+ "<tr role='module-content'><td align='center' valign='top' width='50%' height='100%' class='templateColumnContainer'><table border='0' cellpadding='0' cellspacing='0' width='100%' height='100%'><tr><td class='leftColumnContent' role='column-one' height='100%' style='height:100%;'><table class='module' role='module' data-type='text' border='0' cellpadding='0' cellspacing='0'  width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22child%22%3Afalse%2C%22padding%22%3A%220%2C0%2C0%2C0%22%2C%22containerbackground%22%3A%22%23151b3b%22%7D'>"
			+ "<tr><td role='module-content'  valign='top' height='100%' style='padding: 0px 0px 0px 0px;' bgcolor='#151b3b'><div style='font-size: 10px; line-height: 150%; margin: 0px;'>&nbsp;</div>  <div style='font-size: 10px; line-height: 150%; margin: 0px;'>&nbsp;</div>  <div style='font-size: 10px; line-height: 150%; margin: 0px;'><font color='#ffffff'>Impact Launch.Space</font></div> </td></tr></table></td></tr></table></td>"
			+ "<td align='center' valign='top' width='50%' height='100%' class='templateColumnContainer'><table border='0' cellpadding='0' cellspacing='0' width='100%' height='100%'><tr><td class='rightColumnContent' role='column-two' height='100%' style='height:100%;'><table class='module' role='module' data-type='text' border='0' cellpadding='0' cellspacing='0'  width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22child%22%3Afalse%2C%22padding%22%3A%220%2C0%2C0%2C0%22%2C%22containerbackground%22%3A%22%23151b3b%22%7D'>"
			+ "<tr><td role='module-content'  valign='top' height='100%' style='padding: 0px 0px 0px 0px;' bgcolor='#151b3b'><div style='font-size: 10px; line-height: 150%; margin: 0px; text-align: right;'>&nbsp;</div>  <div style='font-size: 10px; line-height: 150%; margin: 0px; text-align: right;'><font color='#ffffff'>Allied World Healthcare</font></div> </td>"
			+ "</tr></table></td> </tr></table></td></tr></table></td></tr> </table></tr></td></table></td></tr></table></td></tr></table></tr></td></table></div></center></body></html>");
		Mail mail = new Mail(from, subject, to, content);

		SendGrid sendGrid = new SendGrid("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");
		Request request = new Request();

		try {
			request.setMethod(Method.POST);
			request.setBody(mail.build());

			// make request
			request.setBaseUri(sendGrid.getHost());
			request.setEndpoint("/" + sendGrid.getVersion() + "/mail/send");
			for (String key : sendGrid.getRequestHeaders().keySet())
				request.addHeader(key, sendGrid.getRequestHeaders().get(key));

			// send
			Response response = sendGrid.makeCall(request);
			System.out.println("status code: " + response.getStatusCode());
			System.out.println("body: " + response.getBody());
			System.out.println("headers: " + response.getHeaders());
		} catch (IOException ex) {
			ex.printStackTrace();
		}

	}
	
	public void sendUnlockEmail(String resetCode, String email) {
		Email from = new Email("admin@impactlaunchspace.com");
		String subject = "Unlocking account at ImpactLaunch.Space";
		Email to = new Email(email);
		Content content = new Content();
		content.setType("text/html");
		content.setValue("<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>"
				+ "<html xmlns='http://www.w3.org/1999/xhtml' data-dnd='true'><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1' />"
				+ "<style type='text/css'>body {color: #626262;}body a {color: #0088cd;text-decoration: none;}"
				+ "p { margin: 0; padding: 0; }table[class='wrapper'] {width:100% !important;table-layout: fixed;-webkit-font-smoothing: antialiased;-webkit-text-size-adjust: 100%;-moz-text-size-adjust: 100%;-ms-text-size-adjust: 100%;}"
				+ "img[class='max-width'] {max-width: 100% !important;}@media screen and (max-width:480px) {.preheader .rightColumnContent,.footer .rightColumnContent {text-align: left !important;}.preheader .rightColumnContent div,.preheader .rightColumnContent span,.footer .rightColumnContent div,.footer .rightColumnContent span {text-align: left !important;}"
				+ ".preheader .rightColumnContent,.preheader .leftColumnContent {font-size: 80% !important;padding: 5px 0;}"
				+ "table[class='wrapper-mobile'] {width: 100% !important;table-layout: fixed;}img[class='max-width'] {height: auto !important;}"
				+ "a[class='bulletproof-button'] {display: block !important;width: auto !important;font-size: 80%;padding-left: 0 !important;padding-right: 0 !important;} #templateColumns{width:100% !important;}"
				+ ".templateColumnContainer{display:block !important;width:100% !important;padding-left: 0 !important;padding-right: 0 !important;}}</style>"
				+ "<style>body, p, div { font-family: helvetica,arial,sans-serif; }</style><style>body, p, div { font-size: 15px; }</style></head>"
				+ "<body yahoofix='true' style='min-width: 100%; margin: 0; padding: 0; font-size: 15px; font-family: helvetica,arial,sans-serif; color: #626262; background-color: #F4F4F4; color: #626262;' data-attributes='%7B%22dropped%22%3Atrue%2C%22bodybackground%22%3A%22%23F4F4F4%22%2C%22bodyfontname%22%3A%22helvetica%2Carial%2Csans-serif%22%2C%22bodytextcolor%22%3A%22%23626262%22%2C%22bodylinkcolor%22%3A%22%230088cd%22%2C%22bodyfontsize%22%3A15%7D'>"
				+ "<center class='wrapper'><div class='webkit'><table cellpadding='0' cellspacing='0' border='0' width='100%' class='wrapper' bgcolor='#F4F4F4'>"
				+ "<tr><td valign='top' bgcolor='#F4F4F4' width='100%'><table width='100%' role='content-container' class='outer' data-attributes='%7B%22dropped%22%3Atrue%2C%22containerpadding%22%3A%220%2C0%2C0%2C0%22%2C%22containerwidth%22%3A600%2C%22containerbackground%22%3A%22%23F4F4F4%22%7D' align='center' cellpadding='0' cellspacing='0' border='0'>"
				+ "<tr><td width='100%'><table width='100%' cellpadding='0' cellspacing='0' border='0'><tr><td>"
				+ "<table width='100%' cellpadding='0' cellspacing='0' border='0' style='width: 100%; max-width:600px;' align='center'>"
				+ "<tr><td role='modules-container' style='padding: 0px 0px 0px 0px; color: #626262; text-align: left;' bgcolor='#F4F4F4' width='100%' align='left'>"
				+ "<table border='0' cellpadding='0' cellspacing='0' align='center' width='100%' style='display:none !important; visibility:hidden; opacity:0; color:transparent; height:0; width:0;' class='module preheader preheader-hide' role='module' data-type='preheader'>"
				+ "<tr><td role='module-content'><p>This is the preheader text.</p></td></tr></table>"
				+ "<table class='module' role='module' data-type='text' border='0' cellpadding='0' cellspacing='0'  width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22child%22%3Afalse%2C%22padding%22%3A%220%2C0%2C0%2C0%22%2C%22containerbackground%22%3A%22%22%7D'>"
				+"<tr><td role='module-content'  valign='top' height='100%' style='padding: 0px 0px 0px 0px;' bgcolor=''><div style='text-align: right;'><span style='font-family:verdana,geneva,sans-serif;'><span style='font-size:10px;'>Email not displaying correctly? <a href='[weblink]'>View it</a> in your browser.</span></span></div> </td></tr></table>"
				+ "<table role='module' data-type='image' border='0' align='center' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' class='wrapper' data-attributes='%7B%22child%22%3Afalse%2C%22link%22%3A%22%22%2C%22width%22%3A%22300%22%2C%22height%22%3A%22120%22%2C%22imagebackground%22%3A%22%23151b3b%22%2C%22url%22%3A%22https%3A//marketing-image-production.s3.amazonaws.com/uploads/e6f5005a99d36af1be11c21e38fd9a0d1511e6ef482fc9627616042eaea82e2ff36e106b1f57991e1c17c9cae8b289a919adf1a24c3f2aa28db8df7d3a88c0e4.png%22%2C%22alt_text%22%3A%22%22%2C%22dropped%22%3Atrue%2C%22imagemargin%22%3A%2234%2C0%2C34%2C150%22%2C%22alignment%22%3A%22%22%2C%22responsive%22%3Atrue%7D'>"
				+ "<tr><td style='font-size:6px;line-height:10px;background-color:#151b3b;padding: 34px 0px 34px 150px;' valign='top' align='' role='module-content'>"
				+ "<img class='max-width'  width='300'   height=''  src='https://marketing-image-production.s3.amazonaws.com/uploads/e6f5005a99d36af1be11c21e38fd9a0d1511e6ef482fc9627616042eaea82e2ff36e106b1f57991e1c17c9cae8b289a919adf1a24c3f2aa28db8df7d3a88c0e4.png' alt='' border='0' style='display: block; color: #000; text-decoration: none; font-family: Helvetica, arial, sans-serif; font-size: 16px;  max-width: 300px !important; width: 100% !important; height: auto !important; ' /></td></tr></table>"
				+ "<table class='module' role='module' data-type='text' border='0' cellpadding='0' cellspacing='0'  width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22child%22%3Afalse%2C%22padding%22%3A%2234%2C23%2C34%2C23%22%2C%22containerbackground%22%3A%22%23ffffff%22%7D'>"
				+ "<tr><td role='module-content'  valign='top' height='100%' style='padding: 34px 23px 34px 23px;' bgcolor='#ffffff'><h1 style='text-align: center;'><font color='#2d2d2d'>Oops!</font></h1>  <div style='text-align: center;'>It seems like you have been locked out of your account.<br /> ​Click the button below and enter the following&nbsp;PIN number&nbsp;to unlock your account.&nbsp;</div>  <div style='text-align: center;'>&nbsp;</div>  <div style='text-align: center;'><span style='font-size:26px;'><strong>123 456</strong></span></div> </td></tr></table>"
				+ "<table class='module' role='module' data-type='button' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22borderradius%22%3A0%2C%22buttonpadding%22%3A%2214%2C56%2C13%2C56%22%2C%22text%22%3A%22Unlock%2520Account%22%2C%22alignment%22%3A%22center%22%2C%22fontsize%22%3A15%2C%22url%22%3A%22localhost%253A8080/unlockaccount%22%2C%22height%22%3A%22%22%2C%22width%22%3A%22%22%2C%22containerbackground%22%3A%22%23ffffff%22%2C%22padding%22%3A%220%2C0%2C51%2C0%22%2C%22buttoncolor%22%3A%22%232f8646%22%2C%22textcolor%22%3A%22%23ffffff%22%2C%22bordercolor%22%3A%22%232f8646%22%7D'>"
				+ "<tr><td style='padding: 0px 0px 51px 0px;' align='center' bgcolor='#ffffff'><table border='0' cellpadding='0' cellspacing='0' class='wrapper-mobile'><tr>"
				+ "<td align='center' style='-webkit-border-radius: 0px; -moz-border-radius: 0px; border-radius: 0px; font-size: 15px;' bgcolor='#2f8646'>"
				+ "<a href='http://localhost:8080/unlockaccount' class='bulletproof-button' target='_blank' style='height: px; width: px; font-size: 15px; line-height: px; font-family: Helvetica, Arial, sans-serif; color: #ffffff; padding: 14px 56px 13px 56px; text-decoration: none; color: #ffffff; text-decoration: none; -webkit-border-radius: 0px; -moz-border-radius: 0px; border-radius: 0px; border: 1px solid #2f8646; display: inline-block;'>Unlock Account</a>"
				+ "</td></tr></table></td></tr></table>"
				+ "<table class='module' role='module' data-type='spacer' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22spacing%22%3A3%2C%22containerbackground%22%3A%22%23151b3b%22%7D'>"
				+ "<tr><td role='module-content' style='padding: 0px 0px 3px 0px;' bgcolor='#151b3b'></td></tr></table>"
				+ "<table class='module' role='module' data-type='spacer' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22spacing%22%3A34%2C%22containerbackground%22%3A%22%22%7D'>"
				+ "<tr><td role='module-content' style='padding: 0px 0px 34px 0px;' bgcolor=''></td></tr></table>"
				+ "<table class='module' role='module' data-type='spacer' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22spacing%22%3A3%2C%22containerbackground%22%3A%22%23151b3b%22%7D'>"
				+ "<tr><td role='module-content' style='padding: 0px 0px 3px 0px;' bgcolor='#151b3b'></td></tr></table>"
				+ "<table border='0' cellpadding='0' cellspacing='0' align='center' width='100%' class='module footer' role='module' data-type='footer' data-attributes='%7B%22dropped%22%3Atrue%2C%22columns%22%3A%222%22%2C%22padding%22%3A%2248%2C34%2C17%2C34%22%2C%22containerbackground%22%3A%22%23151b3b%22%7D'>"
				+ "<tr><td style='padding: 48px 34px 17px 34px;' bgcolor='#151b3b'>"
				+ "<table border='0' cellpadding='0' cellspacing='0' align='center' width='100%'>"
				+ "<tr role='module-content'><td align='center' valign='top' width='50%' height='100%' class='templateColumnContainer'>"
				+ "<table border='0' cellpadding='0' cellspacing='0' width='100%' height='100%'><tr>"
				+ "<td class='leftColumnContent' role='column-one' height='100%' style='height:100%;'><table class='module' role='module' data-type='text' border='0' cellpadding='0' cellspacing='0'  width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22child%22%3Afalse%2C%22padding%22%3A%220%2C0%2C0%2C0%22%2C%22containerbackground%22%3A%22%23151b3b%22%7D'>"
				+ "<tr> <td role='module-content'  valign='top' height='100%' style='padding: 0px 0px 0px 0px;' bgcolor='#151b3b'><div style='font-size: 10px; line-height: 150%; margin: 0px;'>&nbsp;</div>  <div style='font-size: 10px; line-height: 150%; margin: 0px;'>&nbsp;</div>  <div style='font-size: 10px; line-height: 150%; margin: 0px;'><font color='#ffffff'>Impact Launch.Space</font></div> </td></tr></table></td></tr></table></td>"
				+ "<td align='center' valign='top' width='50%' height='100%' class='templateColumnContainer'><table border='0' cellpadding='0' cellspacing='0' width='100%' height='100%'>"
				+ "<tr><td class='rightColumnContent' role='column-two' height='100%' style='height:100%;'><table class='module' role='module' data-type='text' border='0' cellpadding='0' cellspacing='0'  width='100%' style='table-layout: fixed;' data-attributes='%7B%22dropped%22%3Atrue%2C%22child%22%3Afalse%2C%22padding%22%3A%220%2C0%2C0%2C0%22%2C%22containerbackground%22%3A%22%23151b3b%22%7D'>"
				+ "<tr><td role='module-content'  valign='top' height='100%' style='padding: 0px 0px 0px 0px;' bgcolor='#151b3b'><div style='font-size: 10px; line-height: 150%; margin: 0px; text-align: right;'>&nbsp;</div>  <div style='font-size: 10px; line-height: 150%; margin: 0px; text-align: right;'><font color='#ffffff'>Allied World Healthcare</font></div> </td>"
				+ "</tr></table></td></tr></table></td></tr></table></td></tr></table>"
				+ "</tr></td></table></td></tr></table></td></tr> </table></tr></td></table></div></center></body></html>");
		
		
		Mail mail = new Mail(from, subject, to, content);

		SendGrid sendGrid = new SendGrid("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");
		Request request = new Request();

		try {
			request.setMethod(Method.POST);
			request.setBody(mail.build());

			// make request
			request.setBaseUri(sendGrid.getHost());
			request.setEndpoint("/" + sendGrid.getVersion() + "/mail/send");
			for (String key : sendGrid.getRequestHeaders().keySet())
				request.addHeader(key, sendGrid.getRequestHeaders().get(key));

			// send
			Response response = sendGrid.makeCall(request);
			System.out.println("status code: " + response.getStatusCode());
			System.out.println("body: " + response.getBody());
			System.out.println("headers: " + response.getHeaders());
		} catch (IOException ex) {
			ex.printStackTrace();
		}

	}

	public void updateResetCode(String newCode, String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

		ResetTokenDAO resetTokenDAO = (ResetTokenDAO) context.getBean("resetTokenDAO");
		resetTokenDAO.updateResetCode(newCode, username, calculateExpiryDate());
	}

	public void regenerateResetCode(String username, String email) {
		String newResetCode = generateToken();
		updateResetCode(newResetCode, username);
		sendResetEmail(retrieveResetCode(username), email);
	}
	
	public void regenerateUnlockCode(String username, String email) {
		String newResetCode = generateToken();
		updateResetCode(newResetCode, username);
		sendUnlockEmail(retrieveResetCode(username), email);
	}
	
	public ResetToken retrieveResetToken(String username){
	    ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
	    
	    ResetTokenDAO resetTokenDAO = (ResetTokenDAO) context.getBean("resetTokenDAO");
	      return resetTokenDAO.retrieveResetToken(username);
	  }

	public String retrieveResetCode(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

		ResetTokenDAO resetTokenDAO = (ResetTokenDAO) context.getBean("resetTokenDAO");
		return resetTokenDAO.retrieveResetToken(username).getReset_code();
	}

	public void setNewPassword(String password, String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

		UserDAO userDAO = (UserDAO) context.getBean("userDAO");

		userDAO.updatePasswordInDB(username, password);
	}

	public Boolean ifTokenExpired(String username) {
		ResetToken rt = retrieveResetToken(username);
		Date now = new Date(Calendar.getInstance().getTime().getTime());
		Date expiry = null;
		try {
			expiry = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rt.getExpiryDate());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return now.after(expiry);
	}

	public String calculateExpiryDate() {
		Calendar now = Calendar.getInstance();
		now.add(Calendar.MINUTE, EXPIRATION);
		Date dt = now.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String expiry = sdf.format(dt);
		return expiry;
	}
}