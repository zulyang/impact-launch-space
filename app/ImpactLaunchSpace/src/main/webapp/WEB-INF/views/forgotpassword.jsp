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
<body class="signin">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

<%@include file="common/navigationLogin.jspf" %>

				<div class="col-lg-12 form_container">
					<h4 class="welcome">Forgot your password?</h4>
					<form action="forgotpassword" method="POST"
						class="form-horizontal forgot_form" id="forgotPasswordForm">
						<div class="form-group">
							<div class="col-lg-12">
								<input type="email" required id="usernameemail"
									name="usernameemail" class="form-control" id="inputEmail3"
									placeholder="Enter your email address">
							</div>
						</div>

						<div class="form-group">
							<div class="col-lg-12">
								<button type="submit" class="btn btn-info field" id="forgotPWSendEmailButton">Send Verification Email</button>
							</div>
						</div>
						<p id="forgotPasswordCheck">${forgotPasswordCheck}</p>
					</form>
					
					<div id="email_sent_prompt" style="display: none;">A verification email has been sent to your email address.
							Enter the 6 digits PIN number in the field below.</div>
					<div id="wait_prompt" style="display: none;">Please wait ...</div>
					
					<form action="verifyreset" method="POST"
						class="form-horizontal" id="verify_pin" style="display: none;">
						<div class="form-group resetPINdiv">
							<div class="col-lg-12">
								<input type="text" name="resetcode" class="form-control" required id="resetcode"
									placeholder="Enter your PIN">
								<input type="submit" id="submitPIN" class="btn btn-info" value="Submit"/>
							</div>
						</div>
						<input type="hidden" name="username" value="${username}"/>
						<input type="hidden" name="email" value="${email}"/>
						<p id="pinWrongMessage" style="display: none;">${pinWrongMessage}</p>
					</form>
					<a href="/login1" class="btn btn-default returnLogin" role="button">
					Return to Login</a>
				</div>

				<div class="col-lg-12 form_container" id="changePasswordForm"
					style="display: none;">
					<h4 class="welcome">Set your new password</h4>
					<form action="resetpassword" method="POST" class="form-horizontal">
						<div class="form-group">
							<div class="col-lg-12">
								<input type="password" name="password1" class="form-control field"
									id="password1" placeholder="Enter your new password">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="password" name="password2" class="form-control field"
									id="password2" placeholder="Repeat your password">
									<input type="hidden" name="username" value="${username}"/>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<button type="submit" class="btn btn-success field">CONFIRM</button>
							</div>
						</div>
						<p id="passwordUnmatchMsg">${passwordError}</p>
					</form>
				</div>

				<input type="hidden" id="forgotPasswordValidation"
						name="forgotPasswordValidation" value="${forgotPasswordCheck}">
					<input type="hidden" id="emailValue" name="emailValue"
						value="${email}"> 
					<input type="hidden" id="pinValue" name="pinValue"
						value="${pinWrongMessage}"> 
					<input type="hidden" id="correctPin" name="correctPin"
						value="${correctPin}"> 
					<input type="hidden" id="passwordUnmatch" name="passwordUnmatch"
						value="${passwordError}"> 

			</div>
		</div>

	</div>

</body>
<script type="text/javascript">
	window.onload = function() {
		var forgotPWvalidation = document.getElementById("forgotPasswordValidation").value;
		var emailValue = document.getElementById("emailValue").value;
		var pinValue = document.getElementById("pinValue").value;
		var passwordUnmatch = document.getElementById("passwordUnmatch").value;
		
		console.log(forgotPWvalidation.length);
		console.log(emailValue.length);
		console.log(pinValue);
		
		if ((forgotPWvalidation.length === 0 && emailValue.length > 0) || pinValue.length > 0) {
			if ($('#email_sent_prompt').css('display') == 'none' && $('#wait_prompt').css('display') == 'none') {
				$('#email_sent_prompt').show();
				$('#wait_prompt').show();
				event.preventDefault();
			}
		}
		
		setTimeout(function() { 
			showPinInput(); 
		}, 5000);
		
		var showPinInput = function() {
			if ((forgotPWvalidation.length === 0 && emailValue.length > 0) || pinValue.length > 0) {
				if ($('#verify_pin').css('display') == 'none') {
					$('#wait_prompt').hide();
					$('#verify_pin').show();
				}
			}
		};
		
		if (pinValue.length > 0 ) {
			$('#pinWrongMessage').show();
			event.preventDefault();
		}
		
		var correctPin = document.getElementById("correctPin").value;
		if (correctPin.length > 0 || passwordUnmatch.length > 0) {
			if ($('#forgotPasswordForm').css('display') !== 'none') {
				$('#changePasswordForm').show().siblings('div').hide();
				event.preventDefault();
			}
		}

	}
</script>
</html>
