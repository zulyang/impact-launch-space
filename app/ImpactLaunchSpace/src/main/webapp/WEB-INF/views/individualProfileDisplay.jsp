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

				<nav class="navbar navbar-default navbar-fixed-top profileNav">
					<div class="container-fluid">
						<!-- Brand and toggle get grouped for better mobile display -->
						<div class="navbar-header">
							<a class="navbar-brand" href="index.jsp"> <img
								alt="ImpactLaunch.Space" id="logoLoggedIn"
								src="<%=request.getContextPath()%>/resources/img/logo2.png">
							</a>
						</div>

						<!-- Collect the nav links, forms, and other content for toggling -->
						<div class="collapse navbar-collapse"
							id="bs-example-navbar-collapse-1">
							<form class="navbar-form navbar-left">
								<div class="form-group">
									<input type="text" class="form-control" placeholder="Search">
								</div>
							</form>
							<ul class="nav navbar-nav">
								<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown" role="button" aria-haspopup="true"
									aria-expanded="false">Projects <span class="caret"></span></a>
									<ul class="dropdown-menu">
										<li><a href="#">Action</a></li>
										<li><a href="#">Another action</a></li>
										<li><a href="#">Something else here</a></li>
										<li role="separator" class="divider"></li>
										<li><a href="#">Separated link</a></li>
										<li role="separator" class="divider"></li>
										<li><a href="#">One more separated link</a></li>
									</ul></li>
								<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown" role="button" aria-haspopup="true"
									aria-expanded="false">Resources <span class="caret"></span></a>
									<ul class="dropdown-menu">
										<li><a href="#">Action</a></li>
										<li><a href="#">Another action</a></li>
										<li><a href="#">Something else here</a></li>
										<li role="separator" class="divider"></li>
										<li><a href="#">Separated link</a></li>
										<li role="separator" class="divider"></li>
										<li><a href="#">One more separated link</a></li>
									</ul></li>
								<li class=""><a class="navbar-brand" href="/index"> <img
										alt="home" class="homeIcon"
										src="<%=request.getContextPath()%>/resources/img/homeIcon.png">
								</a></li>
								<li class="profileIcons"><a class="navbar-brand"
									href="/alerts"> <img alt="alerts" class="alertsIcon"
										src="<%=request.getContextPath()%>/resources/img/bellIcon.png">
								</a></li>
								<li class="profileIcons"><a class="navbar-brand"
									href="/chat"> <img alt="chat" class="chatIcon"
										src="<%=request.getContextPath()%>/resources/img/chatIcon.png">
								</a></li>
								<li class="profileIcons"><a class="navbar-brand"
									href="/profile"> <img alt="profilePicture"
										class="profilePictureIcon"
										src="<%=request.getContextPath()%>/resources/img/profilePicture.png">
								</a></li>
								<li class="profileIcons"><a class="navbar-brand"
									href="/profile">Username</a></li>
								<li class="profileIcons"><a class="navbar-brand"
									href="/options"> <img alt="moreOptions"
										class="moreOptionsIcon"
										src="<%=request.getContextPath()%>/resources/img/3dotsIcon.png">
								</a></li>
							</ul>
						</div>
						<!-- /.navbar-collapse -->
					</div>
					<!-- /.container-fluid -->
				</nav>

				<div class="indi_profile_display_container">
					<div class="panel panel-default">
						<div class="panel-body">
							<div style="display: inline-block">
								<img src="/imageDisplay?username=${username}"
									class="circle_indi_profile_image">
							</div>

							<div style="display: inline-block">
								<h1 style="display: inline-block">${individual.getFirst_name()} ${individual.getLast_name()}</h1>

								<div style="display: inline-block" class="btn-group">
									<a href="editprofile-organization" class="btn btn-default">
										Edit Profile </a> 
									<a href="" class="btn btn-default"> Leave A
										Message </a>
								</div>

								<hr>
								<p class="indi_bio">${individual.getPersonalBio()}</p>
								<hr>
								<p>${individual.getJobTitle()}</p>
								<p>${individual.getOrganization()}</p>
								<hr>
								<p style="display: inline-block">${user.getEmail()}</p>
								<p style="display: inline-block">${individual.getContactDetails()}</p>
								<p>${individual.getCountry()}</p>
							</div>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">Skills</div>
						<div class="panel-body">
							<c:forEach items="${userSkills}" var="item">
								<p class="indi_skills">${item.getSkillset()}</p>
							</c:forEach>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">Experience</div>
						<div class="panel-body">
							<c:forEach items="${jobSectorsIndividual}" var="item">
								<p>
									<strong>${item.getYearsOfExperience()}</strong> years of
									experience in <strong>${item.getJob_sector()}</strong>.
								</p>
							</c:forEach>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">Interest</div>
						<div class="panel-body">

							<p>I want to make a difference in:</p>
							<c:forEach items="${preferredProjectArea}" var="item">
								<p class="indi_project_area">${item.getProject_area()}</p>
							</c:forEach>

							<p>Sectors that are important to me:</p>
							<c:forEach items="${preferredJobSectors}" var="item">
								<p class="indi_job_sector">${item.getJob_sector()}</p>
							</c:forEach>

							<p>
								I can dedicate an average of <strong>${individual.getMinimumVolunteerHours()}</strong>
								to <strong>${individual.getMaximumVolunteerHours()}</strong>
								hours in a week.
							</p>

							<p>I am interested to work in:</p>
							<c:forEach items="${preferredCountries}" var="item">
								<p class="indi_preferred_countries">${item.getCountry_name()}</p>
							</c:forEach>

						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">Documents</div>
						<div class="panel-body">${individual.getDocumentList()}</div>
					</div>

				</div>
			</div>
		</div>
	</div>

</body>
</html>
