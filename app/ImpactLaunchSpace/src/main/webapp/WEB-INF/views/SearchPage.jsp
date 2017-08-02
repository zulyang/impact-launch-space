<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search For Project</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<!--custom css codes -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/explore.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.1/js/materialize.min.js"></script>

<script>
	    $(document).ready(function() {
						$('#searchbox').add('#causes').add('#location').add('#misc').on('keyup change',function(event) {
						var $searchbox = $("input#searchbox").val();
						var $causes = $("select#causes").val();
						var $location = $("select#location").val();
						var $misc = $("select#misc").val();

						$.get('searchproject',{
							searchboxName : $searchbox,
							causeName : $causes,
							locationName : $location,
							miscName : $misc},
					function(responseJson) {
						$("#projectResults").empty()
						var trHTML = '';
						$.each(responseJson,function(key,value) {
							var val = value
							var res = val.split(",");
							trHTML += '<div class="col m4"><div class="card"><div class="card-image"><img src="https://st.depositphotos.com/1724125/1373/v/950/depositphotos_13739151-stock-illustration-cartoon-astronaut.jpg"><span class="card-title">'
							+ res[0] + '</span></div><div class="projectStatus">' + res[4]
							+ '</div><div class="card-content"><p>'+ res[1]
							+ '<hr/><i class="fa fa-clock-o"></i> ' + res[2] + ' day(s)<br><i class="fa fa-globe"></i> '+ res[3]
							+ '<br><i class="fa fa-user-circle-o"></i> ' + res[5] + '</p></div><div class="card-action">'
							+ '<a href ="/view-project?project-name=' + res[0]
							+ '&project-proposer=' + res[5]+ '">View Project</a> </div></div> </div>';
						});
						$('#projectResults').append(trHTML);
						});
						});
					});
</script>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<!--navigation bar  -->
				<%@include file="common/navigation.jspf"%>
				<div class="explore-header col-sm-12">

					<h1 class="explore-title">Search For Project</h1>
					<div class="explore-search">
						Search By Keyword: <span class="icon"><i
							class="fa fa-search"></i></span> <input type="text" name="searchbox"
							id="searchbox" placeholder="Project Keyword" class="search" /> <br>

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
						<div id="projectResults"></div>


					</div>
				</div>
			</div>
		</div>
	</div>


</body>
</html>
