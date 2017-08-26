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

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/resource.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/project/project.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css">
<script src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<link href="<%=request.getContextPath()%>/resources/lib/select2/select2.min.css" rel="stylesheet" />
<script src="<%=request.getContextPath()%>/resources/lib/select2/select2.min.js"></script>

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
				<%@include file="../common/navigation.jspf"%>

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
										<input type="text" id="projectTitle" required
											value="${sample_project.getProject_name()}"
											name="projectTitle" readonly class="form-control">
									</div>
								</div>

								<div class="form-group row">
									<label for="projectPurpose" class="col-sm-3 col-form-label">Purpose</label>
									<div class="col-sm-9">
										<input type="text" id="projectPurpose" required
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
											multiple="multiple" name="selected_projectareas" style= "width: 100%" required>
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
											test="${sample_project.getOrganization() == null || sample_project.getOrganization().equals(\"\")}">
											<input type="radio" id="radio_indi" value="individual"
												name="projectOwner" checked disabled />
										</c:if>

										<c:if
											test="${sample_project.getOrganization() != null || sample_project.getOrganization().equals(\"\")}">
											<input type="radio" id="radio_indi" value="individual"
												name="projectOwner" disabled />
										</c:if>
										Myself

										<c:if
											test="${sample_project.getOrganization() == null || sample_project.getOrganization().equals(\"\")}">
											<input type="radio" id="radio_org" value="organization"
												name="projectOwner" disabled />
										</c:if>

										<c:if
											test="${sample_project.getOrganization() != null || sample_project.getOrganization().equals(\"\")}">
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
										<textarea id="projectDescription"
											value="${ sample_project.getDescription()}"
											name="projectDescription" class="form-control"
											placeholder="A short summary of project">${ sample_project.getDescription()}</textarea>
									</div>
								</div>

								<div class="form-group row">
									<label for="projectPrivacy" class="col-sm-3 col-form-label">Project
										Privacy</label>
									<div class="col-sm-9" style="display: block; height: 34px;">
										<c:choose>
											<c:when test="${sample_project.isPublic() }">
												<input type="radio" id="projectPrivacy" value="public"
													required checked name="projectPrivacy" />Public
										</c:when>
											<c:otherwise>
												<input type="radio" id="projectPrivacy" value="public"
													required name="projectPrivacy" />Public
										</c:otherwise>
										</c:choose>

										<c:choose>
											<c:when test="${sample_project.isHiddenToAll() }">
												<input type="radio" id="projectPrivacy" value="hidden"
													required checked name="projectPrivacy" /> Hide from All
										</c:when>
											<c:otherwise>
												<input type="radio" id="projectPrivacy" value="hidden"
													required name="projectPrivacy" /> Hide from All
										</c:otherwise>
										</c:choose>

										<c:choose>
											<c:when test="${sample_project.isHiddenToOutsiders() }">
												<input type="radio" id="projectPrivacy" value="private"
													required name="projectPrivacy" checked /> Hide from Outsiders
										</c:when>
											<c:otherwise>
												<input type="radio" id="projectPrivacy" value="private"
													required name="projectPrivacy" /> Hide from Outsiders
										</c:otherwise>
										</c:choose>

									</div>
								</div>

								<div class="form-group row">
									<label for="projectDuration" class="col-sm-3 col-form-label">Estimated
										Duration</label>
									<div class="col-sm-9">
										<input type="number" required id="projectDuration"
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
											multiple="multiple" name="selected_banlist"  style= "width: 100%">
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
										<button onClick="return add();" type="button" id="addResource"
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
														value="${item.getResource_name()}" required disabled="true" /> 
														<input
														type="hidden" id="old_reso<%=id %>"
														value="${item.getResource_name()}" /></td>
													<td><input required class="editable-field form-control"
														id="desc<%=id %>" type="textarea"
														value="${item.getRequest_description()}" disabled="true" />
														<input type="hidden" id="old_desc<%=id %>"
														value="${item.getRequest_description()}" /></td>
													<td>
													<select required id="resourceCategory<%=id%>"
														name="resourceCategory" class="col-md-4 resourceCategory"
														style="width: 20rem;">
															<option></option>
															<c:forEach items="${resource_category_list}" var="item1">
																<c:choose>
																	<c:when test="${item1.getSkillset().equals(item.getResource_category()) }">
																		<option value="${item1.getSkillset()}" selected = "selected">${item1.getSkillset()}</option>
																	</c:when>
																	<c:otherwise>
																		<option value="${item1.getSkillset()}">${item1.getSkillset()}</option>
																	</c:otherwise>
																</c:choose>
																
															</c:forEach>
													</select> 
													<span class="label label-success"
														id="currentResourceCategory<%=id%>">${item.getResource_category()}</span>
														<input type="hidden" id="old_rc<%=id%>"
														value="${item.getResource_category()}" /></td>
													<td class="col-md-2">
														<button id="edit<%=id%>" type="button"
															class="btn btn-primary manage-edit-button"
															onClick="edit(this.id)">
															<i class="fa fa-pencil"></i>Edit
														</button>
														<button id="save<%=id%>" type="button"
															onClick="return save(this.id);" class="btn btn-success save"
															href="#">
															<i class="fa fa-save"></i>Save
														</button>
														<button id="dele<%=id%>" onClick="return deleteRow(this.id);"
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
					<button class="btn btn-block btn-success"
						onclick="return confirmSubmit();" type="submit">Update
						Project</button>
				</div>
				</form>


			</div>
		</div>

		<div class="modal fade" tabindex="-1" role="dialog" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<form action="addProjectResource" role="form" method="post">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title">Add New Resource(s)</h4>
						</div>
						<div class="modal-body">
							<div class="container">
								<div id="resourcesNeeded" class="form-group row col-md-5">
									<div class="col-md-12">
										<select required id="modalResourceCategory"
											name="modalResourceCategory" style="width: 100%;"
											class="col-md-4 form-control">
											<option value="" disabled selected>Select an expertise/category:</option>
											<c:forEach items="${resource_category_list}" var="item">
												<option value="${item.getSkillset()}">${item.getSkillset()}</option>
											</c:forEach>
										</select> <input required id="modalResourceName" name="modalResourceName"
											class="form-control col-md-4 create-project-add"
											placeholder="What resources do you need?" type="text" />
										<textarea required id="modalResourceDescription"
											name="modalResourceDescription"
											class="form-control col-md-4 create-project-add"
											placeholder="Describe your resource here..."></textarea>
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Cancel</button>
							<button type="button" onclick="return addResource();" id="add" class="btn btn-success">Add</button>
						</div>
					</form>
				</div>
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

		if (userType === "org") {
			document.getElementById("radio_org").checked = true;
			document.getElementById("radio_indi").disabled = true;
		}

		var indiOrg = document.getElementById("indiOrg").value;

		if (userType === "indi" && indiOrg === "") {
			document.getElementById("radio_indi").checked = true;
			document.getElementById("radio_org").disabled = true;
		}
	</script>

	<script>
		function addResource() {						
						var resourceCategory = $('#modalResourceCategory').val();
						var resourceName = $('#modalResourceName').val();
						var resourceDescription = $('#modalResourceDescription').val();
						var oldProjectTitle = $('#oldProjectTitle').val();
						
						if(resourceCategory === "" || resourceName === "" || resourceDescription === "") {
							alert("Please fill up all the fields.");
							return false;
						}
						
						var newId = $('#resourceTableBody tr').length + 1;
						$('#resourceTableBody').append(
								'<tr id="resourceRow'+newId+'"> <td><p><input class="editable-field form-control" id="reso'+newId+'" type="text"value="'+resourceName+'" required disabled="true" /> <input type="hidden" id="old_reso'+newId+'" value="'+resourceName+'"/></p></td> <td><p> <input required class="editable-field form-control" style="border: 1px solid transparent;background-color: transparent;" id="desc'+newId+'" type="textarea"value="'+resourceDescription+'" disabled="true" /> <input type="hidden" id="old_desc'+newId+'" value="'+resourceDescription+'"/></p></td> <td><p> <input type="hidden" id="old_rc'+newId+'" value="'+resourceCategory+'"/> <select required id="resourceCategory'+newId+'"name="resourceCategory"class="col-md-4 js-example-basic-single-resourcecategory resourceCategory"> <option></option> <c:forEach items="${resource_category_list}" var="item"> <c:choose><c:when test="${item.getSkillset().equals('+resourceCategory+')}"> <option value="${item.getSkillset()}"selected="selected">${item.getSkillset()}</option> </c:when> <c:otherwise> <option value="${item.getSkillset()}">${item.getSkillset()}</option> </c:otherwise> </c:choose> </c:forEach> </select> <span class="label label-success"id="currentResourceCategory'+newId+'">'+resourceCategory+'</span> </p></td> <td class="col-md-2"><p> <button id="edit'+newId+'" type="btn" name="edit"class="btn btn-primary edit" onClick="edit(this.id)"href="#"> <i class="fa fa-pencil"></i> Edit </button> <button id="save'+newId+'" type="button" name="save"class="btn btn-success save" onClick="return save(this.id);"href="#"> <i class="fa fa-save"></i> Save </button> <button id="dele'+newId+'" type="submit" name="delete"class="btn btn-danger delete" onClick="return deleteRow(this.id);" href="#"> <i class="fa fa-trash"></i> Delete </button> <button id="canc'+newId+'" type="btn" name="cancel"class="btn btn-default cancel" onClick="cancel(this.id)"href="#"> <i class="fa fa-close"></i> Cancel </button> </p></td></tr>');
							
						$.post('addProjectResource',{
							modalResourceCategory : resourceCategory,
							modalResourceName : resourceName,
							modalResourceDescription : resourceDescription,
							oldProjectTitle : oldProjectTitle
						});
	
						$('#myModal').modal('hide');
						$('.resourceCategory').hide();	
	
		$('#myModal').on(
				'hidden.bs.modal',
				function() {
					$(this).find("input,textarea,select").val('').change();
				});
		return true;
	};
	</script>

	<script type="text/javascript">
		function add() {			
			$('#myModal').modal('show');
		};

		function edit(id) {
			var newId = id.substring(4);

			var toShow = '#resourceCategory' + newId;

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
			var oldId = id.substring(4);
			
			var resoCat = $('#resourceCategory'+oldId).val();
			var resoName = $('#reso'+oldId).val();
			var resoDesc = $('#desc'+oldId).val();
			
			if(resoCat === "" || resoName === "" || resoDesc === "") {
				alert("Please fill up all the fields.");
				return false;
			}

			$('#reso' + oldId).prop('disabled', true);
			$('#desc' + oldId).prop('disabled', true);
			$('#edit' + oldId).show();
			$('#dele' + oldId).show();
			$('#save' + oldId).hide();
			$('#canc' + oldId).hide();
			
			var newlyAddedResourceCat = document.getElementById("resourceCategory" + oldId);
		      if (newlyAddedResourceCat !== null) {
		        var currentResourceCategory = $('#currentResourceCategory' + oldId); 
		        currentResourceCategory.text(''); 
		        currentResourceCategory.text(newlyAddedResourceCat.value); 
		      } 
			
			$('#resourceCategory' + oldId).hide();
			$('#currentResourceCategory' + oldId).show();

			var resourceCategory = $('#resourceCategory' + oldId).val();
			var resourceName = $('#reso' + oldId).val();
			var resourceDescription = $('#desc' + oldId).val();
			var oldResourceCategory = $('#old_rc' + oldId).val();
			var oldResourceName = $('#old_reso' + oldId).val();
			var oldResourceDescription = $('#old_desc' + oldId).val();
			var oldProjectTitle = $('#oldProjectTitle').val();
			
			$.post('saveProjectResource',{
				resourceCategory : resourceCategory,
				resourceName : resourceName,
				resourceDescription :resourceDescription,
				oldResourceCategory :oldResourceCategory,
				oldResourceName : oldResourceName,
				oldResourceDescription : oldResourceDescription,
				oldProjectTitle : oldProjectTitle
			});
			
			$("#row" + oldId).hide();
			
			var newId = $('#resourceTableBody tr').length + 1;
			 
			$('tr#row' + oldId).after(
					'<tr id="resourceRow'+newId+'"> <td><p><input required class="editable-field form-control" id="reso'+newId+'" type="text"value="'+resourceName+'" disabled="true" /> <input type="hidden" id="old_reso'+newId+'" value="${uro.getResourceName()}"/></p></td> <td><p> <input class="editable-field form-control" style="border: 1px solid transparent;background-color: transparent;" required id="desc'+newId+'" type="textarea"value="'+resourceDescription+'" disabled="true" /> <input type="hidden" id="old_desc'+newId+'" value="'+resourceDescription+'"/></p></td> <td><p> <input type="hidden" id="old_rc'+newId+'" value="'+resourceCategory+'"/> <select id="resourceCategory'+newId+'"name="resourceCategory" required class="col-md-4 js-example-basic-single-resourcecategory resourceCategory"> <option></option> <c:forEach items="${resource_category_list}" var="item"> <c:choose> <c:when test="${item.getSkillset().equals('+resourceCategory+')}"> <option value="${item.getSkillset()}"selected="selected">${item.getSkillset()}</option> </c:when> <c:otherwise> <option value="${item.getSkillset()}">${item.getSkillset()}</option> </c:otherwise> </c:choose> </c:forEach> </select> <span class="label label-success"id="currentResourceCategory'+newId+'">'+resourceCategory+'</span> </p></td> <td class="col-md-2"><p> <button id="edit'+newId+'" type="btn" name="edit"class="btn btn-primary edit" onClick="edit(this.id)"href="#"> <i class="fa fa-pencil"></i> Edit </button> <button id="save'+newId+'" type="button" name="save"class="btn btn-success save" onClick="return save(this.id);"href="#"> <i class="fa fa-save"></i> Save </button> <button id="dele'+newId+'" type="submit" name="delete"class="btn btn-danger delete" onClick="return deleteRow(this.id);"href="#"> <i class="fa fa-trash"></i> Delete </button> <button id="canc'+newId+'" type="btn" name="cancel"class="btn btn-default cancel" onClick="cancel(this.id)"href="#"> <i class="fa fa-close"></i> Cancel </button> </p></td></tr>');
			$('.resourceCategory').hide();
			
			$('#resourceCategory' + newId).val(resourceCategory);
			$('#currentResourceCategory' + newId).val(resourceCategory);
			$('#old_rc' + newId).val(resourceCategory);
			$('#old_reso' + newId).val(resourceName);
			$('#old_desc' + newId).val(resourceDescription);

			$('#resourceCategory' + newId).hide();
			$('#currentResourceCategory' + newId).show();

			return true;
		};

		function cancel(id) {
			var disabledStatus = $('.editable-field').attr('disabled');
			var newId = id.substring(4);
			var toHide = '#resourceCategory' + newId;

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
			if (confirm("Are you sure you want to delete this resource?") == true) {
				var newId = id.substring(4);
				var resourceCategory = $('#old_rc' + newId).val();
				var resourceName = $('#reso' + newId).val();
				var resourceDescription = $('#desc' + newId).val();
				var oldProjectTitle = $('#oldProjectTitle').val();
				$.post('deleteProjectResource', {
					resourceCategory : resourceCategory,
					resourceName : resourceName,
					resourceDescription : resourceDescription,
					oldProjectTitle : oldProjectTitle
				});
				
				$('#resourceRow' + newId).hide();
				
				return true;
			} else {
				return false;
			}
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