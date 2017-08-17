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
<script src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
</head>

<body class="signin">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

<%@include file="../common/navigationLogin.jspf" %>
				<div class="col-lg-12 form_container">
					<h4 id="welcome" class="welcome">Welcome!</h4>
					<h4 id="unlockAccountPinMessage" class="unlockAccountPinMessage" style="display: none;">${unlockAccountPin}
					</h4>
					<form class="form-horizontal" action="authenticate" method="POST">
						<div class="form-group">
							<div class="col-lg-12">
								<input name="usernameemail" type="text"
									class="form-control field" id="inputEmail3"
									placeholder="Username or Email">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="password" type="password"
									class="form-control field" id="inputPassword3"
									placeholder="Password">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<div class="checkbox remember">
									<label> <input name="rememberMe" type="checkbox"
										value="true"> Remember me
									</label>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<button type="submit" class="btn btn-success field">Login</button>
							</div>
						</div>
						<p style="color:red;" class="loginValidation">${loginValidation}</p>

						<div class="forget">
							<a href="/forgot-password">Forget your password?</a>
							<br>
							Account locked?<a href="/unlock-account">Click here</a>
						</div>
					</form>
				</div>

				<input type="hidden" id="unlockAccountPin" name="unlockAccountPin" value="${unlockAccountPin}">
			</div>
		</div>

	</div>

</body>

<script type="text/javascript">
	window.onload = function() {
		var unlockAccountStatus = document.getElementById("unlockAccountPin").value;

		if (unlockAccountStatus.length > 0) {
			$('#welcome').hide();
			$('#unlockAccountPinMessage').show()
			event.preventDefault();
		}
	}
</script>
</html>
