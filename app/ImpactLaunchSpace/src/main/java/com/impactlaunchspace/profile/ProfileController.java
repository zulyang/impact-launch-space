package com.impactlaunchspace.profile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Blob;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.impactlaunchspace.entity.CountryOfOperation;
import com.impactlaunchspace.entity.IndividualAccount;
import com.impactlaunchspace.entity.JobSectorOrganization;
import com.impactlaunchspace.entity.OrganizationAccount;

@Controller
public class ProfileController {

	@Autowired
	ProfileService profileService;

	// Setup for Organizations
	@RequestMapping(value = "/setup-organization", method = RequestMethod.GET)
	public String showSetupPageForOrganization() {
		return "setup-organization";
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
		System.out.println(profilePictureFile);
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
		return "setup-complete";
	}

	@RequestMapping(value = "/imageDisplay", method = RequestMethod.GET)
	public void showImage(@RequestParam("username") String username, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {

		OrganizationAccount organizationAccount = profileService.getOrganizationAccountDetails(username);
		File file = organizationAccount.getProfilePicture();
		response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
		byte[] bytesArray = new byte[(int) file.length()];
		FileInputStream fis = new FileInputStream(file);
		fis.read(bytesArray); // read file into bytes[]
		fis.close();
		response.getOutputStream().write(bytesArray);
		response.getOutputStream().close();
	}

	// Setup for Individuals
	@RequestMapping(value = "/setup-individual", method = RequestMethod.GET)
	public String showSetupPageForIndividual() {
		return "setup-individual";
	}

	@RequestMapping(value = "/setup-individual", method = RequestMethod.POST)
	public String processSetupIndividual(@RequestParam String username, @RequestParam String email,
			@RequestParam String firstName, @RequestParam String lastName, @RequestParam String country,
			@RequestParam String organization, @RequestParam String jobSector1, @RequestParam String js1Years,
			@RequestParam Date dateOfBirth, @RequestParam String jobTitle,@RequestParam boolean isPublicProfile,
			@RequestParam String jobSector2,@RequestParam String js2Years, @RequestParam String jobSector3, 
			@RequestParam String js3Years, @RequestParam String skillset,@RequestParam String interestedSectors,
			@RequestParam String importantSectorsToUser,@RequestParam int minimumHours,@RequestParam int maximumHours,
			@RequestParam String preferredCountries, @RequestParam String personalBio, @RequestParam String contactDetails,
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
		System.out.println(profilePictureFile);
		
		IndividualAccount individualAccount = new IndividualAccount(username,email,firstName, 
				lastName,dateOfBirth,country,jobTitle,minimumHours, maximumHours, organization,
				isPublicProfile, profilePictureFile, personalBio, contactDetails);
		
		
		return "setup-individual";
	}
}
