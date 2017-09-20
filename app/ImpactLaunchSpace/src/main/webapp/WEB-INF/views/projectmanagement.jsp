<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Manage My Project</title>
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
	src="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<<<<<<< Updated upstream
  <script src='<%=request.getContextPath()%>/resources/lib/calendar/lib/moment.min.js'></script>
  <script src='<%=request.getContextPath()%>/resources/lib/calendar/fullcalendar.js'></script>
<script>
$(function() {
    $("#sortableToDo").sortable({
  	  update: function(event, ui) {
  	      var list = document.getElementById("sortableToDo").getElementsByTagName("li");
  	      for (var i=0; i < list.length; i++) {
  	    	  $.post('update-card-order',{
    					id : list[i].id,
    					status: "todo",
    					order : i,
    				});
  	    	}
  	    },
        connectWith: "#sortableInProgress, #sortableDone"
    }).disableSelection();

    $("#sortableInProgress").sortable({
  	  update: function(event, ui) {
  	      var list = document.getElementById("sortableInProgress").getElementsByTagName("li");
  	      for (var i=0; i < list.length; i++) {
  	    	  $.post('update-card-order',{
    					id : list[i].id,
    					status: "inprogress",
    					order : i,
    				});
  	    	}
  	    },
        connectWith: "#sortableToDo, #sortableDone"
    }).disableSelection();

    $("#sortableDone").sortable({
  	  update: function(event, ui) {
  	      var list = document.getElementById("sortableDone").getElementsByTagName("li");
  	      for (var i=0; i < list.length; i++) {
  	    	  $.post('update-card-order',{
    					id : list[i].id,
    					status: "done",
    					order : i,
    				});
  	      }
  	    },
        connectWith: "#sortableToDo, #sortableInProgress"
    }).disableSelection();
}); 
  $(document).ready(function() {
	  
	    // page is now ready, initialize the calendar...

	    $('#fullcalendar').fullCalendar({
	        // put your options and callbacks here
	    	height: 400,
	    	theme: true
	    }) 
	});
=======
<script
	src='<%=request.getContextPath()%>/resources/lib/calendar/lib/moment.min.js'></script>
<script
	src='<%=request.getContextPath()%>/resources/lib/calendar/fullcalendar.js'></script>
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
>>>>>>> Stashed changes

						<li class="menu-title">Members</li>
						<button type="btn" class="btn btn-primary btn-bordered"
							id="manageusers">Manage</button>

<<<<<<< Updated upstream
<body>
	<!-- <div id="wrapper"> -->
		<div class="container-fluid">
			<div class="row">
				<%@include file="common/navigation.jspf"%>
				<div class="right side-menu">
					<div id="sidebar-menu" class="active">
						<ul class="metisMenu nav in" id="side-menu">
							<li class="menu-title">Project Description</li>
							<p>${projectName}</p>
							<li><a href="#">Test</a></li>
							<hr/>
							<li class="menu-title">Team Calendar</li>
							
							<hr/>
							<li class="menu-title">Members</li>
							<button type="button" class="btn btn-primary btn-bordered" id="manageusers">Manage</button>
						</ul>

					</div>

				</div>

				<div class="col-sm-12 col-md-12 col-lg-12">
					<div class="project-management-container">
						<div class="container-fluid">
							<div class="row">
								Hi ${username}, welcome to the Project Management Space for
								${projectName}! <input type="hidden" id="project_name"
									value="${projectName}" /> <input type="hidden"
									id="project_proposer" value="${projectProposer}" /> <br>

								<!--tabs-->

								<ul class="nav nav-tabs tabs-bordered nav-justified" id="pm-tabs">
									<li><a href="#kanban" data-toggle="tab"
										aria-expanded="false"><span class>Kanban</span></a></li>
									<li><a href="#project-calendar" data-toggle="tab"
										aria-expanded="false"><span class>Calendar</span></a></li>
									<li><a href="#members" data-toggle="tab"
										aria-expanded="false"><span class>Members</span></a></li>
									<li><a href="#group-chat" data-toggle="tab"
										aria-expanded="false"><span class>Group Chat</span></a></li>

								</ul>
								<br>
								<!--/tabs-->
								<!--tab panes-->
								<div class="section-block">
									<div class="tab-content">
										<div role="tabpanel" class="tab-pane active" id="kanban">
											<div class="about-information">
												<h1 class="section-title">KANBAN BOARD</h1>
												<button type="button" class="btn btn-success"
													onClick="add()">
													<i class="fa fa-plus-circle"></i> Add Card
												</button>
												<div>
													<div id="todoKB">
														<ul id="sortableToDo" class="connectedSortable">
															<div class="kanban-header">TO DO</div>
															<c:forEach items="${todoList}" var="todo"
																varStatus="count">
																<li id="${todo.getCard_id()}" class="ui-state-default">
																	${todo.getCard_id()} ${todo.getCard_title()} <br>
																	${todo.getDescription()} <br> ${todo.getTags()} <br>
																	${todo.getAssignees()} <br>
																	<button id="${todo.getCard_id()},todo" type="submit"
																		name="delete" class="btn btn-danger delete"
																		onClick="delet(this.id)">
																		<i class="fa fa-trash"></i> Delete
																	</button>
																	<button type="button" class="btn btn-primary"
																		onClick="edit()">
																		<i class="fa fa-pencil"></i> Edit
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
																	class="ui-state-default">
																	${inprogress.getCard_id()}
																	${inprogress.getCard_title()} <br>
																	${inprogress.getDescription()} <br>
																	${inprogress.getTags()} <br>
																	${inprogress.getAssignees()} <br>
																	<button id="${inprogress.getCard_id()},inprogress"
																		type="submit" name="delete"
																		class="btn btn-danger delete" onClick="delet(this.id)">
																		<i class="fa fa-trash"></i> Delete
																	</button>
																	<button type="button" class="btn btn-primary"
																		onClick="edit()">
																		<i class="fa fa-pencil"></i> Edit
																	</button>
																</li>
															</c:forEach>
														</ul>
													</div>

													<div id="doneKB">
														<ul id="sortableDone" class="connectedSortable">
															<div class="kanban-header">DONE</div>
															<c:forEach items="${doneList}" var="done">
																<li id="${done.getCard_id()}" class="ui-state-default">
																	${done.getCard_id()} ${done.getCard_title()} <br>
																	${done.getDescription()} <br> ${done.getTags()} <br>
																	${done.getAssignees()} <br>
																	<button id="${done.getCard_id()},done" type="submit"
																		name="delete" class="btn btn-danger delete"
																		onClick="delet(this.id)">
																		<i class="fa fa-trash"></i> Delete
																	</button>

																	<button type="button" class="btn btn-primary"
																		onClick="edit()">
																		<i class="fa fa-pencil"></i> Edit
																	</button>
																</li>
															</c:forEach>
														</ul>
													</div>
												</div>

											</div>
										</div>
										<div role="tabpanel" class="tab-pane" id="project-calendar">
											<div class="full-calendar">
												<h1 class="section-title">CALENDAR</h1>
												<div class="full-calendar-container">
													<div id='fullcalendar'></div>
												</div>
											</div>
										</div>
										<div role="tabpanel" class="tab-pane" id="members">
											<div class="update-information">
												<h1 class="section-title">MANAGE USER RESOURCES</h1>

											</div>
										</div>
										<div role="tabpanel" class="tab-pane" id="group-chat">
											<div class="update-information">
												<h1 class="section-title">GROUP CHAT</h1>

											</div>
										</div>


=======
						<div class="members-profile-icon">
							<!-- Each member profile icon here -->
						</div>

					</ul>

				</div>

			</div>

			<div class="col-sm-12 col-md-12 col-lg-12">
				<div class="project-management-container">
					<div class="container-fluid">
						<div class="row">
							<div class="pms-header">Project Management Space</div>

							<input type="hidden" id="project_name" value="${projectName}" />
							<input type="hidden" id="project_proposer"
								value="${projectProposer}" /> <br>

							<!--tabs-->

							<ul class="nav nav-tabs tabs-bordered nav-justified" id="pm-tabs">
								<li><a href="#activity-log" data-toggle="tab"
									aria-expanded="false"><span class>Activity Log</span></a></li>
								<li><a href="#kanban" data-toggle="tab"
									aria-expanded="false"><span class>Kanban</span></a></li>
								<li><a href="#project-calendar" data-toggle="tab"
									aria-expanded="false"><span class>Calendar</span></a></li>
								<li><a href="#documents" data-toggle="tab"
									aria-expanded="false"><span class>Documents</span></a></li>
								<li><a href="#group-chat" data-toggle="tab"
									aria-expanded="false"><span class>Group Chat</span></a></li>

							</ul>
							<br>
							<!--/tabs-->

							<!--tab panes-->
							<div class="section-block">
								<div class="tab-content">

									<div role="tabpanel" class="tab-pane fade in active"
										id="activity-log">
										<h3 class="tabs-header">ACTIVITY LOG</h3>
									</div>

									<div role="tabpanel" class="tab-pane fade" id="kanban">
										<h3 class="tabs-header">KANBAN BOARD</h3>
										<button type="button" class="btn btn-success" onClick="add()">
											<i class="fa fa-plus-circle"></i> Add Card
										</button>
									</div>
								</div>
								<br> <br>

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
													value="${todo.getDue_date()}" /> ${todo.getCard_title()} <br>
													${todo.getTags()} <br>

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
												<li id="${inprogress.getCard_id()}" class="ui-state-default">

													<input type="hidden" id="title${inprogress.getCard_id()}"
													value="${todo.getCard_title()}" /> <input type="hidden"
													id="desc${inprogress.getCard_id()}"
													value="${todo.getDescription()}" /> <input type="hidden"
													id="tags${inprogress.getCard_id()}"
													value="${todo.getTags()}" /> <input type="hidden"
													id="assignee${inprogress.getCard_id()}"
													value="${todo.getAssignee()}" /> <input type="hidden"
													id="startdate${inprogress.getCard_id()}"
													value="${todo.getStart_date()}" /> <input type="hidden"
													id="duedate${inprogress.getCard_id()}"
													value="${todo.getDue_date()}" />

													${inprogress.getCard_title()} <br>
													${inprogress.getTags()} <br>

													<button id="${inprogress.getCard_id()}" type="submit"
														name="delete" class="btn btn-danger delete"
														onClick="delet(this.id)">
														<i class="fa fa-trash"></i> Delete
													</button>

													<button id="view${inprogress.getCard_id()}" type="submit"
														name="view" class="btn btn-primary"
														onClick="view(this.id)">
														<i class="fa fa-pencil"></i> View
													</button>

												</li>
											</c:forEach>
										</ul>
									</div>

									<div id="doneKB">
										<ul id="sortableDone" class="connectedSortable">
											<div class="kanban-header">DONE</div>

											<c:forEach items="${doneList}" var="done">
												<li id="${done.getCard_id()}" class="ui-state-default">

													${done.getCard_title()} <br> ${done.getTags()}

													<button id="${done.getCard_id()}" type="submit"
														name="delete" class="btn btn-danger delete"
														onClick="delet(this.id)">
														<i class="fa fa-trash"></i> Delete
													</button>

													<button id="view${done.getCard_id()}" type="submit"
														name="view" class="btn btn-primary" onClick="view()">
														<i class="fa fa-pencil"></i> View
													</button>

												</li>
											</c:forEach>
										</ul>
>>>>>>> Stashed changes
									</div>
								</div>

							</div>
<<<<<<< Updated upstream
							<!--/tabs-->
							<!-- end of tab -->
							<br>



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

														</select> <br> Description:
														<textarea id="modalCardDescription" rows="4"
															name="modalCardDescription"
															class="form-control col-md-4 create-project-add"
															placeholder="Describe your card here..."></textarea>
														<br>

														<!-- Tags refer to the all the resource categories in the project -->
														Tags: <select id="modalCardTags" name="modalCardTags"
															class="col-md-4 form-control" style="width: 100%">
															<option value="" disabled selected>Select a Category:</option>
															<c:forEach items="${cat}" var="item">
																<option value="${item}">${item}</option>
															</c:forEach>
														</select> <br> Assignees: <select id="modalCardAssignees"
															name="modalCardAssignees" class="col-md-4 form-control"
															style="width: 100%">
															<option value="" disabled selected>Select a username:</option>
															<c:forEach items="${members}" var="item">
																<option value="${item.getProject_member_username()}">${item.getProject_member_username()}</option>
															</c:forEach>
														</select> <input type="hidden" id="board_id" value="${board_id}">

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


						<!-- Edit card modal (Copied from resources)-->
						<!-- Replace with placeholders. -->
						<div class="modal fade" tabindex="-1" role="dialog" id="EditModal">
							<div class="modal-dialog">
								<div class="modal-content">

									<form action="edit-card" role="form" method="post">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
											<h4 class="modal-title">Edit Card</h4>
										</div>
										<div class="modal-body">
											<div class="container">
												<div id="resourcesNeeded" class="form-group row col-md-5">
													<div class="col-md-12">
														Card Title:
														<textarea id="modalCardTitle" rows="4"
															name="modalCardTitle"
															class="form-control col-md-4 create-project-add"
															placeholder="${todo.getCard_title()}"></textarea>
														</select> <br> Description:
														<textarea id="modalCardDescription" rows="4"
															name="modalCardDescription"
															class="form-control col-md-4 create-project-add"
															placeholder=${todo.getDescription()}></textarea>
														<br>

														<!-- Tags refer to the all the resource categories in the project -->
														Tags: <select id="modalCardTags" name="modalCardTags"
															class="col-md-4 form-control" style="width: 100%">
															<option value="" disabled selected>Select a Category:</option>
															<c:forEach items="${cat}" var="item">
																<option value="${item}">${item}</option>
															</c:forEach>
														</select> <br> Assignees: <select id="modalCardAssignees"
															name="modalCardAssignees" class="col-md-4 form-control"
															style="width: 100%" required>
															<option value="" disabled selected>Select a username:</option>
															<c:forEach items="${members}" var="item">
																<option value="${item.getProject_member_username()}">${item.getProject_member_username()}</option>
															</c:forEach>
														</select>
													</div>
												</div>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal">Cancel</button>
											<button type="button" id="edit" class="btn btn-success">Edit</button>
										</div>
									</form>
								</div>
							</div>
						</div>
						<br> <br> <br> <br>
						<!-- I dunno how to increase white space lol -->
						<br> <br> <br> <br>
						<!-- Display List Of Members and the resource they are providing -->


=======

							<div role="tabpanel" class="tab-pane fade" id="project-calendar">
								<div class="full-calendar">
									<h3 class="tabs-header">CALENDAR</h3>
									<div class="full-calendar-container">
										<div id='fullcalendar'></div>
									</div>
								</div>
							</div>

							<div role="tabpanel" class="tab-pane fade" id="documents">
								<h3 class="tabs-header">DOCUMENTS</h3>
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
											<textarea id="modalCardTitle" rows="4" name="modalCardTitle"
												class="form-control col-md-4 create-project-add"
												placeholder="Give your card a title here..."></textarea>

											</select> <br> Description:
											<textarea id="modalCardDescription" rows="4"
												name="modalCardDescription"
												class="form-control col-md-4 create-project-add"
												placeholder="Describe your card here..."></textarea>
											<br>

											<!-- Tags refer to the all the resource categories in the project -->
											Tags: <select id="modalCardTags" name="modalCardTags"
												class="col-md-4 form-control" style="width: 100%">
												<option value="" disabled selected>Select a
													Category:</option>
												<c:forEach items="${cat}" var="item">
													<option value="${item}">${item}</option>
												</c:forEach>
											</select> <br> Assignees: <select id="modalCardAssignees"
												name="modalCardAssignees" class="col-md-4 form-control"
												style="width: 100%">
												<option value="" disabled selected>Select a
													username:</option>
												<c:forEach items="${members}" var="item">
													<option value="${item.getProject_member_username()}">${item.getProject_member_username()}</option>
												</c:forEach>
											</select>

											<!-- Tags refer to the all the resource categories in the project -->
											<br> Start Date: <br> <input type="date"
												name="startDate" required id="startDate"
												onfocus="(this.type='date')"
												placeholder="Start Date Of Task (mm/dd/yyyy)*"
												class="form-control profileField"> Due Date: <br>
											<input type="date" name="dueDate" required id="dueDate"
												onfocus="(this.type='date')"
												placeholder="Due Date Of Task (mm/dd/yyyy)*"
												class="form-control profileField"> <input
												type="hidden" id="board_id" value="${board_id}">

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
									<div id="resourcesNeeded" class="form-group row col-md-5">
										<div class="col-md-12">

											Card Title: <input type="text" id="modalCardTitleView"
												class="form-control col-md-4 create-project-add"
												name="modalCardTitle"> <br> Description: <input
												type="text" id="modalCardDescriptionView"
												class="form-control col-md-4 create-project-add"
												name="modalCardDescription"> <br> Tags: <select
												id="modalCardTagsView" name="modalCardTags"
												class="col-md-4 form-control" style="width: 100%">
												<c:forEach items="${cat}" var="item">
													<option value="${item}">${item}</option>
												</c:forEach>
											</select> <br> Assignees: <select id="modalCardAssigneeView"
												name="modalCardAssignees" class="col-md-4 form-control"
												style="width: 100%" required>
												<c:forEach items="${members}" var="item">
													<option value="${item.getProject_member_username()}">${item.getProject_member_username()}</option>
												</c:forEach>
											</select> <br> Start Date: <br> <input type="date"
												name="startDate" id="startDateView"
												onfocus="(this.type='date')"
												class="form-control profileField"> Due Date: <br>
											<input type="date" name="dueDate" id="dueDateView"
												onfocus="(this.type='date')"
												class="form-control profileField"> Comments: <br>

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
>>>>>>> Stashed changes
					</div>
				</div>
			</div>
			<br> <br> <br> <br> <br> <br> <br>
			<br>
			<!-- Display List Of Members and the resource they are providing -->
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
						connectWith : "#sortableToDo, #sortableInProgress"
					}).disableSelection();
		});
	}
	$(document).ready(function() {

		// page is now ready, initialize the calendar...
		initialiseKB();
		$('#fullcalendar').fullCalendar({
			// put your options and callbacks here
			height : 400,
			theme : true
		})
	});
</script>

<script type="text/javascript">
	function add() {
		$('#AddModal').modal('show');
	};

	function view(id) {
		var newId = id.substring(4);
		var title = $('#title' + newId).val();
		var desc = $('#desc' + newId).val();
		var tags = $('#tags' + newId).val();
		var assignee = $('#assignee' + newId).val();
		var start_date = $('#startdate' + newId).val();
		var due_date = $('#duedate' + newId).val();

		$('#modalCardTitleView').val(title);
		$('#modalCardDescriptionView').val(desc);
		$('#modalCardTagsView').val(tags);
		$('#modalCardAssigneeView').val(assignee);
		$('#startDateView').val(start_date);
		$('#dueDateView').val(due_date);

		$('#ViewModal').modal('show');
	};

	function delet(id) {
		if (confirm("Are you sure you want to delete this card?") == true) {
			$.post('delete-card', {
				card_id : id,
			});
			$("#todoKB").load(window.location.href + " #todoKB");
			$("#inprogressKB").load(window.location.href + " #inprogressKB");
			$("#doneKB").load(window.location.href + " #doneKB");
			return true;
		} else {
			return false;
		}
	};
</script>

<script>
<<<<<<< Updated upstream
	$(document).ready(function() {	
		$('#add').click(
				function(event) {
							
					var modalCardTitle = $('#modalCardTitle').val();
					var modalCardDescription = $('#modalCardDescription').val();
					var modalCardAssignees = $('#modalCardAssignees').val();
					var modalCardTags = $('#modalCardTags').val();
					var board_id = $('#board_id').val();
					var projectName = $('#project_name').val();
					var projectProposer = $('#project_proposer').val();
					
					var projectName2 = encodeURIComponent(projectName.trim());
					
					$.post('add-card',{
						modalCardTitle : modalCardTitle,
						modalCardDescription : modalCardDescription,
						modalCardAssignees : modalCardAssignees,
						modalCardTags: modalCardTags,
						board_id: board_id,
					});
					
					$('#AddModal').modal('hide');
					$("#todoKB").load(window.location.href + " #todoKB" );
				});
		
		$('#manageusers').click(
				function(e){
				    e.preventDefault();
				    $('#pm-tabs a[href="#members"]').tab('show');
				});
				
		
		}); 						
=======
	$(document).ready(function() {
		$('#add').click(function(event) {

			var modalCardTitle = $('#modalCardTitle').val();
			var modalCardDescription = $('#modalCardDescription').val();
			var modalCardAssignees = $('#modalCardAssignees').val();
			var modalCardTags = $('#modalCardTags').val();
			var board_id = $('#board_id').val();
			var projectName = $('#project_name').val();
			var projectProposer = $('#project_proposer').val();
			var start_date = $('#startdate').val();
			var due_date = $('#duedate').val();
			var projectName2 = encodeURIComponent(projectName.trim());

			$.post('add-card', {
				modalCardTitle : modalCardTitle,
				modalCardDescription : modalCardDescription,
				modalCardAssignees : modalCardAssignees,
				modalCardTags : modalCardTags,
				board_id : board_id,
				start_date : start_date,
				due_date : due_date
			});

			$('#AddModal').modal('hide');
			$("#todoKB").load(window.location.href + " #todoKB");
		});

	});
	/* 		$('#manageusers').click(
	 function(e){
	 e.preventDefault();
	 $('#pm-tabs a[href="#members"]').tab('show');
	 }); */

	$(document).ajaxSuccess(function() {
		initialiseKB();
	});

	$(document).ajaxError(function() {
		initialiseKB();
	});
>>>>>>> Stashed changes
</script>
</html>