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

<!--for multiple select (Select2)-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>

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

							<form onsubmit="checkFields3()"
								class="form-horizontal edit_ind_profile_container"
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
							My Skills: <br> <select
								class="js-example-basic-multiple-skills" multiple="multiple"
								name="selected_skillsets" required>
								<c:forEach items="${skillset_list}" var="item">
									<c:choose>
										<c:when
											test="${individual_userskill_list.contains(item.getSkillset())}">
											<option value="${item.getSkillset()}" selected="selected">${item.getSkillset()}</option>
										</c:when>
										<c:otherwise>
											<option value="${item.getSkillset()}">${item.getSkillset()}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>

						</div>
					</div>
					<br> <br>

					<div class="panel panel-default">
						<div class="panel-heading">Experience</div>
						<div class="panel-body">
							<br> I have expertise in these Job Sectors: <br> 
							<select
								class="js-example-basic-single-jobsectorindividual-required"
								name="selected_jobsector1" required>
								<option value = ""></option>
								<c:forEach items="${job_sector_list}" var="item">
									<c:choose>
										<c:when
											test="${jobSectorIndividual1_string.equals(item.getJob_sector())}">
											<option value="${item.getJob_sector()}"
												selected="selected">${item.getJob_sector()}</option>
										</c:when>
										<c:otherwise>
											<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select> 
							<input id="js1experienceA" type="number"
								placeholder="Years of Experience" required
								name="selected_jobsector1_years"
								value="${jobSectorIndividual1.getYearsOfExperience()}">

							<c:choose>
								<c:when test="${jobSectorIndividual2 != null }">
									<select
										class="js-example-basic-single-jobsectorindividual-optional"
										name="selected_jobsector2" id="jsIndi2aValue">
										<option value=""></option>
										<c:forEach items="${job_sector_list}" var="item">
											<c:choose>
												<c:when
													test="${jobSectorIndividual2_string.equals(item.getJob_sector())}">
													<option value="${item.getJob_sector()}"
														selected="selected">${item.getJob_sector()}</option>
												</c:when>
												<c:otherwise>
													<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>

									<input type="number" id="js2experienceA"
										placeholder="Years of Experience"
										name="selected_jobsector2_years"
										value="${jobSectorIndividual2.getYearsOfExperience()}">
								</c:when>
								<c:otherwise>
									<select
										class="js-example-basic-single-jobsectorindividual-optional"
										name="selected_jobsector2" id="jsIndi2bValue">
										<option value=""></option>
										<c:forEach items="${job_sector_list}" var="item">

											<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>

										</c:forEach>
									</select>
									<input type="number" id="js2experienceB"
										placeholder="Years of Experience"
										name="selected_jobsector2_years">
								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${jobSectorIndividual3 != null }">
									<select
										class="js-example-basic-single-jobsectorindividual-optional"
										name="selected_jobsector3" id="jsIndi3aValue">
										<option value=""></option>
										<c:forEach items="${job_sector_list}" var="item">
											<c:choose>
												<c:when
													test="${jobSectorIndividual3_string.equals(item.getJob_sector())}">
													<option id="jsIndi3AValue" value="${item.getJob_sector()}"
														selected="selected">${item.getJob_sector()}</option>
												</c:when>
												<c:otherwise>
													<option id="jsIndi3BValue" value="${item.getJob_sector()}">${item.getJob_sector()}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>

									<input type="number" id="js3experienceA"
										placeholder="Years of Experience"
										name="selected_jobsector3_years"
										value="${jobSectorIndividual3.getYearsOfExperience()}">
								</c:when>
								<c:otherwise>
									<select
										class="js-example-basic-single-jobsectorindividual-optional"
										name="selected_jobsector3" id="jsIndi3bValue">
										<option value=""></option>
										<c:forEach items="${job_sector_list}" var="item">

											<option id="jsIndi3CValue" value="${item.getJob_sector()}">${item.getJob_sector()}</option>

										</c:forEach>
									</select>
									<input type="number" id="js3experienceB"
										placeholder="Years of Experience"
										name="selected_jobsector3_years">
								</c:otherwise>
							</c:choose>

						</div>
					</div>
					<br> <br>

					<div class="panel panel-default">
						<div class="panel-heading">Interests</div>
						<div class="panel-body">
							I prefer to work in: <select
								class="js-example-basic-multiple-preferredcountries"
								multiple="multiple" name="selected_preferredcountries" required>
								<c:forEach items="${country_list}" var="item">
									<c:choose>
										<c:when
											test="${individual_preferredcountry_list.contains(item.getCountry_name())}">
											<option value="${item.getCountry_name()}" selected="selected">${item.getCountry_name()}</option>
										</c:when>
										<c:otherwise>
											<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>

							</select> <br> Preferred Project Areas: <br> <select
								class="js-example-basic-multiple-preferredprojectareas"
								multiple="multiple" name="selected_preferredprojectareas"
								required>
								<c:forEach items="${project_area_list}" var="item">
									<c:choose>
										<c:when
											test="${individual_preferredprojectarea_list.contains(item.getProject_area())}">
											<option value="${item.getProject_area()}" selected="selected">${item.getProject_area()}</option>
										</c:when>
										<c:otherwise>
											<option value="${item.getProject_area()}">${item.getProject_area()}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>


							</select> <br> Preferred Job Sectors: <br> <select
								class="js-example-basic-multiple-preferredjobsectors"
								multiple="multiple" name="selected_preferredjobsectors" required>
								<c:forEach items="${job_sector_list}" var="item">
									<c:choose>
										<c:when
											test="${individual_preferredjobsector_list.contains(item.getJob_sector())}">
											<option value="${item.getJob_sector()}" selected="selected">${item.getJob_sector()}</option>
										</c:when>
										<c:otherwise>
											<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>


							</select>

						</div>
					</div>
					<br> <br> 
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-9">
							<input onclick="checkFields()" class="btn btn-success edit_org_profile_save"
								type="submit" value="Update details" />
						</div>
					</div>
					<br>
					</form>
					<h4>
						<button type="btn" class="btn btn-default">
							<a href="individualProfileDisplay">Go back to profile</a>
						</button>
					</h4>

				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function checkFields() {			
			var jsIndi2A = document.getElementById("jsIndi2aValue");
			if(jsIndi2A !== null){
				console.log("2a: " + jsIndi2A.value);
				var jsIndiEx2A = document.getElementById("js2experienceA");
				console.log("js indi xperience value 2A: " + jsIndiEx2A);
				change('js2experienceA', 'required');
			} else {
				var jsIndiEx2B = document.getElementById("js2experienceB");
				console.log("js indi xperience value 2B: " + jsIndiEx2B);
				change('js2experienceB', 'required');
			}
			
			console.log("BREAK -------------------");

			var jsIndi3A = document.getElementById("jsIndi3aValue");
			if(jsIndi3A !== null){
				console.log("3a: " + jsIndi3A.value);
				var jsIndiEx3A = document.getElementById("js3experienceA");
				console.log("js indi xperience value 3A: " + jsIndiEx3A);
				change('js3experienceA', 'required');
			} else {
				var jsIndiEx3B = document.getElementById("js3experienceB");
				console.log("js indi xperience value 3B: " + jsIndiEx3B);
				change('js3experienceB', 'required');
			}
		
			return false;
		}

		function change(id, newClass) {
			console.log("in change function");
			identity = document.getElementById(id);
			identity.required = true;
		}
	</script>

	<script type="text/javascript">
		$(".js-example-basic-multiple3").select2({
			maximumSelectionLength : 5,
			placeholder : "Where do you want to make a difference?"
		});
	</script>
	<script type="text/javascript">
		$(".js-example-basic-multiple-skills").select2({
			placeholder : "Select Your Skills"
		});
	</script>
	<script type="text/javascript">
		$(".js-example-basic-multiple-preferredjobsectors").select2({
			placeholder : "Which job sectors are important to you?"
		});
	</script>
	<script type="text/javascript">
		$(".js-example-basic-multiple-preferredcountries").select2({
			placeholder : "Select Countries that you are Interested to Help"
		});
	</script>
	<script type="text/javascript">
		$(".js-example-basic-multiple-preferredprojectareas").select2({
			placeholder : "Which areas do you which to impact?"
		});
	</script>
	<script type="text/javascript">
		$(document).ready(
				function() {
					$(".js-example-basic-single-jobsectorindividual-required")
							.select2({
								placeholder : "Job Sector 1"
							});
				});
	</script>
	<script type="text/javascript">
		$(document).ready(
				function() {
					$(".js-example-basic-single-jobsectorindividual-optional")
							.select2({
								placeholder : "Additional Job Sectors",
								allowClear : true
							});
				});
	</script>
</body>
</html>