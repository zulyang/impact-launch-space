<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>	
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
 		rel="stylesheet">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register Page</title>
</head>
<body>
<h1>Register an account </h1>
	<form method="post" action="registernewuser">
		
		<fieldset>
		<label name ="username">Username</label> 
		<input name="username" type="text" required="required"/>
		</fieldset>
		
		<br /> 
		
		<fieldset>
		<label name="password">Password</label>
		<input	name="password" type="text"  required="required"/>
		</fieldset>
		
		<br /> 
		
		<fieldset>
		<label name="email">Email</label>
		<input name="email" type="text" required="required"/>
		</fieldset>
		
		<br /> 
		
		<input name="user_type" type="radio" value="individual">Individual <br/>
		<input name="user_type" type="radio" value="organization">Organization <br/>
		<hidden path="keep_me_signed_in"/>
		<input type="submit" value="Register" required="required"/>
	</form>

</body>
</html>