<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>Setup your individual account here:</h1>

<form action="setup-individual" method="post">
	Username <input type="text" name="username"/><br>
	Email <input type="text" name="email"/><br>
	Country <input type="text" name="country"/><br>
	Organization <input type="text" name="organization"/><br>
	Job Sector (needs to be list)<input type="text" name="jobSector1"/><br>
	<h2>These fields are null:</h2>
	<br>
	Job Sector 2(needs to be list)<input type="text" name="jobSector2"/><br>
	Job Sector 3(needs to be list)<input type="text" name="jobSector3"/><br>
	Skillsets <input type="text" name="skillsets"/><br>
	Interested Project Areas <input type="text" name="interestedSectorsToUser"/><br>
	Important Sectors <input type="text" name="importantSectorsToUser"/><br>
	Minimum Volunteer Hours <input type="number" name="minimumHours" min="1" max="100"/><br>
	Maximum Volunteer Hours <input type="number" name="maximumHours" min="1" max="100"/><br>
	
	
	Interested Countries of Operation <input type="text" name="countriesOfOperation"/><br>
	Personal Bio<input type="text" name="personalBio"/><br>
	Personal Contact Details<input type="text" name="contactDetails"/><br>
	Picture<input type="file" name="profilePicture"/><br>
	
	<input type="submit" value="Set Account Details!">
</body>
</html>