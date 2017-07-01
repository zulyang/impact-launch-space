<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Your Organization Profile</title>
</head>
<body>
	<div align="center">
		<h4>Company Name <input type="text" value="${organization.getCompanyName()}" name="companyName"></h4>
		<h4>Company Bio <input type="text" value="${organization.getCompanyBio()}" name="companyBio"> </h4>
		<h3>Email: <input type="text" value="${user.getEmail()}" name="email"></h3>
		<h3>Phone: <input type="text" value="${organization.getContactDetails()}" name="contactDetails"></h3>

	</div>
	<div align="center">
		<h4>
			Country Of Operation:
			<c:forEach items="${countriesOfOperation}" var="item">
    		${item.getCountry_name()}<br>
			</c:forEach>
			<br>
			Job Sector: <br>
			<c:forEach items="${jobSectorsOrganization}" var="item">
    		${item.getJob_sector()}<br>
			</c:forEach>
		</h4>
		<h4><a href="organizationprofile1">Go back to profile</a></h4>
	</div>
</body>
</html>