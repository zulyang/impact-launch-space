<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reset your password</title>
</head>
<body>
<h1>Reset your password here. User is logged in at this point.</h1>

Username: <input type="text" value="${username }" disabled/>
<form action="resetpassword" method="POST">
		New Password:
		<input type="password" name="password1"/>
		<br/>
		Confirm New Password:
		<input type="password" name="password2"/>
		<input type="hidden" name="username" value="${username}"/>
		</br>
		<input type="submit" value="Set a new password"/>
</form>

</body>
</html>