<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Oops!</title>
<link rel="icon" type="image/png"
	href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
	<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/error.css" />
</head>
<body>
	<%
		String username = (String) request.getSession().getAttribute("username");
		System.out.println("username: " + username);

		if (username == null) {
	%>
	<%@include file="./common/navigation_not_logged_in.jspf"%>
	<%
		} else {
	%>
	<%@include file="./common/navigation.jspf"%>
	<%
		}
	%>
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
						<p>Something went wrong with your login. Please try again.</p>
						<div class="error-button">
								<a href="/" class="btn-error-home">Back To Login</a>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

</body>
</html>