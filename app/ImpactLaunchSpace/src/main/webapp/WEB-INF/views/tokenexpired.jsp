<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	Token has expired, check your email for the new one. 
	<a href="/verifyaccount"> Verify my account here</a>
	<a href="/resendverification?email=${email}"> Resend my Verification Link</a>
</body>
</html>