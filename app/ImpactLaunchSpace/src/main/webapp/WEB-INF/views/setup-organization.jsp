<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>Setup your organization account here:</h1>

<form>
	Username <input type="text" name="username"/><br>
	Email <input type="text" name="email"/><br>
	Countries of Operation <input type="text" name="countriesOfOperation"/><br>
	Job Sector (needs to be list)<input type="text" name="jobSector1"/><br>
	<h2>These fields are null:</h2>
	<br>
	Job Sector 2(needs to be list)<input type="text" name="jobSector2"/><br>
	Job Sector 3(needs to be list)<input type="text" name="jobSector3"/><br>
	Company Bio<input type="text" name="companyBio"/><br>
	Company Contact Details<input type="text" name="contactDetails"/><br>
	Picture<input type="file" name="profilePicture"/><br>
	
	<input type="submit" value="Set Account Details!">
</form>
</body>
</html>