<%@page import="com.impactlaunchspace.dao.UserDAO"%>
<%@page import="com.impactlaunchspace.login.LoginService"%>
<%@page import="com.impactlaunchspace.entity.User"%>
<%@page
	import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
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
		//This JSP checks for session first.
		//To be inserted in all JSP pages.
		//Check current session, and start to authenticate. (USER)

		User u = (User) request.getSession().getAttribute("user");

		if (u == null || !u.getUser_role().equals("USER")) {
			//If no session, check for rememberMeCookie
			String cookieValue = "";
			Cookie cookies[] = request.getCookies();
			Cookie myCookie = null;
			//Goes through all the cookies and checks if there is the remember me cookie.
			if (cookies != null) {
				for (int i = 0; i < cookies.length; i++) {
					if (cookies[i].getName().equals("rememberMeCookie")) {
						cookieValue = cookies[i].getValue();
						//identify the user and authenticate.
						ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
						CookieDAO cookieDAO = (CookieDAO) context.getBean("cookieDAO");
						String username = cookieDAO.validateCookie(cookieValue);
						if (username != null) {
							//Return User and Put inside session.
							UserDAO userDAO = (UserDAO) context.getBean("userDAO");
							u = userDAO.findByUsername(username);
							request.getSession().setAttribute("user", u);
						}
						break;
					}
				}
			} else {
				response.sendRedirect("/");
			}
		}
	%>
</body>
</html>
