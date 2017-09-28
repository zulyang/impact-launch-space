<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search For Project</title>
<link rel="icon" type="image/png"
	href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/explore.css" />
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
<script src="http://evanplaice.github.io/jquery-csv/src/jquery.csv.js"></script>
<script>
	function loader() {
		$(".se-pre-con").fadeOut("slow");
	};
</script>
<script>
	    $(document)
			.ready(
					function() {
						$('#searchbox').add('#causes').add('#location').add('#misc').on('keyup change',	function(event) {

							if ($("input#searchbox").val().length >= 3) {
								var $searchbox = $("input#searchbox").val();
							}
								var $causes = $("select#causes").val();
								var $location = $("select#location").val();
								var $misc = $("select#misc").val();

							$.get('searchforproject',{
								searchboxName : $searchbox,
								causeName : $causes,
								locationName : $location,
								miscName : $misc
							},function(responseJson) {
								$("#projectResults").empty();
								var trHTML = '';
								console.log(JSON.stringify(responseJson));
								for (i in responseJson.results) {
									var value = responseJson.results[i];
									trHTML += '<div class="col m4"><div class="card"><div class="card-image">';
	
									if (value.projPicture === "true") {
										trHTML += '<img src="/projectImageDisplay?project-name='
												+ value.projname
												+ '&project-proposer='
												+ value.projProposer
												+ '">';
	
									} else {
										trHTML += '<img src="https://st.depositphotos.com/1724125/1373/v/950/depositphotos_13739151-stock-illustration-cartoon-astronaut.jpg">';
									}
	
									trHTML += '<span class="card-title">'
											+ value.projname
											+ '</span></div>';
	
									if (value.projStatus == "new") {
										trHTML += '<span class="label label-primary project_status">new</span>';
									} else if (value.projStatus == "started") {
										trHTML += '<span class="label label-success project_status">started</span>';
									} else {
										trHTML += '<span class="label label-default project_status">ended</span>';
									}
	
									trHTML += '<div class="card-content"><p class="project_description">'
											+ value.projpurpose
											+ '<hr/><i class="fa fa-clock-o"></i> '
											+ value.projDuration
											+ ' day(s)<br><i class="fa fa-globe"></i> '
											+ value.projLocation
											+ '<br><i class="fa fa-user-circle-o"></i> '
											+ value.projProposer
											+ '</p></div>'
											+ '<a href ="/view-project?project-name='
											+ value.projname
											+ '&project-proposer='
											+ value.projProposer
											+ '"><div class="card-action">View Project</div></a></div> </div>';
								}

								$('#projectResults').append(trHTML);
								});
							});
					});
</script>
</head>
<body onload="loader()">
	<div class="se-pre-con"></div>
	>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<%
					String username = (String) request.getSession().getAttribute("username");
					System.out.println("username: " + username);

					if (username == null) {
				%>
				<%@include file="../common/navigation_not_logged_in.jspf"%>
				<%
					} else {
				%>
				<%@include file="../common/navigation.jspf"%>
				<%
					}
				%>

				<main>
				<div class="explore-header col-sm-12">

					<h1 class="explore-title">Search For Project</h1>
					<div class="explore-search">
						Search By Keyword: <span class="icon"><i
							class="fa fa-search"></i></span> <input type="text" name="searchbox"
							id="searchbox" placeholder="Minimum 3 Characters" class="search" />
						<br>

						<div class="styled-select slate">

							<br> Select Causes: <select id="causes">
								<option>Select Cause</option>
								<option value="Agriculture">Agriculture</option>
								<option value="Animal welfare">Animal welfare</option>
								<option value="Arts and culture">Arts and culture</option>
								<option value="Childrens support">Childrens support</option>
								<option value="Crowdfunding">Crowdfunding</option>
								<option value="Construction">Construction</option>
								<option value="Education">Education</option>
								<option value="Elder care">Elder care</option>
								<option value="Environment">Environment</option>
								<option value="Health">Health</option>
								<option value="Fishing">Fishing</option>
								<option value="Forestry">Forestry</option>
								<option value="Fundraising">Fundraising</option>
								<option value="Sports">Sports</option>
								<option value="Technology">Technology</option>
								<option value="Water">Water</option>
								<option value="Wellbeing">Wellbeing</option>
								<option value="Womens support">Womens support</option>
							</select>
						</div>
						     
						<div class="styled-select slate">
							      Select Location:
							<!--Location can be drawn from the User's Profile through session. Make it default? -->
							<select id="location">
								<option>Select Location</option>
								<option selected="All">All</option>
								<c:forEach items="${countries}" var="country">
									<option value="${country.getCountry_name()}">${country.getCountry_name()}</option>
								</c:forEach>
							</select>
						</div>

						<div class="styled-select slate">
							    Sort By: <select id="misc">
								<option>Select Misc</option>
								<option selected="Popularity">Popularity</option>
								<option value="Newest">Newest</option>
								<option value="Duration">Duration</option>
								<option value="Project Status">Project Status</option>
							</select>    
						</div>
						<br>
					</div>
				</div>
				<hr />

				<!-- PROJECT RESULTS CARDS -->
				<div class="container-fluid">
					<div class="row">
						<div class="project_results" id="projectResults"></div>


					</div>
				</div>
				</main>
			</div>
		</div>
	</div>


</body>
</html>
