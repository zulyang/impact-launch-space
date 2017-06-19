<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>Verify your account here</h1>

<form method="post" action="verifyaccount">
		
		<fieldset>
		<label name ="usernameemail">Username/Email</label> 
		<input name="usernameemail" type="text" required="required"/>
		</fieldset>
		
		<br /> 
		
		<fieldset>
		<label name="password">Password</label>
		<input	name="password" type="text"  required="required"/>
		</fieldset>
		
		<fieldset>
		<label name="verificationcode">Verification Code</label>
		<input	name="verificationcode" type="text"  required="required"/>
		</fieldset>
		
		<input type="submit" value="Submit"/>
</form>
</body>
</html>