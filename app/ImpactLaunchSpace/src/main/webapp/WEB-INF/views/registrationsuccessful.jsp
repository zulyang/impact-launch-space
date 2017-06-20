<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
You have successfully registered for an account, check your email to verify your account
${email}
<br/>
exit
<br/>
<a href="/verifyaccount"> Verify my account here</a>
<a href="/resendverification?email=${email}"> Resend my Verification Link</a>
</body>
</html>