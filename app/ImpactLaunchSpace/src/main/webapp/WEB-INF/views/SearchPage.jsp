<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search For Project</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	    $(document).ready(function() {
		$('#causes').add('#location').add('#misc').change(function(event) {

			var $causes = $("select#causes").val();
			var $location = $("select#location").val();
			var $misc = $("select#misc").val();

			$.get('searchproject', {
				causeName : $causes,
				locationName : $location,
				miscName : $misc
			}, function(responseJson) {
				var $select = $('#projects');
				$select.find('option').remove(); //remove all existing projects
				$.each(responseJson, function(key, value) {
					$('<option>').val(key).text(value).appendTo($select);
				});
			});
		});
	});
</script>
</head>
<body>
	<h1>Search For Project</h1>
	Select Causes:
	<select id="causes">
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
	       
	Select Location:
	<!--Location can be drawn from the User's Profile through session. Make it default? -->
	<select id="location">
		<option>Select Location</option>
		<option selected ="All">All</option>
		<c:forEach items="${countries}" var="country">
   			<option value="${country.getCountry_name()}">${country.getCountry_name()}</option>
		</c:forEach>
	</select>
	   
	Sort By:
	<select id="misc">
		<option>Select Misc</option>
		<option selected ="Popularity">Popularity</option>
		<option value="Newest">Newest</option>
		<option value="Duration">Duration</option>
		<option value="Project Status">Project Status</option>	 <!-- Have to use database? -->
	</select>  

	<br>
	Projects:
	<select id="projects">
		<option>Select Project</option>
	</select>

</body>
</html>
