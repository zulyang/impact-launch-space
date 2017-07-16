package com.impactlaunchspace.users;

import java.util.ArrayList;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.IndividualAccountDAO;
import com.impactlaunchspace.dao.OrganizationAccountDAO;
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
	
	public ArrayList<String> retrieveUsernameList(){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		UserDAO userDAO = (UserDAO) context.getBean("userDAO");
		
		ArrayList<String> output = new ArrayList<String>();
		output = userDAO.retrieveUsernameList();
		return output;
	}
	
	public ArrayList<String> retrieveOrganizationNamelist(){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		OrganizationAccountDAO organizationAccountDAO = (OrganizationAccountDAO) context.getBean("organizationAccountDAO");
		
		ArrayList<String> output = new ArrayList<String>();
		output = organizationAccountDAO.retrieveOrganizationNamelist();
		return output;
	}
	
	public String retrieveFullNameOrCompanyName(String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		OrganizationAccountDAO organizationAccountDAO = (OrganizationAccountDAO) context.getBean("organizationAccountDAO");
		IndividualAccountDAO individualAccountDAO = (IndividualAccountDAO) context.getBean("individualAccountDAO");
		UserDAO userDAO = (UserDAO) context.getBean("userDAO");
		
		ArrayList<String> output = new ArrayList<String>();
		User user = userDAO.findByUsername(username);
		
		if(user.getUser_type().equals("organization")){
			return organizationAccountDAO.findByUsername(username).getCompanyName();
		}else if(user.getUser_type().equals("individual")){
			return individualAccountDAO.findByUsername(username).getFirst_name() + " " + individualAccountDAO.findByUsername(username).getLast_name();
		}
		return "";
	}
	
}
