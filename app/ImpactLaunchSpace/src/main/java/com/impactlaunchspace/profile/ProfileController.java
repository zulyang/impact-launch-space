package com.impactlaunchspace.profile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
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
import com.impactlaunchspace.entity.JobSectorOrganization;
import com.impactlaunchspace.entity.OrganizationAccount;

@Controller
public class ProfileController {

	@Autowired
	ProfileService profileService;

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
		JobSectorOrganization jobSectorOrganization1 = new JobSectorOrganization(jobSector1, username);
		JobSectorOrganization jobSectorOrganization2 = new JobSectorOrganization(jobSector2, username);
		JobSectorOrganization jobSectorOrganization3 = new JobSectorOrganization(jobSector3, username);

		ArrayList<JobSectorOrganization> jobSectorsOrganization = new ArrayList<JobSectorOrganization>();
		ArrayList<CountryOfOperation> countriesOfOperationList = new ArrayList<CountryOfOperation>();
		CountryOfOperation countryOfOperation = new CountryOfOperation(countriesOfOperation, username);

		jobSectorsOrganization.add(jobSectorOrganization1);
		jobSectorsOrganization.add(jobSectorOrganization2);
		jobSectorsOrganization.add(jobSectorOrganization3);

		countriesOfOperationList.add(countryOfOperation);

		profileService.firstSetup(organizationAccount, countriesOfOperationList, jobSectorsOrganization);
		
		model.put("organizationAccount", profileService.getOrganizationAccountDetails(username));
		return "setup-complete";
	}
	
	@RequestMapping(value = "/imageDisplay", method = RequestMethod.GET)
	  public void showImage(@RequestParam("username") String username, HttpServletResponse response,HttpServletRequest request) 
	          throws ServletException, IOException{

	    OrganizationAccount organizationAccount = profileService.getOrganizationAccountDetails(username);
	    File file = organizationAccount.getProfilePicture();
	    response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
	    byte[] bytesArray = new byte[(int) file.length()];
	    FileInputStream fis = new FileInputStream(file);
	    fis.read(bytesArray); //read file into bytes[]
	    fis.close();
	    response.getOutputStream().write(bytesArray);
	    response.getOutputStream().close();
	}

	@RequestMapping(value = "/setup-organization111", method = RequestMethod.POST)
	public String blah1(HttpServletRequest request, HttpServletResponse response) {
		/*
		 * String saveFile = ""; String contentType = request.getContentType();
		 * if ((contentType != null) &&
		 * (contentType.indexOf("multipart/form-data") >= 0)) { DataInputStream
		 * in = new DataInputStream( request.getInputStream()); int
		 * formDataLength = request.getContentLength(); byte dataBytes[] = new
		 * byte[formDataLength]; int byteRead = 0; int totalBytesRead = 0; while
		 * (totalBytesRead < formDataLength) { byteRead = in.read(dataBytes,
		 * totalBytesRead, formDataLength); totalBytesRead += byteRead; } String
		 * file = new String(dataBytes); saveFile =
		 * file.substring(file.indexOf("filename=\"") + 10); saveFile =
		 * saveFile.substring(0, saveFile.indexOf("\n")); saveFile =
		 * saveFile.substring(saveFile.lastIndexOf("\\") + 1,
		 * saveFile.indexOf("\"")); int lastIndex =
		 * contentType.lastIndexOf("="); String boundary =
		 * contentType.substring(lastIndex + 1, contentType.length()); int pos;
		 * pos = file.indexOf("filename=\""); pos = file.indexOf("\n", pos) + 1;
		 * pos = file.indexOf("\n", pos) + 1; pos = file.indexOf("\n", pos) + 1;
		 * int boundaryLocation = file.indexOf(boundary, pos) - 4; int startPos
		 * = ((file.substring(0, pos)).getBytes()).length; int endPos =
		 * ((file.substring(0, boundaryLocation)).getBytes()).length; File ff =
		 * new File(saveFile); FileOutputStream fileOut = new
		 * FileOutputStream(ff); fileOut.write(dataBytes, startPos, (endPos -
		 * startPos)); fileOut.flush(); fileOut.close();
		 * 
		 * ResultSet rs = null; PreparedStatement psmnt = null; FileInputStream
		 * fis; try { Connection connection = DbConnection.getConnection(); File
		 * f = new File(saveFile);
		 * 
		 * String idd = request.getAttribute("userid").toString(); String insert
		 * = "UPDATE `employee` SET `Picture`=? WHERE `id`='" + idd + "'";
		 * 
		 * psmnt = connection.prepareStatement(insert); fis = new
		 * FileInputStream(f); psmnt.setBinaryStream(1, (InputStream) fis, (int)
		 * (f.length())); int s = psmnt.executeUpdate(); if (s > 0) {
		 * System.out.println("Uploaded successfully !"); } else {
		 * System.out.println("Error!"); } } catch (Exception e) {
		 * e.printStackTrace(); } }
		 */
		return "redirect:/";
	}

	@RequestMapping(value = "/setup-success", method = RequestMethod.GET)
	public String showSetupSuccessPage() {
		return "setup-success";
	}
}
