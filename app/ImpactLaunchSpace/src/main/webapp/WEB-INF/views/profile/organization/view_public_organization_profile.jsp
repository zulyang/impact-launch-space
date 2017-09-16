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
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/profile/organisation/view_public_organization_profile.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css">
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
</head>

<body>
	<div class="container">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<%@include file="../../common/navigation.jspf"%>

				<div class="view_public_organization_container">
					<div class="panel panel-default">
						<div class="panel-body">
							<div style="display: inline-block">
								<img src="/imageDisplay?username=${organization.getUsername()}"
									class="circle_org_profile_image">
							</div>

							<div style="display: inline-block">
								<h1 style="display: inline-block">${organization.getCompanyName()}</h1>

								<div style="display: inline-block" class="btn-group">
									<a class="btn btn-default" onClick="sendMessage()"> Leave A
										Message </a>
								</div>

								<hr>
								<p class="org_bio">${organization.getCompanyBio()}</p>
								<hr>
								<p style="display: inline-block">
									<i class="fa fa-envelope"></i> ${profileemail}
								</p>
								<br />
								<p style="display: inline-block">
									<i class="fa fa-phone"></i> ${organization.getContactDetails()}
								</p>
								<hr>

								<div class="org_profile_display_countries">
									<i class="fa fa-globe"></i>
									<c:forEach items="${countriesOfOperation}" var="item">
										<p class="org_countries">${item.getCountry_name()}</p>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">Job Sectors</div>
						<div class="panel-body">
							<div class="org_profile_display_jobSectors">
								<c:forEach items="${jobSectorsOrganization}" var="item">
									<p class="org_job_sectors">${item.getJob_sector()}</p>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Leave message modal-->
		<div class="modal fade" tabindex="-1" role="dialog" id="messageModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<form action="send-message" role="form" method="post">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title">Send Message To
								${individual.getUsername() }</h4>
						</div>
						<div class="modal-body">
							<div class="container">
								<div class="form-group row col-md-5">
									<div class="col-md-12 col-xs-9">
										<input class="form-control col-md-4 create-project-add"
											type="text" id="modalSubject" name="modalSubject"
											placeholder="Write a title here" required />

										<textarea id="modalMessage" name="modalMessage"
											class="form-control col-md-4 create-project-add"
											placeholder="Leave your message here"></textarea>
										<input type="hidden" id="recipient" name="recipient"
											value="${individual.getUsername()}" />
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Cancel</button>
							<button type="button" id="send" onclick="sendAjaxMsg()"
								class="btn btn-success">Send</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>

<script type="text/javascript">
	$(document).ready(function() {

	});
</script>

<script>
	function sendMessage() {
		$('#messageModal').modal('show');
	}
</script>
<script>
	function sendAjaxMsg() {
		var modalMessage = $('#modalMessage').val();
		var recipient = $('#recipient').val();
		var modalSubject = $('#modalSubject').val();

		$.post('send-message', {
			modalMessage : modalMessage,
			recipient : recipient,
			modalSubject : modalSubject
		});

		$('#messageModal').modal('hide');

		$('#messageModal').on('hidden.bs.modal', function() {
			$(this).find("textarea").val('').end();
		});

	}
</script>
</html>
