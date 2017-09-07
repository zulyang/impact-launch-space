<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Project</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/project/project.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/project/view_project_public.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css">
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.js"></script>

<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<link
	href="<%=request.getContextPath()%>/resources/lib/select2/select2.min.css"
	rel="stylesheet" />
<script
	src="<%=request.getContextPath()%>/resources/lib/select2/select2.min.js"></script>
<script>
function loader() {
	$(".se-pre-con").fadeOut("slow");
};
</script>
</head>

<body onload="loader()" class="project">
	<div class="se-pre-con"></div>
	<%@include file="../common/navigation.jspf"%>

	<!--main content-->
	<div class="main-content">
		<div class="container">
			<div class="row">
				<div class="content col-md-8 col-sm-12 col-xs-12">
					<div class="section-block">
						<div class="funding-meta">
							<h1 id="project_public_title">${selected_project.getProject_name() }</h1>
							<c:if test="${username.equals(selected_project.getProject_proposer()) }">
								<a href ="/edit-project?project-name=${selected_project.getProject_name()}&project-proposer=${selected_project.getProject_proposer() }" type="button" class="btn btn-success edit_project_public">Edit Project</a>
							</c:if>
							<c:if test="${username.equals(project_organization) }">
								<a href ="/edit-project?project-name=${selected_project.getProject_name()}&project-proposer=${selected_project.getProject_proposer() }" type="button" class="btn btn-success edit_project_public">Edit Project</a>
							</c:if>
							
							<br>
							<br>	
							<input type="hidden" name="project_name"
									value="${selected_project.getProject_name() }"> 
							<input type="hidden" name="project_proposer"
									value="${selected_project.getProject_proposer()}"> 
									
								<span class="type-meta">
								<i class="fa fa-user"></i> 
								<c:choose>
										<c:when test="${selected_project.getOrganization() != null}">
										${selected_project.getOrganization()}
									</c:when>
										<c:otherwise>
										${selected_project.getProject_proposer()}
									</c:otherwise>
								</c:choose>
								</span> 
								
								<span class="type-meta">
									<i class="fa fa-tag"></i> 
									<c:forEach
										items="${project_target_areas}" var="item" varStatus="loop">
										<a href="#">${item }</a>
										<c:if test="${!loop.last}">,</c:if>
									</c:forEach> 
								</span>				
								
							<!--img src="assets/img/image-heartbeat.jpg" class="img-responsive" alt="launch HTML5 Crowdfunding"-->
							<!-- https://player.vimeo.com/video/67938315 -->
							<div class="video-frame">
								<iframe src="${selected_project.getProjectVideo()}"
									width="500" height="281" frameborder="0" webkitallowfullscreen
									mozallowfullscreen allowfullscreen></iframe>
							</div>
							<p>${selected_project.getPurpose()}</p>
							
							<c:choose>
							  <c:when test="${progressPercentage == .00}">
							    <h2><strong>0.00 %</strong></h2>
								<span class="contribution">of project resources secured</span>
								<div class="progress">
									<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0"
										aria-valuemin="0" aria-valuemax="100" style="min-width: 2em;width: 0%;">
										<span class="progress-percentage">0%</span>
									</div>
								</div>
							  </c:when>

							  <c:otherwise>
							    <h2><strong>${progressPercentage} %</strong></h2>
								<span class="contribution">of project resources secured</span>
								<div class="progress">
									<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="${progressPercentage}"
										aria-valuemin="0" aria-valuemax="100" style="min-width: 2em;width: ${progressPercentage}%;">
										<span class="progress-percentage">${progressPercentage}%</span>
									</div>
								</div>
							  </c:otherwise>
							</c:choose>
							
						</div>
						<!-- <span class="count-down"><strong>27</strong>Days to go</span> -->
						
					</div>

					<!--tabs-->
					<div class="section-block">
						<div class="section-tabs">
							<ul class="nav nav-tabs" role="tablist">
								<li role="presentation" class="active"><a href="#about"
									aria-controls="about" role="tab" data-toggle="tab">About</a></li>
								<li role="presentation"><a href="#updates"
									aria-controls="updates" role="tab" data-toggle="tab">Updates</a></li>
							</ul>
						</div>
					</div>
					<!--/tabs-->
					<!--tab panes-->
					<div class="section-block">
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane active" id="about">
								<div class="about-information">
									<h1 class="section-title">ABOUT LAUNCH</h1>
									<p>${selected_project.getDescription()}</p>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane" id="updates">
								<div class="update-information">
									<h1 class="section-title">UPDATES</h1>
									<!--update items-->
									<div class="update-post">
										<h4 class="update-title">We've started shipping!</h4>
										<span class="update-date">Posted 2 days ago</span>
										<p>Suspendisse luctus at massa sit amet bibendum. Cras
											commodo congue urna, vel dictum velit bibendum eget.
											Vestibulum quis risus euismod, facilisis lorem nec, dapibus
											leo. Quisque sodales eget dolor iaculis dapibus. Vivamus sit
											amet lacus ipsum. Nullam varius lobortis neque, et efficitur
											lacus. Quisque dictum tellus nec mi luctus imperdiet. Morbi
											vel aliquet velit, accumsan dapibus urna. Cras ligula orci,
											suscipit id eros non, rhoncus efficitur nisi.</p>
									</div>
									<div class="update-post">
										<h4 class="update-title">Launch begins manufacturing</h4>
										<span class="update-date">Posted 9 days ago</span>
										<p>Suspendisse luctus at massa sit amet bibendum. Cras
											commodo congue urna, vel dictum velit bibendum eget.
											Vestibulum quis risus euismod, facilisis lorem nec, dapibus
											leo. Quisque sodales eget dolor iaculis dapibus. Vivamus sit
											amet lacus ipsum. Nullam varius lobortis neque, et efficitur
											lacus. Quisque dictum tellus nec mi luctus imperdiet. Morbi
											vel aliquet velit, accumsan dapibus urna. Cras ligula orci,
											suscipit id eros non, rhoncus efficitur nisi.</p>
									</div>
									<div class="update-post">
										<h4 class="update-title">Designs have now been finalized</h4>
										<span class="update-date">Posted 17 days ago</span>
										<p>Suspendisse luctus at massa sit amet bibendum. Cras
											commodo congue urna, vel dictum velit bibendum eget.
											Vestibulum quis risus euismod, facilisis lorem nec, dapibus
											leo. Quisque sodales eget dolor iaculis dapibus. Vivamus sit
											amet lacus ipsum. Nullam varius lobortis neque, et efficitur
											lacus. Quisque dictum tellus nec mi luctus imperdiet. Morbi
											vel aliquet velit, accumsan dapibus urna. Cras ligula orci,
											suscipit id eros non, rhoncus efficitur nisi.</p>
									</div>
									<!--/update items-->
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--/tabs-->
				<!--/main content-->
				<!--sidebar-->
				<div class="content col-md-4 col-sm-12 col-xs-12">
					<div class="section-block summary">
						<h1 class="section-title">OWNER</h1>
						<div class="profile-contents">
							<h2 class="position">${creator_name }</h2>
							<img
								src="/imageDisplay?username=${selected_project.getProject_proposer()}"
								class="project_proposer_img responsive"
								alt="John Smith Profile Photo">
							<!--social links-->
							<ul class="list-inline">
								<li><a href="#"><i class="fa fa-twitter"></i></a></li>
								<li><a href="#"><i class="fa fa-facebook"></i></a></li>
								<li><a href="#"><i class="fa fa-linkedin"></i></a></li>
							</ul>
							<!--/social links-->
							<a
								href="/view-profile?username=${selected_project.getProject_proposer()}"
								class="btn btn-contact"><i class="fa fa-user"></i>VIEW
								PROFILE</a>
						</div>
					</div>
					<div class="section-block">
						<h1 class="section-title">WHAT WE NEED</h1>
						<!--resources-->
						<c:set var="count" value="0" scope="page" />

						<c:forEach items="${project_resource_categories}" var="item"
							varStatus="loop">

							<div class="reward-block">
								<h3>Category ${loop.index + 1}: ${item}</h3>
								<!-- category -->
								<c:forEach var="type" items="${project_requested_resources}">
									<c:if test="${type.key.equals(item) }">

										<c:forEach var="item1" items="${type.value}">
											<h2>${item1.get(0)}</h2>
											<!-- name -->
											<p>${item1.get(1)}
												<!-- description -->
											</p>
											<c:set var="count" value="${count + 1}" scope="page" />
											<br>
											
											<!-- Amanda, this if loop is if theres is someone in the position -->
											<c:if test="${!item1.get(2).equals(\"Unfilled Position\")}">
												<span><i class="fa fa-users"></i> ${item1.get(2)}</span>
											</c:if>
											
											<!-- Amanda, this if loop is if theres is noone filling the position -->
											<c:if test="${item1.get(2).equals(\"Unfilled Position\")}">
												<span><i class="fa fa-users"></i><b> ${item1.get(2)} </b></span>
											</c:if>											
											<c:choose>
												
												<c:when
													test="${username.equals(selected_project.getProject_proposer())}">

												</c:when>
												
												<c:when
													test="${project_organization != null && username.equals(project_organization)}">

												</c:when>

												<c:when
													test="${userRequestsForProject.contains(item1.get(0))}">
													<c:choose>
														<c:when test="${userRequestsForProjectObjs.get(userRequestsForProject.indexOf(item1.get(0))).getRequest_status().equals(\"Accepted\")}">
															<button onClick="apply()" type="button"
																id="applyForResource" class="btn btn-success" disabled>ACCEPTED</button>
														</c:when>
														
														<c:when test="${userRequestsForProjectObjs.get(userRequestsForProject.indexOf(item1.get(0))).getRequest_status().equals(\"Confirmed\")}">
															<button onClick="apply()" type="button"
																id="applyForResource" class="btn btn-success" disabled>CONFIRMED</button>
														</c:when>
														
														<c:otherwise>
															<button onClick="apply()" type="button"
																id="applyForResource" class="btn btn-reward" disabled>APPLIED</button>
														</c:otherwise>
													
													</c:choose>
													
												</c:when>
												
												<c:when test="${item1.get(2).equals(\"Unfilled Position\")}">
													<button onClick="apply(${count})" type="button"
														id="applyForResource" class="btn btn-reward applyButton">APPLY</button>
												</c:when>

												<c:otherwise>
													
												</c:otherwise>
												
											</c:choose>


											<div class="modal fade" tabindex="-1" role="dialog"
												id="myModal${count}">
												<div class="modal-dialog">
													<div class="modal-content">

														<form action="sendApplyRequest" method="post">
															<!-- These 2 fields are for parsing the attirbutes -->
															<input type="hidden" name="project_name"
																value="${selected_project.getProject_name() }">
															<input type="hidden" name="project_proposer"
																value="${selected_project.getProject_proposer()}">
															<div class="modal-header">
																<button type="button" class="close" data-dismiss="modal"
																	aria-label="Close">
																	<span aria-hidden="true">&times;</span>
																</button>
																<h4 class="modal-title">Applying for
																	${item1.get(0)}</h4>
															</div>

															<div class="modal-body">
																<div class="container">
																	<div id="resourcesNeeded"
																		class="form-group row col-md-5">
																		<div class="col-md-12">
																			<input type="hidden"
																				id="selected_resource_category${count}"
																				name="selected_resource_category" value="${item}">
																			<br> <input type="hidden"
																				id="selected_requested_resource"
																				name="selected_requested_resource"
																				value="${item1.get(0)}">
																			<h2>My Resources under category: ${item}</h2>
																			<h4>
																				(Select one from your available resources) <select
																					class="js-example-basic-single-userresource"
																					name="selected_resource_name"
																					id="selected_resource_name" required
																					style="width: 40rem">
																				</select>
																			</h4>
																			<h3>
																				Resource Description <br>
																				<textarea type="text" rows="4"
																					name="selected_resource_desc" style="width: 40rem"
																					class="form-control modal_details"
																					id="selected_resource_desc${count}" readonly></textarea>
																			</h3>

																			<h3>
																				Add a personal note <br>
																				<textarea type="text" style="width: 40rem"
																					class="form-control modal_details" rows="5"
																					name="personal_note" id="personal_note" value=""
																					placeholder="Add a personal note..."></textarea>
																			</h3>
																		</div>
																	</div>
																</div>
															</div>

															<div class="modal-footer">
																<button type="button" class="btn btn-default"
																	data-dismiss="modal">Cancel</button>
																<button type="submit" id="add" class="btn btn-success">Apply
																	for resource</button>
															</div>
														</form>

													</div>
												</div>
											</div>

										</c:forEach>
									</c:if>
								</c:forEach>


							</div>

						</c:forEach>

						<!--/resource-->
					</div>
				</div>
				<!--/sidebar-->
			</div>



		</div>
	</div>
	<!-- Template JS -->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/resources/js/main.js"></script>

	<script>
		function apply(count) {
			var selected_resource_category = $('#selected_resource_category'+ count).val();
			var selects = document.getElementsByName('selected_resource_name');
			var select = selects[count-1];
			
			$('#selected_resource_name').empty();
			select.options.length = 0;
			$('#selected_resource_desc' + count).val('');
			
			var blankoption = document.createElement('option');
			blankoption.value = "";
			blankoption.innerHTML = "";
		    select.appendChild(blankoption);
		    
			$.post('obtainUserResources', {
				selected_resource_category : selected_resource_category
			}, function(responseJson) {
				$.each(responseJson,function(key,value) {
					var opt = document.createElement('option');
				    opt.value = value.resourceName;
				    opt.innerHTML = value.resourceName;
				    select.appendChild(opt);
				});
			});
			
			$('#myModal' + count).modal('show');
			
			$(select).change(function(event) {
				var resourceCategory = $('#selected_resource_category'+ count).val();
				var resourceName = $(select).val();
				$.post('getResourceDescription', {
					resourceName : resourceName,
					resourceCategory : resourceCategory
				}, function(responseText) {
					$('#selected_resource_desc' + count).val(responseText);
				});
			});
		};
	</script>

	<script type="text/javascript">
		$(".js-example-basic-single-userresource").select2({
			placeholder : "Select from your existing resources: ",
			allowClear : true
		});
	</script>

	<script>
		    $(document).ready(function() {

				$('#myModal').on(
				'hidden.bs.modal',
				function() {
					$(this).find("select,#personal_note,#selected_resource_desc").val('').end();
				});
			});
	
	</script>
</body>



</html>