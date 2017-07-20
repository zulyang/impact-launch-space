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

<%@include file="common/navigation.jspf" %>
					<div class="col-lg-12 form_container indi_profile_container">
					<form method="post" action="setup-individual"
						enctype="multipart/form-data"
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
									class="form-control profileField"> <input type="text"
									name="lastName" placeholder="Last name"
									class="form-control profileField">
							</div>
						</div>
						<div class="form-group">
							<div
								class="col-lg-12 col-sm-offset-4 col-md-offset-4 col-lg-offset-4">
								<label for="indiPic"
									class="form-control btn btn-info profile_save">Upload
									Profile Picture</label> <input type="file" style="visibility: hidden;"
									name="profilePicture" id="indiPic">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="date" name="dateOfBirth"
									placeholder="Date of Birth (dd/mm/yyyy) class="form-controlprofileField">
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
								<input name="jobTitle" type="text"
									class="form-control profileField"
									placeholder="Current job title">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
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
							<div class="col-lg-12">
								<select class="js-example-basic-single-jobsector-required"
									name="jobSector1" required>
									<option></option>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select> <input name="js1Years" type="number"
									class="form-control profileField"
									placeholder="Years of experience">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select class="js-example-basic-single-jobsector-optional"
									name="jobSector2">
									<option></option>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select> <input name="js2Years" type="number"
									class="form-control profileField"
									placeholder="Years of experience">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select class="js-example-basic-single-jobsector-optional"
									name="jobSector3">
									<option></option>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select> <input name="js3Years" type="number"
									class="form-control profileField"
									placeholder="Years of experience">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select class="js-example-basic-multiple-skills"
									multiple="multiple" name="selected_skillsets" required>
									<c:forEach items="${skillset_list}" var="item">
										<option value="${item.getSkillset()}">${item.getSkillset()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select class="js-example-basic-multiple-preferredjobsector"
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
								<select class="js-example-basic-multiple-projectareas"
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
									class="form-control profileField" placeholder="Minimum Hours">
								<input type="number" name="maximumHours" min="1" max="100"
									class="form-control profileField" placeholder="Maximum Hours">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select class="js-example-basic-multiple-preferredcountries"
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
								<input name="contactDetails" type="text"
									class="form-control profileField" placeholder="Mobile Number">
							</div>
						</div>
						<br>
						<div class="form-radio center">
							<div class="radio_public">
								<input name="isPublicProfile" required="required" value="true"
									type="radio" value="Public Profile">Public Profile
							</div>
							<div class="radio_private">
								<input name="isPublicProfile" required="required" value="false"
									type="radio" value="Private Profile">Private Profile
							</div>
						</div>
						<br>
						<div class="form-group">
							<div
								class="col-lg-12 col-sm-offset-4 col-md-offset-4 col-lg-offset-4">
								<input type="file" name="documents" multiple>
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
</body>
</html>
