<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
 		rel="stylesheet">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1>Login Page to Test Hashing</h1>
	<form action="authenticate" method="POST">
		Username/Email:
		<input type="text" name="username"/>
		Password:
		<input type="password" name="password"/>
		</br>
		<input type="checkbox" name="rememberMe"/> Keep me Signed in
		</br>
		<input type="submit" value="Login"/>
	</form>
	
	<a href="/forgotpassword">Forgot Your Password?</a>
</body>
</html>