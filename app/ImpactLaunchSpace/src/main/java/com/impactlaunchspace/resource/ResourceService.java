package com.impactlaunchspace.resource;

import java.util.ArrayList;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.UserOfferedResourceDAO;
import com.impactlaunchspace.entity.UserOfferedResource;

@Service
public class ResourceService {
	
	public void insertUserResourceOffering(UserOfferedResource userOfferedResource) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		UserOfferedResourceDAO userOfferedResourceDAO = (UserOfferedResourceDAO) context
				.getBean("userOfferedResourceDAO");
		
		userOfferedResourceDAO.insert(userOfferedResource);
	}
	
	public void removeUserResourceOffering(UserOfferedResource userOfferedResource) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		UserOfferedResourceDAO userOfferedResourceDAO = (UserOfferedResourceDAO) context
				.getBean("userOfferedResourceDAO");
		
		userOfferedResourceDAO.remove(userOfferedResource);
	}
	
	public void removeAllUserResourceOffering(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		UserOfferedResourceDAO userOfferedResourceDAO = (UserOfferedResourceDAO) context
				.getBean("userOfferedResourceDAO");
		
		userOfferedResourceDAO.removeAll(username);
	}
	
	public ArrayList<UserOfferedResource> getUserResourceOffering(String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		UserOfferedResourceDAO userOfferedResourceDAO = (UserOfferedResourceDAO) context
				.getBean("userOfferedResourceDAO");
		
		return userOfferedResourceDAO.retrieveAll(username);
	}
	
	public void updateUserResourceOffering(UserOfferedResource oldUserOfferedResource, UserOfferedResource userOfferedResource) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		UserOfferedResourceDAO userOfferedResourceDAO = (UserOfferedResourceDAO) context
				.getBean("userOfferedResourceDAO");
		
		userOfferedResourceDAO.update(oldUserOfferedResource, userOfferedResource);
	}
	
	public UserOfferedResource retrieveOfferedResource(String username, String resource_category, String resource_name){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		UserOfferedResourceDAO userOfferedResourceDAO = (UserOfferedResourceDAO) context
				.getBean("userOfferedResourceDAO");
		return userOfferedResourceDAO.retrieveResource(username, resource_category, resource_name);
	}
}
