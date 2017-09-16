<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Project Management</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<link rel='stylesheet'
	href='<%=request.getContextPath()%>/resources/lib/calendar/fullcalendar.css' />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<script
	src='<%=request.getContextPath()%>/resources/lib/calendar/lib/moment.min.js'></script>
<script
	src='<%=request.getContextPath()%>/resources/lib/calendar/fullcalendar.js'></script>

<style>
#sortableToDo, #sortableInProgress, #sortableDone {
	border: 1px solid #eee;
	width: 142px;
	min-height: 20px;
	list-style-type: none;
	margin: 0;
	padding: 5px 0 0 0;
	float: left;
	margin-right: 10px;
}

#sortableToDo li, #sortableInProgress li, #sortableDone li {
	margin: 0 5px 5px 5px;
	padding: 5px;
	font-size: 1.2em;
	width: 120px;
}
</style>
</head>

<body>
	Hi ${username}, welcome to the Project Management Space for
	${projectName}!
	<input type="hidden" id="project_name" value="${projectName}" />
	<input type="hidden" id="project_proposer" value="${projectProposer}" />
	<br>

	<br>

	<div>
		<div id="todoKB">
			<ul id="sortableToDo" class="connectedSortable">
				<c:forEach items="${todoList}" var="todo" varStatus="count">
					<li id="${todo.getCard_id()}" class="ui-state-default">
						${todo.getCard_id()} ${todo.getCard_title()} <br>
						${todo.getDescription()} <br> ${todo.getTags()} <br>
						${todo.getAssignees()} <br>
						<button id="${todo.getCard_id()},todo" type="submit" name="delete"
							class="btn btn-danger delete" onClick="delet(this.id)">
							Delete</button>
						<button type="button" class="btn btn-success" onClick="edit()">
							<i class="fa fa-plus-circle"></i> Edit Card
						</button>
					</li>
				</c:forEach>
			</ul>
		</div>

		<div id="inprogressKB">
			<ul id="sortableInProgress" class="connectedSortable">
				<c:forEach items="${inprogressList}" var="inprogress">
					<li id="${inprogress.getCard_id()}" class="ui-state-default">
						${inprogress.getCard_id()} ${inprogress.getCard_title()} <br>
						${inprogress.getDescription()} <br> ${inprogress.getTags()} <br>
						${inprogress.getAssignees()} <br>
						<button id="${inprogress.getCard_id()},inprogress" type="submit"
							name="delete" class="btn btn-danger delete"
							onClick="delet(this.id)">Delete</button>
						<button type="button" class="btn btn-success" onClick="edit()">
							<i class="fa fa-plus-circle"></i> Edit Card
						</button>
					</li>
				</c:forEach>
			</ul>
		</div>

		<div id="doneKB">
			<ul id="sortableDone" class="connectedSortable">
				<c:forEach items="${doneList}" var="done">
					<li id="${done.getCard_id()}" class="ui-state-default">
						${done.getCard_id()} ${done.getCard_title()} <br>
						${done.getDescription()} <br> ${done.getTags()} <br>
						${done.getAssignees()} <br>
						<button id="${done.getCard_id()},done" type="submit" name="delete"
							class="btn btn-danger delete" onClick="delet(this.id)">
							Delete</button>

						<button type="button" class="btn btn-success" onClick="edit()">
							<i class="fa fa-plus-circle"></i> Edit Card
						</button>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
	<button type="button" class="btn btn-success" onClick="add()">
		<i class="fa fa-plus-circle"></i> Add Card
	</button>

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
						<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
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
									<textarea id="modalCardTitle" rows="4" name="modalCardTitle"
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
						<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
						<button type="button" id="edit" class="btn btn-success">Edit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<!-- I dunno how to increase white space lol -->
	<br>
	<br>
	<br>
	<br>
	<!-- Display List Of Members and the resource they are providing -->

	<div id='calendar'></div>
</body>

<script type="text/javascript">
	function add() {
		$('#AddModal').modal('show');
	};

	function edit() {
		$('#EditModal').modal('show');
	};

	function delet(id) {
		if (confirm("Are you sure you want to delete this card?") == true) {
			var arr = id.split(",");
			var newId = arr[0];
			var column = arr[1];
			$.post('delete-card', {
				card_id : newId,
			});
			$("#todoKB").load(window.location.href + " #todoKB");
			$("#inprogressKB").load(window.location.href + " #inprogressKB");
			$("#doneKB").load(window.location.href + " #doneKB");
			return true;
		} else {
			return false;
		}
	};
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
	
	$(document).ajaxSuccess(function() {
		initialiseKB();
	});
	
	$(document).ajaxError(function() {
		initialiseKB();
	});
	
	$(document).ready(function() {
		// page is now ready, initialize the calendar...
		initialiseKB();
		$('#calendar').fullCalendar({
			// put your options and callbacks here
			height : 400
		})

		$('#add').click(function(event) {
			var modalCardTitle = $('#modalCardTitle').val();
			var modalCardDescription = $('#modalCardDescription').val();
			var modalCardAssignees = $('#modalCardAssignees').val();
			var modalCardTags = $('#modalCardTags').val();
			var board_id = $('#board_id').val();
			var projectName = $('#project_name').val();
			var projectProposer = $('#project_proposer').val();

			var projectName2 = encodeURIComponent(projectName.trim());

			$.post('add-card', {
				modalCardTitle : modalCardTitle,
				modalCardDescription : modalCardDescription,
				modalCardAssignees : modalCardAssignees,
				modalCardTags : modalCardTags,
				board_id : board_id,
			});

			$('#AddModal').modal('hide');
			$("#todoKB").load(window.location.href + " #todoKB");
		});
	});
</script>
</html>