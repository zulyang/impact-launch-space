<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Forgot Password</title>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
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
</head>
<body class="signin">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<%@include file="../common/navigationLogin.jspf"%>

				<div class="col-lg-12 form_container">
					<h4 class="welcome">Forgot your password?</h4>
					<form action="forgot-password" method="POST"
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
								<button type="submit" class="btn btn-info field"
									id="forgotPWSendEmailButton">Send Verification Email</button>
							</div>
						</div>
						<p id="forgotPasswordCheck">${forgotPasswordCheck}</p>
					</form>

					<a href="/" class="btn btn-default returnLogin" role="button">
						Return to Login</a>
				</div>
			</div>
		</div>

	</div>

</body>
</html>
