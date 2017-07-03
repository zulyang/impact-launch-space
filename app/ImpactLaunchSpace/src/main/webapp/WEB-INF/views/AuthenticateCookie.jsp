<%@page import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="com.impactlaunchspace.dao.CookieDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	//Included at the top of every view. 
	//First, check if there is a session in place. If yes, 
	//If not, whether there is a remember me cookie. If there is, authenticate with the database.
	//If authenticated, log in the user by adding his details into the session. If not, send back to landing page. 
	
	String cookieValue= "";
	Cookie cookies [] = request.getCookies();
	Cookie myCookie = null;
	//Goes through all the cookies and checks if there is the remember me cookie. 
	if (cookies != null)
	{
	 for (int i = 0; i < cookies.length; i++)
	    {
	    if (cookies [i].getName().equals ("rememberMeCookie"))
	    {
	        cookieValue = cookies[i].getValue();
	   	 //identify the user and authenticate. 
	   	 ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
	   	 CookieDAO cookieDAO = (CookieDAO) context.getBean("cookieDAO");
	   	 String username = cookieDAO.validateCookie(cookieValue);
	   	 if(username != null){
	   		 request.getSession().setAttribute("username", username);
	   	 }
	        break;
	    }
	   }
	 
		 
	}else{
		//redirect to index.jsp
		response.sendRedirect("/index");
		
	}

	%>
</body>
</html>