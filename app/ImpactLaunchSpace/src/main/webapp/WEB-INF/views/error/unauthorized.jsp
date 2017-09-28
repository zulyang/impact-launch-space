<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Unauthorized Access</title>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.css">
	<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/error.css" />
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>

<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
</head>

</head>
<body>
	<div class="container-fluid" id="error">
		<div class="row">
			<div class="app-error-container">
				<div class="app-error-card">
					<img src="<%=request.getContextPath()%>/resources/img/Meteor.png"
						alt="Oops!" class="app-error-image">
					<div class="error-header">Oops!</div>
					<div class="error-subheader">Looks like you are lost in
						space...</div>
					<div class="error-message">
						<p>You do not have authorized access to this page.</p>
						<div class="error-button">
								<a href="" class="btn-error-home" onclick="history.back(-1)">Back</a>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>


</body>

</html>