<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Project Users</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/project/project.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/project/manage_project_users.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/bootstrap-tagsinput.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/lib/datatables/css/jquery.dataTables.css">
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/project.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/select2/select2.min.css" />
<script
	src="<%=request.getContextPath()%>/resources/lib/select2/select2.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/bootstrap-tagsinput.js"></script>
<script type="text/javascript" charset="utf8"
	src="<%=request.getContextPath()%>/resources/lib/datatables/js/jquery.dataTables.js"></script>
</head>
<script>
	function loader() {
		$(".se-pre-con").fadeOut("slow");
	};
</script>
</head>
<body onload="loader()" class="project">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">
				<%@include file="../common/navigation.jspf"%>
				<div class="se-pre-con"></div>
				<div class="container manage_project_users">
					<div class="row">
						<div class="alert alert-info project_name" role="alert">${project.getProject_name() }</div>
						<div class="page-header">
							<h2>Manage Project Users</h2>
						</div>

						<div class="panel panel-primary invite_users_panel">
							<!-- Default panel contents -->
							<div class="panel-heading">Invite users to join project</div>
							<form action="send-invite" method="post">
								<input type="hidden" name="project_name" value="${project.getProject_name() }" />
								<input type="hidden" name="project_proposer" value="${project.getProject_proposer() }" />
								<div class="invite_users_input">
									<div class="form-group">
										<div class="col-sm-9">
											<select
												class="js-example-basic-multiple-banlistusers create-new-project-select2 form-control"
												multiple="multiple" name="invited_users"
												style="width: 100% !important;">
												<c:forEach items="${user_list}" var="item">
													<c:if test="${member_list_string.contains(item) == true }">
														<option value="${item}" disabled>${item}</option>
													</c:if>
													
													<c:if test="${item.equals(username) == false && member_list_string.contains(item) == false}">
														<option value="${item}">${item}</option>
													</c:if>
												</c:forEach>
											</select>
										</div>
									</div>
									<button type="submit" class="btn btn-success invite_btn"
										onclick="return inviteUsers();">Invite</button>
								</div>
							</form>
						</div>

						<div class="panel panel-success remove_users_panel">
							<!-- Default panel contents -->
							<div class="panel-heading">Member List</div>
							<form action="">
							<input type="hidden" id="project_name" value="${project.getProject_name() }" />
							<input type="hidden" id="project_proposer" value="${project.getProject_proposer() }" />
														
								<table id="member_table" class="table users_table">
									<thead>
										<tr id="headers">
											<th>Username</th>
											<th>Role</th>
											<th></th>
										</tr>
									</thead>

									<tbody>
										<%
											int id = 0;
										%>
										<c:forEach items="${member_list}" var="item">
											<tr id="row<%=++id%>">
											<input type="hidden" id="member<%=id%>"
														value="${item.getProject_member_username() }" />
											
											<c:choose>	
											<c:when test="${item.getProject_role().equals(\"admin\") }">
												
													
													<td>${item.getProject_member_username() }</td>
													<td>Admin</td>
													<td><button type="button" id="dele<%=id%>"
															onclick="removeUser(this.id);" class="btn btn-danger"
															disabled>Remove User</button></td>
												
											</c:when>

											<c:when test="${item.getProject_role().equals(\"member\") }">
												
													
													<td>${item.getProject_member_username() }</td>
													<td>Resource offerer</td>
													<td><button type="button" class="btn btn-danger"
															id="dele<%=id%>" onclick="removeUser(this.id);">Remove User</button></td>
												
											</c:when>

											<c:when test="${item.getProject_role().equals(\"invited\") }">
												
													
													<td>${item.getProject_member_username() }</td>
													<td>Member</td>
													<td><button type="button" class="btn btn-danger"
															id="dele<%=id%>" onclick="removeUser(this.id);">Remove User</button></td>
												
											</c:when>
											</c:choose>
										</tr>
										</c:forEach>
										
									</tbody>
								</table>
							</form>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(".js-example-basic-multiple-banlistusers").select2({
			placeholder : "Search for users:"
		});
	</script>

	<script>
		$(document).ready(function() {
			$('#member_table').DataTable({
				"order" : [ [ 1, "asc" ] ],
				responsive : true,
				"columnDefs" : [ {
					"targets" : [ 2 ],
					"orderable" : false
				} ]
			});

		});

		function inviteUsers() {
			if (confirm("Do you wish to send an invitation out to the selected users?")) {
				
				return true;
			}
			return false;
		}

		function removeUser(id) {
			var numId = id.substring(4);
			
			var member_username = $('#member' + numId).val();
			if (confirm("Are you sure you want to remove this user from the project? This action cannot be reversed.")) {
				
				var project_name = $('#project_name').val();
				var project_proposer = $('#project_proposer').val();
				
				console.log(member_username);
				$('#row' + numId).remove();

				$.post('remove-member', {
					member_username : member_username,
					project_name : project_name,
					project_proposer : project_proposer
				});
			}
		}
	</script>

</body>

</html>