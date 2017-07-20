<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ImpactLaunch.Space</title>
</head>
<body>
	<div>
		<h4 class="welcome">Set your new password</h4>
		<form action="changepassword" method="POST" class="form-horizontal">
			<div class="form-group">
				<div class="col-lg-12">
					<input type="password" name="existingPassword" class="form-control field"
						id="password1" placeholder="Enter your existing password">
				</div>
				<div class="col-lg-12">
					<input type="password" name="password1" class="form-control field"
						id="password1" placeholder="Enter your new password">
				</div>
			</div>
			<div class="form-group">
				<div class="col-lg-12">
					<input type="password" name="password2" class="form-control field"
						id="password2" placeholder="Repeat your password"> <input
						type="hidden" name="username" value="${username}" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-lg-12">
					<button type="submit" class="btn btn-success field">CONFIRM</button>
				</div>
			</div>
			<p id="passwordChangedMsg">${passwordValidation}</p>
			<p id="passwordUnmatchMsg">${passwordError}</p>
		</form>
	</div>
</body>
</html>