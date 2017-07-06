<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ include file="AuthenticateCookie.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1>Setup your individual account here:</h1>

	<form action="setup-individual" method="post"
		enctype="multipart/form-data">
		Username <input type="text" name="username" value="${username}" readonly /><br> 
		Email <input type="text" name="email" value="${email}" readonly /><br> 
		First Name <input type="text" name="firstName" /><br>
		Last Name <input type="text" name="lastName" /><br> 
		Country <input type="text" name="country" /><br> 
		DOB <input type="date" name="dateOfBirth" /><br>
		Job Title <input type="text" name="jobTitle" /><br> 
		Organization<input type="text" name="organization" /><br> 
		Job Sector (needs to be list)<input type="text" name="jobSector1" /><br> 
		Job Sector 1 Years of Experience<input type="number" name="js1Years" /><br>
		<h2>These fields are null:</h2>
		<br> Job Sector 2(needs to be list)<input type="text" name="jobSector2" /><br> 
		Job Sector 2 Years of Experience<input type="number" name="js2Years" /><br> 
		Job Sector 3(needs to be list)<input type="text" name="jobSector3" /><br> 
		Job Sector 3 Years of Experience<input type="number" name="js3Years" /><br>

		Skillsets <input type="text" name="skillset" /><br> 
		Interested Project Areas <input type="text" name="interestedSectors" /><br>

		Important Sectors <input type="text" name="importantSectorsToUser" /><br>

		Minimum Volunteer Hours <input type="number" name="minimumHours" min="1" max="100" /><br>
		Maximum Volunteer Hours <input type="number" name="maximumHours" min="1" max="100" /><br>

		Preferred Countries of Operation <input type="text" name="preferredCountries" /><br> 
		Personal Bio <input type="text" name="personalBio" /><br> 
		Personal Contact Details<input type="text" name="contactDetails" /><br> 
		Picture<input type="file" name="profilePicture" /><br> 
		Private Profile<input type="radio" name="isPublicProfile" value="false" /><br> 
		Public Profile<input type="radio" name="isPublicProfile" value="true" /><br>
		Documents<input type="file" name="documents" multiple /><br> 
		
		<input type="submit" value="Set Account Details!">
	</form>
</body>
</html>