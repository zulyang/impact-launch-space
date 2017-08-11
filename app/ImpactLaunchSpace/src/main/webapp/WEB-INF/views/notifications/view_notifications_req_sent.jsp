<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Notifications</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/resource.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/project.css" />
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
</head>

<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">
				<%@include file="../common/navigation.jspf"%>

				<div class="manage-resource-container">
					<div class="container">
						<div class="row">
							<h2>My Notifications</h2>
							<hr>
							<div class="col-xs-6 col-sm-3">
								<div id="accordion" class="panel panel-primary behclick-panel">
									<div class="panel-heading">
										<h3 class="panel-title">Impact Launch.Space</h3>
									</div>
									<div class="panel-body">
										<div class="panel-heading ">
											<h4 class="panel-title">Messages</h4>
										</div>
										<div class="panel-collapse collapse in">
											<ul class="list-group">
												<li class="list-group-item"><a
													href="/notifications/messages/inbox">Inbox<span
														class="badge pull-right">${inboxSize }</span></a></li>
												<li class="list-group-item"><a
													href="/notifications/messages/sent">Sent<span
														class="badge pull-right">${sentSize }</span></a></li>
											</ul>
										</div>

										<div class="panel-heading">
											<h4 class="panel-title">Requests</h4>
										</div>
										<div class="panel-collapse collapse in">
											<ul class="list-group">
												<li class="list-group-item"><a
													href="/notifications/requests/inbox">Received <span
														class="badge pull-right">${userRequestsSize }</span></a></li>
												<li class="list-group-item-selected"><a
													href="/notifications/requests/sent">Sent <span
														class="badge pull-right">${userSentRequestsSize }</span></a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="col-xs-6 col-sm-9">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h3 class="panel-title">Requests Inbox</h3>
									</div>
									<div class="panel-body">
										<div class="table-responsive col-md-12">
											<table class="table table-striped table-hover">
												<thead>
													<tr>
														<th>Project Proposer</th>
														<th>Project Name</th>
														<th>Resource Category</th>
														<th>Requested Resource</th>
														<th>Offered Resource</th>
														<th>Status</th>
													</tr>
												</thead>
												<tbody id="userNotificationsTable">
													<%
														int id = 0;
													%>
													<c:forEach items="${userSentRequests}" var="item">


														<tr id="row<%=++id%>">
															<td><p>
																	<input class="editable-field form-control"
																		id="offerer<%=id%>" type="text"
																		value="${item.getProject_proposer() }" disabled="true" />

																</p></td>
															<td><p>
																	<input class="editable-field form-control"
																		id="projname<%=id %>" type="textarea"
																		value="${item.getProject_name()}" disabled="true" />
																</p></td>
															<td><p>
																	<input class="editable-field form-control"
																		id="resourcecategory<%=id%>" type="text"
																		value="${item.getRequested_resource_category() }"
																		disabled="true" />
																</p></td>
															<td><p>
																	<input class="editable-field form-control"
																		id="requestedresourcename<%=id%>" type="text"
																		value="${item.getRequested_resource_name() }"
																		disabled="true" />
																</p></td>

															<td><p>
																	<input class="editable-field form-control"
																		id="offeredresourcename<%=id%>" type="text"
																		value="${item.getOffered_resource_name() }"
																		disabled="true" />
																</p></td>
															<td><p>
																	<input class="editable-field form-control"
																		id="status<%=id%>" type="text"
																		value="${item.getRequest_status() }" disabled="true" />
																</p></td>
															<td class="col-md-2"><p>
																	<button id="view<%=id%>" type="btn" name="view"
																		class="btn btn-primary edit" onClick="view(this.id)"
																		href="#">View</button>
																</p></td>
														</tr>
														<input class="editable-field form-control"
															id="offeredresourcedesc<%=id%>" type="hidden"
															value="${item.getOffered_request_description() }"
															disabled="true" />

														<input class="editable-field form-control"
															id="proposer<%=id%>" type="hidden"
															value="${item.getProject_proposer() }" disabled="true" />

														<input class="editable-field form-control"
															id="offercomments<%=id%>" type="hidden"
															value="${item.getOffer_comments() }" disabled="true" />
													</c:forEach>
												</tbody>
											</table>

											<div class="pull-right">
												<ul class="pagination">
													<li><a href="#">&laquo;</a></li>
													<li><a href="#">1</a></li>
													<li><a href="#">2</a></li>
													<li><a href="#">3</a></li>
													<li><a href="#">&raquo;</a></li>
												</ul>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>



				<!-- View Request modal-->
				<div class="modal fade" tabindex="-1" role="dialog"
					id="viewRequestModal">
					<div class="modal-dialog">
						<div class="modal-content">

							<form action="view-notification" role="form" method="post">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
									<h4 class="modal-title">My Request Offer</h4>
								</div>
								<div class="modal-body">
									<div class="container">
										<div id="resourcesNeeded" class="form-group row col-md-5">
											<div class="col-md-12">

												<!-- Project name, resource category, resource name, request description, project proposer -->

												<p>
													<b>Project Name</b>
												</p>
												<input id="modalProjName" name="modalProjName"
													class="form-control col-md-4 modalNotificationsField"
													placeholder="Project name" type="text" readonly />

												<p>
												<p>
													<b>Project Proposer</b>
												</p>
												<input id="modalProjProposer" name="modalProjProposer"
													class="form-control col-md-4 modalNotificationsField"
													placeholder="Project name" type="text" readonly />

												<p>
													<b>Requested Resource Name</b>
												</p>
												<input id="modalRequestedResourceName"
													name="modalRequestedResourceName"
													class="form-control col-md-4 modalNotificationsField"
													placeholder="Project name" type="text" readonly />

												<p>
													<b>Offered Resource Name</b>
												</p>
												<input id="modalOfferedResourceName"
													name="modalOfferedResourceName"
													class="form-control col-md-4 modalNotificationsField"
													placeholder="Project name" type="text" readonly />


												<p>
													<b>Offered Resource Description</b>
												</p>
												<input id="modalOfferedResourceDesc"
													name="modalOfferedResourceDesc"
													class="form-control col-md-4 modalNotificationsField"
													placeholder="Project name" type="text" readonly />

												<p>
													<b>Your Note to Project Proposer</b>
												</p>
												<input id="modalPersonalNote" name="modalPersonalNote"
													class="form-control col-md-4 modalNotificationsField"
													placeholder="Project name" type="text" readonly /> 
													
													<input
													id="modalRequestStatus" name="modalRequestStatus"
													class="form-control col-md-4 modalNotificationsField"
													placeholder="Project name" type="hidden" readonly />
											</div>
										</div>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">Close</button>
									<button id="cancelbtn" type="submit" class="btn btn-danger"
										data-dismiss="modal">
										<i class="fa fa-times"></i> Cancel Offer
									</button>
									<button id="confirmbtn" type="submit" class="btn btn-success"
										data-dismiss="modal">
										<i class="fa fa-check"></i> Confirm Offer
									</button>

								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	function view(id) {
		var disabledStatus = $('.editable-field').attr('disabled');
		var newId = id.substring(4);
		var proposer = $('#proposer' + newId).val();
		var projname = $('#projname' + newId).val();
		var requestedresourcename = $('#requestedresourcename' + newId).val();
		var offeredresourcename = $('#offeredresourcename' + newId).val();
		var offeredresourcedesc = $('#offeredresourcedesc' + newId).val();
		var offercomments = $('#offercomments' + newId).val();
		var status = $('#status' + newId).val();

		$('#modalProjProposer').val(proposer);
		$('#modalProjName').val(projname);
		$('#modalRequestedResourceName').val(requestedresourcename);
		$('#modalOfferedResourceName').val(offeredresourcename);
		$('#modalOfferedResourceDesc').val(offeredresourcedesc);
		$('#modalPersonalNote').val(offercomments);
		$('#modalRequestStatus').val(status);

		$('#viewRequestModal').modal('show');
		if (status != "Accepted") {
			$('#cancelbtn').hide();
			$('#confirmbtn').hide();
		} else {
			$('#cancelbtn').show();
			$('#confirmbtn').show();
		}
	};
</script>
</html>