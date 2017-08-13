<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>ImpactLaunch.Space</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<style>
#resetcode {
	float: left;
	width: 15rem;
	margin-right: 2rem;
}

#submitPIN {
	float: left;
	width: 12rem;
	margin-left: 1rem;
}

#email_sent_prompt {
	margin-top: -8rem;
	width: 30rem;
	position: absolute;
}

#wait_prompt {
	position: absolute;
}
</style>
</head>
<body class="signin">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<%@include file="../common/navigationLogin.jspf"%>

				<div class="col-lg-12 form_container">
					<h4 class="welcome">Forgot your password?</h4>

					<div id="email_sent_prompt">A
						verification email has been sent to your email address. Enter the
						6 digits PIN number in the field below.</div>
					<div id="wait_prompt">Please wait ...</div>

					<form action="verifyreset" method="POST" style="display: none;" class="form-horizontal"
						id="verify_pin">
						<div class="form-group resetPINdiv">
							<div class="col-lg-12">
								<input type="text" name="resetcode" class="form-control"
									required id="resetcode" placeholder="Enter your PIN"> 
								<input type="submit" onclick="hideTokenInput()" id="submit_token" class="btn btn-info" value="Submit" />
							</div>
						</div>
						<input type="hidden" name="username" value="${username}" /> 
						<input
							type="hidden" name="email" value="${email}" />
						<p id="pinWrongMessage">${pinWrongMessage}</p>
					</form>
					<a href="/login1" class="btn btn-default returnLogin" role="button">
						Return to Login</a>
				</div>

				<input type="hidden" id="emailValue" name="emailValue"
					value="${email}"> 
				<input type="hidden" id="pinValue"
					name="pinValue" value="${pinWrongMessage}"> 
				<input
					type="hidden" id="correctPin" name="correctPin"
					value="${correctPin}"> 
				<input type="hidden"
					id="passwordUnmatch" name="passwordUnmatch"
					value="${passwordError}">

			</div>
		</div>

	</div>

</body>
<script type="text/javascript">
	window.onload = function() {
		setTimeout(function(){ showPinInput(); }, 4000);
		
		var showPinInput = function() {
			$('#wait_prompt').hide();
			$('#verify_pin').show();
		};
	}
</script>
</html>
