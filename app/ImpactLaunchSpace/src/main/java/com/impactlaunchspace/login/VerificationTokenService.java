package com.impactlaunchspace.login;

import java.io.IOException;
import java.util.Random;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.UserDAO;
import com.impactlaunchspace.dao.VerificationTokenDAO;
import com.sendgrid.Content;
import com.sendgrid.Email;
import com.sendgrid.Mail;
import com.sendgrid.Method;
import com.sendgrid.Request;
import com.sendgrid.Response;
import com.sendgrid.SendGrid;

@Service
public class VerificationTokenService {
	
	LoginService loginService;
	
	//this method generates a 6 digit random number
	public String generateToken(){
		Random rand = new Random();
		String token = "";
		
		for(int i=0; i<6; i++){
			token += rand.nextInt(10);
		}
		
		return token;
	}
	
	public boolean verifyToken(String token, String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

	    VerificationTokenDAO verificationTokenDAO = (VerificationTokenDAO) context.getBean("verificationTokenDAO");
	    
	    String verificationCode = null;
	    
	    verificationCode = verificationTokenDAO.retrieveVerificationCode(username);
	    
	    if(verificationCode == null){
	    	return false;
	    }
	    
	    if(token.equals(verificationCode)){
	    	return true;
	    }
	    
	    return false;
	}
	
	public void unlock(String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		
	    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
	    
	    userDAO.unlockAccount(username);
	}
	
	public void lock(String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		
	    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
	    
	    userDAO.lockAccount(username);
	}
	
	public void sendVerificationEmail(String verificationCode, String email){
		Email from = new Email("admin@impactlaunchspace.com");
        String subject = "Verification code for ImpactLaunch.Space";
        Email to = new Email(email);
        Content content = new Content("text/plain", "You have recently registered for an account at ImpactLaunch.Space. \n" +
        "Your verification code is: " + verificationCode);
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
        } catch (IOException ex){
            ex.printStackTrace();
        }
    
	}
	
	public void updateVerificationCode(String newCode, String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

	    VerificationTokenDAO verificationTokenDAO = (VerificationTokenDAO) context.getBean("verificationTokenDAO");
	    verificationTokenDAO.updateVerificationCode(newCode, username);
	}
	
	public void regenerateVerificationCode(String username, String email){
		String newVerificationCode = generateToken();
		updateVerificationCode(newVerificationCode, username);
		sendVerificationEmail(retrieveVerificationCode(username), email);
	}

	
	public String retrieveVerificationCode(String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		
	    VerificationTokenDAO verificationTokenDAO = (VerificationTokenDAO) context.getBean("verificationTokenDAO");
	    return verificationTokenDAO.retrieveVerificationCode(username);
	}
}
