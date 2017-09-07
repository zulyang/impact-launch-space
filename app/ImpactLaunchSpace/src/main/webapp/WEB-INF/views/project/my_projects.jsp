<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Projects Page</title>
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

				<main> 
				<input id="tab1" type="radio" name="tabs" checked>
				<label for="tab1">Created Projects</label> <input id="tab2"
					type="radio" name="tabs"> <label for="tab2">Joined
					Projects</label> 
					
				<section id="content1">
				<c:if test="${projectsByUser.size() == 0 }">
					<p>
						You have not created any projects yet.
					</p>
				</c:if>
				
				<div>
				<c:forEach items="${projectsByUser}" var="item"> 
				<div class="col m4">
					<div class="card">
						<div class="card-image">
							<img src="/projectImageDisplay?project-name=${item.getProject_name()}&project-proposer=${item.getProject_proposer()}">
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
							<p>
							<hr />
							<i class="fa fa-clock-o"></i> ${item.getDuration()} day(s)<br>
							<i class="fa fa-globe"></i> ${item.getLocation()}<br>
							</p>
						</div>
						<a href="/view-project?project-name=${item.getProject_name()}&project-proposer=${item.getProject_proposer()}">
							<div class="card-action">View Project</div>
						</a>
					</div>
				</div>
				</c:forEach>
				</div>
				
				</section> <section id="content2">
				<p>Bacon ipsum dolor sit amet landjaeger sausage brisket, jerky
					drumstick fatback boudin ball tip turducken. Pork belly meatball
					t-bone bresaola tail filet mignon kevin turkey ribeye shank flank
					doner cow kielbasa shankle. Pig swine chicken hamburger, tenderloin
					turkey rump ball tip sirloin frankfurter meatloaf boudin brisket
					ham hock. Hamburger venison brisket tri-tip andouille pork belly
					ball tip short ribs biltong meatball chuck. Pork chop ribeye tail
					short ribs, beef hamburger meatball kielbasa rump corned beef
					porchetta landjaeger flank. Doner rump frankfurter meatball
					meatloaf, cow kevin pork pork loin venison fatback spare ribs
					salami beef ribs.</p>
				<p>Jerky jowl pork chop tongue, kielbasa shank venison. Capicola
					shank pig ribeye leberkas filet mignon brisket beef kevin
					tenderloin porchetta. Capicola fatback venison shank kielbasa,
					drumstick ribeye landjaeger beef kevin tail meatball pastrami
					prosciutto pancetta. Tail kevin spare ribs ground round ham ham
					hock brisket shoulder. Corned beef tri-tip leberkas flank sausage
					ham hock filet mignon beef ribs pancetta turkey.</p>
				</section> </main>

			</div>
		</div>
	</div>


</body>
</html>
