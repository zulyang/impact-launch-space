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
														class="badge pull-right">123</span></a></li>
												<li class="list-group-item-selected"><a
													href="/notifications/messages/sent">Sent<span
														class="badge pull-right">4</span></a></li>
											</ul>
										</div>

										<div class="panel-heading">
											<h4 class="panel-title">Requests</h4>
										</div>
										<div class="panel-collapse collapse in">
											<ul class="list-group">
												<li class="list-group-item"><a
													href="/notifications/requests/inbox">Received <span
														class="badge pull-right">1</span></a></li>
												<li class="list-group-item"><a
													href="/notifications/requests/sent">Sent <span
														class="badge pull-right">2</span></a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="col-xs-6 col-sm-9">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h3 class="panel-title">Messages Sent</h3>
									</div>
									<div class="panel-body">
										<div class="table-responsive col-md-12">
											<table class="table table-striped table-hover">
												<thead>
													<tr>
														<th>Recipient</th>
														<th>Message Subject</th>
														<th>Sent Time</th>
													</tr>
												</thead>
												<tbody id="userNotificationsTable">
													<%
														int id = 0;
													%>
													<c:forEach items="${inbox}" var="item">


														<tr id="row<%=++id%>">
															<td><p>
																	<c:choose>
																		<c:when
																			test="${item.getSender_username().equals(\"admin\")}">
																			<b> <input class="editable-field form-control"
																				id="sender<%=id%>" type="text"
																				value="ImpactLaunch.Space Admin" disabled="true" />
																			</b>
																		</c:when>
																		<c:otherwise>
																			<input class="editable-field form-control"
																				id="sender<%=id%>" type="text"
																				value="${item.getSender_username()}" disabled="true" />
																		</c:otherwise>
																	</c:choose>

																</p></td>
															<td><p>
																	<input class="editable-field form-control"
																		id="subj<%=id %>" type="textarea"
																		value="${item.getNotification_subject()}"
																		disabled="true" />
																</p></td>
															<td><p>
																	<input class="editable-field form-control"
																		id="time<%=id%>" type="text"
																		value="${item.getSent_time() }" disabled="true" />
																</p></td>

															<input class="editable-field form-control"
																id="message<%=id%>" type="hidden"
																value="${item.getNotification_message()}"
																disabled="true" />

															<td class="col-md-2"><p>
																	<button id="view<%=id%>" type="btn" name="view"
																		class="btn btn-primary edit" onClick="view(this.id)"
																		href="#">View</button>
																	<button id="dele<%=id%>" type="submit" name="delete"
																		class="btn btn-danger delete" onClick="del(this.id)"
																		href="#">
																		<i class="fa fa-trash"></i> Delete
																	</button>
																</p></td>
														</tr>

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



				<!-- View Notifications modal-->
				<div class="modal fade" tabindex="-1" role="dialog"
					id="notificationsModal">
					<div class="modal-dialog">
						<div class="modal-content">

							<form action="view-notification" role="form" method="post">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
									<h4 class="modal-title">View Message</h4>
								</div>
								<div class="modal-body">
									<div class="container">
										<div id="resourcesNeeded" class="form-group row col-md-5">
											<div class="col-md-12">
												<p>
													<b>From:</b>
												</p>
												<input id="modalSender" name="modalSender"
													class="form-control col-md-4 modalNotificationsField"
													placeholder="Sender Username here" type="text" readonly />
												<p>
													<b>Subject:</b>
												</p>
												<input id="modalNotificationSubject"
													name="modalNotificationSubject"
													class="form-control col-md-4 modalNotificationsField"
													placeholder="Message subject here" type="text" readonly />
												<p>
													<b>Message:</b>
												</p>
												<textarea id="modalNotificationsMessage"
													name="modalNotificationsMessage"
													class="form-control col-md-4 modalNotificationsField"
													placeholder="Grab message from db and paste here" rows="10"
													readonly></textarea>
											</div>
										</div>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">OK</button>

								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	$(document)
			.ready(
					function() {
						$('#add')
								.click(
										function(event) {
											var resourceCategory = $(
													'#modalResourceCategory')
													.val();
											var resourceName = $(
													'#modalResourceName').val();
											var resourceDescription = $(
													'#modalResourceDescription')
													.val();
											var newId = $('#userNotificationsTable tr').length + 1;
											$('#userResourceTable')
													.append(
															'<tr id="row'+newId+'"> <td><p><input class="editable-field form-control" id="reso'+newId+'" type="text"value="'+resourceName+'" disabled="true" /> <input type="hidden" id="old_reso'+newId+'" value="'+resourceName+'"/></p></td> <td><p> <input class="editable-field form-control" style="border: 1px solid transparent;background-color: transparent;" id="desc'+newId+'" type="textarea"value="'+resourceDescription+'" disabled="true" /> <input type="hidden" id="old_desc'+newId+'" value="'+resourceDescription+'"/></p></td> <td><p> <input type="hidden" id="old_rc'+newId+'" value="'+resourceCategory+'"/> <select id="resourceCategory'+newId+'"name="resourceCategory"class="col-md-4 js-example-basic-single-resourcecategory resourceCategory"> <option></option> <c:forEach items="${resource_category_list}" var="item"> <c:choose><c:when test="${item.getSkillset().equals('
																	+ resourceCategory
																	+ ')}"> <option value="${item.getSkillset()}"selected="selected">${item.getSkillset()}</option> </c:when> <c:otherwise> <option value="${item.getSkillset()}">${item.getSkillset()}</option> </c:otherwise> </c:choose> </c:forEach> </select> <span class="label label-success"id="currentResourceCategory'+newId+'">'
																	+ resourceCategory
																	+ '</span> </p></td> <td class="col-md-2"><p> <button id="edit'
																	+ newId
																	+ '" type="btn" name="edit"class="btn btn-primary edit" onClick="edit(this.id)"href="#"> <i class="fa fa-pencil"></i> Edit </button> <button id="save'
																	+ newId
																	+ '" type="button" name="save"class="btn btn-success save" onClick="save(this.id)"href="#"> <i class="fa fa-save"></i> Save </button> <button id="dele'
																	+ newId
																	+ '" type="submit" name="delete"class="btn btn-danger delete" onClick="del(this.id)"href="#"> <i class="fa fa-trash"></i> Delete </button> <button id="canc'
																	+ newId
																	+ '" type="btn" name="cancel"class="btn btn-default cancel" onClick="cancel(this.id)"href="#"> <i class="fa fa-close"></i> Cancel </button> </p></td></tr>');

											$
													.post(
															'add-user-resource',
															{
																modalResourceCategory : resourceCategory,
																modalResourceName : resourceName,
																modalResourceDescription : resourceDescription
															});

											$('#notificationsModal').modal(
													'hide');

											$('.resourceCategory').hide();
										});

						$('#notificationsModal').on(
								'hidden.bs.modal',
								function() {
									$(this).find("input,textarea,select").val(
											'').end();
								});
					});
</script>
<script type="text/javascript">
	function view(id) {
		var disabledStatus = $('.editable-field').attr('disabled');
		var newId = id.substring(4);
		var sender = $('#sender' + newId).val();
		var subj = $('#subj' + newId).val();
		var sent = $('#sent' + newId).val();
		var message = $('#message' + newId).val();

		$('#modalSender').val(sender);
		$('#modalNotificationSubject').val(subj);
		$('#modalNotificationsMessage').val(message);
		$('#modalNotificationsMessage').val().replace(/\r\n|\r|\n/g, "<br />")
		$('#notificationsModal').modal('show');
	};
</script>

<script type="text/javascript">
	function showTable() {
		$()
	}
</script>

</html>