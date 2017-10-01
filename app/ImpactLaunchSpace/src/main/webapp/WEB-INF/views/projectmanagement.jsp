<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.text.DecimalFormat"%>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Manage My Project</title>
<%@include file = "AuthenticateCookie.jsp"%>
<link rel="icon" type="image/png"
	href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/project/project_management.css" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel='stylesheet'
	href='<%=request.getContextPath()%>/resources/lib/calendar/fullcalendar.css' />

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script
	src="//blueimp.github.io/jQuery-File-Upload/js/vendor/jquery.ui.widget.js"></script>
	    <script
    src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
	
<script
	src="//blueimp.github.io/JavaScript-Load-Image/js/load-image.all.min.js"></script>
<script
	src="//blueimp.github.io/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>
<script
	src="//blueimp.github.io/jQuery-File-Upload/js/jquery.iframe-transport.js"></script>
<script
	src="//blueimp.github.io/jQuery-File-Upload/js/jquery.fileupload.js"></script>
<script
	src="//blueimp.github.io/jQuery-File-Upload/js/jquery.fileupload-process.js"></script>
<script
	src="//blueimp.github.io/jQuery-File-Upload/js/jquery.fileupload-image.js"></script>

<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<script
	src='<%=request.getContextPath()%>/resources/lib/calendar/lib/moment.min.js'></script>
<script
	src='<%=request.getContextPath()%>/resources/lib/calendar/fullcalendar.js'></script>
<link
	href="<%=request.getContextPath()%>/resources/lib/select2/select2.min.css"
	rel="stylesheet" />
<script
	src="<%=request.getContextPath()%>/resources/lib/select2/select2.min.js"></script>	
	    <link rel="stylesheet" type="text/css"
    href="<%=request.getContextPath()%>/resources/lib/datatables/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8"
    src="<%=request.getContextPath()%>/resources/lib/datatables/js/jquery.dataTables.js"></script>
	

</head>

<body>
	<div class="container-fluid">
		<div class="row">
			<%@include file="common/navigation.jspf"%>
			<!-- PM SIDE BAR -->
			<div class="side-menu">
				<div id="sidebar-menu" class="active">
					<ul class="nav in" id="side-menu">
						<li class="menu-title">Project Description</li>
						<div class="project-description">
							${projectName}<br>${username}
						</div>

						<hr />

						<li class="menu-title">Members</li>
						<c:choose>
							<c:when test="${project_proposer.equals(username) || organization.equals(username)}">
								<a class="btn btn-manage-users btn-bordered" id="manageusers"
									href="manage-project-users?project-name=${projectName}&project-proposer=${project_proposer}">Manage</a>
							</c:when>
							<c:otherwise>
								<a class="btn btn-manage-users btn-bordered" id="manageusers"
									href="#" disabled>Manage</a>
							</c:otherwise>
						</c:choose>
						<c:forEach items="${member_list}" var="item">
							<div>
								<!-- Each member profile icon here -->
								<img
									src="/imageDisplay?username=${item.getProject_member_username()}"
									class="members-profile-icon">
								<c:choose>
									<c:when
										test="${item.getProject_member_username().equals(username)}"> 
                    ${item.getProject_member_username()}(me) 
                  </c:when>
									<c:otherwise>
										<a
											href="/view-profile?username=${item.getProject_member_username()}"
											class="username_link_profile">${item.getProject_member_username()}
										</a>
									</c:otherwise>
								</c:choose>

								<c:choose>
									<c:when test="${item.getProject_role().equals(\"admin\")}">
										<i class="fa fa-trophy" style="color: #FCC314"></i>
									</c:when>
									<c:when test="${item.getProject_role().equals(\"member\")}">
										<i class="fa fa-handshake-o"></i>
									</c:when>
									<c:when test="${item.getProject_role().equals(\"invited\")}">
										<i class="fa fa-user" style="color: #bbbbbb"></i>
									</c:when>
								</c:choose>

							</div>
						</c:forEach>

					</ul>

				</div>

			</div>

			<div class="col-sm-12 col-md-12 col-lg-12">
				<div class="project-management-container">
					<div class="container-fluid">
						<div class="row">
							<div class="pms-header">Project Management Space</div>

							<input type="hidden" id="project_name" value="${projectName}" />
							<input type="hidden" id="calendarList" value="${calendarList}" />
							<input type="hidden" id="project_proposer"
								value="${project_proposer}" /> <br>
							<!--tabs-->

							<ul class="nav nav-tabs tabs-bordered nav-justified" id="pm-tabs">
								<li><a href="#kanban" data-toggle="tab"
									aria-expanded="false"><span class>Kanban</span></a></li>
								<li><a href="#activity-log" data-toggle="tab"
									aria-expanded="false"><span class>Activity Log</span></a></li>
								<li><a href="#project-calendar" data-toggle="tab"
									aria-expanded="false" onClick="showCalendar()"><span class>Calendar</span></a></li>
								<li><a href="#documents" data-toggle="tab"
									aria-expanded="false"><span class>Documents</span></a></li>
								<li><a href="#group-chat" data-toggle="tab"
									aria-expanded="false"><span class>Group Chat</span></a></li>

							</ul>
							<!--/tabs-->

							<!--tab panes-->
							<div class="section-block">
								<div class="tab-content">

									<div role="tabpanel" class="tab-pane fade in active"
										id="kanban">
										<h3 class="tabs-header">KANBAN BOARD</h3>
										<button type="button" class="btn btn-success" onClick="add()">
											<i class="fa fa-plus-circle"></i> Add Card
										</button>

										<div>
											<div id="todoKB">
												<ul id="sortableToDo" class="connectedSortable">
													<div class="kanban-header">TO DO</div>

													<c:forEach items="${todoList}" var="todo" varStatus="count">
														<li id="${todo.getCard_id()}" class="ui-state-default">

															<input type="hidden" id="title${todo.getCard_id()}"
															value="${todo.getCard_title()}" /> <input type="hidden"
															id="desc${todo.getCard_id()}"
															value="${todo.getDescription()}" /> <input type="hidden"
															id="tags${todo.getCard_id()}" value="${todo.getTags()}" />
															<input type="hidden" id="assignee${todo.getCard_id()}"
															value="${todo.getAssignee()}" /> <input type="hidden"
															id="startdate${todo.getCard_id()}"
															value="${todo.getStart_date()}" /> <input type="hidden"
															id="duedate${todo.getCard_id()}"
															value="${todo.getDue_date()}" /> 
															<c:forEach var="doc" items="${todo.getDocumentList()}">
														        <input type="hidden"
															class="documentList${todo.getCard_id()}"
															value="${doc}" /> 
														    </c:forEach>
															${todo.getCard_title()}
															<br> ${todo.getTags()} <br>

															<button id="view${todo.getCard_id()}" type="submit"
																name="view" class="btn btn-primary"
																onClick="view(this.id)">
																<i class="fa fa-pencil"></i> View
															</button>

															<button id="${todo.getCard_id()}" type="submit"
																name="delete" class="btn btn-danger delete"
																onClick="delet(this.id)">
																<i class="fa fa-trash"></i> Delete
															</button>
														</li>
													</c:forEach>
												</ul>
											</div>

											<div id="inprogressKB">
												<ul id="sortableInProgress" class="connectedSortable">
													<div class="kanban-header">IN PROGRESS</div>
													<c:forEach items="${inprogressList}" var="inprogress">
														<li id="${inprogress.getCard_id()}"
															class="ui-state-default"><input type="hidden"
															id="title${inprogress.getCard_id()}"
															value="${inprogress.getCard_title()}" /> <input
															type="hidden" id="desc${inprogress.getCard_id()}"
															value="${inprogress.getDescription()}" /> <input
															type="hidden" id="tags${inprogress.getCard_id()}"
															value="${inprogress.getTags()}" /> <input type="hidden"
															id="assignee${inprogress.getCard_id()}"
															value="${inprogress.getAssignee()}" /> <input
															type="hidden" id="startdate${inprogress.getCard_id()}"
															value="${inprogress.getStart_date()}" /> <input
															type="hidden" id="duedate${inprogress.getCard_id()}"
															value="${inprogress.getDue_date()}" />
															<c:forEach var="doc" items="${inprogress.getDocumentList()}">
														        <input type="hidden"
															class="documentList${inprogress.getCard_id()}"
															value="${doc}" /> 
														    </c:forEach>
															${inprogress.getCard_title()} <br>
															${inprogress.getTags()} <br>

															<button id="view${inprogress.getCard_id()}" type="submit"
																name="view" class="btn btn-primary"
																onClick="view(this.id)">
																<i class="fa fa-pencil"></i> View
															</button>

															<button id="${inprogress.getCard_id()}" type="submit"
																name="delete" class="btn btn-danger delete"
																onClick="delet(this.id)">
																<i class="fa fa-trash"></i> Delete
															</button></li>
													</c:forEach>
												</ul>
											</div>
										</div>

										<div id="doneKB">
											<ul id="sortableDone" class="connectedSortable">
												<div class="kanban-header">DONE</div>

												<c:forEach items="${doneList}" var="done">
													<li id="${done.getCard_id()}" class="ui-state-default">

														<input type="hidden" id="title${done.getCard_id()}"
														value="${done.getCard_title()}" /> <input type="hidden"
														id="desc${done.getCard_id()}"
														value="${done.getDescription()}" /> <input type="hidden"
														id="tags${done.getCard_id()}" value="${done.getTags()}" />
														<input type="hidden" id="assignee${done.getCard_id()}"
														value="${done.getAssignee()}" /> <input type="hidden"
														id="startdate${done.getCard_id()}"
														value="${done.getStart_date()}" /> <input type="hidden"
														id="duedate${done.getCard_id()}"
														value="${done.getDue_date()}" /> 
														<c:forEach var="doc" items="${done.getDocumentList()}">
														        <input type="hidden"
															class="documentList${done.getCard_id()}"
															value="${doc}" /> 
														</c:forEach>
														
														${done.getCard_title()}
														<br> ${done.getTags()}</br>
														
														<button id="view${done.getCard_id()}" type="submit"
															name="view" class="btn btn-primary" onClick="view()">
															<i class="fa fa-pencil"></i> View
														</button>

														<button id="${done.getCard_id()}" type="submit"
															name="delete" class="btn btn-danger delete"
															onClick="delet(this.id)">
															<i class="fa fa-trash"></i> Delete
														</button>

													</li>
												</c:forEach>
											</ul>
										</div>
									</div>


									<div role="tabpanel" class="tab-pane fade" id="activity-log">
										<h3 class="tabs-header">ACTIVITY LOG</h3>
										<div class="table-responsive col-md-12">
											<div id="activitylogtablediv">
												<table id="activitylogtable" class="table">
													<tbody id="logtable">
														<c:forEach items="${activitylog}" var="log">
															<tr>${log}</tr>
															<br>
														</c:forEach>
													</tbody>
												</table>
											</div>
										</div>
									</div>

									<div role="tabpanel" class="tab-pane fade"
										id="project-calendar">
										<h3 class="tabs-header">CALENDAR</h3>
										<div class="full-calendar">
											<div class="full-calendar-container">
												<div id='fullcalendar'></div>
											</div>
										</div>
									</div>

									<div role="tabpanel" class="tab-pane fade" id="documents">
										<h3 class="tabs-header">DOCUMENTS</h3>
										<div id="fileUploadDiv" class="fileUploadDiv">
											<h1>Project Documents</h1>

											<div id="dropzone" class="dropzone">
												<div class="fileupload_wrapper">
													                                                    <img src="<%=request.getContextPath() %>/resources/img/fileupload.png" alt="">
                                                    <br>Drop files here, or <label id="browseFiles" title="Click Here to Choose Files" class="fileupload_label" onmouseover="hoverBrowse();" onmouseout="outBrowse();"><br>

														browse for files<input id="fileupload" type="file" name="files"
														multiple="multiple">
													</label>
												</div>
											</div>
											<div id="files" class="thumbnails clearfix"></div>

											<button id="uploadFiles" type="button"
												class="btn btn-primary">Upload</button>
										</div>
										                                        <div id="fileListDiv" class="table-responsive col-md-12" >
                                            <table id="fileListTable" class="table" style="width: 100%;">
                                            <thead>
		<tr>
													                                                    <td class="col-md-5">Name</td>
                                                    <td class="col-md-3">Date Modified</td>
                                                    <td class="col-md-2">Size</td>
                                                    <td class="col-md-1"></td>
                                                    <td class="col-md-1"></td>
                                                </tr></thead>
                                                <tbody id="docFileListRow">

												<c:forEach items="${filesList}" var="file">
													<tr>
														<td>${file.getName()}</td>
														<td><jsp:useBean id="mDate" class="java.util.Date" />
															<c:set target="${mDate}" property="time"
																value="${file.lastModified()}" /> <fmt:formatDate
																value="${mDate}" pattern="dd/MM/yyyy HH:mm" /></td>
														<td><c:set var="fileSize" value="${file.length()}" />
															<%
																String fileSize = String.valueOf(pageContext.getAttribute("fileSize"));
																	Long size = Long.parseLong(fileSize);

																	double b = size;
																	double k = size / 1024.0;
																	double m = ((size / 1024.0) / 1024.0);
																	double g = (((size / 1024.0) / 1024.0) / 1024.0);

																	DecimalFormat dec = new DecimalFormat("#0.00");
																	if (g > 1) {
																		fileSize = dec.format(g) + " GB";
																	} else if (m > 1) {
																		fileSize = dec.format(m) + " MB";
																	} else if (k > 1) {
																		fileSize = dec.format(k) + " KB";
																	} else {
																		fileSize = dec.format(b) + " B";
																	}
																	pageContext.setAttribute("fileSize", fileSize);
															%> <c:out value="${fileSize}" /></td>
														<td><a
															href="/saveFile?file=${file}&project_name=${projectName}&project_proposer=${project_proposer}&username=${username}"><button
                                                                    type="button" class="btn btn-success" title="Download file"><i class="fa fa-download"></i></button></a>

														<td>
                                                            <button type="button" class="btn btn-danger"
                                                                onClick="deleteFile('${file}')" title="Delete"><i class="fa fa-trash"></i></button>
														</td>
													</tr>
												</c:forEach>
												</tbody>
											</table>
										</div>
									</div>

									<div role="tabpanel" class="tab-pane fade" id="group-chat">
										<h3 class="tabs-header">GROUP CHAT</h3>
									</div>

								</div>
							</div>
						</div>
						<!--/tabs-->
						<!-- end of tab -->

					</div>
					<!-- Add new card modal (Copied from resources)-->
					<div class="modal fade" tabindex="-1" role="dialog" id="AddModal">
						<div class="modal-dialog">
							<div class="modal-content">

								<form action="add-card" role="form" method="post">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title">Add New Card</h4>
									</div>
									<div class="modal-body">
										<div class="container">
											<div id="resourcesNeeded" class="form-group row col-md-5">
												<div class="col-md-12">
													Card Title:
													<textarea id="modalCardTitle" rows="4"
														name="modalCardTitle"
														class="form-control col-md-4 create-project-add"
														placeholder="Give your card a title here..."></textarea>

													<br> Description:
													<textarea id="modalCardDescription" rows="4"
														name="modalCardDescription"
														class="form-control col-md-4 create-project-add"
														placeholder="Describe your card here..."></textarea>
													<br>

													<!-- Tags refer to the all the resource categories in the project -->
													Tags: <select id="modalCardTags" name="modalCardTags"
														class="col-md-4 form-control" style="width: 100%">
														<option value="">None</option>
														<c:forEach items="${cat}" var="item">
															<option value="${item}">${item}</option>
														</c:forEach>
													</select> <br> Assignees: <select id="modalCardAssignee"
														name="modalCardAssignee" class="col-md-4 form-control"
														style="width: 100%">
														<option value="">None</option>
														<option value="${username}">${username}(Myself)</option>
														<c:forEach items="${members}" var="item">
															<option value="${item.getProject_member_username()}">${item.getProject_member_username()}</option>
														</c:forEach>
													</select>

													<!-- Start Date and Due Date of the project. Optional -->
													<br> Start Date: <br> <input type="date"
														onblur="setDueDateMin()" name="startdate" id="startdate"
														onfocus="(this.type='date')"
														class="form-control profileField"> Due Date: <br>
													<input type="date" name="duedate" id="duedate"
														onfocus="(this.type='date')"
														class="form-control profileField"> <input
														type="hidden" id="board_id" value="${board_id}">
														
													<!-- Documents -->
													Choose Documents Reference 
													<select required id="modalCardDocLink"
														class="js-example-basic-multiple-documentLink"
														multiple="multiple" name="modalCardDocLink" style="width: 100% !important;">
														<c:forEach items="${filesList}" var="file">
															<option value="${file.name}">${file.name}</option>
														</c:forEach>
													</select>
												</div>
											</div>
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Cancel</button>
										<button type="button" id="add" class="btn btn-success">Add</button>
									</div>
								</form>
							</div>
						</div>
					</div>


					<!-- View card modal / Edit Card(Copied from resources)-->
					<div class="modal fade" tabindex="-1" role="dialog" id="ViewModal">
						<div class="modal-dialog">
							<div class="modal-content">

								<form action="edit-card" role="form" method="post">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title">View Card</h4>
									</div>
									<div class="modal-body">
										<div class="container">
											<div class="form-group row col-md-5">
												<div class="col-md-12">

													Card Title: <input type="text" id="modalCardTitleView"
														class="form-control col-md-4 create-project-add"
														name="modalCardTitle"> <br> 
													Description: <input
														type="text" id="modalCardDescriptionView"
														class="form-control col-md-4 create-project-add"
														name="modalCardDescription"> <br> 
													Tags: 
													<select
														id="modalCardTagsView" name="modalCardTagsView"
														class="col-md-4 form-control" style="width: 100%">
														<c:forEach items="${cat}" var="item">
															<option value="${item}">${item}</option>
														</c:forEach>
													</select> <br> 
													Assignees: <select id="modalCardAssigneeView"
														name="modalCardAssignee" class="col-md-4 form-control"
														style="width: 100%">
														<option value="">None</option>
														<option value="${username}">${username}(Myself)</option>
														<c:forEach items="${members}" var="item">
															<option value="${item.getProject_member_username()}">${item.getProject_member_username()}</option>
														</c:forEach>
													</select> <br> 
													Start Date: <br> 
													<input type="date"
														onblur="setDueDateMinView()" name="startDate"
														id="startDateView" onfocus="(this.type='date')"
														class="form-control profileField"> Due Date: <br>
													<input type="date" name="dueDate" id="dueDateView"
														onfocus="(this.type='date')"
														class="form-control profileField"> <br>

													<!-- Documents -->
													Choose Documents Reference 
													<select id="modalCardDocLinkView"
														class="js-example-basic-multiple-documentLink"
														multiple="multiple" name="modalCardDocLinkView" style="width: 100% !important;">
														<c:forEach items="${filesList}" var="file">
															<option value="${file.name}">${file.name}</option>
														</c:forEach>
													</select>
													
													<div id="documentList_view"></div>
													
													<!--  Comments: <br>
													<div class="table-responsive col-md-12">
														<div id="commentstable">
															<table id="commentstable" class="table">
																<tbody id="commentstable">
																	<c:forEach items="${comments}" var="item">
																		<tr>${item}</tr>
																		<br>
																	</c:forEach>
																</tbody>
															</table>
														</div>
													</div>-->

													<input type="hidden" id="board_id_view" value="${board_id}">
													<input type="hidden" id="card_id_view" name="card_id_view">
												</div>
											</div>
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Cancel</button>
										<button type="button" id="edit" class="btn btn-success">Save</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
</body>

<script type="text/javascript">
	function initialiseKB() {
		$(function() {
			$("#sortableToDo").sortable(
					{
						update : function(event, ui) {
							var list = document.getElementById("sortableToDo")
									.getElementsByTagName("li");
							for (var i = 0; i < list.length; i++) {
								$.post('update-card-order', {
									id : list[i].id,
									status : "todo",
									order : i,
								});
							}
						},

						receive : function(event, ui) {

							var card_id = ui.item.attr("id");
							var from = ui.sender.attr("id");
							var to = "sortableToDo";
							var projectName = $('#project_name').val();

							$.post('detect-status-change', {
								from : from,
								to : to,
								card_id : card_id,
								projectName : projectName

							});
							$("#activitylogtablediv").load(
									window.location.href
											+ " #activitylogtablediv");
						},

						connectWith : "#sortableInProgress, #sortableDone"
					}).disableSelection();

			$("#sortableInProgress").sortable(
					{
						update : function(event, ui) {
							var list = document.getElementById(
									"sortableInProgress").getElementsByTagName(
									"li");
							for (var i = 0; i < list.length; i++) {
								$.post('update-card-order', {
									id : list[i].id,
									status : "inprogress",
									order : i,
								});
							}
						},

						receive : function(event, ui) {

							var card_id = ui.item.attr("id");
							var from = ui.sender.attr("id");
							var to = "sortableInProgress";
							var projectName = $('#project_name').val();

							$.post('detect-status-change', {
								from : from,
								to : to,
								card_id : card_id,
								projectName : projectName
							});
							$("#activitylogtablediv").load(
									window.location.href
											+ " #activitylogtablediv");
						},

						connectWith : "#sortableToDo, #sortableDone"
					}).disableSelection();

			$("#sortableDone").sortable(
					{
						update : function(event, ui) {
							var list = document.getElementById("sortableDone")
									.getElementsByTagName("li");
							for (var i = 0; i < list.length; i++) {
								$.post('update-card-order', {
									id : list[i].id,
									status : "done",
									order : i,
								});
							}
						},

						receive : function(event, ui) {

							var card_id = ui.item.attr("id");
							var from = ui.sender.attr("id");
							var to = "sortableDone";
							var projectName = $('#project_name').val();

							$.post('detect-status-change', {
								from : from,
								to : to,
								card_id : card_id,
								projectName : projectName
							});
							$("#activitylogtablediv").load(
									window.location.href
											+ " #activitylogtablediv");
						},
						connectWith : "#sortableToDo, #sortableInProgress"
					}).disableSelection();
		});
	}

	function refreshActivityLog() {

		setInterval(function() {
			//put this line for everytime i update the activity log (add,edit,delete,shift). create a method)
			$("#activitylogtablediv").load(
					window.location.href + " #activitylogtablediv");
		}, 10000);
	}

	function setDueDateMin() {
		var start_date_value = $("#startdate")[0].value
		$("#duedate")[0].min = start_date_value
	}

	function setDueDateMinView() {
		var start_date_value = $("#startDateView")[0].value
		$("#dueDateView")[0].min = start_date_value
	}

	$(document).ready(function() {
		// page is now ready, initialize the calendar...
		initialiseKB();
		var calendarList = ${calendarList}
		uploadFile();
		$('#fullcalendar').fullCalendar({
			// put your options and callbacks here
			height : 400,
			theme : true,
			editable : false,
			events : calendarList
		});
		
		$("#modalCardDocLinkView").select2({
			placeholder : ""
		});
	});
</script>

<script type="text/javascript">
	function add() {
		$('#AddModal').modal('show');
	};

	function view(id) {
		var projectName = $('#project_name')
		.val();
		var projectProposer = $(
		'#project_proposer').val();
		var newId = id.substring(4);
		var title = $('#title' + newId).val();
		var desc = $('#desc' + newId).val();
		var tags = $('#tags' + newId).val();
		var assignee = $('#assignee' + newId).val();
		var start_date = $('#startdate' + newId).val();
		var due_date = $('#duedate' + newId).val();
		
		var documentList = document.getElementsByClassName("documentList" + newId); 
		var listSize = documentList.length;
	    var documentArr = new Array();
	    for(var j = 0; j < listSize; j++){
	    	documentArr.push(documentList[j].value);
	    }
	    
		$('#modalCardTitleView').val(title);
		$('#modalCardDescriptionView').val(desc);
		$('#modalCardTagsView').val(tags);
		$('#modalCardAssigneeView').val(assignee);
		$('#startDateView').val(start_date);
		$('#dueDateView').val(due_date);
		$('#card_id_view').val(newId);
		
		if(documentArr.length > 0){
			$('#modalCardDocLinkView').val(documentArr).select2();
		}else{
			 $("#modalCardDocLinkView").val(null).trigger("change"); 
		}
		
		var str = "";
		documentArr.forEach(function(doc, index) {
			str +="<a href=\"/saveFile?file=src/main/webapp/resources/storage/"+projectName+"_"+projectProposer+"/"+doc+"&project_name=${projectName}&project_proposer=${project_proposer}&username=${username}\">"+doc+"</a><br>";
		});
		
		$('#documentList_view').html(str);
		
		$('#ViewModal').modal('show');
	};

	function delet(id) {
		if (confirm("Are you sure you want to delete this card?") == true) {
			var projectName = $('#project_name').val();
			$.post('delete-card', {
				card_id : id,
				projectName : projectName
			});
			$("#todoKB").load(window.location.href + " #todoKB");
			$("#inprogressKB").load(window.location.href + " #inprogressKB");
			$("#doneKB").load(window.location.href + " #doneKB");
			$("#activitylogtablediv").load(
					window.location.href + " #activitylogtablediv");
			return true;
		} else {
			return false;
		}
	};
</script>

<script>
	$(document)
			.ready(
					function() {
						$('#add')
								.click(
										function(event) {

											var modalCardTitle = $(
													'#modalCardTitle').val();
											var modalCardDescription = $(
													'#modalCardDescription')
													.val();
											var modalCardAssignee = $(
													'#modalCardAssignee').val();
											var modalCardTags = $(
													'#modalCardTags').val();
											var board_id = $('#board_id').val();
											var projectName = $('#project_name')
													.val();
											var projectProposer = $(
													'#project_proposer').val();

											var start_date = $('#startdate')
													.val();

											var due_date = $('#duedate').val();
											var modalCardDocLink = $('#modalCardDocLink').val();
											
											if(modalCardDocLink!=null){
												modalCardDocLink = modalCardDocLink.toString();
											}
											
											if (start_date === "") {
												start_date = null;
											}

											if (due_date === "") {
												due_date = null;
											}
											var projectName2 = encodeURIComponent(projectName
													.trim());

											$
													.post(
															'add-card',
															{
																modalCardTitle : modalCardTitle,
																modalCardDescription : modalCardDescription,
																modalCardAssignee : modalCardAssignee,
																modalCardTags : modalCardTags,
																board_id : board_id,
																start_date : start_date,
																due_date : due_date,
																projectName : projectName,
																modalCardDocLink: modalCardDocLink
															});

											$('#AddModal').modal('hide');
											$("#todoKB").load(
													window.location.href
															+ " #todoKB");
											$("#activitylogtablediv")
													.load(
															window.location.href
																	+ " #activitylogtablediv");
											
										});

						$('#edit')
								.click(
										function(event) {

											var modalCardTitle = $(
													'#modalCardTitleView')
													.val();
											var modalCardDescription = $(
													'#modalCardDescriptionView')
													.val();
											var modalCardAssignee = $(
													'#modalCardAssigneeView')
													.val();
											var projectName = $('#project_name')
													.val();
											var modalCardTags = $(
													'#modalCardTagsView').val();
											var board_id = $('#board_id_view')
													.val();
											var card_id = $('#card_id_view')
													.val();
											var start_date = $('#startDateView')
													.val();
											var due_date = $('#dueDateView')
													.val();
											var card_id_view = $(
													'#card_id_view').val();
											var modalCardDocLink = $('#modalCardDocLinkView').val();
											
											if(modalCardDocLink!=null){
						                        modalCardDocLink = modalCardDocLink.toString();
						                    }
											
											
											if (start_date === "") {
												start_date = null;
											}

											if (due_date === "") {
												due_date = null;
											}

											$.post(
													'edit-card',
													{
														modalCardTitle : modalCardTitle,
														modalCardDescription : modalCardDescription,
														modalCardTags : modalCardTags,
														modalCardAssignee : modalCardAssignee,
														modalCardDocLink: modalCardDocLink,
														board_id : board_id,
														start_date : start_date,
														due_date : due_date,
														card_id_view : card_id_view,
														projectName : projectName
													});

											$('#ViewModal').modal('hide');
											$("#todoKB").load(
													window.location.href
															+ " #todoKB");
											$("#inprogressKB").load(
													window.location.href
															+ " #inprogressKB");
											$("#doneKB").load(
													window.location.href
															+ " #doneKB");
											$("#activitylogtablediv")
													.load(
															window.location.href
																	+ " #activitylogtablediv");
										});

					});

	$(document).ajaxSuccess(function() {
		initialiseKB();
		uploadFile();
	});

	$(document).ajaxError(function() {
		initialiseKB();
		uploadFile();
	});
</script>

<script>
	var project_name = $('#project_name').val();
	var project_proposer = $('#project_proposer').val();
	var username = $('#username').val();
	var board_id = $('#board_id').val();
	var filesList = new Array();
	var formData = new FormData();

	function uploadFile() {
		$(function() {
			$('#fileupload')
					.fileupload({
						autoUpload : false,
						dropZone : $('#dropzone')
					})
					.on(
						'fileuploadadd',
							function(e, data) {
								$.each(data.files, function(index, file) {
									if(!filesList.includes(data.files[index])){
										data.context = $('<div/>', {
											class : 'thumbnail pull-left'
										}).appendTo('#files');
										filesList.push(data.files[index]);
										var node = $('<p/>').append(
												$('<span/>').text(file.name).data(
														data));
										node.appendTo(data.context); 
									}
								});
							}) 
					.on(
							'fileuploadprocessalways',
							function(e, data) {
								var index = data.index, file = data.files[index], node = $(data.context
										.children()[index]);
								if (file.preview) {
									node.prepend('<br>').prepend(file.preview);
								}
								if (file.error) {
									node.append('<br>').append(
											$('<span class="text-danger"/>')
													.text(file.error));
								}
							}).prop('disabled', !$.support.fileInput).parent()
					.addClass($.support.fileInput ? undefined : 'disabled');

			$("#uploadFiles").unbind("click").click(
					function(event) {
						if (filesList.length > 0) {
							event.preventDefault();
							document.getElementById("uploadFiles").disabled = true;
							formData.append('project_name', project_name);
							formData.append('project_proposer',
									project_proposer);
							formData.append('username', username);
							formData.append('board_id', board_id);

							for (var i = 0; i < filesList.length; i++) {
								formData.append('files', filesList[i]);
							}
							filesList = new Array();
							$.ajax({
								url : 'uploadProjectFiles',
								type : "POST",
								cache : false,
								contentType : false,
								processData : false,
								data : formData,
								success : function(data) {
									formData = new FormData();
									$("#fileUploadDiv").load(
											window.location.href
													+ " #fileUploadDiv");
									$("#fileListDiv").load(
											window.location.href
													+ " #fileListDiv");
									$("#activitylogtablediv").load(
											window.location.href
													+ " #activitylogtablediv");
								}
							});
						} else {
							alert("Please select files to upload");
						}
					});
		});
	}

	function deleteFile(file) {
		var result = confirm("Are you sure you want to delete this file?");
		if (result) { 
		      $.post('deleFile', { 
		          file:file, 
		          project_name:project_name, 
		          project_proposer:project_proposer, 
		          username:username, 
		          board_id:board_id 
		        }); 
		        $("#fileListDiv").load(window.location.href + " #fileListDiv"); 
		        $("#activitylogtablediv").load(window.location.href + " #activitylogtablediv"); 
		}		
	};
</script>

<script>
        
        $('#AddModal').on('hidden.bs.modal', function(){
            $(this).find('form')[0].reset();
        }); 
    
</script>

<script>
function hoverBrowse(){
	  $("#browseFiles").
	    stop().
	    animate({
	      color:"#1ea69a"
	      }, 1000);
	  }
function outBrowse(){
	  $("#browseFiles").
	    stop().
	    animate({
	    	color:"black"
	      }, 1000);
	  }
</script>
<script>
function showCalendar(){
	setTimeout(function () {
		$(".fc-today-button").click();
       },200);
}
</script>

<script>
$(document)
.ready(
        function() {
            $('#fileListTable').DataTable({
                responsive:true,
                "columnDefs": [{
                    "targets" : [3],
                    "orderable":false
                    }, {
                        "targets": [4],
                        "orderable":false
                    
                
                }]
            });
            
        });
        </script>

</html>