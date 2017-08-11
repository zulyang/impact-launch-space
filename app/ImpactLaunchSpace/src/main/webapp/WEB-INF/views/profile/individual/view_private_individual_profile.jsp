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
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css">
<script src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<%-- <script src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-migrate-1.4.1.js"></script> --%>
<script src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>

</head>
<body class="profile">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<%@include file="../../common/navigation.jspf"%>
				<div class="indi_private_profile_display_container">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class="profile_img">
								<img src="/imageDisplay?username=${individual.getUsername()}"
									class="circle_indi_profile_image">
							</div>

							<div class="profile_bio">
								<h1 style="display: inline-block">${individual.getFirst_name()}
									${individual.getLast_name()}</h1>

								<div style="display: inline-block" class="btn-group">
									<a class="btn btn-default" onClick="sendMessage()"> Leave A Message </a>
								</div>

								<hr>
								<p class="indi_bio">${individual.getPersonalBio()}</p>
								<hr>
								<p><i class="fa fa-briefcase"></i> ${individual.getJobTitle()}</p>
								<p><i class="fa fa-building"></i> ${individual.getOrganization()}</p>
								<hr>
								<p style="display: inline-block"><i class="fa fa-envelope"></i> ${user.getEmail()}</p><br/>
								<p style="display: inline-block"><i class="fa fa-phone"></i> ${individual.getContactDetails()}</p>
								<p><i class="fa fa-globe"></i> ${individual.getCountry()}</p>
							</div>
						</div>
					</div>

					<div class="alert alert-danger">
						<strong>Oops!</strong> User has set his/account private.
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
							<h4 class="modal-title">Send Message To ${individual.getUsername() }</h4>
						</div>
						<div class="modal-body">
							<div class="container">
								<div class="form-group row col-md-5">
									<div class="col-md-12 col-xs-9">
										<textarea id=""	name="modalMessage"	class="form-control col-md-4 create-project-add"
											placeholder="Leave your message here"></textarea>
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Cancel</button>
							<button type="button" id="send" class="btn btn-success">Send</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		
	</div>

</body>
<script type="text/javascript">
	function sendMessage(){
		$('#messageModal').modal('show');
	}
	</script>
</html>
