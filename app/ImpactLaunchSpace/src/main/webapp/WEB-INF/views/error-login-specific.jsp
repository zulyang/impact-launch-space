<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
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
	<h2>Something went wrong with your login! Oops</h2>

</body>
</html>