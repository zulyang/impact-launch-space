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
		<select class="js-example-basic-multiple" multiple="multiple"
			name="selected_countries" required>
			<c:forEach items="${country_list}" var="item">
				<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
			</c:forEach>
		</select> <br>

		<h3>Job Sector:</h3>
		<select class="js-example-basic-multiple2" multiple="multiple"
			name="selected_jobsectors" required>
			<c:forEach items="${job_sector_list}" var="item">
				<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
			</c:forEach>
		</select>

		<h3>Job Sector (Indiv Kind):</h3>
		<select class="js-example-basic-single"
			name="selected_jobsectors_indiv" required>
			<c:forEach items="${job_sector_list}" var="item">
				<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
			</c:forEach>
		</select>

		<h3>Project Area:</h3>
		<select class="js-example-basic-multiple3" multiple="multiple"
			name="selected_projectareas" required>
			<c:forEach items="${project_area_list}" var="item">
				<option value="${item.getProject_area()}">${item.getProject_area()}</option>
			</c:forEach>
		</select>

		<h3>Skill Set:</h3>
		<select class="js-example-basic-multiple4" multiple="multiple"
			name="selected_skillsets" required>
			<c:forEach items="${skillset_list}" var="item">
				<option value="${item.getSkillset()}">${item.getSkillset()}</option>
			</c:forEach>
		</select>

		<h3>Job Sector Organization (Edit 1):</h3>
		<select class="js-example-basic-multiple2" multiple="multiple"
			name="country" required>
			<c:forEach items="${job_sector_list}" var="item">
				<c:choose>
					<c:when
						test="${edwardo_jobsector_list.contains(item.getJob_sector())}">
						<option value="${item.getJob_sector()}" selected="selected">${item.getJob_sector()}</option>
					</c:when>
					<c:otherwise>
						<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select> <br>


		<h3>Country of Operations (Edit 1):</h3>
		<select class="js-example-basic-multiple" multiple="multiple"
			name="country" required>
			<c:forEach items="${country_list}" var="item">
				<c:choose>
					<c:when
						test="${edwardo_country_list.contains(item.getCountry_name())}">
						<option value="${item.getCountry_name()}" selected="selected">${item.getCountry_name()}</option>
					</c:when>
					<c:otherwise>
						<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select> <br>


		 <input type="submit" value="test it!" />
	</form>

	<form action="test-number" method="post">
		<input name="numba" type="number" placeholder="Years of experience"
			required /> <input type="submit" value="Send" />
	</form>

	<script type="text/javascript">
		$(".js-example-basic-multiple").select2({
			placeholder : "Select countries where you wish to be involved in"
		});
	</script>
	<script type="text/javascript">
		$(".js-example-basic-multiple2").select2({
			maximumSelectionLength : 3,
			placeholder : "Select Up to 3 Job Sectors"
		});
	</script>
	<script type="text/javascript">
		$(".js-example-basic-multiple3").select2({
			maximumSelectionLength : 5,
			placeholder : "Where do you want to make a difference?"
		});
	</script>
	<script type="text/javascript">
		$(".js-example-basic-multiple4").select2({
			placeholder : "Select Your Skills"
		});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".js-example-basic-single").select2({
				allowClear : true
			});
		});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".js-example-basic-single-country").select2();
		});
	</script>

</body>
</html>