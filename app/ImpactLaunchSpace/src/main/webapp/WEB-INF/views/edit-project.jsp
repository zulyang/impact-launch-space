<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Your Project</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<!--custom css codes -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/resource.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/project.css" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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

<script>
	$(function() {
		$("#accordion").accordion({
			collapsible : true,
			heightStyle : "content"
		});
		;
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
							<form action="edit-project" method="post">
								<input type="hidden" id="oldProjectTitle"
									value="${sample_project.getProject_name()}"
									name="oldProjectTitle" class="form-control">

								<div class="form-group row">
									<label for="projectTitle" class="col-sm-3 col-form-label">Title</label>
									<div class="col-sm-9">
										<input type="text" id="projectTitle"
											value="${sample_project.getProject_name()}"
											name="projectTitle" class="form-control">
									</div>
								</div>

								<div class="form-group row">
									<label for="projectPurpose" class="col-sm-3 col-form-label">Purpose</label>
									<div class="col-sm-9">
										<input type="text" id="projectPurpose"
											value="${sample_project.getPurpose()}" name="projectPurpose"
											class="form-control"
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
												<c:choose>
													<c:when
														test="${project_target_areas.contains(item.getProject_area())}">
														<option value="${item.getProject_area()}"
															selected="selected">${item.getProject_area()}</option>
													</c:when>
													<c:otherwise>
														<option value="${item.getProject_area()}">${item.getProject_area()}</option>
													</c:otherwise>
												</c:choose>

											</c:forEach>
										</select>
									</div>
								</div>

								<div class="form-group row">
									<label for="projectOwner" class="col-sm-3 col-form-label">Project
										Owner</label>
									<div class="col-sm-9" style="display: block; height: 34px;">
										<c:if
											test="${project.getOrganization() == null || project.getOrganization().equals(\"\")}">
											<input type="radio" id="radio_indi" value="individual"
												name="projectOwner" checked disabled />
										</c:if>

										<c:if
											test="${project.getOrganization() != null || project.getOrganization().equals(\"\")}">
											<input type="radio" id="radio_indi" value="individual"
												name="projectOwner" disabled />
										</c:if>
										Myself

										<c:if
											test="${project.getOrganization() == null || project.getOrganization().equals(\"\")}">
											<input type="radio" id="radio_org" value="organization"
												name="projectOwner" disabled />
										</c:if>

										<c:if
											test="${project.getOrganization() != null || project.getOrganization().equals(\"\")}">
											<input type="radio" id="radio_org" value="organization"
												name="projectOwner" checked disabled />
										</c:if>

										Organization
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
												<c:choose>
													<c:when
														test="${item.getCountry_name().equals(sample_project.getLocation())}">
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

								<div class="form-group row">
									<label for="projectDescription" class="col-sm-3 col-form-label">Project
										Description</label>
									<div class="col-sm-9">
										<input type="text" id="projectDescription"
											value="${ sample_project.getDescription()}"
											name="projectDescription" class="form-control"
											placeholder="A short summary of project">
									</div>
								</div>

								<div class="form-group row">
									<label for="projectPrivacy" class="col-sm-3 col-form-label">Project
										Privacy</label>
									<div class="col-sm-9" style="display: block; height: 34px;">
										<c:choose>
											<c:when test="${sample_project.isPublic() }">
												<input type="radio" id="projectPrivacy" value="public"
													checked name="projectPrivacy" />Public
										</c:when>
											<c:otherwise>
												<input type="radio" id="projectPrivacy" value="public"
													name="projectPrivacy" />Public
										</c:otherwise>
										</c:choose>

										<c:choose>
											<c:when test="${sample_project.isHiddenToAll() }">
												<input type="radio" id="projectPrivacy" value="hidden"
													checked name="projectPrivacy" /> Hide from All
										</c:when>
											<c:otherwise>
												<input type="radio" id="projectPrivacy" value="hidden"
													name="projectPrivacy" /> Hide from All
										</c:otherwise>
										</c:choose>

										<c:choose>
											<c:when test="${sample_project.isHiddenToOutsiders() }">
												<input type="radio" id="projectPrivacy" value="private"
													name="projectPrivacy" checked /> Hide from Outsiders
										</c:when>
											<c:otherwise>
												<input type="radio" id="projectPrivacy" value="private"
													name="projectPrivacy" /> Hide from Outsiders
										</c:otherwise>
										</c:choose>

									</div>
								</div>

								<div class="form-group row">
									<label for="projectDuration" class="col-sm-3 col-form-label">Estimated
										Duration</label>
									<div class="col-sm-9">
										<input type="number" id="projectDuration"
											value="${sample_project.getDuration() }"
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
											<option value=""></option>
											<c:forEach items="${user_list}" var="item">
												<c:choose>
													<c:when test="${project_ban_list.contains(item)}">
														<option value="${item}" selected="selected">${item}</option>
													</c:when>
													<c:otherwise>
														<c:if test="${item.equals(project_proposer) == false}">
															<option value="${item}">${item}</option>
														</c:if>
													</c:otherwise>
												</c:choose>

											</c:forEach>
										</select><br>
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
							<div class="form-group row">
								<nav class="navbar navbar-default query" role="query">
								<div class="container-fluid">
									<div class="collapse navbar-collapse" id="">
										<button type="button" id="addResource"
											class="btn btn-success create pull-right">
											<i class="fa fa-plus-circle"></i> Add resource
										</button>
									</div>

								</div>
								</nav>
								<div class="table-responsive col-md-12">
									<table width="100%" border="0" cellspacing="0" cellpadding="5"
										id="resourcesNeeded" class="table table-striped table-hover">
										<thead>
											<tr>
												<th>Resource Name</th>
												<th>Resource Description</th>
												<th>Category</th>
												<th>Actions</th>
											</tr>
										</thead>
										<tbody id="resourceTableBody">
											<%
												int id = 0;
											%>
											<c:forEach items="${project_requested_resources}" var="item"
												varStatus="loop">
												<tr id="resourceRow<%=++id%>">
													<td><input class="editable-field form-control"
														id="reso<%=id %>" type="text"
														value="${item.getResource_name()}" disabled="true" /></td>
													<td><input class="editable-field form-control"
														id="desc<%=id %>" type="textarea"
														value="${item.getRequest_description()}" disabled="true" />
													</td>
													<td>
													<select id="resourceCategory<%=id%>"
														name="resourceCategory"
														class="col-md-4 resourceCategory" style="width:20rem;">
															<option></option>
															<c:forEach items="${resource_category_list}" var="item1">
																<option value="${item1.getSkillset()}">${item1.getSkillset()}</option>
															</c:forEach>
													</select> 
													<span class="label label-success"
														id="currentResourceCategory<%=id%>">${item.getResource_category()}</span>
													</td>
													<td class="col-md-2">
														<button id="edit<%=id%>" type="button"
															class="btn btn-primary manage-edit-button"
															onClick="edit(this.id)">
															<i class="fa fa-pencil"></i>Edit
														</button>
														<button id="save<%=id%>" type="button"
															onClick="save(this.id)" class="btn btn-success save"
															href="#">
															<i class="fa fa-save"></i>Save
														</button>
														<button id="dele<%=id%>" onClick="deleteRow(this.id)"
															type="button" class="btn btn-danger delete" href="#">
															<i class="fa fa-trash"></i> Delete
														</button>
														<button id="canc<%=id%>" onClick="cancel(this.id)"
															type="button" class="btn btn-default cancel" href="#">
															<i class="fa fa-close"></i>Cancel
														</button>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>

					</div>
					<hr>
					<button class="btn btn-block btn-success" onclick="return confirmSubmit();" type="submit">Update
						Project</button>
				</div>
				</form>


			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
	              $('.resourceCategory').hide();
		});
	</script>

	<script>
		function confirmSubmit() {
			if (confirm("Are you sure you want to save changes?") == true) {
		        return true;
		    } else {
		        return false;
		    }
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
		$('#addResource').on(
				'click',
				function() {
					var totalRows = $('#resourceTableBody tr').length;
					console.log("table rows: " + totalRows);
					var lastRow = totalRows + 1;
					
					$('#resourceTableBody tr:last').after('<tr id="resourceRow<%=++id%>"><td><input class="editable-field form-control"id="reso'+lastRow+'" type="text" disabled="true" /></td><td><input class="editable-field form-control"id="desc'+lastRow+'" type="textarea" disabled="true" /></td><td><select id="resourceCategory'+lastRow+'"name="resourceCategory"class="col-md-4 resourceCategory" style="width:20rem;"><option></option><c:forEach items="${resource_category_list}" var="item1"><option value="${item1.getSkillset()}">${item1.getSkillset()}</option></c:forEach></select><span class="label label-success"id="currentResourceCategory'+lastRow+'">${item.getResource_category()}</span></td><td class="col-md-2"><button id="edit'+lastRow+'" type="button"class="btn btn-primary manage-edit-button"onClick="edit(this.id)"><i class="fa fa-pencil"></i>Edit</button><button id="save'+lastRow+'" type="button"onClick="save(this.id)" class="btn btn-success save"href="#"><i class="fa fa-save"></i>Save</button><button id="dele'+lastRow+'" onClick="deleteRow(this.id)"type="button" class="btn btn-danger delete" href="#"><i class="fa fa-trash"></i> Delete</button><button id="canc'+lastRow+'" onClick="cancel(this.id)"type="button" class="btn btn-default cancel" href="#"><i class="fa fa-close"></i>Cancel</button></td></tr>');
					
					$('#reso' + lastRow).prop('disabled', false);
					$('#desc' + lastRow).prop('disabled', false);
					$('#edit' + lastRow).hide();
					$('#dele' + lastRow).hide();
					$('#save' + lastRow).show();
					$('#canc' + lastRow).show();
					$('#resourceCategory' + lastRow).show();	
					$('#currentResourceCategory' + lastRow).hide();
				});

		function edit(id) {
			var disabledStatus = $('.editable-field').attr('disabled');
			console.log("disabledstatus: " + disabledStatus);
			var newId = id.substring(4);

			console.log("id: " + id);
			console.log("newId: " + newId);

			var toShow = '#resourceCategory' + newId;
			console.log("toShow: " + toShow);

			$('#reso' + newId).prop('disabled', false);
			$('#desc' + newId).prop('disabled', false);
			$('#edit' + newId).hide();
			$('#dele' + newId).hide();
			$('#save' + newId).show();
			$('#canc' + newId).show();
			$('#resourceCategory' + newId).show();
			$('#currentResourceCategory' + newId).hide();
		};

		function save(id) {
			var disabledStatus = $('.editable-field').attr('disabled');
			var newId = id.substring(4);
			console.log("id: " + newId);

			$('#reso' + newId).prop('disabled', true);
			$('#desc' + newId).prop('disabled', true);
			$('#edit' + newId).show();
			$('#dele' + newId).show();
			$('#save' + newId).hide();
			$('#canc' + newId).hide();
			
			var newlyAddedResourceCat = document.getElementById("resourceCategory" + newId);
			console.log("newlyAddedResourceCat: " + newlyAddedResourceCat);
			if (newlyAddedResourceCat !== null) {
				console.log("newlyAddedResourceCat: " + newlyAddedResourceCat.value);
				var currentResourceCategory = $('#currentResourceCategory' + newId);
				currentResourceCategory.text('');
				currentResourceCategory.text(newlyAddedResourceCat.value);
			}
			
			$('#resourceCategory' + newId).hide();
			$('#currentResourceCategory' + newId).show();
		};

		function cancel(id) {
			var disabledStatus = $('.editable-field').attr('disabled');
			var newId = id.substring(4);

			console.log("id: " + newId);
			var toHide = '#resourceCategory' + newId;
			console.log("toHide: " + toHide);

			$('#reso' + newId).prop('disabled', true);
			$('#desc' + newId).prop('disabled', true);
			$('#edit' + newId).show();
			$('#dele' + newId).show();
			$('#save' + newId).hide();
			$('#canc' + newId).hide();
			$('#resourceCategory' + newId).hide();
			$('#currentResourceCategory' + newId).show();
		}

		function deleteRow(id) {
			var newId = id.substring(4);
			$('#resourceRow' + newId).hide();
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
		$(".js-example-basic-single-organization").select2({
			placeholder : "Select an organization: "
		});
	</script>

	<script type="text/javascript">
		$(".js-example-basic-single-resourcecategory").select2({
			placeholder : "Select an expertise/category: ",
			allowClear : true
		});
	</script>

</body>

</html>