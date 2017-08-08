<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search For Project</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/explore.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css">
<script src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/materialize/js/materialize.min.js"></script>

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

<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">
				<%@include file="common/navigation.jspf"%>
<div class="explore-header col-sm-12">
	<h1 class="explore-title">Search For Resource</h1>
<div class="explore-search">
	Search By Keyword:
	<span class="icon"><i class="fa fa-search"></i></span><input type="text" name="searchbox" id="searchbox" placeholder="Minimum 3 Characters" class="search"/>
	<br>	
	
	<div class="styled-select slate">
	<br>Select skillset:
	<select id="skillset">
		<option>All</option>
		<c:forEach items="${skillset}" var="skillset">
   			<option value="${skillset.getSkillset()}">${skillset.getSkillset()}</option>
		</c:forEach>
	</select>
	</div>
	</div>
	</div>
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

</div>
</div>
</div>
</body>
</html>
