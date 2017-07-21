<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<form action="testmultiple" method="post">
		Resource category <input type="text" name="resourceCategory" id="resourceCategory"><br>

		Resource name <input type="text" name="resourceName" value=""><br>

		Resource description <input type="text" name="resourceDescription"
			value=""><br>
			
		Resource category2 <input type="text" name="resourceCategory" id="resourceCategory"><br>

		Resource name2 <input type="text" name="resourceName" value=""><br>

		Resource description2 <input type="text" name="resourceDescription"
			value=""><br>	

	<input type="submit" value="send">
	</form>
</body>
</html>