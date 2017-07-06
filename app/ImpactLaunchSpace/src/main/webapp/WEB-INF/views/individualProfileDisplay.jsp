<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import = "java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Individual Dashboard</title>
</head>
<body>
	<div align="center">
		<img src="/imageDisplay?username=${username}" class="circle_profile_image">
		<h1>${individual.getFirst_name()}${individual.getLast_name()}</h1>
		<h2>${individual.getJobTitle()}</h2>
		<h2>${individual.getOrganization()}</h2>
		<h3>Date Of Birth: ${individual.getDateOfBirth()}</h3>
		<h3>Country: ${individual.getCountry()}</h3>
		<h3>Email: ${user.getEmail()}</h3>
		<h3>Phone: ${individual.getContactDetails()}</h3>
		<h5>Personal Bio: ${individual.getPersonalBio()}</h5>
	</div>
	<br>
	<br>
	<div align="center">
		<h4>
			I can dedicate ${individual.getMinimumVolunteerHours()} to
			${individual.getMaximumVolunteerHours()} hours in a week. <br> I
			prefer to work in:
			<c:forEach items="${preferredCountries}" var="item">
    	${item.getCountry_name()}<br>
			</c:forEach>
			<br> I have expertise in these Job Sectors: <br>
			<c:forEach items="${jobSectorsIndividual}" var="item">
    	${item.getJob_sector()} : ${item.getYearsOfExperience()} Years Of Experience<br>
			</c:forEach>
			<br> Preferred Project Areas: <br>
			<c:forEach items="${preferredProjectArea}" var="item">
    	${item.getProject_area()}<br>
			</c:forEach>
			<br> Preferred Job Sectors: <br>
			<c:forEach items="${preferredJobSectors}" var="item">
    	${item.getJob_sector()}<br>
			</c:forEach>
			<br> My Skills: <br>
			<c:forEach items="${userSkills}" var="item">
    	${item.getSkillset()}<br>
			</c:forEach>
		</h4>

		${individual.getDocumentList()}

		<h4>
			<a href="editprofile-individual">Edit Profile</a>
		</h4>
	</div>
</body>
</html>