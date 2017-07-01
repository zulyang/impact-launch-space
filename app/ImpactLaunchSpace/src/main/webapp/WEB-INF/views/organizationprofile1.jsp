<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Organization Dashboard</title>
</head>
<body>

	<div align="center">
		<h1>${organization.getCompanyName()}</h1>
		<h2>${organization.getCompanyBio()}</h2>
		<h3>Email: ${user.getEmail()}</h3>
		<h3>Phone: ${organization.getContactDetails()}</h3>

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
	</div>
</body>
</html>