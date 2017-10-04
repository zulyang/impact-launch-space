<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Your Individual Profile</title>
<%@include file = "../../AuthenticateCookie.jsp" %>
<link rel="icon" type="image/png"
	href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/profile/individual/edit_individual_profile.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css">
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<link
	href="<%=request.getContextPath()%>/resources/lib/select2/select2.min.css"
	rel="stylesheet" />
<script
	src="<%=request.getContextPath()%>/resources/lib/select2/select2.min.js"></script>
<link href="<%=request.getContextPath()%>/resources/css/cropper.min.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/resources/lib/cropper.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/intlTelInput.css">
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
							<div class="required" style="float: right;">* fields are
								required</div>
							<div class="edit_indi_picture_container">
								<img src="/imageDisplay?username=${username}"
									class="circle_edit_ind_profile_image">
								<button type="button"
									class="btn btn-info btn-lg edit_indi_profile_picture_btn"
									data-toggle="modal" data-target="#myModal">Edit your
									profile picture</button>

								<div id="myModal" class="modal fade" role="dialog">
									<div class="modal-dialog edit_profile_picture_modal">

										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">&times;</button>
												<h4 class="modal-title">Crop your profile picture</h4>
											</div>
											<div class="modal-body">
												<label for="editChooseIndPic"
													class="btn btn-info edit_indi_profile_save"> <i
													class="fa fa-picture-o" aria-hidden="true"
													style="font: none;"></i>&nbspChoose your profile picture
												</label> 
												<p style="color:red">*Please use only .jpeg images for now. PNG images will be allowed soon.</p>
												<input type="file" name="image" id="editChooseIndPic"
													style="visibility: hidden;" onchange="readURL(this);" />
												<div class="image_container" id="image_container">
													<img id="blah" src="#" alt="" />
												</div>
												<div id="crop_button"
													class="btn btn-info image_cropper_btns">
													<span><i class="fa fa-crop" aria-hidden="true"></i>&nbspCrop</span>
												</div>
												<div id="reset_button"
													class="btn btn-warning image_cropper_btns">
													<span><i class="fa fa-trash" aria-hidden="true"></i>&nbspReset
														Image</span>
												</div>
												<div id="cropped_result" class="cropped_result"></div>
												<div id="confirm_button"
													class="btn btn-success image_cropper_btns"
													onClick="reloadPage()">
													<i class="fa fa-check" aria-hidden="true"></i>&nbsp<a
														class="btn_text">Confirm photo</a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<form onsubmit="return checkFields();"
								class="form-horizontal edit_ind_profile_container"
								action="editprofile-individual" method="post">
								<div class="form-group">
									<label for="editIndFirstName" class="col-sm-3 font_labels">First
										Name<span class="required">*</span>
									</label>

									<div class="col-sm-9">
										<input type="text" id="editIndFirstName" required
											value="${individual.getFirst_name()}" name="firstName"
											class="form-control edit_profileField" />
									</div>
								</div>

								<div class="form-group">
									<label for="editIndLastName" class="col-sm-3 font_labels">Last
										Name<span class="required">*</span>
									</label>

									<div class="col-sm-9">
										<input type="text" required
											value="${individual.getLast_name()}" name="lastName"
											class="form-control edit_profileField" id="editIndLastName" />
									</div>
								</div>

								<div class="form-group">
									<label for="editJobTitle" class="col-sm-3 font_labels">Job
										Title<span class="required">*</span>
									</label>

									<div class="col-sm-9">
										<input type="text" value="${individual.getJobTitle()}"
											name="jobTitle" class="form-control edit_profileField"
											id="editJobTitle" />
									</div>
								</div>

								<div class="form-group">
									<label for="editOrg" class="col-sm-3">Organization</label>
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
													<c:otherwise>
														<option value="${item}">${item}</option>
													</c:otherwise>
												</c:choose>

											</c:forEach>
										</select>

									</div>
								</div>

								<div class="form-group">
									<label for="editDob" class="col-sm-3 font_labels">Date
										Of Birth<span class="required">*</span>
									</label>

									<div class="col-sm-9">
										<input type="date" value="${individual.getDateOfBirth()}"
											name="dateOfBirth" required
											class="form-control edit_profileField" id="editDob" />
									</div>
								</div>

								<div class="form-group">
									<label for="editCountry" class="col-sm-3 font_labels">Country<span
										class="required">*</span></label>

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
									<label for="editEmail" class="col-sm-3 font_labels">Email<span
										class="required">*</span></label>

									<div class="col-sm-9">
										<input type="text" value="${user.getEmail()}" name="email"
											class="form-control edit_profileField" id="editEmail"
											readonly />
									</div>
								</div>

								<div class="form-group">
									<label for="editContactDetails" class="col-sm-3">Phone</label>
									<div class="col-sm-9">
										<input name="contactDetailsShown" type="tel" id="contactNumberShown"
										 placeholder="Mobile Number" class="form-control edit_profileField" value="${individual.getContactDetails()}">
										<input id="editContact" type="hidden" name="contactDetails" value="${individual.getContactDetails()}">

									</div>
								</div>

								<div class="form-group">
									<label for="editPersonalBio" class="col-sm-3">Personal
										Bio</label>
									<div class="col-sm-9">
										<input type="text" value="${individual.getPersonalBio()}"
											name="personalBio" class="form-control edit_profileField"
											id="editPersonalBio" />

									</div>
								</div>

								<div class="form-group">
									<label for="editMinHour" class="col-sm-3 font_labels">Min
										Hours<span class="required">*</span>
									</label>

									<div class="col-sm-9">
										<input type="number" required
											value="${individual.getMinimumVolunteerHours()}"
											name="minimumVolunteerHours"
											class="form-control edit_profileField" id="editMinHour" />
									</div>
								</div>

								<div class="form-group">
									<label for="editMaxHour" class="col-sm-3 font_labels">Max
										Hours<span class="required">*</span>
									</label>

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
						<div class="panel-heading font_labels">Skills</div>
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
						<div class="panel-heading font_labels">Experience</div>
						<div class="panel-body">
							<br> I have expertise in these Job Sectors: <br> <select
								required
								class="js-example-basic-single-jobsectorindividual-required"
								name="selected_jobsector1" id="jsIndi1Value"
								style="width: 49%; margin-bottom: 2rem;">

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
								style="width: 49%; display: inline; margin-bottom: 2rem;"
								class="form-control">


							<c:choose>
								<c:when test="${jobSectorIndividual2 != null }">
									<select
										class="js-example-basic-single-jobsectorindividual-optional"
										name="selected_jobsector2" id="jsIndi2aValue"
										style="width: 49%; margin-bottom: 2rem;">

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
										style="width: 49%; margin-bottom: 2rem;">

								</c:when>
								<c:otherwise>
									<select
										class="js-example-basic-single-jobsectorindividual-optional"
										name="selected_jobsector2" id="jsIndi2bValue"
										style="width: 49%; margin-bottom: 2rem;">
										<option value=""></option>
										<c:forEach items="${job_sector_list}" var="item">

											<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>

										</c:forEach>
									</select>
									<input type="number" id="js2experienceB"
										placeholder="Years of Experience"
										name="selected_jobsector2_years"
										style="width: 49%; display: inline; margin-bottom: 2rem;"
										class="form-control">

								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${jobSectorIndividual3 != null }">
									<select
										class="js-example-basic-single-jobsectorindividual-optional"
										name="selected_jobsector3" id="jsIndi3aValue"
										style="width: 49%; margin-bottom: 2rem;">
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
										style="width: 49%; display: inline; margin-bottom: 2rem;"
										class="form-control">

								</c:when>
								<c:otherwise>
									<select
										class="js-example-basic-single-jobsectorindividual-optional"
										name="selected_jobsector3" id="jsIndi3bValue"
										style="width: 49%; margin-bottom: 2rem;">

										<option value=""></option>
										<c:forEach items="${job_sector_list}" var="item">

											<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>

										</c:forEach>
									</select>
									<input type="number" id="js3experienceB"
										placeholder="Years of Experience"
										name="selected_jobsector3_years"
										style="width: 49%; display: inline; margin-bottom: 2rem;"
										class="form-control">

								</c:otherwise>
							</c:choose>

						</div>
					</div>
					<br> <br>

					<div class="panel panel-default">
						<div class="panel-heading">Interests</div>
						<div class="panel-body">
							I prefer to work in:<span class="required">*</span> <select
								class="js-example-basic-multiple-preferredcountries edit_profileField"
								multiple="multiple" name="selected_preferredcountries"
								id="preferredCountries"
								style="width: 100%; margin-bottom: 2rem;" required>

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

							</select> <br> Preferred Project Areas:<span class="required">*</span>
							<br> <select
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


							</select> <br> Preferred Job Sectors:<span class="required">*</span>
							<br> <select
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
										<div id="document_upload_button"
											class="document_upload_button" onclick="uploadFile()">Upload
											your documents</div>

										<div style='height: 0px; width: 0px; overflow: hidden;'>
											<input id=uploadFile name="documents" multiple type="file"
												value="upload" onchange="docSub(this)" />
										</div>
								</tr>
								</div>
							</table>
						</div>
					</div>

					<br>
					<div class="form-group">
						<div class="col-lg-12">
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
	<script src="<%=request.getContextPath()%>/resources/js/intlTelInput.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/intlTelInput.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/utils.js"></script>
	
	<script type="text/javascript" defer>
		function reloadPage() {
			location.reload();
		}

		function readURL(input) {
			if (input.files && input.files[0]) {

				var reader = new FileReader();
				reader.onload = function(e) {

					$('#blah').attr('src', e.target.result);

				};
				reader.readAsDataURL(input.files[0]);
				setTimeout(initCropper, 1000);
			}
		}
		function initCropper() {
			var image = document.getElementById('blah');
			var cropper = new Cropper(image, {
				aspectRatio : 1 / 1,
				crop : function(e) {
					//console.log(e.detail.x);
					//console.log(e.detail.y);
				}
			});

			document.getElementById('reset_button').addEventListener('click',
					function() {
						cropper.reset();
						cropper.clear();
						cropper.destroy();
						$('#blah').removeAttr('src');
						var clone = $('#blah').clone();
						$('#blah').remove();
						$('#image_container').append(clone);

						$('#cropped_result').children()[0].remove();
					})

			// On crop button clicked
			document
					.getElementById('crop_button')
					.addEventListener(
							'click',
							function() {
								var imgurl = cropper.getCroppedCanvas()
										.toDataURL();
								var img = document.createElement("img");
								img.src = imgurl;

								document.getElementById("cropped_result")
										.appendChild(img);
								document.getElementById("cropped_result").childNodes[0]
										.setAttribute(
												"style",
												"border-radius: 50%;width: 250px;display: flex;margin-left: auto;margin-right: auto;");
							})

			document.getElementById('confirm_button').addEventListener('click',
					function() {
						cropper.getCroppedCanvas().toBlob(function(blob) {
							var formData = new FormData();
							formData.append('profilePicture', blob);
							// Use `jQuery.ajax` method
							$.ajax('edit-individual-profile-pic', {
								method : "POST",
								data : formData,
								processData : false,
								contentType : false,
								success : function() {
									console.log('Upload success');
								},
								error : function() {
									console.log('Upload error');
								}
							});
						});
					})
		}
	</script>
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

			var dob = document.getElementById("editDob").value;
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

			var contactNumber = document.getElementById("contactNumberShown").value;

			if (contactNumber !== "") {
				if (contactNumber.indexOf(' ') >= 0){
					alert('Please do not enter spaces in your contact number.')
					return false;
				}
			}

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

					if (js1yearsOfEx > age) {
						alert('Your years of experience cannot be greater than your age.');
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

					if (js2yearsOfEx > age) {
						alert('Your years of experience cannot be greater than your age.');
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

					if (js2byearsOfEx > age) {
						alert('Your years of experience cannot be greater than your age.');
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

					if (js3ayearsOfEx > age) {
						alert('Your years of experience cannot be greater than your age.');
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

					if (js3byearsOfEx > age) {
						alert('Your years of experience cannot be greater than your age.');
						return false;
					}
				}
			}

			var job_sector_1;
			if (jsIndi1 !== null) {
				job_sector_1 = jsIndi1.value;
			}

			var job_sector_2;
			if (jsIndi2A === null) {
				job_sector_2 = jsIndi2B.value;
			} else {
				job_sector_2 = jsIndi2A.value;
			}

			var job_sector_3;
			if (jsIndi3A === null) {
				job_sector_3 = jsIndi3B.value;
			} else {
				job_sector_3 = jsIndi3A.value;
			}

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
			placeholder : "Select Your Skills*"
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
			
			var ctx = "${pageContext.request.contextPath}" + "resources/js/utils.js";
			
			$("#contactNumberShown").intlTelInput({
				autoPlaceholder : "aggressive",
				utilsScript : ctx,
				
			});
			
			$("form").submit(function() {
				  $("#editContact").val($("#contactNumberShown").intlTelInput("getNumber"));
			});
		});
	</script>
</body>
</html>