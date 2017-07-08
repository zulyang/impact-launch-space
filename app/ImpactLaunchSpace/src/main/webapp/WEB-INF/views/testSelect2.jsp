<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<link rel="stylesheet"
 href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <link
	href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>


</head>
<body>
<form action="processSelect2" method="POST">
	<h3>Country:</h3>
	<select class="js-example-basic-multiple" multiple="multiple" name="selected_countries" required>
		<c:forEach items="${country_list}" var="item">
    	<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
		</c:forEach>
	</select>
	<br>
	
	<h3>Job Sector:</h3>
		<select class="js-example-basic-multiple2" multiple="multiple" name="selected_jobsectors" required>
		<c:forEach items="${job_sector_list}" var="item">
    	<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
		</c:forEach>
	</select>
	<input type="submit" value="test it!"/>
</form>	
	<script type="text/javascript">
		$(".js-example-basic-multiple").select2({
			  placeholder: "Select a country"
		});
	</script>
	<script type="text/javascript">
		$(".js-example-basic-multiple2").select2({
			  maximumSelectionLength: 3,
			  placeholder: "Select Up to 3 Job Sectors"
		});
	</script>

</body>
</html>