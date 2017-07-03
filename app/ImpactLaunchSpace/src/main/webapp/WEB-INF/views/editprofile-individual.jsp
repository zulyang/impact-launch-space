<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Your Individual Profile</title>
</head>
<body>
<div align="center">
		<form action = "editprofile-individual" method="post">
			<h4>First Name: <input type="text" value="${individual.getFirst_name()}" name="firstName"/> 
			Last Name: <input type="text" value="${individual.getLast_name()}" name="lastName"/> </h4>
			<h4>Job Title: <input type="text" value="${individual.getJobTitle()}" name ="jobTitle"/></h4>
			<h4>Organization: <input type="text" value="${individual.getOrganization()}" name="organization"/></h4>
			<h4>Date Of Birth: <input type="date" value="${individual.getDateOfBirth()}" name="dateOfBirth"/></h4>
			<h3>Country: <input type="text" value="${individual.getCountry()}" name="country"/></h3>
			<h4>Email: <input type="text" value="${user.getEmail()}" name="email" readonly/></h4>
			<h4>Phone: <input type="text" value="${individual.getContactDetails()}" name="contactDetails"/></h4>
			<h4>Personal Bio: <input type="text" value="${individual.getPersonalBio()}" name="personalBio"/></h4>
			<h4>Min Hours: <input type="number" value="${individual.getMinimumVolunteerHours()}" name="minimumVolunteerHours"/>
			Max Hours: <input type="number" value="${individual.getMaximumVolunteerHours()}" name="maximumVolunteerHours"/></h4>
			<input type="submit" value="Update details"/>
		</form>
	</div>
	<br>
	<br>
	<div align="center">
		<h4>
			I prefer to work in:
			<c:forEach items="${preferredCountries}" var="item">
    	${item.getCountry_name()}<br>
			</c:forEach>
			<br>
			I have expertise in these Job Sectors: <br>
			<c:forEach items="${jobSectorsIndividual}" var="item">
    	${item.getJob_sector()} : ${item.getYearsOfExperience()} Years Of Experience<br>
			</c:forEach>
			<br>
			Preferred Project Areas: <br>
			<c:forEach items="${preferredProjectArea}" var="item">
    	${item.getProject_area()}<br>
			</c:forEach>
			<br>
			Preferred Job Sectors: <br>
			<c:forEach items="${preferredJobSectors}" var="item">
    	${item.getJob_sector()}<br>
			</c:forEach>
			<br>
			My Skills: <br>
			<c:forEach items="${userSkills}" var="item">
    	${item.getSkillset()}<br>
			</c:forEach>
		</h4>
		<h4><a href="individualprofile1">Go back to profile</a></h4>
	</div>
</body>
</html>