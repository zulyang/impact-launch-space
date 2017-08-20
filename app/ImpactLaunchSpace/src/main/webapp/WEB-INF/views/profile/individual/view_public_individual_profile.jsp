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
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css">
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>

<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
</head>

<body class="profile">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<%@include file="../../common/navigation.jspf"%>


				<div class="indi_public_profile_display_container ">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="/imageDisplay?username=${individual.getUsername()}"
									class="circle_indi_profile_image">

							<div class="profile_bio">
								<h1 style="display: inline-block">${individual.getFirst_name()}
									${individual.getLast_name()}</h1>

								<div class="btn-group">
									<a class="btn btn-default" onClick="sendMessage()"> Leave A
										Message </a>
								</div>

								<hr>
								<p class="indi_bio">${individual.getPersonalBio()}</p>
								<hr>
								<p>
									<i class="fa fa-briefcase"></i> ${individual.getJobTitle()}
								</p>
								<c:if test="${individual.getOrganization().length() > 0}">
									<p>
										<i class="fa fa-building"></i> ${individual.getOrganization()}
									</p>
								</c:if>

								<hr>
								<p style="display: inline-block">
									<i class="fa fa-envelope"></i> ${user.getEmail()}
								</p>
								<br />
								<p style="display: inline-block">
									<i class="fa fa-phone"></i> ${individual.getContactDetails()}
								</p>
								<p>
									<i class="fa fa-globe"></i> ${individual.getCountry()}
								</p>
							</div>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">Skills</div>
						<div class="panel-body">
							<c:forEach items="${userSkills}" var="item">
								<p class="indi_skills">${item.getSkillset()}</p>
							</c:forEach>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">Experience</div>
						<div class="panel-body">
							<c:forEach items="${jobSectorsIndividual}" var="item">
								<p>
									<strong>${item.getYearsOfExperience()}</strong> years of
									experience in <strong>${item.getJob_sector()}</strong>.
								</p>
							</c:forEach>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">Interest</div>
						<div class="panel-body">

							<p>I want to make a difference in:</p>
							<c:forEach items="${preferredProjectArea}" var="item">
								<p class="indi_project_area">${item.getProject_area()}</p>
							</c:forEach>

							<p>Sectors that are important to me:</p>
							<c:forEach items="${preferredJobSectors}" var="item">
								<p class="indi_job_sector">${item.getJob_sector()}</p>
							</c:forEach>

							<p>
								I can dedicate an average of <strong>${individual.getMinimumVolunteerHours()}</strong>
								to <strong>${individual.getMaximumVolunteerHours()}</strong>
								hours in a week.
							</p>

							<p>I am interested to work in:</p>
							<c:forEach items="${preferredCountries}" var="item">
								<p class="indi_preferred_countries">${item.getCountry_name()}</p>
							</c:forEach>

						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">Documents</div>
						<div class="panel-body">
							<table>
								<c:forEach items="${individual.getDocumentList()}"
									var="document">
									<tr>
										<td><a href="/downloadFile?file=${document}"> <img
												src="<%=request.getContextPath()%>/resources/img/file.png" />
										</a></td>
										<td><a href="/downloadFile?file=${document}">${document.getName()}</a></td>
									</tr>
								</c:forEach>
							</table>
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
