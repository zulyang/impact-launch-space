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
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/profile/individual/setup_individual_profile.css" />
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

				<div class="form_container indi_profile_container">
					<form method="post" onsubmit="return checkFields();"
						action="setup-individual" enctype="multipart/form-data"
						class="form-horizontal indi_profile_form">
						<p class="required pull-right">* fields are required.</p>
						<h3 class="info_header">Personal information</h3>

						<div class="form-group">
							<label for="username" class="col-sm-3 font_labels">Username<span
								class="required">*</span></label>

							<div class="col-lg-9">
								<input type="text" id="username" name="username"
									value="${username}" readonly class="form-control profileField">
							</div>
						</div>
						<div class="form-group">
							<label for="email" style="text-align: left;" class="col-sm-3">Email<span
								class="required">*</span></label>

							<div class="col-lg-9">
								<input type="text" id="email" name="email" value="${email}"
									readonly class="form-control profileField">
							</div>
						</div>
						<div class="form-group">
							<label for="firstName" class="col-sm-3 font_labels">First
								Name<span class="required">*</span>
							</label>

							<div class="col-lg-9">
								<input type="text" id="firstName" name="firstName"
									placeholder="First name" required
									class="form-control profileField">
							</div>
						</div>
						<div class="form-group">
							<label for="lastName" class="col-sm-3 font_labels">Last
								Name<span class="required">*</span>
							</label>

							<div class="col-lg-9">
								<input type="text" id="lastName" name="lastName"
									placeholder="Last name" required
									class="form-control profileField">
							</div>
						</div>

						<div class="form-group">
							<label for="lastName" class="col-sm-3 font_labels">Date
								of Birth<span class="required">*</span>
							</label>

							<div class="col-lg-9">
								<input type="date" name="dateOfBirth" required id="dateOfBirth"
									onfocus="(this.type='date')"
									placeholder="Date of Birth (dd/mm/yyyy)*"
									class="form-control profileField">
							</div>
						</div>
						<div class="form-group">
							<label for="country" class="col-sm-3 font_labels">Base
								Country<span class="required">*</span>
							</label>

							<div class="col-lg-9">
								<select id="country" class="js-example-basic-single-country"
									name="country" style="width: 100%" required>
									<option></option>
									<c:forEach items="${country_list}" var="item">
										<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<h3 class="info_header">Work</h3>

						<div class="form-group">
							<label for="country" style="text-align: left;"
								class="col-sm-3 control-label font_labels">Job Title<span
								class="required">*</span></label>

							<div class="col-lg-9">
								<input name="jobTitle" id="jobTitle" type="text" required
									class="form-control profileField"
									placeholder="Current job title">
							</div>
						</div>
						<div class="form-group">
							<label for="organization" class="col-sm-3 font_labels">Organization</label>
							<div class="col-lg-9">
								<select id="organization" style="width: 100%"
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
							<label for="jsIndi1Value" class="col-sm-3 font_labels">Primary
								Job Sector<span class="required">*</span>
							</label>

							<div class="col-lg-9">
								<select required style="width: 100%"
									class="js-example-basic-single-jobsector-required profileField"
									name="jobSector1" id="jsIndi1Value">
									<option></option>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="js1experience" class="col-sm-3 font_labels">Years
								of Experience<span class="required">*</span>
							</label>

							<div class="col-lg-9">
								<input required name="js1Years" type="number" id="js1experience"
									class="form-control profileField"
									placeholder="Years of experience">
							</div>
						</div>

						<div class="form-group">
							<label for="jsIndi2Value" class="col-sm-3 font_labels">Additional
								Job Sector</label>
							<div class="col-lg-9">
								<select style="width: 100%"
									class="js-example-basic-single-jobsector-optional profileField"
									name="jobSector2" id="jsIndi2Value">
									<option></option>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="js2experience" class="col-sm-3 font_labels">Years
								of Experience</label>
							<div class="col-lg-9">
								<input name="js2Years" type="number" id="js2experience"
									class="form-control profileField"
									placeholder="Years of experience">
							</div>
						</div>

						<div class="form-group">
							<label for="jsIndi3Value" class="col-sm-3 font_labels">Additional
								Job Sector</label>
							<div class="col-lg-9">
								<select style="width: 100%"
									class="js-example-basic-single-jobsector-optional profileField"
									name="jobSector3" id="jsIndi3Value">
									<option></option>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="js3experience" class="col-sm-3 font_labels">Years
								of Experience</label>
							<div class="col-lg-9">
								<input name="js3Years" type="number" id="js3experience"
									class="form-control profileField"
									placeholder="Years of experience">
							</div>
						</div>

						<div class="form-group">
							<label for="skills" class="col-sm-3 font_labels">Your
								Skills<span class="required">*</span>
							</label>

							<div class="col-lg-9">
								<select class="js-example-basic-multiple-skills profileField"
									style="width: 100%" multiple="multiple"
									name="selected_skillsets" id="skills" required>
									<c:forEach items="${skillset_list}" var="item">
										<option value="${item.getSkillset()}">${item.getSkillset()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="job_sectors" class="col-sm-3 font_labels">Job
								Sectors<span class="required">*</span>
							</label>

							<div class="col-lg-9">
								<select style="width: 100%"
									class="js-example-basic-multiple-preferredjobsector profileField"
									multiple="multiple" id="job_sectors"
									name="selected_preferredjobsectors" required>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="project_areas" class="col-sm-3 font_labels">Project
								Areas<span class="required">*</span>
							</label>

							<div class="col-lg-9">
								<select style="width: 100%"
									class="js-example-basic-multiple-projectareas profileField"
									id="project_areas" multiple="multiple"
									name="selected_projectareas" required>
									<c:forEach items="${project_area_list}" var="item">
										<option value="${item.getProject_area()}">${item.getProject_area()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="minHours" class="col-sm-3 font-labels">Min
								Hours<span class="required">*</span>
							</label>
							<div class="col-lg-9">
								<input type="number" name="minimumHours" min="1" max="100"
									id="minHours" class="form-control profileField"
									placeholder="Minimum Hours to commit per week" required>
							</div>
						</div>
						<div class="form-group">
							<label for="maxHours" class="col-sm-3 font-labels">Max
								Hours<span class="required">*</span>
							</label>
							<div class="col-lg-9">
								<input type="number" name="maximumHours" id="maxHours" min="1"
									max="100" class="form-control profileField"
									placeholder="Maximum Hours to commit per week" required>
						
						</div>
				</div>
				<div class="form-group">
                            <label for="preferred_countries" class="col-sm-3 font_labels">Preferred Countries<span class="required">*</span></label>
	
					<div class="col-lg-9">
						<select style="width: 100%" id="preferred_countries"
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
				      
				      	<h3 class="info_header">Others</h3>
				<br>
				<div class="form-group">
					<div class="col-lg-12 custom-file-upload" id="documents">
                                <div id="document_upload_button" class="document_upload_button" onclick="uploadFile()">Upload your supporting document</div>

						<div style='height: 0px; width: 0px; overflow: hidden;'>
							<input id=uploadFile name="documents" multiple type="file"
								value="upload" onchange="docSub(this)" />
						</div>
					</div>
				</div>   <br>               
                        <h3 class="info_header" style="margin-right: 5px;">Privacy
                        <span class="required">*</span>
				
				<i class="fa fa-info-circle info_tooltip" rel="tooltip"
                            title="A public profile will show users your email address and contact number."></i></h3>

				<div class="form-radio center">
					<ul class="radio_as_button">
						<li><input type="radio" id="public" name="isPublicProfile"
							required="required" value="true"> <label for="public">Public</label>
						</li>

						<li><input type="radio" id="private" name="isPublicProfile"
							required="required" value="false"> <label for="private">Private</label>
						</li>

					</ul>
				</div>
				<br><br>
				<div class="form-group">
					<div class="col-lg-12">
						<input type="submit" class="btn btn-success profile_save"
							value="Save Account Details">
					</div>
				</div>
				</form>
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
	</script>

	<script type="text/javascript">
		function checkFields() {
			var dob = document.getElementById("dateOfBirth").value;
			var year = dob.substring(0, 4);

			var birthYear = parseInt(year);
			var currentYear = new Date().getFullYear();
			var age = currentYear - birthYear;

			if (age > 117) {
				alert('Your age cannot be greater than 100 years.');
				return false;
			}

			var date = new Date();
			var today = date.getFullYear() + "-" + (date.getMonth() + 1) + "-"
					+ date.getDate();

			var currentDate = Date.parse(today.replace(/-/g, " "));
			var pickedDate = Date.parse(dob.replace(/-/g, " "));

			if (pickedDate >= currentDate) {
				alert('Your birth date cannot today or a future date.');
				return false;
			}

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

					if (js1yearsOfEx > age) {
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

					if (js2yearsOfEx > age) {
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

					if (js3yearsOfEx > age) {
						alert('Your years of experience cannot be greater than your age.');
						return false;
					}
				}
			}

			if (jsIndi1A !== null && jsIndi2A !== null && jsIndi3A !== null) {
				var job_sector_1 = jsIndi1A.value;
				var job_sector_2 = jsIndi2A.value;
				var job_sector_3 = jsIndi3A.value;

				if (job_sector_1 !== "" && job_sector_2 !== "") {
					if (job_sector_1 === job_sector_2) {
						alert('Please do not select the same job sector.');
						return false;
					}
				}

				if (job_sector_1 !== "" && job_sector_3 !== "") {
					if (job_sector_1 === job_sector_3) {
						alert('Please do not select the same job sector.');
						return false;
					}
				}

				if (job_sector_3 !== "" && job_sector_2 !== "") {
					if (job_sector_3 === job_sector_2) {
						alert('Please do not select the same job sector.');
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

			if (contactNumber !== "") {
				if (/^\d+$/.test(contactNumber) === false
						|| contactNumber.length > 20
						|| contactNumber.length < 8) {
					alert('Please enter a minimum of 8 numbers and a maximum of 20 positive numbers for your phone number, without symbols and spaces.')
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
				placeholder : "Select Primary Job Sector:",
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
