package com.impactlaunchspace.profile;

import java.util.ArrayList;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.CountryDAO;
import com.impactlaunchspace.dao.CountryOfOperationDAO;
import com.impactlaunchspace.dao.DocumentsIndividualDAO;
import com.impactlaunchspace.dao.IndividualAccountDAO;
import com.impactlaunchspace.dao.JobSectorDAO;
import com.impactlaunchspace.dao.JobSectorIndividualDAO;
import com.impactlaunchspace.dao.JobSectorOrganizationDAO;
import com.impactlaunchspace.dao.OrganizationAccountDAO;
import com.impactlaunchspace.dao.PreferredCountryDAO;
import com.impactlaunchspace.dao.PreferredJobSectorDAO;
import com.impactlaunchspace.dao.PreferredProjectAreaDAO;
import com.impactlaunchspace.dao.ProjectAreaDAO;
import com.impactlaunchspace.dao.SkillsetDAO;
import com.impactlaunchspace.dao.UserSkillDAO;
import com.impactlaunchspace.entity.Country;
import com.impactlaunchspace.entity.CountryOfOperation;
import com.impactlaunchspace.entity.IndividualAccount;
import com.impactlaunchspace.entity.JobSector;
import com.impactlaunchspace.entity.JobSectorIndividual;
import com.impactlaunchspace.entity.JobSectorOrganization;
import com.impactlaunchspace.entity.OrganizationAccount;
import com.impactlaunchspace.entity.PreferredCountry;
import com.impactlaunchspace.entity.PreferredJobSector;
import com.impactlaunchspace.entity.PreferredProjectArea;
import com.impactlaunchspace.entity.ProjectArea;
import com.impactlaunchspace.entity.Skillset;
import com.impactlaunchspace.entity.UserSkill;

@Service
public class ProfileService {
	public void firstSetupOrganization(OrganizationAccount organizationAccount,
			ArrayList<CountryOfOperation> countriesOfOperation,
			ArrayList<JobSectorOrganization> jobSectorsOrganization) {

		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		OrganizationAccountDAO organizationAccountDAO = (OrganizationAccountDAO) context
				.getBean("organizationAccountDAO");
		CountryOfOperationDAO countryOfOperationDAO = (CountryOfOperationDAO) context.getBean("countryOfOperationDAO");
		JobSectorOrganizationDAO jobSectorOrganizationDAO = (JobSectorOrganizationDAO) context
				.getBean("jobSectorOrganizationDAO");
		for (CountryOfOperation countryOfOperation : countriesOfOperation) {
			if (countryOfOperation != null) {
				countryOfOperationDAO.insert(countryOfOperation);
			}

		}

		for (JobSectorOrganization jobSectorOrganization : jobSectorsOrganization) {
			if (jobSectorOrganization != null) {
				jobSectorOrganizationDAO.insert(jobSectorOrganization);
			}
		}

		organizationAccountDAO.insert(organizationAccount);
	}

	public void firstSetupIndividual(IndividualAccount individualAccount,
			ArrayList<JobSectorIndividual> jobSectorsIndividual, ArrayList<PreferredCountry> prferredCountryList,
			ArrayList<PreferredJobSector> preferredJobSectorList,
			ArrayList<PreferredProjectArea> preferredProjectAreaList, ArrayList<UserSkill> userSkillsetList) {

		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		IndividualAccountDAO individualAccountDAO = (IndividualAccountDAO) context.getBean("individualAccountDAO");
		JobSectorIndividualDAO jobSectorIndividualDAO = (JobSectorIndividualDAO) context
				.getBean("jobSectorIndividualDAO");
		PreferredCountryDAO preferredCountryDAO = (PreferredCountryDAO) context.getBean("preferredCountryDAO");
		PreferredJobSectorDAO preferredJobSectorDAO = (PreferredJobSectorDAO) context.getBean("preferredJobSectorDAO");
		PreferredProjectAreaDAO preferredProjectAreaDAO = (PreferredProjectAreaDAO) context
				.getBean("preferredProjectAreaDAO");
		UserSkillDAO userSkillDAO = (UserSkillDAO) context.getBean("userSkillDAO");
		DocumentsIndividualDAO documentsIndividualDAO = (DocumentsIndividualDAO) context
				.getBean("documentsIndividualDAO");

		for (JobSectorIndividual jobSectorIndividual : jobSectorsIndividual) {
			if (jobSectorIndividual != null) {
				jobSectorIndividualDAO.insert(jobSectorIndividual);
			}

		}

		for (PreferredCountry preferredCountry : prferredCountryList) {
			if (preferredCountry != null) {
				preferredCountryDAO.insert(preferredCountry);
			}
		}

		for (PreferredJobSector preferredJobSector : preferredJobSectorList) {
			if (preferredJobSector != null) {
				preferredJobSectorDAO.insert(preferredJobSector);
			}
		}

		for (PreferredProjectArea preferredProjectArea : preferredProjectAreaList) {
			if (preferredProjectArea != null) {
				preferredProjectAreaDAO.insert(preferredProjectArea);
			}
		}

		for (UserSkill userskill : userSkillsetList) {
			if (userskill != null) {
				userSkillDAO.insert(userskill);
			}
		}

		individualAccountDAO.insert(individualAccount);
	}

	public OrganizationAccount getOrganizationAccountDetails(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		OrganizationAccountDAO organizationAccountDAO = (OrganizationAccountDAO) context
				.getBean("organizationAccountDAO");

		return organizationAccountDAO.findByUsername(username);
	}

	public IndividualAccount getIndividualAccountDetails(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		IndividualAccountDAO individualAccountDAO = (IndividualAccountDAO) context.getBean("individualAccountDAO");

		return individualAccountDAO.findByUsername(username);
	}

	// These 2 methods help return information for organizations accounts
	public ArrayList<CountryOfOperation> retrieveCountriesOfOperations(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		CountryOfOperationDAO countryOfOperationDAO = (CountryOfOperationDAO) context.getBean("countryOfOperationDAO");

		return countryOfOperationDAO.retrieveCountriesOfOperations(username);
	}

	public ArrayList<JobSectorOrganization> retrieveOrganizationJobSectors(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		JobSectorOrganizationDAO jobSectorOrganizationDAO = (JobSectorOrganizationDAO) context
				.getBean("jobSectorOrganizationDAO");

		return jobSectorOrganizationDAO.retrieveOrganizationJobSectors(username);
	}

	// These methods help return information for individual accounts
	public ArrayList<JobSectorIndividual> retrieveIndividualJobSectors(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		JobSectorIndividualDAO jobSectorIndividualDAO = (JobSectorIndividualDAO) context
				.getBean("jobSectorIndividualDAO");

		return jobSectorIndividualDAO.retrieveIndividualJobSectors(username);
	}

	public ArrayList<PreferredCountry> retrievePreferredCountries(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		PreferredCountryDAO preferredCountryDAO = (PreferredCountryDAO) context.getBean("preferredCountryDAO");

		return preferredCountryDAO.retrievePreferredCountries(username);
	}

	public ArrayList<PreferredJobSector> retrievePreferredJobSectors(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		PreferredJobSectorDAO preferredJobSectorDAO = (PreferredJobSectorDAO) context.getBean("preferredJobSectorDAO");

		return preferredJobSectorDAO.retrievePreferredJobSectors(username);
	}

	public ArrayList<PreferredProjectArea> retrievePreferredProjectArea(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		PreferredProjectAreaDAO preferredProjectAreaDAO = (PreferredProjectAreaDAO) context
				.getBean("preferredProjectAreaDAO");

		return preferredProjectAreaDAO.retrievePreferredProjectArea(username);
	}

	public ArrayList<UserSkill> retrieveAllSkillsOfUser(String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		UserSkillDAO userSkillDAO = (UserSkillDAO) context.getBean("userSkillDAO");

		return userSkillDAO.retrieveAllSkillsOfUser(username);
	}

	public void updateOrganizationAccount(OrganizationAccount updatedOrganizationAccount, String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		OrganizationAccountDAO organizationAccountDAO = (OrganizationAccountDAO) context
				.getBean("organizationAccountDAO");

		organizationAccountDAO.update(updatedOrganizationAccount, username);

	}

	public void updateIndividualAccount(IndividualAccount updatedIndividualAccount, String username) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		IndividualAccountDAO individualAccountDAO = (IndividualAccountDAO) context.getBean("individualAccountDAO");

		individualAccountDAO.update(updatedIndividualAccount, username);
	}

	// These methods are for populating the set-up page
	public ArrayList<Country> retrieveCountryList() {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		CountryDAO countryDAO = (CountryDAO) context.getBean("countryDAO");

		return countryDAO.retrieveAll();
	}

	public ArrayList<JobSector> retrieveJobSectorList() {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		JobSectorDAO jobSectorDAO = (JobSectorDAO) context.getBean("jobSectorDAO");

		return jobSectorDAO.retrieveAll();
	}

	public ArrayList<ProjectArea> retrieveProjectAreaList() {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		ProjectAreaDAO projectAreaDAO = (ProjectAreaDAO) context.getBean("projectAreaDAO");

		return projectAreaDAO.retrieveAll();
	}

	public ArrayList<Skillset> retrieveSkillsetList() {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		SkillsetDAO skillsetDAO = (SkillsetDAO) context.getBean("skillsetDAO");

		return skillsetDAO.retrieveAll();
	}
	
	public void updateMultipleFieldsOrganization(String username, ArrayList<JobSectorOrganization> updated_jobsector_organization,
			ArrayList<CountryOfOperation> updated_countriesofoperations) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		OrganizationAccountDAO organizationAccountDAO = (OrganizationAccountDAO) context
				.getBean("organizationAccountDAO");
		CountryOfOperationDAO countryOfOperationDAO = (CountryOfOperationDAO) context.getBean("countryOfOperationDAO");
		JobSectorOrganizationDAO jobSectorOrganizationDAO = (JobSectorOrganizationDAO) context
				.getBean("jobSectorOrganizationDAO");
		
		countryOfOperationDAO.deleteUserCountriesOfOperations(username);
		jobSectorOrganizationDAO.deleteUserJobSectorOrganization(username);
		
		for(CountryOfOperation coo: updated_countriesofoperations){
			countryOfOperationDAO.insert(coo);
		}
		
		for(JobSectorOrganization jso: updated_jobsector_organization){
			jobSectorOrganizationDAO.insert(jso);
		}
	}
	
	public void updateMultipleFieldsIndividual(String username, JobSectorIndividual jobSector1, JobSectorIndividual jobSector2, 
			JobSectorIndividual jobSector3,	ArrayList<PreferredCountry> updated_preferredcountries, 
			ArrayList<PreferredJobSector> updated_preferredjobsectors, 
			ArrayList<PreferredProjectArea> updated_preferredprojectareas, ArrayList<UserSkill> updated_skillsets) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		
		JobSectorIndividualDAO jobSectorIndividualDAO = (JobSectorIndividualDAO) context.getBean("jobSectorIndividualDAO");
		PreferredCountryDAO preferredCountryDAO = (PreferredCountryDAO) context.getBean("preferredCountryDAO");
		PreferredJobSectorDAO preferredJobSectorDAO = (PreferredJobSectorDAO) context.getBean("preferredJobSectorDAO");
		PreferredProjectAreaDAO preferredProjectAreaDAO = (PreferredProjectAreaDAO) context.getBean("preferredProjectAreaDAO");
		UserSkillDAO userSkillDAO = (UserSkillDAO) context.getBean("userSkillDAO");
		
		jobSectorIndividualDAO.deleteUserJobSectorIndividual(username);
		preferredCountryDAO.deleteUserPreferredCountry(username);
		preferredJobSectorDAO.deleteUserPreferredJobSector(username);
		preferredProjectAreaDAO.deleteUserPreferredProjectArea(username);
		userSkillDAO.deleteUserSkillset(username);
		
		if(jobSector1 != null ){
			jobSectorIndividualDAO.insert(jobSector1);
		}
		if(jobSector2 != null ){
			jobSectorIndividualDAO.insert(jobSector2);
		}
		if(jobSector3 != null ){
			jobSectorIndividualDAO.insert(jobSector3);
		}
		
		for(PreferredCountry pc: updated_preferredcountries){
			preferredCountryDAO.insert(pc);
		}	
		
		for(PreferredJobSector pjs: updated_preferredjobsectors){
			preferredJobSectorDAO.insert(pjs);
		}
		
		for(PreferredProjectArea ppa: updated_preferredprojectareas){
			preferredProjectAreaDAO.insert(ppa);
		}
		
		for(UserSkill us: updated_skillsets){
			userSkillDAO.insert(us);
		}
	}

}
