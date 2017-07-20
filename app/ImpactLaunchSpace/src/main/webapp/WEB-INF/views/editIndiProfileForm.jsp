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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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

				<!--navigation bar  -->
				<%@include file="common/navigation.jspf"%>

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

							<form onsubmit="return checkFields();"
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
										<select class="js-example-basic-single-organization"
											name="organization" id="editOrg">
											<option></option>
											<c:forEach items="${organization_list}" var="item">
												<option value="${item}">${item}</option>
											</c:forEach>
										</select>

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
							<br> I have expertise in these Job Sectors: <br> <select
								class="js-example-basic-single-jobsectorindividual-required"
								name="selected_jobsector1" required>
								<option value=""></option>
								<c:forEach items="${job_sector_list}" var="item">
									<c:choose>
										<c:when
											test="${jobSectorIndividual1_string.equals(item.getJob_sector())}">
											<option value="${item.getJob_sector()}" selected="selected">${item.getJob_sector()}</option>
										</c:when>
										<c:otherwise>
											<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select> <input id="js1experienceA" type="number"
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
													<option value="${item.getJob_sector()}" selected="selected">${item.getJob_sector()}</option>
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
													<option value="${item.getJob_sector()}" selected="selected">${item.getJob_sector()}</option>
												</c:when>
												<c:otherwise>
													<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
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

											<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>

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
					<div class="panel panel-default">
						<div class="panel-heading">Documents</div>
						<div class="panel-body">
							<table>
								<c:forEach items="${individual.getDocumentList()}"
									var="document">
									<tr>
										<td><a href="/downloadFile?file=${document}"> <img
												src="<%=request.getContextPath()%>/resources/img/file.png" />
										</a></td>
										<td><a href="/downloadFile?file=${document}">${document.getName()}</a></td>
										<td><a
											href="/deleteFile?username=${individual.getUsername()}&file=${document}">
												<img
												src="<%=request.getContextPath()%>/resources/img/cross.png" />
										</a></td>
									</tr>
								</c:forEach>
							</table>
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
			console.log("2A: " + jsIndi2A);

			var jsIndiEx2A = document.getElementById("js2experienceA");

			if (jsIndi2A !== null) {
				console.log("2a: " + jsIndi2A.value);

				if (jsIndi2A.value !== "" && jsIndiEx2A.value === "") {
					console.log("js indi xperience value 2A: "
							+ jsIndiEx2A.value);
					change('js2experienceA', 'required');
					alert('Please fill in the years of experience you have for the sector(s) chosen.')
					return false;
				}

				if (jsIndi2A.value === "" && jsIndiEx2A.value !== "") {
					console.log("js indi xperience value 2A: "
							+ jsIndiEx2A.value);
					change('jsIndi2aValue', 'required');
					alert('Please select a sector for the number of years of experience that you have for.')
					return false;
				}
			}

			var jsIndi2B = document.getElementById("jsIndi2bValue");
			console.log("2B: " + jsIndi2B);

			var jsIndiEx2B = document.getElementById("js2experienceB");

			if (jsIndi2B !== null) {
				console.log("2b: " + jsIndi2B.value);
				if (jsIndi2B.value !== "" && jsIndiEx2B.value === "") {
					console.log("js indi xperience value 2B: "
							+ jsIndiEx2B.value);
					change('js2experienceB', 'required');
					alert('Please fill in the years of experience you have for the sector(s) chosen.')
					return false;
				}

				if (jsIndi2B.value === "" && jsIndiEx2B.value !== "") {
					console.log("js indi xperience value 2B: "
							+ jsIndiEx2B.value);
					change('jsIndi2bValue', 'required');
					alert('Please select a sector for the number of years of experience that you have for.')
					return false;
				}
			}

			console.log("BREAK -------------------");

			var jsIndi3A = document.getElementById("jsIndi3aValue");
			console.log("3A: " + jsIndi3A);
			var jsIndiEx3A = document.getElementById("js3experienceA");

			if (jsIndi3A !== null) {
				console.log("3a: " + jsIndi3A.value);

				if (jsIndi3A.value !== "" && jsIndiEx3A.value === "") {
					console.log("js indi xperience value 3A: "
							+ jsIndiEx3A.value);
					change('js3experienceA', 'required');
					alert('Please select a sector for the number of years of experience that you have for.')
					return false;
				}

				if (jsIndi3A.value === "" && jsIndiEx3A.value !== "") {
					console.log("js indi xperience value 3A: "
							+ jsIndiEx3A.value);
					change('jsIndi3aValue', 'required');
					alert('Please fill in the years of experience you have for the sector(s) chosen.')
					return false;
				}
			}

			var jsIndi3B = document.getElementById("jsIndi3bValue");
			console.log("3B: " + jsIndi3B);

			var jsIndiEx3B = document.getElementById("js3experienceB");

			if (jsIndi3B !== null) {
				console.log("3b: " + jsIndi3B.value);
				if (jsIndi3B.value !== "" && jsIndiEx3B.value === "") {
					console.log("js indi xperience value 3B: "
							+ jsIndiEx3B.value);
					change('js3experienceB', 'required');
					alert('Please fill in the years of experience you have for the sector(s) chosen.')
					return false;
				}

				if (jsIndi3B.value === "" && jsIndiEx3B.value !== "") {
					console.log("js indi xperience value 3B: "
							+ jsIndiEx3B.value);
					change('jsIndi3bValue', 'required');
					alert('Please select a sector for the number of years of experience that you have for.')
					return false;
				}
			}

			return true;
		}

		function change(id, newClass) {
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

	<script type="text/javascript">
		$(document).ready(function() {
			$(".js-example-basic-single-organization").select2({
				placeholder : "Select an organization: "
			});
		});
	</script>
</body>
</html>