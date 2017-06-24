package com.impactlaunchspace.profile;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.entity.OrganizationAccount;
import com.impactlaunchspace.dao.OrganizationAccountDAO;

@Service
public class ProfileService {
	public void firstSetup(OrganizationAccount organizationAccount){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		OrganizationAccountDAO organizationAccountDAO = (OrganizationAccountDAO) context.getBean("organizationAccountDAO");
	    organizationAccountDAO.insert(organizationAccount);
	}
}
