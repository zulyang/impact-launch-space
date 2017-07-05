package com.impactlaunchspace.profile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
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
	public String showSetupPageForOrganization() {
		return "setup-organization";
	}

	// Setup for Organizations
	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public String showSetupPageForOrganizationProfile() {
		return "profile";
	}

	@RequestMapping(value = "/setup-organization", method = RequestMethod.POST)
	public String processSetupOrganization(@RequestParam String username, @RequestParam String email,
			@RequestParam String companyName, @RequestParam String countriesOfOperation,
			@RequestParam String companyBio, @RequestParam String jobSector1, @RequestParam String jobSector2,
			@RequestParam String jobSector3, @RequestParam String contactDetails,
			@RequestParam("profilePicture") MultipartFile profilePicture, ModelMap model) {

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

		// this requires changing
		ArrayList<JobSectorOrganization> jobSectorsOrganization = new ArrayList<JobSectorOrganization>();
		ArrayList<CountryOfOperation> countriesOfOperationList = new ArrayList<CountryOfOperation>();

		if (jobSector1 != null && jobSector1.length() != 0) {
			JobSectorOrganization jobSectorOrganization1 = new JobSectorOrganization(jobSector1, username);
			jobSectorsOrganization.add(jobSectorOrganization1);
		}

		if (jobSector2 != null && jobSector2.length() != 0) {
			JobSectorOrganization jobSectorOrganization2 = new JobSectorOrganization(jobSector2, username);
			jobSectorsOrganization.add(jobSectorOrganization2);
		}

		if (jobSector3 != null && jobSector3.length() != 0) {
			JobSectorOrganization jobSectorOrganization3 = new JobSectorOrganization(jobSector3, username);
			jobSectorsOrganization.add(jobSectorOrganization3);
		}

		CountryOfOperation countryOfOperation = new CountryOfOperation(countriesOfOperation, username);

		countriesOfOperationList.add(countryOfOperation);

		profileService.firstSetupOrganization(organizationAccount, countriesOfOperationList, jobSectorsOrganization);

		model.put("username", username);
		return "organizationprofile1";
	}

	// Setup for Individuals
	@RequestMapping(value = "/setup-individual", method = RequestMethod.GET)
	public String showSetupPageForIndividual() {
		return "setup-individual";
	}

	@RequestMapping(value = "/setup-individual", method = RequestMethod.POST)
	public String processSetupIndividual(@RequestParam String username, @RequestParam String email,
			@RequestParam String firstName, @RequestParam String lastName, @RequestParam String country,
			@RequestParam String organization, @RequestParam String jobSector1, @RequestParam int js1Years,
			@RequestParam Date dateOfBirth, @RequestParam String jobTitle, @RequestParam boolean isPublicProfile,
			@RequestParam String jobSector2, @RequestParam int js2Years, @RequestParam String jobSector3,
			@RequestParam int js3Years, @RequestParam String skillset, @RequestParam String interestedSectors,
			@RequestParam String importantSectorsToUser, @RequestParam int minimumHours, @RequestParam int maximumHours,
			@RequestParam String preferredCountries, @RequestParam String personalBio,
			@RequestParam String contactDetails, @RequestParam("profilePicture") MultipartFile profilePicture,
			@RequestParam("documents") MultipartFile[] documents, ModelMap model) {

		File profilePictureFile = new File(profilePicture.getOriginalFilename());
		try {
			profilePicture.transferTo(profilePictureFile);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		ArrayList<File> documentList = new ArrayList<>();
		if (documents != null && documents.length > 0) {
			for (MultipartFile document : documents) {
				File documentFile = new File(document.getOriginalFilename());
				try {
					document.transferTo(documentFile);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				documentList.add(documentFile);
			}
		}

		IndividualAccount individualAccount = new IndividualAccount(username, email, dateOfBirth, firstName, lastName,
				country, jobTitle, minimumHours, maximumHours, organization, isPublicProfile, profilePictureFile,
				personalBio, contactDetails, documentList);

		// this requires changing
		ArrayList<JobSectorIndividual> jobSectorsIndividual = new ArrayList<JobSectorIndividual>();
		ArrayList<PreferredCountry> prferredCountryList = new ArrayList<PreferredCountry>();
		ArrayList<PreferredJobSector> preferredJobSectorList = new ArrayList<PreferredJobSector>();
		ArrayList<PreferredProjectArea> preferredProjectAreaList = new ArrayList<PreferredProjectArea>();
		ArrayList<UserSkill> userSkillsetList = new ArrayList<UserSkill>();

		if (jobSector1 != null && jobSector1.length() != 0) {
			JobSectorIndividual jobSectorIndividual1 = new JobSectorIndividual(jobSector1, username, js1Years);
			jobSectorsIndividual.add(jobSectorIndividual1);
		}

		if (jobSector2 != null && jobSector2.length() != 0) {
			JobSectorIndividual jobSectorIndividual2 = new JobSectorIndividual(jobSector2, username, js2Years);
			jobSectorsIndividual.add(jobSectorIndividual2);
		}

		if (jobSector3 != null && jobSector3.length() != 0) {
			JobSectorIndividual jobSectorIndividual3 = new JobSectorIndividual(jobSector3, username, js3Years);
			jobSectorsIndividual.add(jobSectorIndividual3);
		}

		// we assume theres only one just for testing sake.
		PreferredCountry preferredCountry = new PreferredCountry(preferredCountries, username);
		PreferredJobSector preferredJobSectors = new PreferredJobSector(importantSectorsToUser, username);
		PreferredProjectArea preferredProjectArea = new PreferredProjectArea(interestedSectors, username);
		UserSkill userskill = new UserSkill(skillset, username);

		prferredCountryList.add(preferredCountry);
		preferredJobSectorList.add(preferredJobSectors);
		preferredProjectAreaList.add(preferredProjectArea);
		userSkillsetList.add(userskill);

		profileService.firstSetupIndividual(individualAccount, jobSectorsIndividual, prferredCountryList,
				preferredJobSectorList, preferredProjectAreaList, userSkillsetList);

		model.put("username", username);
		return "setup-complete";
	}

	// Dashboard and Edit Pages for Organization Profiles
	@RequestMapping(value = "/organizationprofile1", method = RequestMethod.GET)
	public String showOrganizationDashboardPage(HttpServletRequest request) {
		return "organizationprofile1";
	}

	@RequestMapping(value = "/editprofile-organization", method = RequestMethod.GET)
	public String showEditProfilePageOrganization(HttpServletRequest request) {
		return "editprofile-organization";
	}

	@RequestMapping(value = "/editprofile-organization", method = RequestMethod.POST)
	public String processUpdateOrganizationProfile(@RequestParam String companyName, @RequestParam String companyBio,
			@RequestParam String contactDetails, HttpServletRequest request) {
		OrganizationAccount organization = (OrganizationAccount) request.getSession().getAttribute("organization");
		String username = organization.getUsername();
		String email = organization.getEmail();
		// todo
		OrganizationAccount updatedOrganizationAccount = new OrganizationAccount(organization.getUsername(),
				organization.getEmail(), companyName, organization.isNeedsSupport(), organization.isOfferingSupport(),
				organization.getProfilePicture(), companyBio, contactDetails);
		profileService.updateOrganizationAccount(updatedOrganizationAccount, username);

		// change the session attributes
		request.getSession().setAttribute("organization", profileService.getOrganizationAccountDetails(username));

		return "organizationprofile1";
	}

	// Dashboard and Edit Pages for Individual Profiles
	@RequestMapping(value = "/individualprofile1", method = RequestMethod.GET)
	public String showIndividualDashboardPage(HttpServletRequest request) {
		return "individualprofile1";
	}

	@RequestMapping(value = "/editprofile-individual", method = RequestMethod.GET)
	public String showEditProfilePageIndividual(HttpServletRequest request) {
		return "/editprofile-individual";
	}

	@RequestMapping(value = "/editprofile-individual", method = RequestMethod.POST)
	public String processUpdateIndividualProfile(@RequestParam String firstName, @RequestParam String lastName,
			@RequestParam String jobTitle, @RequestParam String organization, @RequestParam String country,
			@RequestParam String contactDetails, @RequestParam String personalBio, @RequestParam Date dateOfBirth,
			@RequestParam int minimumVolunteerHours, @RequestParam int maximumVolunteerHours,
			HttpServletRequest request) {
		IndividualAccount individual = (IndividualAccount) request.getSession().getAttribute("individual");
		String username = individual.getUsername();
		String email = individual.getEmail();
		// to-do
		IndividualAccount updatedIndividualAccount = new IndividualAccount(individual.getUsername(),
				individual.getEmail(), dateOfBirth, firstName, lastName, country, jobTitle, minimumVolunteerHours,
				maximumVolunteerHours, organization, individual.isPublicProfile(), individual.getProfilePicture(),
				personalBio, contactDetails, individual.getDocumentList());
		profileService.updateIndividualAccount(updatedIndividualAccount, username);

		// change the session attributes
		request.getSession().setAttribute("individual", profileService.getIndividualAccountDetails(username));

		return "individualprofile1";
	}

	@RequestMapping(value = "/editprofile-individual-profilepic", method = RequestMethod.POST)
	public String processUpdateIndividualProfilePicture(@RequestParam("profilePicture") MultipartFile profilePicture,
			HttpServletRequest request) {
		if (profilePicture.isEmpty() || profilePicture == null) {
			return "editprofile-individual";
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
			IndividualAccount individual = (IndividualAccount) request.getSession().getAttribute("individual");
			IndividualAccount updatedIndividualAccount = new IndividualAccount(individual.getUsername(),
					individual.getEmail(), individual.getDateOfBirth(), individual.getFirst_name(),
					individual.getLast_name(), individual.getCountry(), individual.getJobTitle(),
					individual.getMinimumVolunteerHours(), individual.getMaximumVolunteerHours(),
					individual.getOrganization(), individual.isPublicProfile(), profilePictureFile,
					individual.getPersonalBio(), individual.getContactDetails(), individual.getDocumentList());
			profileService.updateIndividualAccount(updatedIndividualAccount, individual.getUsername());

			// change the session attributes
			request.getSession().setAttribute("individual",
					profileService.getIndividualAccountDetails(individual.getUsername()));

			return "editprofile-individual";
		}
	}

	@RequestMapping(value = "/editprofile-organization-profilepic", method = RequestMethod.POST)
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
			return "editprofile-organization";
		}
	}

	@RequestMapping(value = "/imageDisplay", method = RequestMethod.GET)
	public void showImage(@RequestParam("username") String username, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		User user = userService.retrieveUser(username);
		if (user !=null && user.getUser_type().equals("organization")) {
			OrganizationAccount organizationAccount = profileService.getOrganizationAccountDetails(username);
			File file = organizationAccount.getProfilePicture();
			response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
			byte[] bytesArray = new byte[(int) file.length()];
			FileInputStream fis = new FileInputStream(file);
			fis.read(bytesArray); // read file into bytes[]
			fis.close();
			response.getOutputStream().write(bytesArray);
			response.getOutputStream().close();
		} else if (user !=null && user.getUser_type().equals("individual")) {
			IndividualAccount individualAccount = profileService.getIndividualAccountDetails(username);
			File file = individualAccount.getProfilePicture();
			response.setContentType("image/jpeg");
			System.out.println(file.getName());
			System.out.println(response.getContentType());
			byte[] bytesArray = new byte[(int) file.length()];
			FileInputStream fis = new FileInputStream(file);
			fis.read(bytesArray); // read file into bytes[]
			fis.close();
			response.getOutputStream().write(bytesArray);
			response.getOutputStream().close();
		}
	}

	@RequestMapping(value = "/showFiles", method = RequestMethod.GET)
	public void showFiles(@RequestParam("username") String username, HttpServletResponse response,
			HttpServletRequest request) throws ServletException {
		 IndividualAccount individualAccount =
		 profileService.getIndividualAccountDetails(username);
		 System.out.println("username: " + username + "\n account: " +
		 individualAccount);
		 File file = individualAccount.getProfilePicture();
		 FileInputStream inputStream;
		 try {
		 inputStream = new FileInputStream(file);
		 response.setHeader("Content-Disposition", "attachment; filename=" + file.getName());
		 response.setHeader("Content-Length", String.valueOf(file.length()));
		 FileCopyUtils.copy(inputStream, response.getOutputStream());
		 } catch (IOException e) {
		 // TODO Auto-generated catch block
		 e.printStackTrace();
		 }
	}
}
