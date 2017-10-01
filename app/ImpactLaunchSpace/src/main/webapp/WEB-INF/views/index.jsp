<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>ImpactLaunch.Space</title>
<link rel="icon" type="image/png"
	href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/parallax.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/index.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/password-rules-helper/dist/css/passwordRulesHelper.min.css" />
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<script
	src="https://www.solodev.com/assets/parallax/jquery.localscroll-1.2.7-min.js"></script>
<script
	src="https://www.solodev.com/assets/parallax/jquery.parallax-1.1.3.js"></script>
<script
	src="https://www.solodev.com/assets/parallax/jquery.scrollTo-1.4.2-min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/scrolling.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/password-rules-helper/dist/js/passwordRulesHelper.min.js"></script>
</head>
<body class="landing">
	<div class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/"> 
					<img alt="ImpactLaunch.Space" id="brand_image" src="<%=request.getContextPath()%>/resources/img/logo2.png">
				</a>
			</div>
			<div class="collapse navbar-collapse">
				<form class="navbar-form navbar-right" id="header-form" role="form"
					action="authenticate" method="POST">
					<div class="lt-left">
						<div class="form-group">
							<div>
								<label for="exampleInputEmail2">Email or Phone</label>
							</div>
							<input name="usernameemail" type="text" required
								class="form-control input-sm" id="inputEmail3"
								placeholder="Email or Username">
						</div>
						<div class="form-group">
							<div>
								<label for="exampleInputPassword2">Password</label>
							</div>
							<input name="password" id="inputPassword3" type="password" required
								class="form-control input-sm" id="exampleInputPassword2"
								placeholder="Password">
						</div>
						<div class="checkbox">
							<label> <input name="rememberMe" type="checkbox"
								value="true"> Remember me
							</label> <label> <a class="forgot_password"
								href="/forgot-password">Forgot password</a></label>
						</div>
					</div>
					<div class="lt-right">
						<button type="submit" class="login-btn">Login</button>
					</div>
					<p style="color:red;" class="loginValidation">${loginValidation}</p>
				</form>
			</div>
		</div>
	</div>

	<div class="container-parallax">
		<div id="intro">
			<div class="story">
				<div class="float-left">
					<div class="col-md-12 register_container">
						<form action="registernewuser" method="post" class="form"
							role="form">
							<h3>Create your account</h3>
							<label class="radio-inline"> <input name="user_type"
								required="required" type="radio" value="individual"
								id="inlineCheckbox1" /> Individual
							</label> <label class="radio-inline"> <input name="user_type"
								required="required" type="radio" value="organization"
								id="inlineCheckbox2" /> Organization
							</label> <br /> <br /> <input class="form-control input-lg"
								name="username" required="required" type="text"
								placeholder="Username" /> <input class="form-control input-lg"
								name="email" required="required" type="email"
								placeholder="Email address" /> <input
								class="form-control input-lg" name="password1" id="password1"
								required="required" placeholder="New Password" type="password" />
							<input name="password2" id="password2" required="required"
								class="form-control input-lg" name="password"
								placeholder="Repeat your password" type="password"
								onChange="checkPasswordMatch();" />
							<div class="col-lg-12 password_match_message"
								id="divCheckPasswordMatch"></div>
							<p class="registerError">${registerCheck}</p>
							<p class="registerError">${passwordCheck}</p>
							<button class="btn btn-lg btn-primary btn-block signup-btn"
								type="submit">Create my account</button>
						</form>
					</div>
				</div>
			</div>
			<!--.story-->
		</div>
		<!--#intro-->
		<div id="second">
			<div class="bg"></div>
			<div class="story">
				<div class="float-right">
					<h2>Impacting People, Changing Lives</h2>
					<p>A unique and simple online tool to allow projects and those
						looking to give back to share project ideas, communicate and
						collaborate to enable transformational change for those who need
						support most.</p>
					<button type="button" class="btn-learn click" name="learnMore">Learn
						More</button>
				</div>
			</div>
			<!--.story-->
		</div>
		<!--#second-->
		<div id="third">
			<div class="story">
				<div class="float-left">
					<h2>Are You An Innovator Or A Giver?</h2>
					<h4>I Am An Innovator</h4>
					<p>If you have a social mission, we'll connect you directly to
						skilled professionals that want to donate their time and
						expertise. These people come from around the world and have a wide
						variety of skills. As a fellow social enterprise, we do not charge
						other social impact organizations fees.</p>
					<h4>I Am A Giver</h4>
					<p>We connect you to inspiring social impact projects around
						the world that will benefit from your skills.</p>
				</div>
			</div>
			<!--.story-->
		</div>
		<!--#third-->
		<div id="fourth">
			<div class="explore_story">
			<div class="float-right">
				<h2>Explore</h2>
				<p>Browse social impact projects near you.</p>
				<a href="/search-project" class="btn-learn explore_btn">Explore
					Projects</a>
					</div>
			</div>
		</div>

		<div id="footer">
			<p>Allied World Healthcare © 2017</p>
		</div>
	</div>

</body>

<script type="text/javascript">
	$(function() {
		$('#password1').passwordRulesValidator();
	});

	function checkPasswordMatch() {
		var password = $("#password1").val();
		var confirmPassword = $("#password2").val();

		if (password != confirmPassword)
			$("#divCheckPasswordMatch").html("Passwords do not match!").css(
					'color', 'red');
		else
			$("#divCheckPasswordMatch").html("Passwords match.").css('color',
					'green');
	}

	$(document).ready(function() {
		$("#password1, #password2").keyup(checkPasswordMatch);
	});
</script>

</html>