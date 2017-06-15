package com.impactlaunchspace.login;

import java.util.Random;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.UserDAO;
import com.impactlaunchspace.dao.VerificationTokenDAO;

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
}
