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
<link
	href="<%=request.getContextPath()%>/resources/lib/select2/select2.min.css"
	rel="stylesheet" />
<script
	src="<%=request.getContextPath()%>/resources/lib/select2/select2.min.js"></script>

</head>
<body class="profile">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<!--navigation bar  -->
				<%@include file="../../common/navigation.jspf"%>

				<div class="edit_ind_profile_display_container">
					<div class="panel panel-default">
						<div class="panel-heading">Edit Individual Profile Form</div>
						<div class="panel-body">
							<div class="edit_org_pic" style="display: inline-block">
								<form action="edit-individual-profile-pic" method="post"
									enctype="multipart/form-data">
									<img src="/imageDisplay?username=${username}"
										class="circle_edit_ind_profile_image" height="64" width="64">

									<label for="editChooseIndPic"
										class="form-control btn btn-info edit_org_profile_save">Update
										your profile picture</label> <input type="file" name="profilePicture"
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
										<input type="text" id="editIndFirstName" required
											value="${individual.getFirst_name()}" name="firstName"
											class="form-control edit_profileField" />
									</div>
								</div>

								<div class="form-group">
									<label for="editIndLastName" class="col-sm-3 control-label">Last
										Name</label>
									<div class="col-sm-9">
										<input type="text" required
											value="${individual.getLast_name()}" name="lastName"
											class="form-control edit_profileField" id="editIndLastName" />
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
										<select
											class="js-example-basic-single-organization form-control edit_profileField"
											name="organization" id="editOrg">
											<option></option>
											<c:forEach items="${organization_list}" var="item">
												<c:choose>
													<c:when
														test="${individual.getOrganization().equals(item) }">
														<option value="${item}" selected="selected">${item}</option>
													</c:when>
												</c:choose>
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
											name="dateOfBirth" required
											class="form-control edit_profileField" id="editDob" />
									</div>
								</div>

								<div class="form-group">
									<label for="editCountry" class="col-sm-3 control-label">Country</label>
									<div class="col-sm-9">
										<select
											class="js-example-basic-single-country form-control edit_profileField"
											name="country" id="editCountry" required>
											<c:forEach items="${country_list}" var="item">
												<c:choose>
													<c:when
														test="${item.getCountry_name().equals(individual.getCountry())}">
														<option value="${item.getCountry_name()}"
															selected="selected">${item.getCountry_name()}</option>
													</c:when>
													<c:otherwise>
														<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
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
										<input type="number" required
											value="${individual.getMinimumVolunteerHours()}"
											name="minimumVolunteerHours"
											class="form-control edit_profileField" id="editMinHour" />
									</div>
								</div>

								<div class="form-group">
									<label for="editMaxHour" class="col-sm-3 control-label">Max
										Hours</label>
									<div class="col-sm-9">
										<input type="number" required
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
								name="selected_skillsets" required id="skillsets"
								style="width: 100%">
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
								name="selected_jobsector1" id="jsIndi1Value" style="width: 49%">
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
							</select> <input type="number" placeholder="Years of Experience"
								id="js1experience" name="selected_jobsector1_years"
								value="${jobSectorIndividual1.getYearsOfExperience()}"
								style="width: 49%">

							<c:choose>
								<c:when test="${jobSectorIndividual2 != null }">
									<select
										class="js-example-basic-single-jobsectorindividual-optional"
										name="selected_jobsector2" id="jsIndi2aValue"
										style="width: 49%">
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
										value="${jobSectorIndividual2.getYearsOfExperience()}"
										style="width: 49%">
								</c:when>
								<c:otherwise>
									<select
										class="js-example-basic-single-jobsectorindividual-optional"
										name="selected_jobsector2" id="jsIndi2bValue"
										style="width: 49%">
										<option value=""></option>
										<c:forEach items="${job_sector_list}" var="item">

											<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>

										</c:forEach>
									</select>
									<input type="number" id="js2experienceB"
										placeholder="Years of Experience"
										name="selected_jobsector2_years" style="width: 49%">
								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${jobSectorIndividual3 != null }">
									<select
										class="js-example-basic-single-jobsectorindividual-optional"
										name="selected_jobsector3" id="jsIndi3aValue"
										style="width: 49%">
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
										value="${jobSectorIndividual3.getYearsOfExperience()}"
										style="width: 49%">
								</c:when>
								<c:otherwise>
									<select
										class="js-example-basic-single-jobsectorindividual-optional"
										name="selected_jobsector3" id="jsIndi3bValue"
										style="width: 49%">
										<option value=""></option>
										<c:forEach items="${job_sector_list}" var="item">

											<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>

										</c:forEach>
									</select>
									<input type="number" id="js3experienceB"
										placeholder="Years of Experience"
										name="selected_jobsector3_years" style="width: 49%">
								</c:otherwise>
							</c:choose>

						</div>
					</div>
					<br> <br>

					<div class="panel panel-default">
						<div class="panel-heading">Interests</div>
						<div class="panel-body">
							I prefer to work in: <select
								class="js-example-basic-multiple-preferredcountries edit_profileField"
								multiple="multiple" name="selected_preferredcountries"
								id="preferredCountries" style="width: 100%" required>
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
								class="js-example-basic-multiple-preferredprojectareas edit_profileField"
								multiple="multiple" name="selected_preferredprojectareas"
								style="width: 100%" id="preferredAreas" required>
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
								class="js-example-basic-multiple-preferredjobsectors edit_profileField"
								multiple="multiple" name="selected_preferredjobsectors"
								id="preferredJobSectors" style="width: 100%" required>
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
								<tr>
									<div class="col-lg-12 custom-file-upload" id="documents">
										<div id="document_upload_button" onclick="uploadFile()">Upload your documents</div>
										<div style='height: 0px; width: 0px; overflow: hidden;'>
											<input id=uploadFile name="documents" multiple type="file"
												value="upload" onchange="docSub(this)" />
										</div>
								</tr>
								</div>
							</table>
						</div>
					</div>


					<br> <br>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-9">
							<input type="submit"
								class="btn btn-success edit_org_profile_save"
								value="Update details" />
						</div>
					</div>

					<br>
					</form>
					<h4>
						<button type="btn" class="btn btn-default">
							<a href="view-my-profile">Go back to profile</a>
						</button>
					</h4>

				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function uploadFile() {
			document.getElementById("uploadFile").click();
		}
		function docSub(obj) {
			var fileList = document.getElementById("uploadFile").files;
			var allFileNames;

			for (var i = 0; i < fileList.length; i++) {
				var fileName = fileList[i].name.split("\\");
				allFileNames += (fileName + "<br>");
			}

			document.getElementById("document_upload_button").innerHTML = allFileNames
					.substring(9);
			event.preventDefault();
		}

		function checkFields() {
			var firstName = document.getElementById("editIndFirstName");

			if (firstName.value === "") {
				alert('Please input your job title at your current organization.')
				return false;
			}

			var lastName = document.getElementById("editIndLastName");

			if (lastName.value === "") {
				alert('Please input your job title at your current organization.')
				return false;
			}

			var jobTitle = document.getElementById("editJobTitle");

			var organization = document.getElementById("editOrg");

			var contactNumber = document.getElementById("editContact").value;

			if (/^\d+$/.test(contactNumber) === false
					|| contactNumber.length > 20) {
				alert('Please enter a maximum of 20 positive numbers for your phone number, without symbols and spaces.')
				return false;
			}

			/*if (jobTitle.value !== "" && organization.value === "") {
				alert('Please choose your organization.')
				return false;
			}*/

			if (jobTitle.value === "" && organization.value !== "") {
				alert('Please input your job title at your current organization.')
				return false;
			}

			var minHours = document.getElementById("editMinHour");

			var maxHours = document.getElementById("editMaxHour");

			if (minHours === "" || maxHours === "") {
				alert('Please enter the number of hours that you are willing to volunteer for projects.')
				return false;
			}

			if (minHours !== "" && maxHours !== "") {
				var min = parseInt(minHours.value);
				var max = parseInt(maxHours.value);

				if (min <= 0 || max <= 0) {
					alert('Please enter numbers greater than 0 for hours to volunteer.')
					return false;
				}

				if (min > max) {
					alert('Your minimum hours cannot be greater than maximum hours.')
					return false;
				}
			}

			var skillsets = document.getElementById("skillsets");

			if (skillsets !== null) {
				if (skillsets.value === "") {
					alert('Please state your skills.')
					return false;
				}
			}

			var jsIndi1 = document.getElementById("jsIndi1Value");

			var jsIndiEx1 = document.getElementById("js1experience");

			if (jsIndi1 !== null) {
				if (jsIndi1.value !== "" && jsIndiEx1.value === "") {
					change('js1experience', 'required');
					alert('Please fill in the years of experience you have for the sector(s) chosen.')
					return false;
				}

				if (jsIndi1.value === "" && jsIndiEx1.value !== "") {
					change('jsIndi1Value', 'required');
					alert('Please select a sector for the number of years of experience that you have for.')
					return false;
				}

				if (jsIndiEx1.value !== "") {

					var js1yearsOfEx = parseInt(jsIndiEx1.value);

					if (js1yearsOfEx <= 0) {
						alert('Please enter numbers greater than 0 for your years of experience.')
						return false;
					}

					if (isNaN(js1yearsOfEx)) {
						alert('Please enter only numbers for the number of years of experience you possess.')
						return false;
					}
				}
			}

			var jsIndi2A = document.getElementById("jsIndi2aValue");

			var jsIndiEx2A = document.getElementById("js2experienceA");

			if (jsIndi2A !== null) {

				if (jsIndi2A.value !== "" && jsIndiEx2A.value === "") {
					change('js2experienceA', 'required');
					alert('Please fill in the years of experience you have for the sector(s) chosen.')
					return false;
				}

				if (jsIndi2A.value === "" && jsIndiEx2A.value !== "") {
					change('jsIndi2aValue', 'required');
					alert('Please select a sector for the number of years of experience that you have for.')
					return false;
				}

				if (jsIndiEx2A.value !== "") {

					var js2yearsOfEx = parseInt(jsIndiEx2A.value);

					if (js2yearsOfEx <= 0) {
						alert('Please enter numbers greater than 0 for your years of experience.')
						return false;
					}

					if (isNaN(js2yearsOfEx)) {
						alert('Please enter only numbers for the number of years of experience you possess.')
						return false;
					}
				}
			}

			var jsIndi2B = document.getElementById("jsIndi2bValue");

			var jsIndiEx2B = document.getElementById("js2experienceB");

			if (jsIndi2B !== null) {
				if (jsIndi2B.value !== "" && jsIndiEx2B.value === "") {
					change('js2experienceB', 'required');
					alert('Please fill in the years of experience you have for the sector(s) chosen.')
					return false;
				}

				if (jsIndi2B.value === "" && jsIndiEx2B.value !== "") {
					change('jsIndi2bValue', 'required');
					alert('Please select a sector for the number of years of experience that you have for.')
					return false;
				}
				
				if (jsIndiEx2B.value !== "") {

					var js2byearsOfEx = parseInt(jsIndiEx2B.value);

					if (js2byearsOfEx <= 0) {
						alert('Please enter numbers greater than 0 for your years of experience.')
						return false;
					}

					if (isNaN(js2byearsOfEx)) {
						alert('Please enter only numbers for the number of years of experience you possess.')
						return false;
					}
				}
			}

			var jsIndi3A = document.getElementById("jsIndi3aValue");
			var jsIndiEx3A = document.getElementById("js3experienceA");

			if (jsIndi3A !== null) {

				if (jsIndi3A.value !== "" && jsIndiEx3A.value === "") {
					change('js3experienceA', 'required');
					alert('Please select a sector for the number of years of experience that you have for.')
					return false;
				}

				if (jsIndi3A.value === "" && jsIndiEx3A.value !== "") {
					change('jsIndi3aValue', 'required');
					alert('Please fill in the years of experience you have for the sector(s) chosen.')
					return false;
				}
				
				if (jsIndiEx3A.value !== "") {

					var js3ayearsOfEx = parseInt(jsIndiEx3A.value);

					if (js3ayearsOfEx <= 0) {
						alert('Please enter numbers greater than 0 for your years of experience.')
						return false;
					}

					if (isNaN(js3ayearsOfEx)) {
						alert('Please enter only numbers for the number of years of experience you possess.')
						return false;
					}
				}
			}

			var jsIndi3B = document.getElementById("jsIndi3bValue");

			var jsIndiEx3B = document.getElementById("js3experienceB");

			if (jsIndi3B !== null) {
				if (jsIndi3B.value !== "" && jsIndiEx3B.value === "") {
					change('js3experienceB', 'required');
					alert('Please fill in the years of experience you have for the sector(s) chosen.')
					return false;
				}

				if (jsIndi3B.value === "" && jsIndiEx3B.value !== "") {
					change('jsIndi3bValue', 'required');
					alert('Please select a sector for the number of years of experience that you have for.')
					return false;
				}
				
				if (jsIndiEx3B.value !== "") {

					var js3byearsOfEx = parseInt(jsIndiEx3B.value);

					if (js3byearsOfEx <= 0) {
						alert('Please enter numbers greater than 0 for your years of experience.')
						return false;
					}

					if (isNaN(js3byearsOfEx)) {
						alert('Please enter only numbers for the number of years of experience you possess.')
						return false;
					}
				}
			}

			var preferredCountries = document
					.getElementById("preferredCountries");

			if (preferredCountries !== null) {
				if (preferredCountries.value === "") {
					alert('Please tell us which country you prefer to volunter in.')
					return false;
				}
			}

			var preferredAreas = document.getElementById("preferredAreas");

			if (preferredAreas !== null) {
				if (preferredAreas.value === "") {
					alert('Please tell us the areas you would like to volunteer in.')
					return false;
				}
			}

			var preferredJobSectors = document
					.getElementById("preferredJobSectors");

			if (preferredJobSectors !== null) {
				if (preferredJobSectors.value === "") {
					alert('Please tell us the job sectors you prefer to work in.')
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
		$(document).ready(function() {
			$(".js-example-basic-single-country").select2({
				placeholder : "Country which you are based in: ",
				allowClear : true
			});
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
				placeholder : "Select an organization: ",
				allowClear : true
			});
		});
	</script>
</body>
</html>