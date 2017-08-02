<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<!--custom css codes -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/resource.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/project.css" />
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
<!--for multiple select (Select2)-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
</head>
<body>
	<h1>Applying for Environmental Lawyers</h1>

	<input type="hidden" id="selected_resource_category" value="Legal">
	<br>

	<h2>My Resources</h2>
	<select class="js-example-basic-single-userresource"
		name="selected_resource_name" id="selected_resource_name" required>
		<option></option>
		<c:forEach items="${user_offered_resources}" var="item">
			<option value="${item.getResourceName()}">${item.getResourceName()}</option>
		</c:forEach>
	</select>
	<h3>
		Description
		<br>
		<input type="text" name="selected_resource_desc" id="selected_resource_desc" readonly>
	</h3>
	
	<h3>
		Add a personal note
		<br>
		<input type="text" name="personal_note" id="personal_note" value="">
	</h3>

	<script type="text/javascript">
		$(".js-example-basic-single-userresource").select2({
			placeholder : "Select from your existing resources: ",
			allowClear : true
		});
	</script>
	
	<script>
	    $(document).ready(function() {
		$('#selected_resource_name').change(function(event) {
			var resourceCategory = $("#selected_resource_category").val();
			var resourceName = $("select#selected_resource_name").val();
			
			$.post('getResourceDescription', {
				resourceName : resourceName,
				resourceCategory : resourceCategory
			}, function(responseText) {
				$('#selected_resource_desc').val(responseText);
			});
		});
	});         
</script>
</body>
</html>