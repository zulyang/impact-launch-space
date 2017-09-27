<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Edit Organization Profile</title>
<link rel="icon" type="image/png"
	href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/profile/organization/edit_organization_profile.css" />
<link href="<%=request.getContextPath()%>/resources/css/cropper.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css">
<script src="<%=request.getContextPath()%>/resources/lib/cropper.min.js"></script>
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
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/intlTelInput.css">
</head>
<body class="profile">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">
				<!--navigation bar  -->
				<%@include file="../../common/navigation.jspf"%>


				<div class="edit_org_profile_display_container">
					<div class="panel panel-default">
						<div class="panel-heading">Edit Organization Profile Form</div>
						<div class="panel-body">
							<div class="required" style="float: right;">* fields are
								required</div>
							<div class="edit_org_picture_container">
								<img src="/imageDisplay?username=${username}"
									class="circle_edit_org_profile_image">
								<button type="button"
									class="btn btn-info btn-lg edit_org_picture_btn"
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
												<label for="editChooseOrgPic"
													class="btn btn-info edit_org_profile_save"> <i
													class="fa fa-picture-o" aria-hidden="true"
													style="font: none;"></i>&nbspChoose your profile picture
												</label> <input type="file" name="image" id="editChooseOrgPic"
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

							<form class="form-horizontal edit_org_profile_container"
								onsubmit="return checkFields();"
								action="editprofile-organization" method="post">
								
								<div class="form-group">
									<label for="editOrgName" class="col-sm-2">Company Name<span
										class="required">*</span></label>
									<div class="col-sm-10">
										<input type="text" id="editOrgName"
											class="form-control edit_profileField"
											value="${organization.getCompanyName()}" name="companyName">
									</div>
								</div>
								<div class="form-group">
									<label for="editOrgEmail" class="col-sm-2">Email<span
										class="required">*</span></label>
									<div class="col-sm-10">
										<input class="form-control edit_profileField"
											id="editOrgEmail" type="text" value="${user.getEmail()}"
											name="email" readonly>
									</div>
								</div>
								<div class="form-group">
									<label for="editOrgContact" class="col-sm-2">Contact
										Details</label>
									<div class="col-sm-10">
										<input name="contactDetailsShown" type="tel"
											id="contactNumberShown"
											class="form-control contactNumberShown"
											placeholder="Mobile Number"
											value="${organization.getContactDetails()}"> <input
											id="editOrgContact" type="hidden" name="contactDetails"
											value="${organization.getContactDetails()}">

									</div>
								</div>
								<div class="form-group">
									<label for="editOrgBio" class="col-sm-2">Company Bio</label>
									<div class="col-sm-10">
										<textarea id="editOrgBio" rows="4" name="companyBio"
											class="form-control edit_profileField"
											value="${organization.getCompanyBio()}">${organization.getCompanyBio()}
										</textarea>
									</div>
								</div>

								<div class="form-group">
									<label for="editCountry" class="col-sm-2">Countries Of
										Operation<span class="required">*</span>
									</label>
									<div class="col-sm-10">
										<select id="editCountry" style="width: 100%"
											class="js-example-basic-multiple edit_profileField"
											multiple="multiple" name="selected_countryofoperation"
											required>
											<c:forEach items="${country_list}" var="item">
												<p class="org_countries">
													<c:choose>
														<c:when
															test="${organization_countriesofoperation_list.contains(item.getCountry_name())}">
															<option value="${item.getCountry_name()}"
																selected="selected">${item.getCountry_name()}</option>
														</c:when>
														<c:otherwise>
															<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
														</c:otherwise>
													</c:choose>
												</p>
											</c:forEach>
										</select>
									</div>
								</div>

								<div class="form-group">
									<label for="editJobSectors" class="col-sm-2">Job
										Sectors<span class="required">*</span>
									</label>
									<div class="col-sm-10">
										<select id="editJobSectors" style="width: 100%"
											class="js-example-basic-multiple2 edit_profileField"
											multiple="multiple" name="selected_jobsectors" required>
											<c:forEach items="${job_sector_list}" var="item">
												<c:choose>
													<c:when
														test="${organization_jobsector_list.contains(item.getJob_sector())}">
														<option value="${item.getJob_sector()}"
															selected="selected">${item.getJob_sector()}</option>
													</c:when>
													<c:otherwise>
														<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
								</div>

								<div class="form-group">
									<div class="col-lg-12">
										<input class="btn btn-success edit_org_profile_save"
											type="submit" value="Update details" />
									</div>
								</div>


							</form>
						</div>
					</div>


				</div>
			</div>
		</div>
	</div>

	<script
		src="<%=request.getContextPath()%>/resources/js/intlTelInput.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/js/intlTelInput.min.js"></script>
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
							$.ajax('edit-organization-profile-pic', {
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
		function checkFields() {
			var contactNumber = document.getElementById("contactNumberShown").value;

			if (contactNumber.indexOf(' ') >= 0) {
				alert('Please do not enter spaces in your contact number.')
				return false;
			}
		}
	</script>

	<script type="text/javascript">
		$(".js-example-basic-multiple").select2({
			placeholder : "Select countries where you wish to be involved in"
		});
	</script>

	<script type="text/javascript">
		$(".js-example-basic-multiple2").select2({
			maximumSelectionLength : 3,
			placeholder : "Select Up to 3 Job Sectors"
		});
	</script>

	<script type="text/javascript">
		$(document).ready(
				function() {

					var ctx = "${pageContext.request.contextPath}"
							+ "resources/js/utils.js";

					$("#contactNumberShown").intlTelInput({
						autoPlaceholder : "aggressive",
						utilsScript : ctx,

					});

					$("form").submit(
							function() {
								$("#editOrgContact").val(
										$("#contactNumberShown").intlTelInput(
												"getNumber"));
							});
				});
	</script>
</body>
</body>
</html>
