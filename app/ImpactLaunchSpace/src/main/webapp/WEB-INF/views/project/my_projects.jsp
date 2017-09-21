<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Projects Page</title>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/project/my_projects.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css">
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/materialize/js/materialize.min.js"></script>

</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<!--navigation bar  -->
				<%@include file="../common/navigation.jspf"%>

				<main> <input id="tab1" type="radio" name="tabs" checked>
				<label for="tab1">Created Projects</label> <input id="tab2"
					type="radio" name="tabs"> <label for="tab2">Joined
					Projects</label> <section id="content1"> <c:if
					test="${projectsByUser.size() == 0 }">
					<p>You have not created any projects yet.</p>
				</c:if>

				<div>
					<c:forEach items="${projectsByUser}" var="item">
						<div class="col m4">
							<div class="card">
								<div class="card-image">
									<img
										src="/projectImageDisplay?project-name=${item.getProject_name()}&project-proposer=${item.getProject_proposer()}">
									<span class="card-title">${item.getProject_name()}</span>
								</div>

								<div>
									<c:choose>
										<c:when test="${item.getProject_status() == 'new'}">
											<span class="label label-primary project_status">${item.getProject_status()}</span>
										</c:when>

										<c:when test="${item.getProject_status() == 'started'}">
											<span class="label label-success project_status">${item.getProject_status()}</span>
										</c:when>

										<c:otherwise>
											<span class="label label-default project_status">${item.getProject_status()}</span>
										</c:otherwise>
									</c:choose>
								</div>

								<div class="card-content">
									<p class="my_projects_description">${item.getPurpose()}
									<hr />
									<i class="fa fa-clock-o"></i> ${item.getDuration()} day(s)<br>
									<i class="fa fa-globe"></i> ${item.getLocation()}<br>
									</p>
								</div>
								<a
									href="/view-project?project-name=${item.getProject_name()}&project-proposer=${item.getProject_proposer()}">
									<div class="card-action">View Project</div>
								</a>
							</div>
						</div>
					</c:forEach>
				</div>

				</section> <section id="content2"> <c:if
					test="${projectsJoinedByUser.size() == 0 }">
					<p>You have not joined any projects yet.</p>
				</c:if>

				<div>
					<c:forEach items="${projectsJoinedByUser}" var="item">
						<div class="col m4">
							<div class="card">
								<div class="card-image">
									<img
										src="/projectImageDisplay?project-name=${item.getProject_name()}&project-proposer=${item.getProject_proposer()}">
									<span class="card-title">${item.getProject_name()}</span>
								</div>

								<c:choose>
									<c:when test="${item.getProject_status() == 'new'}">
										<span class="label label-primary project_status">${item.getProject_status()}</span>
									</c:when>

									<c:when test="${item.getProject_status() == 'started'}">
										<span class="label label-success project_status">${item.getProject_status()}</span>
									</c:when>

									<c:otherwise>
										<span class="label label-default project_status">${item.getProject_status()}</span>
									</c:otherwise>
								</c:choose>

								<div class="card-content">
									<p class="project_description">${item.getPurpose()}
									<hr />
									<i class="fa fa-clock-o"></i> ${item.getDuration()} day(s)<br>
									<i class="fa fa-globe"></i> ${item.getLocation()}<br>
									</p>
								</div>
								<a
									href="/view-project?project-name=${item.getProject_name()}&project-proposer=${item.getProject_proposer()}">
									<div class="card-action">View Project</div>
								</a>
							</div>
						</div>
					</c:forEach>
				</section> </main>

			</div>
		</div>
	</div>


</body>
</html>
