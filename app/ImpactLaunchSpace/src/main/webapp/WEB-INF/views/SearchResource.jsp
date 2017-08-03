<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search For Project</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
	    $(document).ready(function() {
		$('#searchbox').add('#skillset').on('keyup change', function(event) {

			if($("input#searchbox").val().length >= 3){
			var $searchbox = $("input#searchbox").val();
			}
			var $skillset = $("select#skillset").val();

			$.get('searchforresource', {

				searchboxName:$searchbox,
				skillsetName :$skillset

			}, function(responseJson) {
				$("#resources tbody").empty()
			    var trHTML = '';
			    $.each(responseJson, function (key, value) {
					var val = value
					var res = val.split(",");
			        trHTML += '<tr><td>' + res[0] + '</td><td>' + res[1] + '</td><td>' + res[2] + '</td><td>' + res[3] +'</td></tr>';
			    });
			    $('#resources').append(trHTML);
			});
		});
	});
</script>
</head>
<body>
	<h1>Search For Resource</h1>

	Search By Keyword:
	<input type="text" name="searchbox" id="searchbox" placeholder="Minimum 3 Characters">
	<br>	       
Select skillset:
	<select id="skillset">
		<option>Select skillset</option>
		<c:forEach items="${skillset}" var="skillset">
   			<option value="${skillset.getSkillset()}">${skillset.getSkillset()}</option>
		</c:forEach>
	</select>
	<br>
	<!-- RESULTS -->
	Resources:
	<table id="resources" border='1'>
	<thead>
    <tr>
        <th>Resource Name</th>
        <th>Resource Description</th>
        <th>Resource Category</th>
        <th>Resource Owner</th>
        <th>Contact</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
	</table>

</body>
</html>
