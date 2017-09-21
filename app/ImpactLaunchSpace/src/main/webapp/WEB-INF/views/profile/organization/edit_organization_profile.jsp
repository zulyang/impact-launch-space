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
<title>Edit Organization Profile</title>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/profile/organization/edit_organization_profile.css" />
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


				<div class="edit_org_profile_display_container">
					<div class="panel panel-default">
						<div class="panel-heading">Edit Organization Profile Form</div>
						<div class="panel-body">

							<div class="edit_org_pic" style="display: inline-block">
								<form action="edit-organization-profile-pic" method="post" enctype="multipart/form-data">
									<img src="/imageDisplay?username=${organization.getUsername()}"
										class="circle_edit_org_profile_image" height="64" width="64">

									<label for="editChooseOrgPic"
										class="form-control btn btn-info edit_org_profile_save">Choose
										A New Picture</label> <input
										style="display: inline-block; visibility: hidden;" type="file"
										name="profilePicture" id="editChooseOrgPic" /> <label
										for="editUploadOrgPic"
										class="form-control btn btn-info edit_org_profile_save">Upload</label>
									<input style="display: inline-block; visibility: hidden;"
										type="submit" value="Update picture" id="editUploadOrgPic" />
								</form>
							</div>

							<form class="form-horizontal edit_org_profile_container" onsubmit="return checkFields();" action="editprofile-organization" method="post">
								<div class="form-group">
									<label for="editOrgName" class="col-sm-2">Company
										Name</label>
									<div class="col-sm-10">
										<input type="text" id="editOrgName"
											class="form-control edit_profileField"
											value="${organization.getCompanyName()}" name="companyName">
									</div>
								</div>
								<div class="form-group">
									<label for="editOrgEmail" class="col-sm-2">Email</label>
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
										<input id="editOrgContact"
											class="form-control edit_profileField" type="text"
											value="${organization.getContactDetails()}"
											name="contactDetails">
									</div>
								</div>
								<div class="form-group">
									<label for="editOrgBio" class="col-sm-2">Company
										Bio</label>
									<div class="col-sm-10">
										<textarea id="editOrgBio" rows="4" name="companyBio"
											class="form-control edit_profileField"
											value="${organization.getCompanyBio()}">${organization.getCompanyBio()}
										</textarea>
									</div>
								</div>

								<div class="form-group">
									<label for="editCountry" class="col-sm-2">Countries
										Of Operation</label>
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
										Sectors</label>
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

	<script type="text/javascript">
		function checkFields() {
			var contactNumber = document.getElementById("editOrgContact").value;
			
			if (/^\d+$/.test(contactNumber) === false || contactNumber.length > 20) {
				alert('Please enter a maximum of 20 positive numbers for your phone number, without symbols and spaces.')
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
</body>
</html>
