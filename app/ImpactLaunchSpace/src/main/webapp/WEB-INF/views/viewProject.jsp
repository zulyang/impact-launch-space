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
				<div class="content col-md-8 col-sm-12 col-xs-12">
					<div class="section-block">
						<div class="funding-meta">
							<h1>${selected_project.getProject_name() }</h1>
							<input type="hidden" name="project_name" value="${selected_project.getProject_name() }">
							<input type="hidden" name="project_proposer" value="${selected_project.getProject_proposer()}">
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
							<!--img src="assets/img/image-heartbeat.jpg" class="img-responsive" alt="launch HTML5 Crowdfunding"-->
							<div class="video-frame">
								<iframe src="https://player.vimeo.com/video/67938315"
									width="500" height="281" frameborder="0" webkitallowfullscreen
									mozallowfullscreen allowfullscreen></iframe>
							</div>
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

					<!--tabs-->
					<div class="section-block">
						<div class="section-tabs">
							<ul class="nav nav-tabs" role="tablist">
								<li role="presentation" class="active"><a href="#about"
									aria-controls="about" role="tab" data-toggle="tab">About</a></li>
								<li role="presentation"><a href="#updates"
									aria-controls="updates" role="tab" data-toggle="tab">Updates</a></li>
							</ul>
						</div>
					</div>
					<!--/tabs-->
					<!--tab panes-->
					<div class="section-block">
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane active" id="about">
								<div class="about-information">
									<h1 class="section-title">ABOUT LAUNCH</h1>
									<p>${selected_project.getDescription()}</p>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane" id="updates">
								<div class="update-information">
									<h1 class="section-title">UPDATES</h1>
									<!--update items-->
									<div class="update-post">
										<h4 class="update-title">We've started shipping!</h4>
										<span class="update-date">Posted 2 days ago</span>
										<p>Suspendisse luctus at massa sit amet bibendum. Cras
											commodo congue urna, vel dictum velit bibendum eget.
											Vestibulum quis risus euismod, facilisis lorem nec, dapibus
											leo. Quisque sodales eget dolor iaculis dapibus. Vivamus sit
											amet lacus ipsum. Nullam varius lobortis neque, et efficitur
											lacus. Quisque dictum tellus nec mi luctus imperdiet. Morbi
											vel aliquet velit, accumsan dapibus urna. Cras ligula orci,
											suscipit id eros non, rhoncus efficitur nisi.</p>
									</div>
									<div class="update-post">
										<h4 class="update-title">Launch begins manufacturing</h4>
										<span class="update-date">Posted 9 days ago</span>
										<p>Suspendisse luctus at massa sit amet bibendum. Cras
											commodo congue urna, vel dictum velit bibendum eget.
											Vestibulum quis risus euismod, facilisis lorem nec, dapibus
											leo. Quisque sodales eget dolor iaculis dapibus. Vivamus sit
											amet lacus ipsum. Nullam varius lobortis neque, et efficitur
											lacus. Quisque dictum tellus nec mi luctus imperdiet. Morbi
											vel aliquet velit, accumsan dapibus urna. Cras ligula orci,
											suscipit id eros non, rhoncus efficitur nisi.</p>
									</div>
									<div class="update-post">
										<h4 class="update-title">Designs have now been finalized</h4>
										<span class="update-date">Posted 17 days ago</span>
										<p>Suspendisse luctus at massa sit amet bibendum. Cras
											commodo congue urna, vel dictum velit bibendum eget.
											Vestibulum quis risus euismod, facilisis lorem nec, dapibus
											leo. Quisque sodales eget dolor iaculis dapibus. Vivamus sit
											amet lacus ipsum. Nullam varius lobortis neque, et efficitur
											lacus. Quisque dictum tellus nec mi luctus imperdiet. Morbi
											vel aliquet velit, accumsan dapibus urna. Cras ligula orci,
											suscipit id eros non, rhoncus efficitur nisi.</p>
									</div>
									<!--/update items-->
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--/tabs-->
				<!--/main content-->
				<!--sidebar-->
				<div class="content col-md-4 col-sm-12 col-xs-12">
					<div class="section-block summary">
						<h1 class="section-title">OWNER</h1>
						<div class="profile-contents">
							<h2 class="position">${creator_name }</h2>
							<div class="profile-image"><img
								src="/imageDisplay?username=${selected_project.getProject_proposer()}"
								class="img responsive"
								alt="John Smith Profile Photo"></div>
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
					</div>
					<div class="section-block">
						<h1 class="section-title">WHAT WE NEED</h1>
						<!--resources-->
						<c:forEach items="${project_resource_categories}" var="item"
							varStatus="loop">


							<div class="reward-block">
								<h3>Category ${loop.index + 1}: ${item}</h3>
								<c:forEach var="type" items="${project_requested_resources}">
									<c:if test="${type.key.equals(item) }">

										<c:forEach var="item" items="${type.value}">
											<h2>${item.get(0)}</h2>
											<p>${item.get(1)}
											<p>
												<br> <span><i class="fa fa-users"></i> 180
													backers</span> <a href="" class="btn btn-reward">APPLY</a>
										</c:forEach>
									</c:if>
								</c:forEach>


							</div>

						</c:forEach>

						<!--/resource-->
					</div>
				</div>
				<!--/sidebar-->
			</div>
		</div>
	</div>
	<!-- Template JS -->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/resources/js/main.js"></script>


</body>



</html>