<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
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

				<div class="col-lg-12 form_container" id="register_container">
					<h4 class="createAccount">Create a new account</h4>
					<form method="post" action="registernewuser"
						class="form-horizontal">
						<br>
						<div class="form-radio center">
							<div class="radio_indi">
								<input name="user_type" required="required" type="radio"
									value="individual">Individual
							</div>
							<div class="radio_org">
								<input name="user_type" required="required" type="radio"
									value="organization">Organisation
							</div>
						</div>
						<br>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="username" required="required" type="text"
									class="form-control field" placeholder="Username">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="password1" required="required" type="password"
									class="form-control field" placeholder="Password">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="password2" required="required" type="password"
									class="form-control field" placeholder="Repeat your password">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="email" required="required" type="email"
									class="form-control field" placeholder="Email address">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="submit" class="btn btn-success field"
									value="Register" id="register_button">
							</div>
						</div>
						<p class="registerError">${registerCheck}</p>
						<p class="registerError">${passwordCheck}</p>
						<p class="finePrint">By registering, you confirm that you
							agree with our Terms & Conditions and Privacy Policy.</p>
					</form>
				</div>

				<div class="col-lg-12 register_success" id="register_success"
					style="display: none;">
					<h4 class="register_success_message">Registration Successful</h4>
					<p class="success_verify_message">You have successfully
						registered for an account. A verification code has been sent to
						your email.</p>
					<a href="/verifyaccount" class="btn btn-info verify_account" id="verify_account"
						role="button">Verify My Account</a>
				</div>


				<input type="hidden" id="registerSuccess" name="registerSuccess"
					value="${registerSuccess}"> 
			</div> 
		</div>

	</div>

</body>
<script type="text/javascript">
	window.onload = function() {
		var registerCheckStatus = document.getElementById("registerSuccess").value;

		console.log(registerCheckStatus);

		if (registerCheckStatus.length > 0) {
			if ($('#register_container').css('display') !== 'none') {
				$('#register_success').show().siblings('div').hide();
				event.preventDefault();
			}
		}

	}
</script>
</html>
