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
<body class="profile">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<nav class="navbar navbar-default navbar-fixed-top profileNav">
					<div class="container-fluid">
						<!-- Brand and toggle get grouped for better mobile display -->
						<div class="navbar-header">
							<button type="button" class="navbar-toggle collapsed"
								data-toggle="collapse"
								data-target="#bs-example-navbar-collapse-1"
								aria-expanded="false">
								<span class="sr-only">Toggle navigation</span> <span
									class="icon-bar"></span> <span class="icon-bar"></span> <span
									class="icon-bar"></span>
							</button>
							<a class="navbar-brand" href="index.jsp"> <img
								alt="ImpactLaunch.Space" id="logo"
								src="<%=request.getContextPath()%>/resources/img/"></a>
						</div>

						<!-- Collect the nav links, forms, and other content for toggling -->
						<div class="collapse navbar-collapse"
							id="bs-example-navbar-collapse-1">
							<form class="navbar-form navbar-left">
								<div class="form-group">
									<input type="text" class="form-control" placeholder="Search">
								</div>
							</form>
							<ul class="nav navbar-nav">
								<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown" role="button" aria-haspopup="true"
									aria-expanded="false">Projects <span class="caret"></span></a>
									<ul class="dropdown-menu">
										<li><a href="#">Action</a></li>
										<li><a href="#">Another action</a></li>
										<li><a href="#">Something else here</a></li>
										<li role="separator" class="divider"></li>
										<li><a href="#">Separated link</a></li>
										<li role="separator" class="divider"></li>
										<li><a href="#">One more separated link</a></li>
									</ul></li>
								<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown" role="button" aria-haspopup="true"
									aria-expanded="false">Resources <span class="caret"></span></a>
									<ul class="dropdown-menu">
										<li><a href="#">Action</a></li>
										<li><a href="#">Another action</a></li>
										<li><a href="#">Something else here</a></li>
										<li role="separator" class="divider"></li>
										<li><a href="#">Separated link</a></li>
										<li role="separator" class="divider"></li>
										<li><a href="#">One more separated link</a></li>
									</ul>
								</li>
								<li class="">
									<a class="navbar-brand" href="/index"> 
										<img
										alt="home" class="homeIcon"
										src="<%=request.getContextPath()%>/resources/img/homeIcon.png">
									</a>
								</li>
								<li class="profileIcons">
									<a class="navbar-brand" href="/alerts"> 
										<img
										alt="alerts" class="alertsIcon"
										src="<%=request.getContextPath()%>/resources/img/bellIcon.png">
									</a>
								</li>
								<li class="profileIcons">
									<a class="navbar-brand" href="/chat"> 
										<img
										alt="chat" class="chatIcon"
										src="<%=request.getContextPath()%>/resources/img/chatIcon.png">
									</a>
								</li>
								<li class="profileIcons">
									<a class="navbar-brand" href="/profile"> 
										<img
										alt="profilePicture" class="profilePictureIcon"
										src="<%=request.getContextPath()%>/resources/img/profilePicture.png">
									</a>
								</li>
								<li class="profileIcons">
									<a class="navbar-brand" href="/profile">Username</a>
								</li>
								<li class="profileIcons">
									<a class="navbar-brand" href="/options"> 
										<img
										alt="moreOptions" class="moreOptionsIcon"
										src="<%=request.getContextPath()%>/resources/img/3dotsIcon.png">
									</a>
								</li>
							</ul>
						</div>
						<!-- /.navbar-collapse -->
					</div>
					<!-- /.container-fluid -->
				</nav>

				<div class="col-lg-12 form_container profile_container">
					<form method="post" action="" class="form-horizontal profile_form">
						<div class="form-group">
							<img class="col-lg-12 col-sm-offset-4 col-md-offset-4 col-lg-offset-4 circle_profile_image" src="<%=request.getContextPath()%>/resources/img/rocketGirl.jpeg">
							<div class="col-lg-12 col-sm-offset-4 col-md-offset-4 col-lg-offset-4">
								<input type="file" name="pic" accept="image/*">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="username" required="required" type="text"
									class="form-control profileField" placeholder="Username">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="password" required="required" type="password"
									class="form-control profileField" placeholder="Password">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="repeatpassword" required="required" type="password"
									class="form-control profileField"
									placeholder="Repeat your password">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="companyName" required="required" type="text"
									class="form-control profileField" placeholder="Official name">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="companyEmail" required="required" type="email"
									class="form-control profileField"
									placeholder="Official email address">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<textarea rows="4" class="form-control profileField companyBio"
									placeholder="A short company bio"></textarea>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="sector" required="required" type="text"
									class="form-control profileField" placeholder="Sector">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="companyCountries" required="required" type="text"
									class="form-control profileField"
									placeholder="Countries in which organisation exists in">
							</div>
						</div>
						<br>
						<div class="form-radio center">
							<div class="offerSupport">
								<input name="user_type" required="required" type="radio"
									value="offer">Offer support
							</div>
							<div class="needSupport">
								<input name="user_type" required="required" type="radio"
									value="need">Need support
							</div>
							<div class="bothSupport">
								<input name="user_type" required="required" type="radio"
									value="both">Both
							</div>
						</div>
						<br>
						<div class="form-group">
							<div class="col-lg-12">
								<button type="submit" value="Save"
									class="btn btn-success profile_save">SAVE</button>
							</div>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>

</body>
</html>
