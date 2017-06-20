package com.impactlaunchspace.login;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.ResetTokenDAO;
import com.impactlaunchspace.dao.UserDAO;
import com.impactlaunchspace.dao.VerificationTokenDAO;
import com.impactlaunchspace.entity.ResetToken;
import com.impactlaunchspace.entity.User;
import com.impactlaunchspace.entity.VerificationToken;

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
				    ResetTokenDAO resetTokenDAO = (ResetTokenDAO) context.getBean("resetTokenDAO");
				    String cipherpw = BCrypt.hashpw(password, BCrypt.gensalt());
				    User user = new User(username, cipherpw, email, user_type);
				    userDAO.insert(user);
				    
				    //generates the token and stores it
				    String hashCode= vtService.generateToken();
				    VerificationToken first_vt = new VerificationToken(hashCode,user.getUsername());
				    ResetToken placeholder_rt = new ResetToken("0",user.getUsername());
				    
				    verificationTokenDAO.insert(first_vt);
				    resetTokenDAO.insert(placeholder_rt);
				    return true;
				}catch(Exception e){
					return false;
				}
	}
}
