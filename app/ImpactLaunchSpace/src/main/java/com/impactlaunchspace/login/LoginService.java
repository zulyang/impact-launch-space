package com.impactlaunchspace.login;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.UserDAO;
import com.impactlaunchspace.entity.User;

@Service
public class LoginService {
	public boolean authenticate(String username, String password){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

	    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
		User user = userDAO.findByUsername(username);
		//if user is null, 
		if(user == null){
			user = userDAO.findByEmail(username);
		}
		
		if(user!= null){
			boolean isUser = false;
			
			//check plaintext with ciphertext salt in DB
			isUser = BCrypt.checkpw(password, user.getPassword());
			
			if(isUser){
				//successful login
				//firstly store a new salt in the db
				userDAO.updatePasswordInDB(user.getUsername(), password);
				
				return true;
			}else{
				//unsuccessful, return and validate
				return false;
			}
		}else{
			//wrong login particulars
			return false;
		}
	}
	
	public boolean checkEnabled(String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

	    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
		User user = null;
		user = userDAO.findByUsername(username);
		
		//if user is null, 
		if(user == null){
			user = userDAO.findByEmail(username);
		}
		
		if(user== null){
			return false;
		}
		
		return user.isEnabled();
	}
	
	public void resetLoginAttempts(String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

	    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
	    userDAO.resetLoginAttempts(username);
	}
	
	public void increaseLoginAttempts(String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
	    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
	    userDAO.increaseLoginAttempts(username);
	}
	
	public int getLoginAttempts(String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
	    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
	    return userDAO.getLoginAttempts(username);

	}
	
	public void lockAccount(String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
	    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
	    userDAO.lockAccount(username);
		
	}
	
	public void unlockAccount(String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
	    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
	    userDAO.unlockAccount(username);	
	}
	
	public boolean userExists(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
	    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
	    User user = null;
	    user = userDAO.findByUsername(username);
	    if(user == null){
	    	return false;
	    }else{
	    	return true;
	    }
	}
}
