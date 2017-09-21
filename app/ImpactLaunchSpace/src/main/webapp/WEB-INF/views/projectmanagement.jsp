<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Manage My Project</title>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
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

						<li class="menu-title">Members</li>
						<button type="btn" class="btn btn-primary btn-bordered"
							id="manageusers">Manage</button>

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
							<input type="hidden" id="project_proposer" value="${project_proposer}" /> <br>
							<!--tabs-->

							<ul class="nav nav-tabs tabs-bordered nav-justified" id="pm-tabs">
								<li><a href="#kanban" data-toggle="tab"
									aria-expanded="false"><span class>Kanban</span></a></li>
								<li><a href="#activity-log" data-toggle="tab"
									aria-expanded="false"><span class>Activity Log</span></a></li>
								<li><a href="#project-calendar" data-toggle="tab"
									aria-expanded="false"><span class>Calendar</span></a></li>
								<li><a href="#documents" data-toggle="tab"
									aria-expanded="false"><span class>Documents</span></a></li>
								<li><a href="#group-chat" data-toggle="tab"
									aria-expanded="false"><span class>Group Chat</span></a></li>

							</ul>
							<!--/tabs-->

							<!--tab panes-->
							<div class="section-block">
								<div class="tab-content">

									<div role="tabpanel" class="tab-pane fade in active" id="kanban">
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
													value="${inprogress.getCard_title()}" /> <input type="hidden"
													id="desc${inprogress.getCard_id()}"
													value="${inprogress.getDescription()}" /> <input type="hidden"
													id="tags${inprogress.getCard_id()}"
													value="${inprogress.getTags()}" /> <input type="hidden"
													id="assignee${inprogress.getCard_id()}"
													value="${inprogress.getAssignee()}" /> <input type="hidden"
													id="startdate${inprogress.getCard_id()}"
													value="${inprogress.getStart_date()}" /> <input type="hidden"
													id="duedate${inprogress.getCard_id()}"
													value="${inprogress.getDue_date()}" />

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
													</button>



												</li>
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
													id="tags${done.getCard_id()}"
													value="${done.getTags()}" /> <input type="hidden"
													id="assignee${done.getCard_id()}"
													value="${done.getAssignee()}" /> <input type="hidden"
													id="startdate${done.getCard_id()}"
													value="${done.getStart_date()}" /> <input type="hidden"
													id="duedate${done.getCard_id()}"
													value="${done.getDue_date()}" />
													${done.getCard_title()} <br> ${done.getTags()}
													
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

							
									<div role="tabpanel" class="tab-pane fade"
										id="activity-log">
										<h3 class="tabs-header">ACTIVITY LOG</h3>
										<div class="table-responsive col-md-12">
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
												<option value="">None</option>
												<c:forEach items="${cat}" var="item">
													<option value="${item}">${item}</option>
												</c:forEach>
											</select> <br> 
											
											Assignees: <select id="modalCardAssignee"
												name="modalCardAssignee" class="col-md-4 form-control"
												style="width: 100%">
												<option value="">None</option>
												<c:forEach items="${members}" var="item">
													<option value="${item.getProject_member_username()}">${item.getProject_member_username()}</option>
												</c:forEach>
											</select>

											<!-- Tags refer to the all the resource categories in the project -->
											<br> Start Date: <br> <input type="date"
												name="startdate" required id="startdate"
												onfocus="(this.type='date')"
												placeholder="Start Date Of Task (mm/dd/yyyy)*"
												class="form-control profileField"> Due Date: <br>
												
											<input type="date" name="duedate" required id="duedate"
												onfocus="(this.type='date')"
												placeholder="Due Date Of Task (mm/dd/yyyy)*"
												class="form-control profileField"> 
												
												<input type="hidden" id="board_id" value="${board_id}">

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
												id="modalCardTagsView" name="modalCardTagsView"
												class="col-md-4 form-control" style="width: 100%">
												<c:forEach items="${cat}" var="item">
													<option value="${item}">${item}</option>
												</c:forEach>
											</select> <br> 
											Assignees: <select id="modalCardAssigneeView"
												name="modalCardAssignee" class="col-md-4 form-control"
												style="width: 100%" >
												<option value="">None</option>
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
											<input type="hidden" id="board_id_view" value="${board_id}">
											
											<input type="hidden" id="card_id_view" name = "card_id_view">
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
	
	function refreshActivityLog(){
		
		var projectProposer = $('#project_proposer').val();
		var projectName = $('#project_name').val();
		var projectName2 = encodeURIComponent(projectName.trim());
		
		var url = "project-management?project-name="+projectName2+"&project-proposer="+projectProposer; 
		    setInterval(function(){  
		        $('#activitylogtable').load(url)
		       }, 1000);
	}
	
	$(document).ready(function() {

		// page is now ready, initialize the calendar...
		initialiseKB();
		//refreshActivityLog();
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
		$('#card_id_view').val(newId);
		
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
	$(document).ready(function() {
		$('#add').click(function(event) {
			
			var modalCardTitle = $('#modalCardTitle').val();
			var modalCardDescription = $('#modalCardDescription').val();
			var modalCardAssignee = $('#modalCardAssignee').val();
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
				modalCardAssignee : modalCardAssignee,
				modalCardTags : modalCardTags,
				board_id : board_id,
				start_date : start_date,
				due_date : due_date
			});

			$('#AddModal').modal('hide');
			$("#todoKB").load(window.location.href + " #todoKB");
		});
		
		$('#edit').click(function(event) {

			var modalCardTitle = $('#modalCardTitleView').val();
			var modalCardDescription = $('#modalCardDescriptionView').val();
			var modalCardAssignee = $('#modalCardAssigneeView').val();
			var modalCardTags = $('#modalCardTagsView').val();
			var board_id = $('#board_id_view').val();
			var card_id = $('#card_id_view').val();
			var start_date = $('#startDateView').val();
			var due_date = $('#dueDateView').val();
			var card_id_view = $('#card_id_view').val();
		

			$.post('edit-card', {
				modalCardTitle : modalCardTitle,
				modalCardDescription : modalCardDescription,
				modalCardTags : modalCardTags,
				modalCardAssignee : modalCardAssignee,
				board_id : board_id,
				start_date : start_date,
				due_date : due_date,
				card_id_view : card_id_view
				
			});

			$('#ViewModal').modal('hide');
			$("#todoKB").load(window.location.href + " #todoKB");
			$("#inprogressKB").load(window.location.href + " #inprogressKB");
			$("#doneKB").load(window.location.href + " #doneKB");
		});

	});
	/* $('#manageusers').click(
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
</script>
</html>