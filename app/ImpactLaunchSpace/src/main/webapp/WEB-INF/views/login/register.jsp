<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>ImpactLaunch.Space</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/password-rules-helper/dist/css/passwordRulesHelper.min.css" />
<script src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/password-rules-helper/dist/js/passwordRulesHelper.min.js"></script>

</head>

<body class="signup">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">


				<div class="col-lg-12 register_container" id="register_container">
					<h4 style="position: relative;">Create a new account</h4>
					<form method="post" action="registernewuser"
						class="form-horizontal" style="padding-top: 2rem;">
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
						<div class="form-group" style="margin-bottom: 0px;">
							<div class="col-lg-12">
								<input name="password1" id="password1" required="required" type="password"
									class="form-control field" placeholder="Password">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="password2" id="password2" required="required" type="password"
									class="form-control field" placeholder="Repeat your password" onChange="checkPasswordMatch();">
							</div>
							
							<div class="col-lg-12 password_match_message" id="divCheckPasswordMatch"></div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="email" required="required" type="email"
									class="form-control field" placeholder="Email address">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="submit" style="width: 100%;" class="btn btn-success field"
									value="Register" id="register_button">
							</div>
						</div>
						<p class="registerError">${registerCheck}</p>
						<p class="registerError">${passwordCheck}</p>
						<p class="finePrint">By registering, you confirm that you
							agree with our Terms & Conditions and Privacy Policy.</p>
					</form>
				</div>

<%@include file="../common/navigationLogin.jspf" %>
				<div class="col-lg-12 register_success" id="register_success"
					style="display: none;">
					
<%@include file="../common/navigationLogin.jspf" %>
					
					<h4 class="register_success_message">Registration Successful</h4>
					<p class="success_verify_message">You have successfully
						registered for an account.<br> A verification code has been sent to
						your email.</p>
					<a href="/verify-account" class="btn btn-info verify_account" id="verify_account"
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

		if (registerCheckStatus.length > 0) {
			if ($('#register_container').css('display') !== 'none') {
				$('#register_success').show().siblings('div').hide();
				event.preventDefault();
			}
		}

	}
</script>

<script type="text/javascript">
$(function() {
    $('#password1').passwordRulesValidator();
});	


function checkPasswordMatch() {
    var password = $("#password1").val();
    var confirmPassword = $("#password2").val();

    if (password != confirmPassword)
        $("#divCheckPasswordMatch").html("Passwords do not match!").css('color', 'red');
    else
        $("#divCheckPasswordMatch").html("Passwords match.").css('color','green');
}

$(document).ready(function () {
   $("#password1, #password2").keyup(checkPasswordMatch);
});

</script>
</html>
