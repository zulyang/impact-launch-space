<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Your Individual Profile</title>
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
				<!-- /.container-fluid --> </nav>
				<div class="edit_ind_profile_display_container">
					<div class="panel panel-default">
						<div class="panel-heading">Edit Individual Profile Form</div>
						<div class="panel-body">
							<div class="edit_org_pic" style="display: inline-block">
								<form action="editprofile-individual-profilepic" method="post"
									enctype="multipart/form-data">
									<img src="/imageDisplay?username=${username}"
										class="circle_edit_ind_profile_image" height="64" width="64">

									<label for="editChooseIndPic"
										class="form-control btn btn-info edit_org_profile_save">Choose
										A New Picture</label> <input type="file" name="profilePicture"
										style="display: inline-block; visibility: hidden;"
										id="editChooseIndPic" /> <label for="editUploadIndPic"
										class="form-control btn btn-info edit_org_profile_save">Upload</label>
									<input style="display: inline-block; visibility: hidden;"
										type="submit" value="Update picture" id="editUploadIndPic" />

								</form>
							</div>

							<form class="form-horizontal edit_ind_profile_container"
								action="editprofile-individual" method="post">
								<div class="form-group">
									<label for="editIndFirstName" class="col-sm-3 control-label">First
										Name</label>
									<div class="col-sm-9">
										<input type="text" id="editIndFirstName"
											value="${individual.getFirst_name()}" name="firstName"
											class="form-control edit_profileField" />
									</div>
								</div>

								<div class="form-group">
									<label for="editIndLastName" class="col-sm-3 control-label">Last
										Name</label>
									<div class="col-sm-9">
										<input type="text" value="${individual.getLast_name()}"
											name="lastName" class="form-control edit_profileField"
											id="editIndLastName" />
									</div>
								</div>

								<div class="form-group">
									<label for="editJobTitle" class="col-sm-3 control-label">Job
										Title</label>
									<div class="col-sm-9">
										<input type="text" value="${individual.getJobTitle()}"
											name="jobTitle" class="form-control edit_profileField"
											id="editJobTitle" />
									</div>
								</div>

								<div class="form-group">
									<label for="editOrg" class="col-sm-3 control-label">Organization</label>
									<div class="col-sm-9">
										<input type="text" value="${individual.getOrganization()}"
											name="organization" class="form-control edit_profileField"
											id="editOrg" />
									</div>
								</div>

								<div class="form-group">
									<label for="editDob" class="col-sm-3 control-label">Date
										Of Birth</label>
									<div class="col-sm-9">
										<input type="date" value="${individual.getDateOfBirth()}"
											name="dateOfBirth" class="form-control edit_profileField"
											id="editDob" />
									</div>
								</div>

								<div class="form-group">
									<label for="editCountry" class="col-sm-3 control-label">Country</label>
									<div class="col-sm-9">
										<input type="text" value="${individual.getCountry()}"
											name="country" class="form-control edit_profileField"
											id="editCountry" />
									</div>
								</div>

								<div class="form-group">
									<label for="editEmail" class="col-sm-3 control-label">Email</label>
									<div class="col-sm-9">
										<input type="text" value="${user.getEmail()}" name="email"
											class="form-control edit_profileField" id="editEmail"
											readonly />
									</div>
								</div>

								<div class="form-group">
									<label for="editContactDetails" class="col-sm-3 control-label">Phone</label>
									<div class="col-sm-9">
										<input type="text" value="${individual.getContactDetails()}"
											name="contactDetails" class="form-control edit_profileField"
											id="editContact" />

									</div>
								</div>

								<div class="form-group">
									<label for="editPersonalBio" class="col-sm-3 control-label">Personal
										Bio</label>
									<div class="col-sm-9">
										<input type="text" value="${individual.getPersonalBio()}"
											name="personalBio" class="form-control edit_profileField"
											id="editPersonalBio" />

									</div>
								</div>

								<div class="form-group">
									<label for="editMinHour" class="col-sm-3 control-label">Min
										Hours</label>
									<div class="col-sm-9">
										<input type="number"
											value="${individual.getMinimumVolunteerHours()}"
											name="minimumVolunteerHours"
											class="form-control edit_profileField" id="editMinHour" />
									</div>
								</div>

								<div class="form-group">
									<label for="editMaxHour" class="col-sm-3 control-label">Max
										Hours</label>
									<div class="col-sm-9">
										<input type="number"
											value="${individual.getMaximumVolunteerHours()}"
											name="maximumVolunteerHours"
											class="form-control edit_profileField" id="editMaxHour" />
									</div>
								</div>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">Skills</div>
						<div class="panel-body">
							My Skills: <br>
							<c:forEach items="${userSkills}" var="item">
      ${item.getSkillset()}<br>
							</c:forEach>
						</div>
					</div>
					<br> <br>

					<div class="panel panel-default">
						<div class="panel-heading">Experience</div>
						<div class="panel-body">
							<br> I have expertise in these Job Sectors: <br>
							<c:forEach items="${jobSectorsIndividual}" var="item">
      ${item.getJob_sector()} : ${item.getYearsOfExperience()} Years Of Experience<br>
							</c:forEach>
						</div>
					</div>
					<br> <br>

					<div class="panel panel-default">
						<div class="panel-heading">Interests</div>
						<div class="panel-body">
							I prefer to work in:
							<c:forEach items="${preferredCountries}" var="item">
      ${item.getCountry_name()}<br>
							</c:forEach>

							<br> Preferred Project Areas: <br>
							<c:forEach items="${preferredProjectArea}" var="item">
      ${item.getProject_area()}<br>
							</c:forEach>
							<br> Preferred Job Sectors: <br>
							<c:forEach items="${preferredJobSectors}" var="item">
      ${item.getJob_sector()}<br>
							</c:forEach>

						</div>
					</div>
					<br> <br>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-9">
							<input class="btn btn-success edit_org_profile_save"
								type="submit" value="Update details" />
						</div>
					</div>
					<br>
					<h4>
						<button type="btn" class="btn btn-default">
							<a href="individualProfileDisplay">Go back to profile</a>
						</button>
					</h4>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>