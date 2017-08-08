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
	href="<%=request.getContextPath()%>/resources/css/project.css" />
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
<script src="<%=request.getContextPath()%>/resources/js/project.js"></script>

<!--for multiple select (Select2)-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/bootstrap-tagsinput.js"></script>

</head>
<body class="project">

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<!--navigation bar  -->
				<%@include file="common/navigation.jspf"%>

				<div class="create-project-container">

					<div id="rootwizard" class="wizard">
						<div class="wizard-inner">
							<div class="connecting-line"></div>
							<ul class="nav nav-tabs" role="tablist">

								<li role="presentation" class="active"><a href="#step1"
									data-toggle="tab" aria-controls="step1" role="tab"
									title="Basic Information"> <span class="round-tab">
											<i class="glyphicon glyphicon-folder-open"></i>
									</span>
								</a></li>

								<li role="presentation" class="disabled"><a href="#step2"
									data-toggle="tab" aria-controls="step2" role="tab"
									title="Story"> <span class="round-tab"> <i
											class="glyphicon glyphicon-film	"></i>
									</span>
								</a></li>
								<li role="presentation" class="disabled"><a href="#step3"
									data-toggle="tab" aria-controls="step3" role="tab"
									title="Resources"> <span class="round-tab"> <i
											class="glyphicon glyphicon-user"></i>
									</span>
								</a></li>

								<li role="presentation" class="disabled"><a
									href="#complete" data-toggle="tab" aria-controls="complete"
									role="tab" title="Complete"> <span class="round-tab">
											<i class="glyphicon glyphicon-ok"></i>
									</span>
								</a></li>
							</ul>
						</div>

						<form action="create-project" method="post">
							<input type="submit" id="createProject" style="display: none" />
							<div class="tab-content">
								<div class="tab-pane active" role="tabpanel" id="step1">
									<h3>Step 1</h3>
									<p>Fill in basic information of new project</p>
									<div class="form-group row">
										<label for="projectTitle" class="col-sm-3 col-form-label">Title</label>
										<div class="col-sm-9">
											<input required type="text" id="projectTitle"
												name="projectTitle" class="form-control">
										</div>
									</div>

									<div class="form-group row">
										<label for="projectPurpose" class="col-sm-3 col-form-label">Purpose</label>
										<div class="col-sm-9">
											<input required type="text" id="projectPurpose"
												name="projectPurpose" class="form-control"
												placeholder="Your project purpose in one line">
										</div>
									</div>

									<div class="form-group row">
										<label for="socialImpactType" class="col-sm-3 col-form-label">Social
											Impact Type</label>
										<div class="col-sm-9">
											<select required id="socialImpact"
												class="js-example-basic-multiple-targetprojectareas create-new-project-select2 form-control"
												multiple="multiple" name="selected_projectareas">
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
											<input required type="radio" id="radio_indi"
												value="individual" name="projectOwner" /> Myself <input
												required type="radio" id="radio_org" value="organization"
												name="projectOwner" /> Organization <input required
												type="hidden" id="userType" name="userType"
												value="${user_type}"> <input type="hidden"
												id="indiOrg" name="indiOrg" value="${indi_org}">
										</div>
									</div>

									<div class="form-group row">
										<label for="projectLocation" class="col-sm-3 col-form-label">Project
											Location</label>
										<div class="col-sm-9">
											<select required id="projectLocation"
												class="js-example-basic-single-projectlocation"
												name="projectLocation">
												<option></option>
												<c:forEach items="${country_list}" var="item">
													<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
												</c:forEach>
											</select>
										</div>
									</div>

									<div class="form-group row">
										<label for="projectDescription"
											class="col-sm-3 col-form-label">Project Description</label>
										<div class="col-sm-9">
											<textarea required id="projectDescription" value=""
												name="projectDescription" class="form-control"
												placeholder="A short summary of project" rows = "4"></textarea>
										</div>
									</div>

									<div class="form-group row">
										<label for="projectPrivacy" class="col-sm-3 col-form-label">Project
											Privacy</label>
										<div class="col-sm-9" style="display: block; height: 34px;">
											<input required type="radio" id="projectPrivacy1"
												value="public" name="projectPrivacy" /> Public <input
												required type="radio" id="projectPrivacy2" value="hidden"
												name="projectPrivacy" /> Hide from All <input required
												type="radio" id="projectPrivacy3" value="private"
												name="projectPrivacy" /> Hide from Outsiders
										</div>
									</div>

									<div class="form-group row">
										<label for="projectDuration" class="col-sm-3 col-form-label">Estimated
											Duration</label>
										<div class="col-sm-9">
											<input required type="number" id="projectDuration" value=""
												name="projectDuration" class="form-control"
												placeholder="Number of days">
										</div>
									</div>


									<div class="form-group row">
										<label for="projectBanList" class="col-sm-3 col-form-label">Ban
											List</label>
										<div class="col-sm-9">
											<select
												class="js-example-basic-multiple-banlistusers create-new-project-select2 form-control"
												multiple="multiple" name="selected_banlist">
												<c:forEach items="${user_list}" var="item">
													<c:if test="${item.equals(username) == false}">
														<option value="${item}">${item}</option>
													</c:if>
												</c:forEach>
											</select> <br>
										</div>
									</div>
									<hr />
									<ul class="list-inline pull-right">
										<li><button type="button" onclick="return checkStep1();"
												class="btn btn-primary next-step">Save and continue</button>
										</li>
									</ul>
								</div>
								<div class="tab-pane" role="tabpanel" id="step2">
									<h3>Step 2</h3>
									<p>Upload relevant materials for others to know more about
										your project</p>
									<div class="form-group row">
										<label for="projectVideo" class="col-sm-3 control-label">Project
											Video</label>
										<div class="col-sm-9">
											<button type="btn" class="btn btn-info" value="submit">Upload
												a video</button>
										</div>
										<br> <br>
									</div>

									<div class="form-group row ">
										<label for="projectDocuments" class="col-sm-3 col-form-label">Project
											Documents</label>
										<div class="col-sm-9">
											<button type="btn" class="btn btn-info" value="submit">Upload
												documents</button>
										</div>
									</div>
									<hr />
									<ul class="list-inline pull-right">
										<li><button type="button"
												class="btn btn-default prev-step">Previous</button></li>
										<li><button type="button"
												class="btn btn-primary next-step">Save and continue</button></li>
									</ul>
								</div>
								<div class="tab-pane" role="tabpanel" id="step3">
									<h3>Step 3</h3>
									<p>Indicate the resource(s) your project need</p>

									<div id="resourcesNeeded" class="form-group row col-sm-9">
										<div class="col-md-12" style="padding-top: 3rem;">
											<select required id="resourceCategory1"
												name="resourceCategory" class="col-md-4 resourceCat" style= "width: 100%">
												<option value="" disabled selected>Select your
													resource category</option>
												<c:forEach items="${resource_category_list}" var="item">
													<option value="${item.getSkillset()}">${item.getSkillset()}</option>
												</c:forEach>
											</select> <input required id="resourceName1" name="resourceName"
												style="padding-top: 1rem;"
												class="form-control col-md-4 resourceName"
												placeholder="What resources do you need?" type="text" />
											<textarea required id="resourceDescription1"
												style="padding-top: 3rem;" name="resourceDescription"
												class="form-control col-md-4 resourceDes"
												placeholder="Describe your resource here..."></textarea>
										</div>
									</div>

									<div class="col-sm-12">
										<input id="addResource" class="btn btn-info" type="button"
											value="Add Resource" /> <br />
										<hr />
									</div>


									<ul class="list-inline pull-right">
										<li><button type="button"
												class="btn btn-default prev-step">Previous</button></li>
										<li><button type="submit" id="createProject" onclick="checkAllFields();" class="btn btn-success next-step createProject">Create Project</button></li>
									</ul>
								</div>
								<div class="tab-pane" role="tabpanel" id="complete">
									<h3>Complete</h3>
									<p>Your project has been successfully created!</p>
									<button type="button" class="btn btn-default">Back To
										Home</button>
								</div>
								<div class="clearfix"></div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			window.setInterval(function(){
				checkAllFields();
				}, 1000);
		});
	</script>

	<script type="text/javascript">
		function checkAllFields() {
			var lastRow = $('#resourcesNeeded').find("div:last");
			var lastRowInputField = lastRow.find('select');
			var id = lastRowInputField.attr("id");
			console.log("lastRowInputs: " + id);

			var emptyResourceFields = false;

			var totalRows = id.substring(16);
			console.log("totalRows: " + totalRows);

			for (count = 1; count <= totalRows; count++) {
				var resourceCat = document.getElementById("resourceCategory" + count).value;
				var resourceName = document.getElementById("resourceName" + count).value;
				var resourceDes = document.getElementById("resourceDescription" + count).value;
				
				console.log("resourceCat: " + resourceCat);
				console.log("resourceName: " + resourceName);
				console.log("resourceDes: " + resourceDes);

				if(resourceCat === "" || resourceName === "" || resourceDes === ""){
					emptyResourceFields = true;
					console.log("fail empty");
					$('.createProject').prop('disabled', true);
					//alert("Please fill in all the fields for the resources you need.");
					return false;
				}
			}
			
			if(!emptyResourceFields) {
				console.log("pass empty");
				$('.createProject').prop('disabled', false);
			}
			
			return true;
		}

		function checkStep1() {
			var title = document.getElementById("projectTitle").value;
			var purpose = document.getElementById("projectPurpose").value;
			var socialImpact = document.getElementById("socialImpact").value;
			var radioIndi = document.getElementById("radio_indi");
			var radioOrg = document.getElementById("radio_org");
			console.log("radioIndi: " + radioIndi.checked);
			console.log("radioOrg: " + radioOrg.checked);

			var projectLocation = document.getElementById("projectLocation").value;
			var projectDescription = document
					.getElementById("projectDescription").value;

			var projectPrivacy1 = document.getElementById("projectPrivacy1");
			console.log("projectPrivacy1: " + projectPrivacy1.checked);
			var projectPrivacy2 = document.getElementById("projectPrivacy2");
			console.log("projectPrivacy2: " + projectPrivacy2.checked);
			var projectPrivacy3 = document.getElementById("projectPrivacy3");
			console.log("projectPrivacy3: " + projectPrivacy3.checked);

			var projectDuration = document.getElementById("projectDuration").value;

			var message = "Please fill in the ";
			var passFields = true;

			if (title === "") {
				console.log("title");
				message += "title, ";
				passFields = false;
			}

			if (purpose === "") {
				console.log("purpose");
				message += "purpose, ";
				passFields = false;
				//alert("Please fill in the purpose.");
			}

			if (socialImpact === "") {
				console.log("social impact");
				passFields = false;
				message += "social impact, ";//alert("Please fill in the title.");
			}

			if (!radioIndi.checked && !radioOrg.checked) {
				console.log("indi org radio");
				passFields = false;
				message += "project owner, ";//alert("Please state the project owner.");
			}

			if (projectLocation === "") {
				console.log("projectLocation");
				passFields = false;
				message += "project location, ";//alert("Please state where the project will be based in.");
			}

			if (projectDescription === "") {
				console.log("projectDescription");
				passFields = false;
				message += "project description, ";//alert("Please describe the project.");
			}

			if (!projectPrivacy1.checked && !projectPrivacy2.checked
					&& !projectPrivacy3.checked) {
				console.log("projectPrivacy");
				passFields = false;
				message += "project privacy, ";//alert("Please state the project owner.");
			}

			if (projectDuration === "") {
				console.log("projectDuration");
				passFields = false;
				message += "project duration, ";//alert("Please state the estimated project duration.");
			}

			if (!passFields) {
				message = message.replace(/,\s*$/, "");
				console.log("fail field");
				alert(message += ".");
				return false;
			} else {
				console.log("pass field");
				return true;
			}
		}

		$('#addResource')
				.on(
						'click',
						function() {
							var lastRow = $('#resourcesNeeded').closest(
									'#resourcesNeeded').find("div:last-child");
							console.log("lastRow: " + lastRow);
							var lastRowInputs = lastRow.find('input');
							var lastRowSelect = lastRow.find('select');
							var lastRowTextarea = lastRow.find('textarea');

							var isClone = false;

							var checkInput = false;
							var checkSelect = false;
							var checkTextarea = false;

							lastRowInputs.each(function() {
								if ($(this).val().length) {
									checkInput = true;
								}
							});

							lastRowSelect.each(function() {
								if ($(this).val() !== null) {
									if ($(this).val().length) {
										checkSelect = true;
									}
								}
							});

							lastRowTextarea.each(function() {
								if ($(this).val().length) {
									checkTextarea = true;
								}
							});

							console.log("check input: " + checkInput);
							console.log("checkSelect: " + checkSelect);
							console.log("checkTextarea: " + checkTextarea);
							
							if(!checkInput || !checkSelect || !checkTextarea){
								console.log("empty resource fields");
								alert("Please fill in all the fields for the resources you need.");
								return false;
							}

							console.log("isClone is true");
							var cloned = lastRow.clone();
							cloned
									.find('input, select, textarea')
									.each(
											function() {
												var id = $(this).attr('id');
												console.log("id: " + id);
												var regIdMatch = /^(.+)(\d+)$/;
												var aIdParts = id
														.match(regIdMatch);
												var newId = aIdParts[1]
														+ (parseInt(
																aIdParts[2], 10) + 1);

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