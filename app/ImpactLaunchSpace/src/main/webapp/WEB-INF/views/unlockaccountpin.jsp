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

<body class="unlockaccount">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

<%@include file="common/navigationLogin.jspf" %>

				<div class="col-lg-12 form_container">
					<h4 class="unlockAccountMessage">Enter your verification
						token.</h4>
					<form class="form-horizontal" action="processunlockaccount"
						method="POST">
						<div class="form-group">
							<div class="col-lg-12">
								<input name="resetcode" type="text" class="form-control field"
									id="inputEmail3" placeholder="Enter your verification token">
								<input type="hidden" name="username" value="${username}" /> <input
									type="hidden" name="email" value="${email}" />
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<button type="submit" class="btn btn-success field">Unlock
									my account</button>
							</div>
						</div>
						<p class="unlockAccountPin">${unlockAccountPin}</p>

					</form>
				</div>
			</div>
		</div>

	</div>

</body>
</html>