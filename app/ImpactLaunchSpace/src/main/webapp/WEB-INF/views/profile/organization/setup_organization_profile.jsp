<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Set Up Organization Profile</title>
<%@include file = "../../AuthenticateCookie.jsp"; %>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/profile/organization/setup_organization_profile.css" />
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/intlTelInput.css">

</head>

<body class="profile">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<%@include file="../../common/navigation.jspf"%>

				<div class="form_container org_profile_container">
					<form method="post" action="setup-organization" onsubmit="return checkFields();"
						enctype="multipart/form-data"
						class="form-horizontal org_profile_form">
						                        
                        <h3 class="info_header">Company Information</h3>

						<div class="form-group">
							<div class="col-lg-12">
								<input type="text" name="username" value="${username}" readonly
									class="form-control profileField" style="width: 100%">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="text" name="email" value="${email}" readonly
									class="form-control profileField" style="width: 100%">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="companyName" required type="text"
									class="form-control profileField" placeholder="Company name"
									style="width: 100%">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select class="js-example-basic-multiple" required
									multiple="multiple" name="countriesOfOperation"
									style="width: 100%">
									<c:forEach items="${country_list}" var="item">
										<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select class="js-example-basic-multiple2" multiple="multiple"
									name="selected_jobsectors" style="width: 100%" required>
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
									placeholder="A short company bio" style="width: 100%"></textarea>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="contactDetailsShown" type="tel" id="contactNumberShown" class="form-control profileField"
									style="width: 308%" placeholder="Office telephone number">
								<input id="contactNumber" type="hidden" name="contactDetails">
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
	<script src="<%=request.getContextPath()%>/resources/js/intlTelInput.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/intlTelInput.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/utils.js"></script>
	
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

		function checkFields() {
			var contactNumber = document.getElementById("contactNumberShown").value;

			if (contactNumber !== "") {
				if (contactNumber.indexOf(' ') >= 0){
					alert('Please do not enter spaces in your contact number.')
					return false;
				}
			}
		}
	</script>

	<script type="text/javascript">
		$(".js-example-basic-multiple").select2({
            placeholder : "Select country of operation"

		});
	</script>
	<script type="text/javascript">
		$(".js-example-basic-multiple2").select2({
			maximumSelectionLength : 3,
			placeholder : "Select Up to 3 Job Sectors"
		});
	</script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			var ctx = "${pageContext.request.contextPath}" + "resources/js/utils.js";
			
			$("#contactNumberShown").intlTelInput({
				autoPlaceholder : "aggressive",
				utilsScript : ctx,
				
			});
			
			$("form").submit(function() {
				  $("#contactNumber").val($("#contactNumberShown").intlTelInput("getNumber"));
			});

		});

	</script>

</body>
</html>
