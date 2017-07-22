<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css"
	rel="stylesheet" />
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

				<%@include file="common/navigation.jspf"%>

				<div class="col-lg-12 form_container org_profile_container">
					<form method="post" action="setup-organization"
						enctype="multipart/form-data"
						class="form-horizontal org_profile_form">
						<div class="form-group">
							<div class="col-lg-12">
								<div id="profile_upload_button" onclick="uploadFile()">Upload
									a display picture</div>
								<div style='height: 0px; width: 0px; overflow: hidden;'>
									<input id="uploadFile" name="profilePicture" type="file"
										value="upload" onchange="sub(this)" />
								</div>
							</div>
						</div>
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
								<input name="companyName" required type="text"
									class="form-control profileField" placeholder="Company name">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select class="js-example-basic-multiple" required multiple="multiple"
									name="countriesOfOperation">
									<c:forEach items="${country_list}" var="item">
										<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select class="js-example-basic-multiple2" multiple="multiple"
									name="selected_jobsectors" required>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<textarea rows="4" name="companyBio"
									class="form-control companyBio"
									placeholder="A short company bio"></textarea>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="contactDetails" required="required" type="text"
									class="form-control profileField"
									placeholder="Office telephone number">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<button type="submit" value="Save"
									class="btn btn-success profile_save">Save Account
									Details</button>
							</div>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>

	<script type="text/javascript">
		function uploadFile() {
			document.getElementById("uploadFile").click();
		}
		function sub(obj) {
			var file = obj.value;
			var fileName = file.split("\\");
			document.getElementById("profile_upload_button").innerHTML = fileName[fileName.length - 1];
			event.preventDefault();
		}
	</script>

	<script type="text/javascript">
		$(".js-example-basic-multiple").select2({
			placeholder : "Select a country"
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
