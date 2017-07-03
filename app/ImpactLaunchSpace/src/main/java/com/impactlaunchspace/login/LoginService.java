package com.impactlaunchspace.login;

import java.util.UUID;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.CookieDAO;
import com.impactlaunchspace.dao.IndividualAccountDAO;
import com.impactlaunchspace.dao.OrganizationAccountDAO;
import com.impactlaunchspace.dao.UserDAO;
import com.impactlaunchspace.entity.IndividualAccount;
import com.impactlaunchspace.entity.OrganizationAccount;
import com.impactlaunchspace.entity.User;

@Service
public class LoginService {
	public boolean authenticate(String usernameemail, String password){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

	    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
		User user = userDAO.findByUsername(usernameemail);
		//if user is null, 
		if(user == null){
			user = userDAO.findByEmail(usernameemail);
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
	
	public boolean checkEnabled(String usernameemail){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

	    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
		User user = null;
		user = userDAO.findByUsername(usernameemail);
		
		//if user is null, 
		if(user == null){
			user = userDAO.findByEmail(usernameemail);
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
	
	public boolean userExists(String usernameemail) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
	    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
	    User user = null;
	    user = userDAO.findByUsername(usernameemail);
	    if(user == null){
	    	user = userDAO.findByEmail(usernameemail);
	    	if(user == null){
	    		return false;
	    	}
	    	return true;
	    }else{
	    	return true;
	    }
	}
	
	//this method returns the username from a possible username/email field
	public String returnUsernameFromEmail(String usernameemail){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
	    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
	    String username = null;
	    User user = null;
	    user = userDAO.findByUsername(usernameemail);
	    if(user == null){
	    	user = userDAO.findByEmail(usernameemail);
	    	if(user == null){
	    		return null;
	    	}
	    	username = user.getUsername();
	    	return username;
	    }else{
	    	return usernameemail;
	    }
	}
	
	//this method returns the email from a possible username/email field
	public String returnEmailFromUsername(String usernameemail){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
	    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
	    User user = null;
	    user = userDAO.findByEmail(usernameemail);
	    if(user == null){
	    	user = userDAO.findByUsername(usernameemail);
	    	if(user == null){
	    		return null;
	    	}
	    	return user.getEmail();
	    }else{
	    	return usernameemail;
	    }
	}
	
	public boolean isFirstTimeLogin(String usernameemail){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		OrganizationAccountDAO organizationAccountDAO = (OrganizationAccountDAO) context.getBean("organizationAccountDAO");
		IndividualAccountDAO individualAccountDAO = (IndividualAccountDAO) context.getBean("individualAccountDAO");
		OrganizationAccount organizationAccount = null;
		IndividualAccount individualAccount = null;
		organizationAccount = organizationAccountDAO.findByUsername(usernameemail);
		if(organizationAccount == null){
			organizationAccount = organizationAccountDAO.findByEmail(usernameemail);
		}if(organizationAccount == null){
			individualAccount = individualAccountDAO.findByUsername(usernameemail);
		}if(individualAccount == null){
			individualAccount = individualAccountDAO.findByEmail(usernameemail);
		}if(individualAccount == null && organizationAccount == null){
			return true;
		}
		
		return false;
	}
	
	public UUID generateCookieSecret(String username){
		UUID secret = UUID.randomUUID();
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		CookieDAO cookieDAO = (CookieDAO) context.getBean("cookieDAO");
		cookieDAO.insert(username, secret.toString());
		return secret;
	}
}
