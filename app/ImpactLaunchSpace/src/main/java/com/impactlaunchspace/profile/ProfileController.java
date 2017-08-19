package com.impactlaunchspace.profile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.impactlaunchspace.entity.CountryOfOperation;
import com.impactlaunchspace.entity.IndividualAccount;
import com.impactlaunchspace.entity.JobSectorIndividual;
import com.impactlaunchspace.entity.JobSectorOrganization;
import com.impactlaunchspace.entity.OrganizationAccount;
import com.impactlaunchspace.entity.PreferredCountry;
import com.impactlaunchspace.entity.PreferredJobSector;
import com.impactlaunchspace.entity.PreferredProjectArea;
import com.impactlaunchspace.entity.User;
import com.impactlaunchspace.entity.UserSkill;
import com.impactlaunchspace.users.UserService;

@Controller
public class ProfileController {

	@Autowired
	ProfileService profileService;

	@Autowired
	UserService userService;

	// Setup for Organizations
	@RequestMapping(value = "/setup-organization", method = RequestMethod.GET)
	public String showSetupPageForOrganizationProfile() {
		return "profile/organization/" + "setup_organization_profile";
	}

	@RequestMapping(value = "/setup-organization", method = RequestMethod.POST)
	public String processSetupOrganization(@RequestParam String username, @RequestParam String email,
			@RequestParam String companyName, @RequestParam ArrayList<String> countriesOfOperation,
			@RequestParam String companyBio, @RequestParam ArrayList<String> selected_jobsectors,
			@RequestParam String contactDetails, @RequestParam("profilePicture") MultipartFile profilePicture,
			ModelMap model, HttpServletRequest request) {

		File profilePictureFile = new File(profilePicture.getOriginalFilename());
		try {
			profilePicture.transferTo(profilePictureFile);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		OrganizationAccount organizationAccount = new OrganizationAccount(username, email, companyName, false, false,
				profilePictureFile, companyBio, contactDetails);

		profilePictureFile.deleteOnExit();
		// this requires changing
		ArrayList<JobSectorOrganization> jobSectorsOrganization = new ArrayList<JobSectorOrganization>();
		ArrayList<CountryOfOperation> countriesOfOperationList = new ArrayList<CountryOfOperation>();

		for (String jobSectorOrganization : selected_jobsectors) {
			JobSectorOrganization jobSectorOrganization3 = new JobSectorOrganization(jobSectorOrganization, username);
			jobSectorsOrganization.add(jobSectorOrganization3);
		}

		// handle multiple select for countries of operation
		for (String countryOfOperation : countriesOfOperation) {
			CountryOfOperation countryOfOperationObj = new CountryOfOperation(countryOfOperation, username);
			countriesOfOperationList.add(countryOfOperationObj);
		}

		profileService.firstSetupOrganization(organizationAccount, countriesOfOperationList, jobSectorsOrganization);

		model.put("username", username);
		model.addAttribute("organization", profileService.getOrganizationAccountDetails(username));
		request.getSession().setAttribute("organization", profileService.getOrganizationAccountDetails(username));
		request.getSession().setAttribute("organization", profileService.getOrganizationAccountDetails(username));
		request.getSession().setAttribute("countriesOfOperation",
				profileService.retrieveCountriesOfOperations(username));
		request.getSession().setAttribute("jobSectorsOrganization",
				profileService.retrieveOrganizationJobSectors(username));
		return "profile/organization/" + "view_own_organization_profile";
	}

	@RequestMapping(value = "/view-organization-profile", method = RequestMethod.GET)
	public String showOrganizationDisplayPage(HttpServletRequest request) {
		return "profile/organization/" + "view_own_organization_profile";
	}

	@RequestMapping(value = "/edit-organization-profile", method = RequestMethod.GET)
	public String EditProfilePageOrganization(ModelMap model, HttpServletRequest request) {

		// Populate the JobSectors and countries the organization has chosen for
		// editing
		request.getSession().setAttribute("country_list", profileService.retrieveCountryList());
		request.getSession().setAttribute("job_sector_list", profileService.retrieveJobSectorList());

		ArrayList<CountryOfOperation> coos = profileService
				.retrieveCountriesOfOperations((String) request.getSession().getAttribute("username"));
		ArrayList<String> organization_countriesofoperation_list = new ArrayList<String>();
		for (CountryOfOperation coo : coos) {
			organization_countriesofoperation_list.add(coo.getCountry_name());
		}

		ArrayList<JobSectorOrganization> jsos = profileService
				.retrieveOrganizationJobSectors((String) request.getSession().getAttribute("username"));
		ArrayList<String> organization_jobsector_list = new ArrayList<String>();
		for (JobSectorOrganization jso : jsos) {
			organization_jobsector_list.add(jso.getJob_sector());
		}

		request.getSession().setAttribute("organization_jobsector_list", organization_jobsector_list);
		request.getSession().setAttribute("organization_countriesofoperation_list",
				organization_countriesofoperation_list);
		request.getSession().setAttribute("country_list", profileService.retrieveCountryList());
		request.getSession().setAttribute("job_sector_list", profileService.retrieveJobSectorList());
		return "profile/organization/" + "edit_organization_profile";
	}

	@RequestMapping(value = "/editprofile-organization", method = RequestMethod.GET)
	public String showEditProfilePageOrganization(HttpServletRequest request) {
		return "editprofile-organization";
	}

	// Setup for Individuals
	@RequestMapping(value = "/setup-individual", method = RequestMethod.GET)
	public String showSetupPageForIndividualProfile() {
		return "profile/individual/" + "setup_individual_profile";
	}

	@RequestMapping(value = "/setup-individual", method = RequestMethod.POST)
	public String processSetupIndividual(@RequestParam String username, @RequestParam String email,
			@RequestParam String firstName, @RequestParam String lastName, @RequestParam String country,
			@RequestParam String organization, @RequestParam String jobSector1, @RequestParam int js1Years,
			@RequestParam Date dateOfBirth, @RequestParam String jobTitle, @RequestParam boolean isPublicProfile,
			@RequestParam(required = false) String jobSector2, @RequestParam(required = false) String js2Years,
			@RequestParam(required = false) String jobSector3, @RequestParam(required = false) String js3Years,
			@RequestParam ArrayList<String> selected_skillsets,
			@RequestParam ArrayList<String> selected_preferredjobsectors,
			@RequestParam ArrayList<String> selected_projectareas, @RequestParam int minimumHours,
			@RequestParam int maximumHours, @RequestParam ArrayList<String> selected_preferredcountries,
			@RequestParam String personalBio, @RequestParam String contactDetails,
			@RequestParam("profilePicture") MultipartFile profilePicture,
			@RequestParam("documents") MultipartFile[] documents, ModelMap model, HttpServletRequest request) {

		File profilePictureFile = null;
		if(profilePicture.getOriginalFilename().isEmpty()){
			profilePictureFile = new File("src/main/webapp/resources/img/astronaut.png");
		}else{
			profilePictureFile = new File(profilePicture.getOriginalFilename());
			
			try {
				profilePicture.transferTo(profilePictureFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		ArrayList<File> documentList = new ArrayList<>();
		if (documents != null) {
			for (MultipartFile document : documents) {
				File documentFile = new File(document.getOriginalFilename());
				try {
					document.transferTo(documentFile);
				} catch (IllegalStateException | IOException e) {
					//first document error
				}
				documentList.add(documentFile);
			}
		}

		IndividualAccount individualAccount = new IndividualAccount(username, email, dateOfBirth, firstName, lastName,
				country, jobTitle, minimumHours, maximumHours, organization, isPublicProfile, profilePictureFile,
				personalBio, contactDetails, documentList);

		profilePictureFile.deleteOnExit();

		// this requires changing
		ArrayList<JobSectorIndividual> jobSectorsIndividual = new ArrayList<JobSectorIndividual>();
		ArrayList<PreferredCountry> preferredCountryList = new ArrayList<PreferredCountry>();
		ArrayList<PreferredJobSector> preferredJobSectorList = new ArrayList<PreferredJobSector>();
		ArrayList<PreferredProjectArea> preferredProjectAreaList = new ArrayList<PreferredProjectArea>();
		ArrayList<UserSkill> userSkillsetList = new ArrayList<UserSkill>();

		if (jobSector1 != null && jobSector1.length() != 0) {
			JobSectorIndividual jobSectorIndividual1 = new JobSectorIndividual(jobSector1, username, js1Years);
			jobSectorsIndividual.add(jobSectorIndividual1);
		}

		if (jobSector2 != null && jobSector2.length() != 0) {
			JobSectorIndividual jobSectorIndividual2 = new JobSectorIndividual(jobSector2, username,
					Integer.parseInt(js2Years));
			jobSectorsIndividual.add(jobSectorIndividual2);
		}

		if (jobSector3 != null && jobSector3.length() != 0) {
			JobSectorIndividual jobSectorIndividual3 = new JobSectorIndividual(jobSector3, username,
					Integer.parseInt(js3Years));
			jobSectorsIndividual.add(jobSectorIndividual3);
		}

		for (String preferredCountry : selected_preferredcountries) {
			PreferredCountry preferredCountryObj = new PreferredCountry(preferredCountry, username);
			preferredCountryList.add(preferredCountryObj);
		}

		for (String preferredJobSector : selected_preferredjobsectors) {
			PreferredJobSector preferredJobSectorObj = new PreferredJobSector(preferredJobSector, username);
			preferredJobSectorList.add(preferredJobSectorObj);
		}

		for (String preferredProjectArea : selected_projectareas) {
			PreferredProjectArea preferredProjectAreaObj = new PreferredProjectArea(preferredProjectArea, username);
			preferredProjectAreaList.add(preferredProjectAreaObj);
		}

		for (String skillset : selected_skillsets) {
			UserSkill skillsetObj = new UserSkill(skillset, username);
			userSkillsetList.add(skillsetObj);
		}

		profileService.firstSetupIndividual(individualAccount, jobSectorsIndividual, preferredCountryList,
				preferredJobSectorList, preferredProjectAreaList, userSkillsetList);

		model.put("username", username);
		request.getSession().setAttribute("individual", profileService.getIndividualAccountDetails(username));
		request.getSession().setAttribute("jobSectorsIndividual",
				profileService.retrieveIndividualJobSectors(username));

		request.getSession().setAttribute("preferredCountries", profileService.retrievePreferredCountries(username));
		request.getSession().setAttribute("preferredJobSectors", profileService.retrievePreferredJobSectors(username));
		request.getSession().setAttribute("preferredProjectArea",
				profileService.retrievePreferredProjectArea(username));
		request.getSession().setAttribute("userSkills", profileService.retrieveAllSkillsOfUser(username));
		request.getSession().setAttribute("individual", profileService.getIndividualAccountDetails(username));
		return "profile/individual/" + "view_own_individual_profile";
	}

	@RequestMapping(value = "/individualprofile1", method = RequestMethod.GET)
	public String showIndividualDashboardPage(HttpServletRequest request) {
		return "individualprofile1";
	}

	@RequestMapping(value = "/editprofile-organization", method = RequestMethod.POST)
	public String processUpdateOrganizationProfile(@RequestParam String companyName, @RequestParam String companyBio,
			@RequestParam String contactDetails, @RequestParam ArrayList<String> selected_countryofoperation,
			@RequestParam ArrayList<String> selected_jobsectors, HttpServletRequest request) {

		OrganizationAccount organization = (OrganizationAccount) request.getSession().getAttribute("organization");
		String username = organization.getUsername();
		String email = organization.getEmail();
		// todo
		OrganizationAccount updatedOrganizationAccount = new OrganizationAccount(organization.getUsername(),
				organization.getEmail(), companyName, organization.isNeedsSupport(), organization.isOfferingSupport(),
				organization.getProfilePicture(), companyBio, contactDetails);
		profileService.updateOrganizationAccount(updatedOrganizationAccount, username);

		ArrayList<CountryOfOperation> updated_countriesofoperations = new ArrayList<CountryOfOperation>();

		for (String countryofoperation : selected_countryofoperation) {
			updated_countriesofoperations.add(new CountryOfOperation(countryofoperation, username));
		}

		ArrayList<JobSectorOrganization> updated_jobsector_organization = new ArrayList<JobSectorOrganization>();

		for (String jobsectororganization : selected_jobsectors) {
			updated_jobsector_organization.add(new JobSectorOrganization(jobsectororganization, username));
		}

		profileService.updateMultipleFieldsOrganization(username, updated_jobsector_organization,
				updated_countriesofoperations);

		// change the session attributes
		request.getSession().setAttribute("organization", profileService.getOrganizationAccountDetails(username));
		request.getSession().setAttribute("organization", profileService.getOrganizationAccountDetails(username));
		request.getSession().setAttribute("countriesOfOperation",
				profileService.retrieveCountriesOfOperations(username));
		request.getSession().setAttribute("jobSectorsOrganization",
				profileService.retrieveOrganizationJobSectors(username));
		return "profile/organization/" + "view_own_organization_profile";
	}

	// Dashboard and Edit Pages for Individual Profiles
	@RequestMapping(value = "/view-my-profile", method = RequestMethod.GET)
	public String showOwnProfile(HttpServletRequest request, ModelMap model) {
		String username = (String)request.getSession().getAttribute("username");
		
		User user = userService.retrieveUser(username);
		
		if(user.getUser_type().equals("organization")){
			return "profile/organization/" + "view_own_organization_profile";
		}else{
			return "profile/individual/" + "view_own_individual_profile";
		}
		
	}
	
	@RequestMapping(value = "/view-profile", method = RequestMethod.GET)
	public String showMyProfilePage(@RequestParam("username") String username, HttpServletRequest request, ModelMap model) {
		User user = userService.retrieveUser(username);
		String loggedin_username = (String) request.getSession().getAttribute("username");
		
		if(user != null){
			String userType = user.getUser_type();
			
			if(username.equals(loggedin_username)){
				
				User me = userService.retrieveUser(loggedin_username);
				
				if(me.getUser_type().equals("organization")){
					return "profile/organization/" + "view_own_organization_profile";
				}else{
					return "profile/individual/" + "view_own_individual_profile";
				}
			}
			
			if(userType.equals("organization")){
				OrganizationAccount organization = profileService.getOrganizationAccountDetails(username);
				
				request.getSession().setAttribute("profileemail", user.getEmail());
				request.getSession().setAttribute("organization",organization);
				request.getSession().setAttribute("countriesOfOperation",
						profileService.retrieveCountriesOfOperations(username));
				request.getSession().setAttribute("jobSectorsOrganization",
						profileService.retrieveOrganizationJobSectors(username));
				return "profile/organization/" + "view_public_organization_profile";
			}else if(userType.equals("individual")){
				IndividualAccount individual = profileService.getIndividualAccountDetails(username);
				boolean isPublic = individual.isPublicProfile();
				
				request.getSession().setAttribute("individual",
						individual);
				
				request.getSession().setAttribute("jobSectorsIndividual",
						profileService.retrieveIndividualJobSectors(username));

				request.getSession().setAttribute("preferredCountries",
						profileService.retrievePreferredCountries(username));
				request.getSession().setAttribute("preferredJobSectors",
						profileService.retrievePreferredJobSectors(username));
				request.getSession().setAttribute("preferredProjectArea",
						profileService.retrievePreferredProjectArea(username));
				request.getSession().setAttribute("userSkills",
						profileService.retrieveAllSkillsOfUser(username));
				
				if(isPublic){
					return "profile/individual/" + "view_public_individual_profile";
				}else{
					return "profile/individual/" + "view_private_individual_profile";
				}
				
			}
		}
		return "profile/individual/" + "view_own_individual_profile";
	}

	@RequestMapping(value = "/editprofile-individual", method = RequestMethod.GET)
	public String showEditProfilePageIndividual(HttpServletRequest request, ModelMap model) {
		IndividualAccount individual = (IndividualAccount) request.getSession().getAttribute("myacccount-individual");

		// Populate the Multiple-value fields the individual has chosen for
		// editing
		request.getSession().setAttribute("country_list", profileService.retrieveCountryList());
		request.getSession().setAttribute("job_sector_list", profileService.retrieveJobSectorList());
		request.getSession().setAttribute("skillset_list", profileService.retrieveSkillsetList());
		request.getSession().setAttribute("project_area_list", profileService.retrieveProjectAreaList());
		request.getSession().setAttribute("user_list", userService.retrieveUsernameList());
		request.getSession().setAttribute("organization_list", userService.retrieveOrganizationNamelist());

		// sets up individual user's current skills to be shown in edit page
		ArrayList<UserSkill> userskills = profileService
				.retrieveAllSkillsOfUser(((String) request.getSession().getAttribute("username")));
		ArrayList<String> individual_userskill_list = new ArrayList<String>();
		for (UserSkill userskill : userskills) {
			individual_userskill_list.add(userskill.getSkillset());
		}

		// sets up individual user's current preferred countries to be shown in
		// edit page
		ArrayList<PreferredCountry> preferredCountries = profileService
				.retrievePreferredCountries(((String) request.getSession().getAttribute("username")));
		ArrayList<String> individual_preferredcountry_list = new ArrayList<String>();
		for (PreferredCountry preferredCountry : preferredCountries) {
			individual_preferredcountry_list.add(preferredCountry.getCountry_name());
		}

		// sets up individual user's current preferred project areas to be shown
		// in edit page
		ArrayList<PreferredProjectArea> preferredProjectAreas = profileService
				.retrievePreferredProjectArea(((String) request.getSession().getAttribute("username")));
		ArrayList<String> individual_preferredprojectarea_list = new ArrayList<String>();
		for (PreferredProjectArea preferredProjectArea : preferredProjectAreas) {
			individual_preferredprojectarea_list.add(preferredProjectArea.getProject_area());
		}

		// sets up individual user's current preferred job sectors to be shown
		// in edit page
		ArrayList<PreferredJobSector> preferredJobSectors = profileService
				.retrievePreferredJobSectors(((String) request.getSession().getAttribute("username")));
		ArrayList<String> individual_preferredjobsector_list = new ArrayList<String>();
		for (PreferredJobSector preferredJobSector : preferredJobSectors) {
			individual_preferredjobsector_list.add(preferredJobSector.getJob_sector());
		}

		// sets up individual user's current expertise in job sectors to be
		// shown in edit page
		ArrayList<JobSectorIndividual> jobSectorsIndividual = profileService
				.retrieveIndividualJobSectors(((String) request.getSession().getAttribute("username")));

		for (int i = 0; i < 3; i++) {
			if (i == 0) {
				if (jobSectorsIndividual.get(0) != null) {
					request.getSession().setAttribute("jobSectorIndividual1", jobSectorsIndividual.get(0));
					request.getSession().setAttribute("jobSectorIndividual1_string",
							jobSectorsIndividual.get(0).getJob_sector());
				}
			}

			if (i == 1) {
				if (jobSectorsIndividual.size() > 1) {
					request.getSession().setAttribute("jobSectorIndividual2", jobSectorsIndividual.get(1));
					request.getSession().setAttribute("jobSectorIndividual2_string",
							jobSectorsIndividual.get(1).getJob_sector());
				}
			}

			if (i == 2) {
				if (jobSectorsIndividual.size() > 2) {
					request.getSession().setAttribute("jobSectorIndividual3", jobSectorsIndividual.get(2));
					request.getSession().setAttribute("jobSectorIndividual3_string",
							jobSectorsIndividual.get(2).getJob_sector());
				}
			}
		}

		request.getSession().setAttribute("individual_preferredjobsector_list", individual_preferredjobsector_list);
		request.getSession().setAttribute("individual_preferredprojectarea_list", individual_preferredprojectarea_list);
		request.getSession().setAttribute("individual_preferredcountry_list", individual_preferredcountry_list);
		request.getSession().setAttribute("individual_userskill_list", individual_userskill_list);

		request.getSession().setAttribute("jobSectorsIndividual",
				profileService.retrieveIndividualJobSectors(individual.getUsername()));
		return "/profile/individual/" + "edit_individual_profile";
	}

	@RequestMapping(value = "/editprofile-individual", method = RequestMethod.POST)
	public String processUpdateIndividualProfile(@RequestParam String firstName, @RequestParam String lastName,
			@RequestParam String jobTitle, @RequestParam String organization, @RequestParam String country,
			@RequestParam String contactDetails, @RequestParam String personalBio, @RequestParam Date dateOfBirth,
			@RequestParam int minimumVolunteerHours, @RequestParam int maximumVolunteerHours,
			@RequestParam ArrayList<String> selected_skillsets,
			@RequestParam ArrayList<String> selected_preferredcountries,
			@RequestParam ArrayList<String> selected_preferredprojectareas,
			@RequestParam ArrayList<String> selected_preferredjobsectors, @RequestParam String selected_jobsector1,
			@RequestParam String selected_jobsector1_years, @RequestParam(required = false) String selected_jobsector2,
			@RequestParam(required = false) String selected_jobsector2_years,
			@RequestParam(required = false) String selected_jobsector3,
			@RequestParam(required = false) String selected_jobsector3_years, HttpServletRequest request) {
		IndividualAccount individual = (IndividualAccount) request.getSession().getAttribute("myacccount-individual");
		String username = individual.getUsername();
		String email = individual.getEmail();
		// to-do
		if(organization.length() == 0){ 
	      organization = null; 
	    } 

		IndividualAccount updatedIndividualAccount = new IndividualAccount(individual.getUsername(),
				individual.getEmail(), dateOfBirth, firstName, lastName, country, jobTitle, minimumVolunteerHours,
				maximumVolunteerHours, organization, individual.isPublicProfile(), individual.getProfilePicture(),
				personalBio, contactDetails, individual.getDocumentList());
		profileService.updateIndividualAccount(updatedIndividualAccount, username);

		ArrayList<PreferredJobSector> updated_preferredjobsector_individual = new ArrayList<PreferredJobSector>();

		for (String preferredJobSector : selected_preferredjobsectors) {
			updated_preferredjobsector_individual.add(new PreferredJobSector(preferredJobSector, username));
		}

		ArrayList<PreferredProjectArea> updated_preferredprojectarea_individual = new ArrayList<PreferredProjectArea>();

		for (String preferredProjectArea : selected_preferredprojectareas) {
			updated_preferredprojectarea_individual.add(new PreferredProjectArea(preferredProjectArea, username));
		}

		ArrayList<PreferredCountry> updated_preferredcountries_individual = new ArrayList<PreferredCountry>();

		for (String preferredCountry : selected_preferredcountries) {
			updated_preferredcountries_individual.add(new PreferredCountry(preferredCountry, username));
		}

		ArrayList<UserSkill> updated_skillsets_individual = new ArrayList<UserSkill>();

		for (String userSkill : selected_skillsets) {
			updated_skillsets_individual.add(new UserSkill(userSkill, username));
		}

		ArrayList<JobSectorIndividual> jobSectorsIndividual = profileService.retrieveIndividualJobSectors(username);

		JobSectorIndividual jobSectorIndividual1 = null;
		JobSectorIndividual jobSectorIndividual2 = null;
		JobSectorIndividual jobSectorIndividual3 = null;

		if (selected_jobsector1 != null && !selected_jobsector1.isEmpty()) {
			jobSectorIndividual1 = new JobSectorIndividual(selected_jobsector1, username,
					Integer.parseInt(selected_jobsector1_years));
		}

		if (selected_jobsector2 != null && !selected_jobsector2.isEmpty()) {
			jobSectorIndividual2 = new JobSectorIndividual(selected_jobsector2, username,
					Integer.parseInt(selected_jobsector2_years));
		}

		if (selected_jobsector3 != null && !selected_jobsector3.isEmpty()) {
			jobSectorIndividual3 = new JobSectorIndividual(selected_jobsector3, username,
					Integer.parseInt(selected_jobsector3_years));
		}

		profileService.updateMultipleFieldsIndividual(username, jobSectorIndividual1, jobSectorIndividual2,
				jobSectorIndividual3, updated_preferredcountries_individual, updated_preferredjobsector_individual,
				updated_preferredprojectarea_individual, updated_skillsets_individual);

		// change the session attributes
		ArrayList<JobSectorIndividual> jobSectorsIndividualSession = profileService
				.retrieveIndividualJobSectors(((String) request.getSession().getAttribute("username")));

		for (int i = 0; i < 3; i++) {
			if (i == 0) {
				if (jobSectorsIndividualSession.get(0) != null) {
					request.getSession().setAttribute("jobSectorIndividual1", jobSectorsIndividualSession.get(0));
					request.getSession().setAttribute("jobSectorIndividual1_string",
							jobSectorsIndividualSession.get(0).getJob_sector());
				}
			}

			if (i == 1) {
				if (jobSectorsIndividualSession.size() > 1) {
					request.getSession().setAttribute("jobSectorIndividual2", jobSectorsIndividualSession.get(1));
					request.getSession().setAttribute("jobSectorIndividual2_string",
							jobSectorsIndividualSession.get(1).getJob_sector());
				}
			}

			if (i == 2) {
				if (jobSectorsIndividualSession.size() > 2) {
					request.getSession().setAttribute("jobSectorIndividual3", jobSectorsIndividualSession.get(2));
					request.getSession().setAttribute("jobSectorIndividual3_string",
							jobSectorsIndividualSession.get(2).getJob_sector());
				}
			}

			if (jobSectorsIndividualSession.size() == 1) {
				request.getSession().removeAttribute("jobSectorIndividual2");
				request.getSession().removeAttribute("jobSectorIndividual2_string");
				request.getSession().removeAttribute("jobSectorIndividual3");
				request.getSession().removeAttribute("jobSectorIndividual3_string");
			}

			if (jobSectorsIndividualSession.size() == 2) {
				request.getSession().removeAttribute("jobSectorIndividual3");
				request.getSession().removeAttribute("jobSectorIndividual3_string");
			}

		}
		request.getSession().setAttribute("individual", profileService.getIndividualAccountDetails(username));
		request.getSession().setAttribute("myacccount-individual", profileService.getIndividualAccountDetails(username));
		request.getSession().setAttribute("jobSectorsIndividual",
				profileService.retrieveIndividualJobSectors(username));
		request.getSession().setAttribute("preferredProjectArea",
				profileService.retrievePreferredProjectArea(username));
		request.getSession().setAttribute("preferredCountries", profileService.retrievePreferredCountries(username));
		request.getSession().setAttribute("preferredJobSectors", profileService.retrievePreferredJobSectors(username));
		request.getSession().setAttribute("userSkills", profileService.retrieveAllSkillsOfUser(username));

		return "profile/individual/" + "view_own_individual_profile";
	}

	@RequestMapping(value = "/edit-individual-profile-pic", method = RequestMethod.POST)
	public String processUpdateIndividualProfilePicture(@RequestParam("profilePicture") MultipartFile profilePicture,
			HttpServletRequest request) {
		if (profilePicture.isEmpty() || profilePicture == null) {
			System.out.println("Is null or empty");
			return "profile/individual/" + "edit_individual_profile";
		} else {
			System.out.println(profilePicture);
			File profilePictureFile = new File(profilePicture.getOriginalFilename());
			try {
				profilePicture.transferTo(profilePictureFile);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			IndividualAccount individual = (IndividualAccount) request.getSession().getAttribute("myacccount-individual");
			System.out.println("Individual "+individual);
			IndividualAccount updatedIndividualAccount = new IndividualAccount(individual.getUsername(),
					individual.getEmail(), individual.getDateOfBirth(), individual.getFirst_name(),
					individual.getLast_name(), individual.getCountry(), individual.getJobTitle(),
					individual.getMinimumVolunteerHours(), individual.getMaximumVolunteerHours(),
					individual.getOrganization(), individual.isPublicProfile(), profilePictureFile,
					individual.getPersonalBio(), individual.getContactDetails(), individual.getDocumentList());
			profileService.updateIndividualAccount(updatedIndividualAccount, individual.getUsername());

			profilePictureFile.deleteOnExit();

			// change the session attributes
			request.getSession().setAttribute("individual",
					profileService.getIndividualAccountDetails(individual.getUsername()));
			request.getSession().setAttribute("myacccount-individual",
					profileService.getIndividualAccountDetails(individual.getUsername()));

			return "profile/individual/" + "edit_individual_profile";
		}
	}

	@RequestMapping(value = "/edit-organization-profile-pic", method = RequestMethod.POST)
	public String processUpdateOrganizationProfilePicture(@RequestParam("profilePicture") MultipartFile profilePicture,
			HttpServletRequest request) {
		if (profilePicture.isEmpty() || profilePicture == null) {
			return "editprofile-organization";
		} else {
			File profilePictureFile = new File(profilePicture.getOriginalFilename());
			try {
				profilePicture.transferTo(profilePictureFile);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			OrganizationAccount organization = (OrganizationAccount) request.getSession().getAttribute("organization");
			OrganizationAccount updatedOrganizationAccount = new OrganizationAccount(organization.getUsername(),
					organization.getEmail(), organization.getCompanyName(), organization.isNeedsSupport(),
					organization.isOfferingSupport(), profilePictureFile, organization.getCompanyBio(),
					organization.getContactDetails());

			profileService.updateOrganizationAccount(updatedOrganizationAccount, organization.getUsername());
			request.getSession().setAttribute("organization",
					profileService.getOrganizationAccountDetails(organization.getUsername()));
			return "profile/organization/" + "edit_organization_profile";
		}
	}

	@RequestMapping(value = "/imageDisplay", method = RequestMethod.GET)
	public void showImage(@RequestParam("username") String username, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		User user = userService.retrieveUser(username);
		if (user != null && user.getUser_type().equals("organization")) {
			OrganizationAccount organizationAccount = profileService.getOrganizationAccountDetails(username);
			File file = organizationAccount.getProfilePicture();
			response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
			byte[] bytesArray = new byte[(int) file.length()];
			FileInputStream fis = new FileInputStream(file);
			fis.read(bytesArray); // read file into bytes[]
			fis.close();
			response.getOutputStream().write(bytesArray);
			response.getOutputStream().close();
		} else if (user != null && user.getUser_type().equals("individual")) {
			IndividualAccount individualAccount = profileService.getIndividualAccountDetails(username);
			File file = individualAccount.getProfilePicture();
			response.setContentType("image/jpeg");
			byte[] bytesArray = new byte[(int) file.length()];
			FileInputStream fis = new FileInputStream(file);
			fis.read(bytesArray); // read file into bytes[]
			fis.close();
			response.getOutputStream().write(bytesArray);
			response.getOutputStream().close();
		}
	}

	@RequestMapping(value = "/testSelect2", method = RequestMethod.GET)
	public String displaySelect(ModelMap model) {
		model.addAttribute("country_list", profileService.retrieveCountryList());
		model.addAttribute("job_sector_list", profileService.retrieveJobSectorList());
		model.addAttribute("project_area_list", profileService.retrieveProjectAreaList());
		model.addAttribute("skillset_list", profileService.retrieveSkillsetList());

		ArrayList<CountryOfOperation> coos = profileService.retrieveCountriesOfOperations("edwardo");
		ArrayList<String> edwardo_country_list = new ArrayList<String>();
		for (CountryOfOperation coo : coos) {
			edwardo_country_list.add(coo.getCountry_name());
		}
		model.addAttribute("edwardo_country_list", edwardo_country_list);

		ArrayList<JobSectorOrganization> jsos = profileService.retrieveOrganizationJobSectors("edwardo");
		ArrayList<String> edwardo_jobsector_list = new ArrayList<String>();
		for (JobSectorOrganization jso : jsos) {
			edwardo_jobsector_list.add(jso.getJob_sector());
		}
		model.addAttribute("edwardo_jobsector_list", edwardo_jobsector_list);

		return "testSelect2";
	}

	@RequestMapping(value = "/processSelect2", method = RequestMethod.POST)
	public String displaySelect2(@RequestParam ArrayList<String> selected_countries, ModelMap model) {
		for (String country : selected_countries) {
		}

		model.put("selected_countries", selected_countries);
		return "processSelect2";
	}

	@RequestMapping(value = "/processSelect2", method = RequestMethod.GET)
	public String displaySelect12(@RequestParam ArrayList<String> selected_countries, ModelMap model) {
		return "processSelect2";
	}

	@RequestMapping(value = "/downloadFile", method = RequestMethod.GET)
	public void showFiles(@RequestParam File file, HttpServletResponse response, HttpServletRequest request)
			throws ServletException {
		FileInputStream inputStream;
		try {
			inputStream = new FileInputStream(file);
			response.setHeader("Content-Disposition", "attachment; filename=" + file.getName());
			response.setHeader("Content-Length", String.valueOf(file.length()));
			FileCopyUtils.copy(inputStream, response.getOutputStream());
			inputStream.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/deleteFile", method = RequestMethod.GET)
	public String deleteFile(@RequestParam String username, @RequestParam File file, HttpServletResponse response,
			HttpServletRequest request) throws ServletException {
		profileService.deleteDocument(username, file);
		// change the session attributes
		request.getSession().setAttribute("individual", profileService.getIndividualAccountDetails(username));
		return "profile/individual/" + "edit_individual_profile";
	}
	
}
