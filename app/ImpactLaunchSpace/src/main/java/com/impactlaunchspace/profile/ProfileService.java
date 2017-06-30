package com.impactlaunchspace.profile;

import java.util.ArrayList;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.CountryOfOperationDAO;
import com.impactlaunchspace.dao.JobSectorOrganizationDAO;
import com.impactlaunchspace.dao.OrganizationAccountDAO;
import com.impactlaunchspace.entity.CountryOfOperation;
import com.impactlaunchspace.entity.JobSectorOrganization;
import com.impactlaunchspace.entity.OrganizationAccount;

@Service
public class ProfileService {
	public void firstSetupOrganization(OrganizationAccount organizationAccount, 
			ArrayList<CountryOfOperation> countriesOfOperation,
			ArrayList<JobSectorOrganization> jobSectorsOrganization){
		
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		OrganizationAccountDAO organizationAccountDAO = (OrganizationAccountDAO) context.getBean("organizationAccountDAO");
		CountryOfOperationDAO countryOfOperationDAO = (CountryOfOperationDAO) context.getBean("countryOfOperationDAO");
		JobSectorOrganizationDAO jobSectorOrganizationDAO = (JobSectorOrganizationDAO) context.getBean("jobSectorOrganizationDAO");
	    for(CountryOfOperation countryOfOperation : countriesOfOperation){
	    	if(countryOfOperation!= null){
	    		countryOfOperationDAO.insert(countryOfOperation);
	    	}
	    	
	    }
	    
	    for(JobSectorOrganization jobSectorOrganization : jobSectorsOrganization){
	    	if(jobSectorOrganization != null){
	    		jobSectorOrganizationDAO.insert(jobSectorOrganization);
	    	}
	    }
	    
		organizationAccountDAO.insert(organizationAccount);
	}
	
	
	public void firstSetupIndividual(OrganizationAccount organizationAccount, 
			ArrayList<CountryOfOperation> countriesOfOperation,
			ArrayList<JobSectorOrganization> jobSectorsOrganization){
		
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		OrganizationAccountDAO organizationAccountDAO = (OrganizationAccountDAO) context.getBean("organizationAccountDAO");
		CountryOfOperationDAO countryOfOperationDAO = (CountryOfOperationDAO) context.getBean("countryOfOperationDAO");
		JobSectorOrganizationDAO jobSectorOrganizationDAO = (JobSectorOrganizationDAO) context.getBean("jobSectorOrganizationDAO");
	    for(CountryOfOperation countryOfOperation : countriesOfOperation){
	    	if(countryOfOperation!= null){
	    		countryOfOperationDAO.insert(countryOfOperation);
	    	}
	    	
	    }
	    
	    for(JobSectorOrganization jobSectorOrganization : jobSectorsOrganization){
	    	if(jobSectorOrganization != null){
	    		jobSectorOrganizationDAO.insert(jobSectorOrganization);
	    	}
	    }
	    
		organizationAccountDAO.insert(organizationAccount);
	}
	
	public OrganizationAccount getOrganizationAccountDetails(String username){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		OrganizationAccountDAO organizationAccountDAO = (OrganizationAccountDAO) context.getBean("organizationAccountDAO");

		return organizationAccountDAO.findByUsername(username);
	}
	
}
