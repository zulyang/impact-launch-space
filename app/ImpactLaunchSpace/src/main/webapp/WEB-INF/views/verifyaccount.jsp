<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ImpactLaunch.Space</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<!--custom css codes -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
	integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
	crossorigin="anonymous"></script>
	
	
</head>
<body class="signup">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

<%@include file="common/navigationLogin.jspf" %>
				<div class="col-lg-12 verify_container" id="verify_container">
					<h4 class="verifyAccountMessage">Verify your account</h4>
					<form method="post" class="form-horizontal" action="verifyaccount">
						<div class="form-group">
							<div class="col-lg-12">
								<input type="text" name="usernameemail"
									class="form-control field" placeholder="Username/Email">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="password" name="password"
									class="form-control field" placeholder="Password">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="text" name="verificationcode"
									class="form-control field" placeholder="Verification code">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<button type="submit" value="Register"
									class="btn btn-success field" id="verify_button">Submit</button>
							</div>
						</div>
						<p style="color:red;" class="verifyNewAccount">${verifyNewAccount}</p>
					</form>
				</div>


				<div class="col-lg-12 verify_success" id="verify_success"
					style="display: none;">
					<h4 class="verify_success_message">Verification Successful</h4>
					<p>Hi ${usernameemail}, your account has been verified!</p>
					<a href="/login1" class="btn btn-success signInNowBox">SIGN IN NOW</a>
					<a href="/" class="btn btn-default returnHome" role="button">Return
						to Home</a>
				</div>

				<input type="hidden" id="registerCheck" name="registerCheck"
					value="${registerCheck}"> <input type="hidden"
					id="verifyNewAccount" name="verifyNewAccount"
					value="${verifyNewAccount}"> <input type="hidden"
					id="verifyNewAccountSuccess" name="verifyNewAccountSuccess"
					value="${verifyNewAccountSuccess}">
			</div>
	</body>
 
 <script type="text/javascript">
	window.onload = function() {
		var verifyNewAccountStatus = document
				.getElementById("verifyNewAccount").value;
		var verifyNewAccountSuccessStatus = document
				.getElementById("verifyNewAccountSuccess").value;

		if (verifyNewAccountStatus.length > 0) {
			$('#register_container').hide();
			$('#register_success').hide();
			$('#verify_container').show();
			event.preventDefault();
		}

		if (verifyNewAccountSuccessStatus.length > 0) {
			$('#register_container').hide();
			$('#register_success').hide();
			$('#verify_container').hide();
			$('#verify_success').show();
			event.preventDefault();
		}
	}
</script>
</html>