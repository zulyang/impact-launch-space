<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Verify Account</title>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/app.css" />
<script src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
</head>

<body class="signup">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

<%@include file="../common/navigationLogin.jspf" %>
				<div class="col-lg-12 verify_container" id="verify_container">
					<h4 class="verifyAccountMessage">Verify your account</h4>
					<form method="post" class="form-horizontal" action="verify-account">
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
					<a href="/login" class="btn btn-success signInNowBox">SIGN IN NOW</a>
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
			</div>
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