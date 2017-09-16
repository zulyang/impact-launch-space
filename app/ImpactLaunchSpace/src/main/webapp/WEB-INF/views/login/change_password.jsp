<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Change My Password</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.css">
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>


</head>
<body>
	<div>
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-12 col-md-12 col-lg-12">

					<!--navigation bar  -->
					<%@include file="../common/navigation.jspf"%>

					<div class="change-password-container">
						<h4>Set your new password</h4>
						<form action="change-password" method="POST"
							class="form-horizontal">
							<div class="form-group">
								<div class="col-lg-12">
									<input type="password" name="existingPassword"
										class="form-control field" id="password1"
										placeholder="Enter your existing password">
								</div>
							</div>
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
							<p id="passwordChangedMsg">${passwordValidation}</p>
							<p id="passwordUnmatchMsg">${passwordError}</p>
						</form>

					</div>
				</div>
			</div>
		</div>
</body>
</html>