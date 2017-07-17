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

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<!--custom css codes -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/bootstrap-tagsinput.css" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<!--for multiple select (Select2)-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/bootstrap-tagsinput.js"></script>
</head>

<body>
	<div id="resourcesNeeded" class="form-group row">
		<div class="col-sm-9">
			<select id="cat1" class="js-example-basic-single-resourcecategory"
				name="cat1">
				<option></option>
				<c:forEach items="${resource_category_list}" var="item">
					<option value="${item.getSkillset()}">${item.getSkillset()}</option>
				</c:forEach>
			</select>
		</div>
		<div class="bs-example">
			<input id="resourceTags1" onChange="checkInput();"
				name="resourceTags1" type="text" data-role="tagsinput" />
		</div>
		<br> <br> <br>

	</div>

	<div class="col-sm-9">
		<input id="addResource" class="btn btn-info" type="button"
			value="Add Resource" />
	</div>

	<script type="text/javascript">
		$(document).ready(
				function() {
					$('#addResource').on(
							'click',
							function() {
								$('#resourcesNeeded').clone(true).insertAfter(
										'#resourcesNeeded');
								return false;
							});
				});
	</script>
	
	
</body>
</html>