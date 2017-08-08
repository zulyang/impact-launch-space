<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>ImpactLaunch.Space</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<!--custom css codes -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
	integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
	crossorigin="anonymous"></script>

</head>
<body class="profile">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

<%@include file="common/navigation.jspf" %>
				

				<div class="org_profile_display_container">
					<div class="panel panel-default">
						<div class="panel-body">
							<div style="display: inline-block">
								<img src="/imageDisplay?username=${organization.getUsername()}"
									class="circle_org_profile_image">
							</div>

							<div style="display: inline-block">
								<h1 style="display: inline-block">${organization.getCompanyName()}</h1>

								<div style="display: inline-block" class="btn-group">
									<a href="" class="btn btn-default"> Leave A
										Message </a>
								</div>

								<hr>
								<p class="org_bio">${organization.getCompanyBio()}</p>
								<hr>
								<p style="display: inline-block"><i class="fa fa-envelope"></i> ${profileemail}</p>
								<p style="display: inline-block"><i class="fa fa-phone"></i> ${organization.getContactDetails()}</p>
								<hr>
								<div class="org_profile_display_countries">
								<i class="fa fa-map-pin"></i> 
									<c:forEach items="${countriesOfOperation}" var="item">
										<p class="org_countries">${item.getCountry_name()}</p>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">Job Sectors</div>
						<div class="panel-body">
							<div class="org_profile_display_jobSectors">
								<c:forEach items="${jobSectorsOrganization}" var="item">
									<p class="org_job_sectors">${item.getJob_sector()}</p>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
