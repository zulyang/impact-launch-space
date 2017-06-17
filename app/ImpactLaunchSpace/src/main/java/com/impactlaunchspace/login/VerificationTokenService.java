package com.impactlaunchspace.login;

import java.util.Random;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.UserDAO;
import com.impactlaunchspace.dao.VerificationTokenDAO;
import com.sendgrid.SendGrid;

@Service
public class VerificationTokenService {
	
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
	
	public void sendVerificationEmail(String verificationCode){
		SendGrid sendgrid = new SendGrid("codezilla1", "Codezilla1");

        SendGrid.Email email = new SendGrid.Email();

        email.addTo("edward.foo.2015@smu.edu.sg");
        email.setFrom("edward.foo.2015@smu.edu.sg");
        email.setSubject("Sending with SendGrid is Fun");
        email.setHtml("and easy to do anywhere, even with Java");
        try{
        	SendGrid.Response response = sendgrid.send(email);
        }catch(Exception e){
        	System.out.print(e.getMessage());
        	e.printStackTrace();
        }
    
	}
	

	
	public String retrieveVerificationCode(String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		
	    VerificationTokenDAO verificationTokenDAO = (VerificationTokenDAO) context.getBean("verificationTokenDAO");
	    return verificationTokenDAO.retrieveVerificationCode(username);
	}
}
