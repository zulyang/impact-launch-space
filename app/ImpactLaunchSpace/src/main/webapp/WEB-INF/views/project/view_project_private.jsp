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

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/project/project.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/project/view_project_private.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css">
<script src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
</head>

<body class="project">
	<%@include file="../common/navigation.jspf"%>


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
									<p><i class="fa fa-lock fa-4x"></i> This project is private. Contact the project owner to request access.</p>
								</div>
							</div>
						</div>
					</div>
			</div>
				<div class="content col-md-8 col-sm-12 col-xs-12">
					<div class="section-block">
						<div class="funding-meta">
							<h1 id="project_private_title">${selected_project.getProject_name() }</h1>
							<button onClick="" type="button" class="btn btn-success edit_project_private">Edit Project</button>
							<br>
							<br>
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
							
						</div>
						
					</div>
				</div>
				<!--/main content-->
				<div class="content col-md-4 col-sm-12 col-xs-12">
					<div class="section-block summary">
						<h1 class="section-title">OWNER</h1>
						<div class="profile-contents">
							<h2 class="position">${creator_name }</h2>
							<img src="/imageDisplay?username=${selected_project.getProject_proposer()}"
								class="project_proposer_img responsive"
								alt="John Smith Profile Photo">
							<!--social links-->
							<ul class="list-inline">
								<li><a href="#"><i class="fa fa-twitter"></i></a></li>
								<li><a href="#"><i class="fa fa-facebook"></i></a></li>
								<li><a href="#"><i class="fa fa-linkedin"></i></a></li>
							</ul>
							<!--/social links-->
							<a href="/view-profile?username=${selected_project.getProject_proposer()}" class="btn btn-contact"><i class="fa fa-user"></i>VIEW
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