package com.impactlaunchspace.login;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.UserDAO;
import com.impactlaunchspace.dao.VerificationTokenDAO;
import com.impactlaunchspace.entity.User;

@Service
public class RegisterService {
	@Autowired
	VerificationTokenService vtService; 
	
	public boolean registerNewUser(String username, String password, String email, String user_type){
		//this method registers the user, hashes the pw and stores it into the db
				try{
					ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
				

				    UserDAO userDAO = (UserDAO) context.getBean("userDAO");
				    VerificationTokenDAO verificationTokenDAO = (VerificationTokenDAO) context.getBean("verificationTokenDAO");
				    
				    String cipherpw = BCrypt.hashpw(password, BCrypt.gensalt());
				    User user = new User(username, cipherpw, email, user_type);
				    userDAO.insert(user);
				    
				    //generates the token and stores it
				    String hashCode= vtService.generateToken();
				    VerificationToken first_vt = new VerificationToken(hashCode,user.getUsername());
				    
				    verificationTokenDAO.insert(first_vt);
				    return true;
				}catch(Exception e){
					return false;
				}
	}
}
