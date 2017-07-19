<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create New Project</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<!--custom css codes -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/bootstrap-tagsinput.css" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
	integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
	crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!--for multiple select (Select2)-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/bootstrap-tagsinput.js"></script>

<script>
	$(function() {
		$("#accordion").accordion({
			collapsible : true,
			heightStyle : "content"
		});
	});
</script>
</head>
<body class="project">

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<!--navigation bar  -->
				<%@include file="common/navigation.jspf"%>

				<div class="create-project-container">
					<div id="accordion">
						<h3>Basic Info</h3>
						<div>
							<form action="create-project" method="post">
								<div class="form-group row">
									<label for="projectTitle" class="col-sm-3 col-form-label">Title</label>
									<div class="col-sm-9">
										<input type="text" id="projectTitle" value=""
											name="projectTitle" class="form-control">
									</div>
								</div>

								<div class="form-group row">
									<label for="projectPurpose" class="col-sm-3 col-form-label">Purpose</label>
									<div class="col-sm-9">
										<input type="text" id="projectPurpose" value=""
											name="projectPurpose" class="form-control"
											placeholder="Your project purpose in one line">
									</div>
								</div>

								<div class="form-group row">
									<label for="socialImpactType" class="col-sm-3 col-form-label">Social
										Impact Type</label>
									<div class="col-sm-9">
										<select class="js-example-basic-multiple-targetprojectareas"
											multiple="multiple" name="selected_projectareas" required>
											<c:forEach items="${project_area_list}" var="item">
												<option value="${item.getProject_area()}">${item.getProject_area()}</option>
											</c:forEach>
										</select>



									</div>
								</div>

								<div class="form-group row">
									<label for="projectOwner" class="col-sm-3 col-form-label">Project
										Owner</label>
									<div class="col-sm-9" style="display: block; height: 34px;">
										<input type="radio" id="radio_indi" value="individual"
											name="projectOwner" /> Myself <input type="radio"
											id="radio_org" value="organization" name="projectOwner" />
										Organization <input type="hidden" id="userType"
											name="userType" value="${user_type}"> <input
											type="hidden" id="indiOrg" name="indiOrg" value="${indi_org}">
									</div>
								</div>

								<div class="form-group row">
									<label for="projectLocation" class="col-sm-3 col-form-label">Project
										Location</label>
									<div class="col-sm-9">
										<select class="js-example-basic-single-projectlocation"
											name="projectLocation" required>
											<option></option>
											<c:forEach items="${country_list}" var="item">
												<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
											</c:forEach>
										</select>
									</div>
								</div>

								<div class="form-group row">
									<label for="projectDescription" class="col-sm-3 col-form-label">Project
										Description</label>
									<div class="col-sm-9">
										<input type="text" id="projectDescription" value=""
											name="projectDescription" class="form-control"
											placeholder="A short summary of project">
									</div>
								</div>

								<div class="form-group row">
									<label for="projectPrivacy" class="col-sm-3 col-form-label">Project
										Privacy</label>
									<div class="col-sm-9" style="display: block; height: 34px;">
										<input type="radio" id="projectPrivacy" value="public"
											name="projectPrivacy" /> Public <input type="radio"
											id="projectPrivacy" value="hidden" name="projectPrivacy" />
										Hide from All <input type="radio" id="projectPrivacy"
											value="private" name="projectPrivacy" /> Hide from Outsiders
									</div>
								</div>

								<div class="form-group row">
									<label for="projectDuration" class="col-sm-3 col-form-label">Estimated
										Duration</label>
									<div class="col-sm-9">
										<input type="number" id="projectDuration" value=""
											name="projectDuration" class="form-control"
											placeholder="Number of days">
									</div>
								</div>


								<div class="form-group row">
									<label for="projectBanList" class="col-sm-3 col-form-label">Ban
										List</label>
									<div class="col-sm-9">
										<select class="js-example-basic-multiple-banlistusers"
											multiple="multiple" name="selected_banlist">
											<c:forEach items="${user_list}" var="item">
												<c:if test="${item.equals(username) == false}">
													<option value="${item}">${item}</option>
												</c:if>
											</c:forEach>
										</select> <br>
									</div>
								</div>

								<br> <br>
						</div>
						<h3>Story</h3>
						<div>
							<div class="form-group row">
								<label for="projectVideo" class="col-sm-3 control-label">Project
									Video</label>
								<div class="col-sm-9">
									<button type="btn" class="btn btn-info" value="submit">Upload
										a video</button>
								</div>
							</div>

							<div class="form-group row ">
								<label for="projectDocuments" class="col-sm-3 col-form-label">Project
									Documents</label>
								<div class="col-sm-9">
									<button type="btn" class="btn btn-info" value="submit">Upload
										documents</button>
								</div>
							</div>
						</div>
						<h3>What I Need</h3>
						<div>
							<div id="resourcesNeeded" class="form-group row col-sm-9">
								<div>
									<select id="cat1" name="cat1">
										<option></option>
										<c:forEach items="${resource_category_list}" var="item">
											<option value="${item.getSkillset()}">${item.getSkillset()}</option>
										</c:forEach>
									</select> <input id="resource1" name="resource1"
										placeholder="What resources do you need?" type="text" />
									<textarea id="description1" name="description1"
										placeholder="Describe your resource here..."></textarea>
								</div>
							</div>

							<div class="col-sm-9">
								<input id="addResource" class="btn btn-info" type="button"
									value="Add Resource" />
							</div>
						</div>
					</div>

				</div>
				<button class="btn btn-block btn-success" type="submit">Create
					Project</button>
			</div>
			</form>
		</div>
	</div>
	</div>

	<script type="text/javascript">
		function checkInput() {
			var info = $("#resourceTags1").val();
			if (info === "") {
				console.log("info is blank");
			}
			console.log("info: " + info);
		}

		$('#addResource').on(
				'click',
				function() {
					var lastRow = $('#resourcesNeeded').closest(
							'#resourcesNeeded').find("div:last-child");
					console.log("lastRow: " + lastRow);
					var lastRowInputs = lastRow.find('input');
					var isClone = false;
					lastRowInputs.each(function() {
						if ($(this).val().length) {
							isClone = true;
						}
					});
					if (!isClone)
						return false;
					console.log("isClone is true");
					var cloned = lastRow.clone();
					cloned.find('input, select, textarea').each(
							function() {
								var id = $(this).attr('id');
								console.log("id: " + id);
								var regIdMatch = /^(.+)(\d+)$/;
								var aIdParts = id.match(regIdMatch);
								var newId = aIdParts[1]
										+ (parseInt(aIdParts[2], 10) + 1);

								$(this).attr('id', newId);
								$(this).attr('name', newId);
							});

					cloned.find("input[type='text']").val('');
					cloned.find("select").val('');
					cloned.find("textarea").val('');
					cloned.insertAfter(lastRow);
				});
	</script>

	<script>
		function checkResourceFields() {
			var category = document.getElementById("category1");
			var resource = document.getElementById("resource1");
			console.log(category.value);
			console.log(resource.value);

			if (category.value === "" || resource.value === "") {
				console.log("blank");
				alert("Please fill in all resource fields!");
				return false;
			}

			return true;
		}
	</script>

	<script>
		var userType = document.getElementById("userType").value;
		console.log(userType);

		if (userType === "org") {
			document.getElementById("radio_org").checked = true;
			document.getElementById("radio_indi").disabled = true;
		}

		var indiOrg = document.getElementById("indiOrg").value;
		console.log(indiOrg);

		if (userType === "indi" && indiOrg === "") {
			document.getElementById("radio_indi").checked = true;
			document.getElementById("radio_org").disabled = true;
		}
	</script>

	<script type="text/javascript">
		$(".js-example-basic-multiple-targetprojectareas").select2({
			maximumSelectionLength : 3,
			placeholder : "Where do you want to make a difference?"
		});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".js-example-basic-single-projectlocation").select2({
				placeholder : "Select a country:"
			});
		});
	</script>

	<script type="text/javascript">
		$(".js-example-basic-multiple-banlistusers").select2({
			placeholder : "Search for username : "
		});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".js-example-basic-single-organization").select2({
				placeholder : "Select an organization: "
			});
		});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".js-example-basic-single-resourcecategory").select2({
				placeholder : "Select an expertise/category: ",
				allowClear : true
			});
		});
	</script>
</body>



</html>