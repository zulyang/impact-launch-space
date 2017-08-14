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
</head>
<body class="signin">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<%@include file="../common/navigationLogin.jspf"%>

				<div class="col-lg-12 form_container" id="changePasswordForm">
					<h4 class="welcome">Set your new password</h4>
					<form action="resetpassword" method="POST" class="form-horizontal">
						<div class="form-group">
							<div class="col-lg-12">
								<input type="password" name="password1"
									class="form-control field" id="password1"
									placeholder="Enter your new password">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="password" name="password2"
									class="form-control field" id="password2"
									placeholder="Repeat your password"> <input
									type="hidden" name="username" value="${username}" />
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
			</div>
		</div>

	</div>

</body>
</html>
