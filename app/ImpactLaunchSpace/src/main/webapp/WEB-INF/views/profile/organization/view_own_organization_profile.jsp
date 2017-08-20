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
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css">
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
</head>

<body class="profile">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<%@include file="../../common/navigation.jspf"%>

				<div class="org_profile_display_container">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="/imageDisplay?username=${organization.getUsername()}"
								class="circle_org_profile_image">

							<div class="profile_bio">
								<h1>${organization.getCompanyName()}</h1>

								<div class="btn-group">
									<a href="edit-organization-profile" class="btn btn-default">
										Edit Profile </a>
								</div>

								<hr>
								<p class="org_bio">${organization.getCompanyBio()}</p>
								<hr>
								<p style="display: inline-block;">
									<i class="fa fa-envelope"></i> ${user.getEmail()}
								</p>
								<br />
								<p style="display: inline-block;">
									<i class="fa fa-phone"></i> ${organization.getContactDetails()}
								</p>
								<hr>

								<div class="org_profile_display_countries">
									<i class="fa fa-globe"></i>
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
