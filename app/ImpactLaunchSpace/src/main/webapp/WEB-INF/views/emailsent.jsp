<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1> Hi ${username}, an email has been sent to your account: ${email}.</h1>

<h2>Enter your verification code here:</h2>
<br/>
<form action="verifyreset" method="POST">
		6 Digit PIN:
		<input type="text" name="resetcode"/>
		</br>
		<input type="hidden" name="username" value="${username}"/>
		<input type="hidden" name="email" value="${email}"/>
		<input type="submit" value="Login"/>
</form>
</body>
</html>