<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="java.io.*"%>

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
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
	});
</script>
</head>
<body class="project">

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
				<!-- /.container-fluid --> </nav>

				<div class="create-project-container">
					<div id="accordion">
						<h3>Basic Info</h3>
						<div>
							<form action="create-project"
								onsubmit="return checkResourceFields();" method="post">
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
										<input type="radio" id="projectOwner" value="individual"
											name="projectOwner" /> Myself <input type="radio"
											id="projectOwner" value="organization" name="projectOwner" />
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
										<input type="text" id="projectBanList" value=""
											name="projectBanList" class="form-control"
											placeholder="Search for username">
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
								<div style="display: inline-block" id="results" class="col-sm-9"></div>
								<br> <br> <br>
								<div style="display: inline-block" class="col-sm-9">
									<input id="buttonclck" onclick="checkResourceFields()"
										class="btn btn-info" type="button" value="Add more resources" />
								</div>
							</div>
						</div>
					</div>
					<hr>
					<button class="btn btn-block btn-success" type="submit">Create
						Project</button>
				</div>
				</form>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$('#results')
				.append(
						'<form><table width="100%" border="0" cellspacing="0" cellpadding="5" id="resourcesNeeded" class="border"><tr><th>Category</th><th>Resource Needed</th></tr> <tr> <td> <select required class="dd" name="Phonenumberdd1" id="Phonenumberdd1"> <option value=""></option><option value="test1">test 1</option><option value="test2">test 2</option></select></td> <td> <input required type="text" name="to1" id="to1" value="" /> </td></TR></TABLE></form>	');

		$('#results').on('focus', ':input', function() {
			$(this).closest('tr').filter(function() {
				return !$(this).data('saved');
			}).find(':input').each(function() {
				$(this).data('value', this.value);
				$(this).closest('tr').data('saved', true);
			});
		}).on('input change', ':input', function() {
			$(this).data('filled', this.value != $(this).data('value'))
			var tr = $(this).closest('tr');
			all = tr.find(':input'), fld = all.filter(function() {
				return $(this).data('filled');
			});
			if (all.length == fld.length) {
				if (!tr.data('done')) {
					$('#buttonclck')[0].click();
					tr.data('done', true);
				}
			} else {
				if (tr.data('done')) {

					tr.data('done', false);
				}
			}
		});

		$('#buttonclck').on(
				'click',
				function() {
					var lastRow = $('#resourcesNeeded').closest(
							'#resourcesNeeded').find("tr:last-child");
					var lastRowInputs = lastRow.find('input');
					var isClone = false;
					lastRowInputs.each(function() {
						if ($(this).val().length) {
							isClone = true;
						}
					});
					if (!isClone)
						return false;
					var cloned = lastRow.clone();
					cloned.find('input, select').each(
							function() {
								var id = $(this).attr('id');

								var regIdMatch = /^(.+)(\d+)$/;
								var aIdParts = id.match(regIdMatch);
								var newId = aIdParts[1]
										+ (parseInt(aIdParts[2], 10) + 1);

								$(this).attr('id', newId);
								$(this).attr('name', newId);
							});

					cloned.find("input[type='text']").val('');
					cloned.insertAfter(lastRow);
				});

		function checkResourceFields() {
			var category = document.getElementById("Phonenumberdd1");
			var resource = document.getElementById("to1");
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
</body>



</html>