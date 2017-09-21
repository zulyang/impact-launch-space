<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>ImpactLaunch.Space</title>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/parallax.css" />

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
</head>
<body class="landing">
	<div class="container-parallax">
		<%@include file="common/navigationLogin.jspf"%>
		<div id="intro">
			<div class="story">
				<div class="float-left">
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
		<!--#intro-->
		<div id="second">
			<div class="bg"></div>
			<div class="story">

				<div class="float-right">
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
		<!--#second-->
		<div id="third">
			<div class="explore_story">
				<div class="float-left">
					<h2>Explore</h2>
					<p>Browse social impact projects near you.</p>
					<a href="/search-project" class="btn-learn">Explore Projects</a>
				</div>
			</div>
			<!--.story-->
		</div>
		<!--#third-->
		<div id="fourth">
			<div class="linked_story">
				<div class="float-right">
					<h2 style="padding-bottom: 20px;">Get Started</h2>
					<a href="/register" class="btn-learn">Register Now</a>
				</div>
			</div>
		</div>

		<div id="footer">
			<p>Allied World Healthcare © 2017</p>
		</div>
	</div>
</body>
</html>