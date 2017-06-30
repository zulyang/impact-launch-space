package com.impactlaunchspace.users;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.UserDAO;
import com.impactlaunchspace.entity.User;

@Service
public class UserService {
	public User retrieveUser(String usernameemail){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		UserDAO userDAO = (UserDAO) context.getBean("userDAO");
		
		User output = null;
		output = userDAO.findByUsername(usernameemail);
		if(output != null){
			return output;
		}else{
			output = userDAO.findByEmail(usernameemail);
			if(output != null){
				return output;
			}
		}
		
		return null;
	}
	
}