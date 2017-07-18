<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Project</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<!--custom css codes -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/project.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
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


</head>
<body class="project">
	<%@include file="common/navigation.jspf"%>


	<!--main content-->
	<div class="main-content">
		<div class="container">
			<div class="row">
			<div class="content col-md-12 col-sm-12 col-xs-12">
			<div class="section-block">
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane active" id="about">
								<div class="about-information">
									<h1 class="section-title">Oops!</h1>
									<p><i class="fa fa-lock fa-4x"></i> This project is private.</p>
								</div>
							</div>
						</div>
					</div>
			</div>
				<div class="content col-md-8 col-sm-12 col-xs-12">
					<div class="section-block">
						<div class="funding-meta">
							<h1>${selected_project.getProject_name() }</h1>
							<span class="type-meta"><i class="fa fa-user"></i> <c:choose>
									<c:when test="${selected_project.getOrganization() != null}">
									${selected_project.getOrganization()}
								</c:when>
									<c:otherwise>
									${selected_project.getProject_proposer()}
								</c:otherwise>
								</c:choose></span> <span class="type-meta"><i class="fa fa-tag"></i> <c:forEach
									items="${project_target_areas}" var="item" varStatus="loop">
									<a href="#">${item }</a>
									<c:if test="${!loop.last}">,</c:if>
								</c:forEach> </span>

							<p>${selected_project.getPurpose() }</p>
							<h2>$10,350</h2>
							<span class="contribution">raised by <strong>5,234</strong>
								ready to launch
							</span>
							<div class="progress">
								<div class="progress-bar" role="progressbar" aria-valuenow="45"
									aria-valuemin="0" aria-valuemax="100" style="width: 45%;">
									<span class="sr-only">45% Complete</span>
								</div>
							</div>
							<span class="goal-progress"><strong>45%</strong> of
								$23,000 raised</span>
						</div>
						<span class="count-down"><strong>27</strong>Days to go</span>
					</div>
				</div>
				<!--/main content-->
				<div class="content col-md-4 col-sm-12 col-xs-12">
					<div class="section-block summary">
						<h1 class="section-title">OWNER</h1>
						<div class="profile-contents">
							<h2 class="position">${creator_name }</h2>
							<img src="/imageDisplay?username=${selected_project.getProject_proposer()}"
								class="profile-image img responsive"
								alt="John Smith Profile Photo">
							<!--social links-->
							<ul class="list-inline">
								<li><a href="#"><i class="fa fa-twitter"></i></a></li>
								<li><a href="#"><i class="fa fa-facebook"></i></a></li>
								<li><a href="#"><i class="fa fa-linkedin"></i></a></li>
							</ul>
							<!--/social links-->
							<a href="#" class="btn btn-contact"><i class="fa fa-user"></i>VIEW
								PROFILE</a>
						</div>
					</div></div>
			</div>
		</div>
	</div>
	<!-- Template JS -->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/resources/js/main.js"></script>


</body>



</html>