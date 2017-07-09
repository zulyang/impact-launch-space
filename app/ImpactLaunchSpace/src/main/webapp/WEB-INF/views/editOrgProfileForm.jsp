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
					<!-- /.container-fluid -->
				</nav>

				<div class="edit_org_profile_display_container">
					<div class="panel panel-default">
						<div class="panel-heading">Edit Organisation Profile Form</div>
						<div class="panel-body">

							<div class="edit_org_pic" style="display: inline-block">
								<form action="editprofile-organization-profilepic" method="post"
									enctype="multipart/form-data">
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

							<form class="form-horizontal edit_org_profile_container"
								action="editprofile-organization" method="post">
								<div class="form-group">
									<label for="editOrgName" class="col-sm-2 control-label">Company
										Name</label>
									<div class="col-sm-10">
										<input type="text" id="editOrgName"
											class="form-control edit_profileField"
											value="${organization.getCompanyName()}" name="companyName">
									</div>
								</div>
								<div class="form-group">
									<label for="editOrgEmail" class="col-sm-2 control-label">Email</label>
									<div class="col-sm-10">
										<input class="form-control edit_profileField"
											id="editOrgEmail" type="text" value="${user.getEmail()}"
											name="email" readonly>
									</div>
								</div>
								<div class="form-group">
									<label for="editOrgContact" class="col-sm-2 control-label">Contact
										Details</label>
									<div class="col-sm-10">
										<input id="editOrgContact"
											class="form-control edit_profileField" type="text"
											value="${organization.getContactDetails()}"
											name="contactDetails">
									</div>
								</div>
								<div class="form-group">
									<label for="editOrgBio" class="col-sm-2 control-label">Company
										Bio</label>
									<div class="col-sm-10">
										<textarea id="editOrgBio" rows="4" type="text"
											name="companyBio" class="form-control edit_profileField"
											value="${organization.getCompanyBio()}">
										</textarea>
									</div>
								</div>


								<hr>
								<div class="org_profile_display_countries">

									<select class="js-example-basic-multiple" multiple="multiple"
										name="selected_countryofoperation" required>
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
								<div class="panel panel-default">
									<div class="panel-heading">Job Sectors</div>
									<div class="panel-body">
										<div class="org_profile_display_jobSectors">
											<select class="js-example-basic-multiple2"
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
								</div>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
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
