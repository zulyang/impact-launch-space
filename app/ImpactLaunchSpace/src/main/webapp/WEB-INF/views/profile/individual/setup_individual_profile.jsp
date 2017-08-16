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
				<%@include file="../../common/navigation.jspf"%>
				<div class="col-lg-12 form_container indi_profile_container">
					<form method="post" onsubmit="return checkFields();"
						action="setup-individual" enctype="multipart/form-data"
						class="form-horizontal indi_profile_form">
						<h3>Personal information</h3>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="text" name="username" value="${username}" readonly
									class="form-control profileField">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="text" name="email" value="${email}" readonly
									class="form-control profileField">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="text" name="firstName" placeholder="First name"
									required class="form-control profileField"> <input
									type="text" name="lastName" placeholder="Last name" required
									class="form-control profileField">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<div id="profile_upload_button" onclick="uploadPicture()">Upload a profile picture</div>
								<div style='height: 0px; width: 0px; overflow: hidden;'>
									<input id="uploadPicture" name="profilePicture" type="file"
										value="upload" onchange="sub(this)" />
								</div>
							</div>
						</div>

						<div class="form-group">
							<div class="col-lg-12">
								<input type="date" name="dateOfBirth" required id="dateOfBirth"
									placeholder="Date of Birth (dd/mm/yyyy)"
									class="form-control profileField">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select class="js-example-basic-single-country" name="country"
									required>
									<option></option>
									<c:forEach items="${country_list}" var="item">
										<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<h3>Work</h3>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="jobTitle" id="jobTitle" type="text" required
									class="form-control profileField"
									placeholder="Current job title">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select id="organization"
									class="js-example-basic-single-organization profileField"
									name="organization">
									<option></option>
									<c:forEach items="${organization_list}" var="item">
										<option value="${item}">${item}</option>
									</c:forEach>
								</select>


							</div>
						</div>

						<div class="form-group">
							<div class="col-lg-12">
								<select
									class="js-example-basic-single-jobsector-required profileField"
									name="jobSector1" id="jsIndi1Value">
									<option></option>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select> <input name="js1Years" type="number" id="js1experience"
									class="form-control profileField"
									placeholder="Years of experience">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select
									class="js-example-basic-single-jobsector-optional profileField"
									name="jobSector2" id="jsIndi2Value">
									<option></option>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select> <input name="js2Years" type="number" id="js2experience"
									class="form-control profileField"
									placeholder="Years of experience">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select
									class="js-example-basic-single-jobsector-optional profileField"
									name="jobSector3" id="jsIndi3Value">
									<option></option>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select> <input name="js3Years" type="number" id="js3experience"
									class="form-control profileField"
									placeholder="Years of experience">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select class="js-example-basic-multiple-skills profileField"
									multiple="multiple" name="selected_skillsets" required>
									<c:forEach items="${skillset_list}" var="item">
										<option value="${item.getSkillset()}">${item.getSkillset()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select
									class="js-example-basic-multiple-preferredjobsector profileField"
									multiple="multiple" name="selected_preferredjobsectors"
									required>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select
									class="js-example-basic-multiple-projectareas profileField"
									multiple="multiple" name="selected_projectareas" required>
									<c:forEach items="${project_area_list}" var="item">
										<option value="${item.getProject_area()}">${item.getProject_area()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="number" name="minimumHours" min="1" max="100"
									id="minHours" class="form-control profileField"
									placeholder="Minimum Hours per week" required> <input
									type="number" name="maximumHours" id="maxHours" min="1"
									max="100" class="form-control profileField"
									placeholder="Maximum Hours per week" required>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select
									class="js-example-basic-multiple-preferredcountries profileField"
									multiple="multiple" name="selected_preferredcountries" required>
									<c:forEach items="${country_list}" var="item">
										<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<textarea rows="4" name="personalBio"
									class="form-control personalBio"
									placeholder="A short personal bio"></textarea>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="contactDetails" type="text" id="contactNumber"
									class="form-control profileField" placeholder="Mobile Number">
							</div>
						</div>
						<br>
						<h3 style="display: inline-block; margin-right: 5px;">Privacy
						</h3>
						<i class="fa fa-info-circle info_tooltip" rel="tooltip"
							title="A public profile will show users your email address and contact number."></i>
						<div class="form-radio center">
							<!-- <div class="radio_public">
								<input name="isPublicProfile" required="required" value="true"
									type="radio" value="Public Profile">Public Profile
							</div>
							<div class="radio_private">
								<input name="isPublicProfile" required="required" value="false"
									type="radio" value="Private Profile">Private Profile
							</div> -->

							<ul class="radio_as_button">
								<li><input type="radio" id="public" name="isPublicProfile"
									required="required" value="true"> <label for="public">Public</label>
								</li>

								<li><input type="radio" id="private" name="isPublicProfile"
									required="required" value="false"> <label for="private">Private</label>
								</li>

							</ul>


						</div>
						<br>
						<div class="form-group">
							<div class="col-lg-12 custom-file-upload" id="documents">
								<div id="document_upload_button" onclick="uploadFile()">Upload your documents</div>
								<div style='height: 0px; width: 0px; overflow: hidden;'>
									<input id=uploadFile name="documents" multiple type="file"
										value="upload" onchange="docSub(this)" />
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="submit" class="btn btn-success profile_save"
									value="Set Account Details">
							</div>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>

	<script type="text/javascript">
		function uploadPicture() {
			document.getElementById("uploadPicture").click();
		}
		function sub(obj) {
			var file = obj.value;
			var fileName = file.split("\\");
			document.getElementById("profile_upload_button").innerHTML = fileName[fileName.length - 1];
			event.preventDefault();
		}

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
	</script>

	<script type="text/javascript">
		function checkFields() {
			var jobTitle = document.getElementById("jobTitle");

			var organization = document.getElementById("organization");

			/*if (jobTitle.value === "") {
				alert('Please input your job title.')
				return false;
			}*/

			var dob = document.getElementById("dateOfBirth").value;
			var year = dob.substring(0, 4);
			
			var birthYear = parseInt(year);
			var currentYear = new Date().getFullYear();
			var age = currentYear - birthYear;
			
			var jsIndi1A = document.getElementById("jsIndi1Value");

			var jsIndiEx1B = document.getElementById("js1experience");

			if (jsIndi1A !== null) {
				if (jsIndi1A.value !== "" && jsIndiEx1B.value === "") {
					change('js1experience', 'required');
					alert('Please fill in the years of experience you have for the sector(s) chosen.')
					return false;
				}

				if (jsIndi1A.value === "" && jsIndiEx1B.value !== "") {
					change('jsIndi1Value', 'required');
					alert('Please select a sector for the number of years of experience that you have for.')
					return false;
				}
			}

			if (jsIndiEx1B !== null) {
				if (jsIndiEx1B.value !== "") {
					
					var js1yearsOfEx = parseInt(jsIndiEx1B.value);
					
					if (js1yearsOfEx <= 0) {
						alert('Please enter numbers greater than 0 for your years of experience.')
						return false;
					}

					if (isNaN(js1yearsOfEx)) {
						alert('Please enter only numbers for the number of years of experience you possess.')
						return false;
					}
					
					if(js1yearsOfEx > age){
						alert('Your years of experience cannot be greater than your age.');
						return false;
					}
				}
			}

			var jsIndi2A = document.getElementById("jsIndi2Value");

			var jsIndiEx2B = document.getElementById("js2experience");

			if (jsIndi2A !== null) {
				if (jsIndi2A.value !== "" && jsIndiEx2B.value === "") {
					change('js2experience', 'required');
					alert('Please fill in the years of experience you have for the sector(s) chosen.')
					return false;
				}

				if (jsIndi2A.value === "" && jsIndiEx2B.value !== "") {
					change('jsIndi2Value', 'required');
					alert('Please select a sector for the number of years of experience that you have for.')
					return false;
				}
			}

			if (jsIndiEx2B !== null) {
				if (jsIndiEx2B.value !== "") {
					
					var js2yearsOfEx = parseInt(jsIndiEx2B.value);
					
					if (js2yearsOfEx <= 0) {
						alert('Please enter numbers greater than 0 for your years of experience.')
						return false;
					}

					if (isNaN(js2yearsOfEx)) {
						alert('Please enter only numbers for the number of years of experience you possess.')
						return false;
					}
					
					if(js2yearsOfEx > age){
						alert('Your years of experience cannot be greater than your age.');
						return false;
					}
				}
			}

			var jsIndi3A = document.getElementById("jsIndi3Value");

			var jsIndiEx3B = document.getElementById("js3experience");

			if (jsIndi3A !== null) {
				if (jsIndi3A.value !== "" && jsIndiEx3B.value === "") {
					change('js3experience', 'required');
					alert('Please fill in the years of experience you have for the sector(s) chosen.')
					return false;
				}

				if (jsIndi3A.value === "" && jsIndiEx3B.value !== "") {
					change('jsIndi3Value', 'required');
					alert('Please select a sector for the number of years of experience that you have for.')
					return false;
				}
			}
			
			if (jsIndiEx3B !== null) {
				if (jsIndiEx3B.value !== "") {
					
					var js3yearsOfEx = parseInt(jsIndiEx3B.value);
					
					if (js3yearsOfEx <= 0) {
						alert('Please enter numbers greater than 0 for your years of experience.')
						return false;
					}

					if (isNaN(js3yearsOfEx)) {
						alert('Please enter only numbers for the number of years of experience you possess.')
						return false;
					}
					
					if(js3yearsOfEx > age){
						alert('Your years of experience cannot be greater than your age.');
						return false;
					}
				}
			}

			var minHours = document.getElementById("minHours");
			var maxHours = document.getElementById("maxHours");
			
			if (minHours !== null && maxHours !== null) {
				var min = minHours.value;				
				var max = maxHours.value;
				
				if (min !== "" && max !== "") {
					if (isNaN(min) || isNaN(max)) {
						alert('Please enter only numbers for the minimum and maximum hours that you want to volunteer.')
						return false;
					}

					if (min <= 0 || max <= 0) {
						alert('Please enter numbers greater than 0 for hours to volunteer.')
						return false;
					}

					if (min > max) {
						alert('Your minimum hours cannot be greater than maximum hours.')
						return false;
					}
				}
			}

			var contactNumber = document.getElementById("contactNumber").value;

			if (/^\d+$/.test(contactNumber) === false
					|| contactNumber.length > 20) {
				alert('Please enter a maximum of 20 positive numbers for your phone number, without symbols and spaces.')
				return false;
			}

			return true;
		}

		function change(id, newClass) {
			identity = document.getElementById(id);
			identity.required = true;
		}
	</script>

	<script type="text/javascript">
		$(".js-example-basic-multiple-preferredcountries").select2({
			placeholder : "Select countries where you wish to be involved in"
		});
	</script>
	<script type="text/javascript">
		$(".js-example-basic-multiple-preferredjobsector").select2({
			maximumSelectionLength : 3,
			placeholder : "Select Up to 3 Job Sectors that interest you"
		});
	</script>
	<script type="text/javascript">
		$(".js-example-basic-multiple-projectareas").select2({
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
		$(document).ready(function() {
			$(".js-example-basic-single-jobsector-required").select2({
				placeholder : "Select Primary Job Sector (required):",
				allowClear : true
			});
		});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".js-example-basic-single-jobsector-optional").select2({
				placeholder : "Select Additional Job Sector (optional):",
				allowClear : true
			});
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
		$(document).ready(function() {
			$(".js-example-basic-single-organization").select2({
				placeholder : "Current Organization: "
			});
		});
	</script>


	<script type="text/javascript">
		$(document).ready(function() {
			$("[rel=tooltip]").tooltip({
				placement : 'right'
			});
		});
	</script>

</body>
</html>
