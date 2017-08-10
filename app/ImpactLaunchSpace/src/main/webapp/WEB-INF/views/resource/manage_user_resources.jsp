<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Resources</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/resource.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/project.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css">
<script src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<link href="<%=request.getContextPath()%>/resources/lib/select2/select2.min.css" rel="stylesheet" />
<script src="<%=request.getContextPath()%>/resources/lib/select2/select2.min.js"></script>
</head>

<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">
				<%@include file="../common/navigation.jspf"%>

				<div class="manage-resource-container">
					<div class="container">
						<div class="row">
							<h2>Manage Resources</h2>
							<hr>
							<nav class="navbar navbar-default query" role="query">
							<div class="container-fluid">
								<div class="collapse navbar-collapse" id="">
									<div class="navbar-form navbar-left">
										<input type="text" class="form-control"
											placeholder="Search resources" />
									</div>
									<button type="button" class="btn btn-success create pull-right"
										onClick="add()">
										<i class="fa fa-plus-circle"></i> Add
									</button>
								</div>

							</div>
							</nav>
							<div class="table-responsive col-md-12">
								<table class="table table-striped table-hover">
									<thead>
										<tr>
											<th>Resource Name</th>
											<th>Resource Description</th>
											<th>Category</th>
											<th>Actions</th>
										</tr>
									</thead>
									<tbody id="userResourceTable">
										<%
											int id = 0;
										%>
										<c:forEach items="${user_resource_offering}" var="uro">
											<tr id="row<%=++id%>">
												<td><p>
														<input class="editable-field form-control"
															id="reso<%=id%>" type="text"
															value="${uro.getResourceName()}" disabled="true" /> <input
															type="hidden" id="old_reso<%=id%>"
															value="${uro.getResourceName()}" />
													</p></td>
												<td><p>
														<input class="editable-field form-control"
															id="desc<%=id %>" type="textarea"
															value="${uro.getResourceDescription()}" disabled="true" />
														<input type="hidden" id="old_desc<%=id%>"
															value="${uro.getResourceDescription()}" />
													</p></td>
												<td><p>
														<input type="hidden" id="old_rc<%=id%>"
															value="${uro.getResourceCategory()}" /> <select
															id="resourceCategory<%=id%>" name="resourceCategory"
															class="col-md-4 resourceCategory">
															<option></option>
															<c:forEach items="${resource_category_list}" var="item">
																<c:choose>
																	<c:when
																		test="${item.getSkillset().equals(uro.getResourceCategory())}">
																		<option value="${item.getSkillset()}"
																			selected="selected">${item.getSkillset()}</option>
																	</c:when>
																	<c:otherwise>
																		<option value="${item.getSkillset()}">${item.getSkillset()}</option>
																	</c:otherwise>
																</c:choose>
															</c:forEach>
														</select> <span class="label label-success"
															id="currentResourceCategory<%=id%>">${uro.getResourceCategory()}</span>
													</p></td>
												<td class="col-md-2"><p>
														<button id="edit<%=id%>" type="btn" name="edit"
															class="btn btn-primary edit" onClick="edit(this.id)"
															href="#">
															<i class="fa fa-pencil"></i> Edit
														</button>
														<button id="save<%=id%>" type="button" name="save"
															class="btn btn-success save" onClick="save(this.id)"
															href="#">
															<i class="fa fa-save"></i> Save
														</button>
														<button id="dele<%=id%>" type="submit" name="delete"
															class="btn btn-danger delete" onClick="del(this.id)"
															href="#">
															<i class="fa fa-trash"></i> Delete
														</button>
														<button id="canc<%=id%>" type="btn" name="cancel"
															class="btn btn-default cancel" onClick="cancel(this.id)"
															href="#">
															<i class="fa fa-close"></i> Cancel
														</button>
													</p></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
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

		<!-- Add new resources modal-->
		<div class="modal fade" tabindex="-1" role="dialog" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<form action="add-user-resource" role="form" method="post">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title">Add New Resource(s)</h4>
						</div>
						<div class="modal-body">
							<div class="container">
								<div id="resourcesNeeded" class="form-group row col-md-5">
									<div class="col-md-12">
										<select id="modalResourceCategory"
											name="modalResourceCategory"
											class="col-md-4 js-example-basic-single-resourcecategoryshown" style = "width : 100%">
											<option></option>
											<c:forEach items="${resource_category_list}" var="item">
												<option value="${item.getSkillset()}">${item.getSkillset()}</option>
											</c:forEach>
										</select> <input id="modalResourceName" name="modalResourceName"
											class="form-control col-md-4 create-project-add"
											placeholder="What resources can you provide?" type="text" />
										<textarea id="modalResourceDescription"
											name="modalResourceDescription"
											class="form-control col-md-4 create-project-add"
											placeholder="Describe your resource here..."></textarea>
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

	</div>
</body>
<script>
	$(document).ready(function() {
		$('#add').click(
				function(event) {
					var resourceCategory = $('#modalResourceCategory').val();
					var resourceName = $('#modalResourceName').val();
					var resourceDescription = $('#modalResourceDescription').val();
					var newId = $('#userResourceTable tr').length + 1;
					$('#userResourceTable').append(
							'<tr id="row'+newId+'"> <td><p><input class="editable-field form-control" id="reso'+newId+'" type="text"value="'+resourceName+'" disabled="true" /> <input type="hidden" id="old_reso'+newId+'" value="'+resourceName+'"/></p></td> <td><p> <input class="editable-field form-control" style="border: 1px solid transparent;background-color: transparent;" id="desc'+newId+'" type="textarea"value="'+resourceDescription+'" disabled="true" /> <input type="hidden" id="old_desc'+newId+'" value="'+resourceDescription+'"/></p></td> <td><p> <input type="hidden" id="old_rc'+newId+'" value="'+resourceCategory+'"/> <select id="resourceCategory'+newId+'"name="resourceCategory"class="col-md-4 js-example-basic-single-resourcecategory resourceCategory"> <option></option> <c:forEach items="${resource_category_list}" var="item"> <c:choose><c:when test="${item.getSkillset().equals('+resourceCategory+')}"> <option value="${item.getSkillset()}"selected="selected">${item.getSkillset()}</option> </c:when> <c:otherwise> <option value="${item.getSkillset()}">${item.getSkillset()}</option> </c:otherwise> </c:choose> </c:forEach> </select> <span class="label label-success"id="currentResourceCategory'+newId+'">'+resourceCategory+'</span> </p></td> <td class="col-md-2"><p> <button id="edit'+newId+'" type="btn" name="edit"class="btn btn-primary edit" onClick="edit(this.id)"href="#"> <i class="fa fa-pencil"></i> Edit </button> <button id="save'+newId+'" type="button" name="save"class="btn btn-success save" onClick="save(this.id)"href="#"> <i class="fa fa-save"></i> Save </button> <button id="dele'+newId+'" type="submit" name="delete"class="btn btn-danger delete" onClick="del(this.id)"href="#"> <i class="fa fa-trash"></i> Delete </button> <button id="canc'+newId+'" type="btn" name="cancel"class="btn btn-default cancel" onClick="cancel(this.id)"href="#"> <i class="fa fa-close"></i> Cancel </button> </p></td></tr>');
						

					$.post('add-user-resource',{
						modalResourceCategory : resourceCategory,
						modalResourceName : resourceName,
						modalResourceDescription : resourceDescription
					});

					$('#myModal').modal('hide');

					$('.resourceCategory').hide();
				});

	$('#myModal').on(
			'hidden.bs.modal',
			function() {
				$(this).find("input,textarea,select").val('').end();
			});
});
</script>
<script type="text/javascript">
	function edit(id) {
		var newId = id.substring(4);

		$('#reso' + newId).prop('disabled', false);
		$('#desc' + newId).prop('disabled', false);
		$('#edit' + newId).hide();
		$('#dele' + newId).hide();
		$('#save' + newId).show();
		$('#canc' + newId).show();
		$('#resourceCategory' + newId).show();
		$('#currentResourceCategory' + newId).hide();
	};

	function save(id) {
		var disabledStatus = $('.editable-field').attr('disabled');

		var oldId = id.substring(4);

		$('#reso' + oldId).prop('disabled', true);
		$('#desc' + oldId).prop('disabled', true);
		$('#edit' + oldId).show();
		$('#dele' + oldId).show();
		$('#save' + oldId).hide();
		$('#canc' + oldId).hide();
		$('#resourceCategory' + oldId).hide();
		$('#currentResourceCategory' + oldId).show();
		
		var resourceCategory = $('#resourceCategory' + oldId).val();
		var resourceName = $('#reso' + oldId).val();
		var resourceDescription = $('#desc' + oldId).val();
		var oldResourceCategory = $('#old_rc' + oldId).val();
		var oldResourceName = $('#old_reso' + oldId).val();
		var oldResourceDescription = $('#old_desc' + oldId).val();
		$.post('save-user-resource',{
			resourceCategory : resourceCategory,
			resourceName : resourceName,
			resourceDescription :resourceDescription,
			oldResourceCategory :oldResourceCategory,
			oldResourceName : oldResourceName,
			oldResourceDescription : oldResourceDescription
		});
		
		$("#row" + oldId).hide();
		
		var newId = $('#userResourceTable tr').length + 1;
		 
		$('tr#row' + oldId).after(
				'<tr id="row'+newId+'"> <td><p><input class="editable-field form-control" id="reso'+newId+'" type="text"value="'+resourceName+'" disabled="true" /> <input type="hidden" id="old_reso'+newId+'" value="${uro.getResourceName()}"/></p></td> <td><p> <input class="editable-field form-control" style="border: 1px solid transparent;background-color: transparent;" id="desc'+newId+'" type="textarea"value="'+resourceDescription+'" disabled="true" /> <input type="hidden" id="old_desc'+newId+'" value="'+resourceDescription+'"/></p></td> <td><p> <input type="hidden" id="old_rc'+newId+'" value="'+resourceCategory+'"/> <select id="resourceCategory'+newId+'"name="resourceCategory"class="col-md-4 js-example-basic-single-resourcecategory resourceCategory"> <option></option> <c:forEach items="${resource_category_list}" var="item"> <c:choose> <c:when test="${item.getSkillset().equals('+resourceCategory+')}"> <option value="${item.getSkillset()}"selected="selected">${item.getSkillset()}</option> </c:when> <c:otherwise> <option value="${item.getSkillset()}">${item.getSkillset()}</option> </c:otherwise> </c:choose> </c:forEach> </select> <span class="label label-success"id="currentResourceCategory'+newId+'">'+resourceCategory+'</span> </p></td> <td class="col-md-2"><p> <button id="edit'+newId+'" type="btn" name="edit"class="btn btn-primary edit" onClick="edit(this.id)"href="#"> <i class="fa fa-pencil"></i> Edit </button> <button id="save'+newId+'" type="button" name="save"class="btn btn-success save" onClick="save(this.id)"href="#"> <i class="fa fa-save"></i> Save </button> <button id="dele'+newId+'" type="submit" name="delete"class="btn btn-danger delete" onClick="del(this.id)"href="#"> <i class="fa fa-trash"></i> Delete </button> <button id="canc'+newId+'" type="btn" name="cancel"class="btn btn-default cancel" onClick="cancel(this.id)"href="#"> <i class="fa fa-close"></i> Cancel </button> </p></td></tr>');
		$('.resourceCategory').hide();
		
		$('#resourceCategory' + newId).val(resourceCategory);
		$('#currentResourceCategory' + newId).val(resourceCategory);
		$('#old_rc' + newId).val(resourceCategory);
		$('#old_reso' + newId).val(resourceName);
		$('#old_desc' + newId).val(resourceDescription);
	};

	function cancel(id) {
		var disabledStatus = $('.editable-field').attr('disabled');

		var newId = id.substring(4);

		$('#reso' + newId).prop('disabled', true);
		$('#desc' + newId).prop('disabled', true);
		$('#edit' + newId).show();
		$('#dele' + newId).show();
		$('#save' + newId).hide();
		$('#canc' + newId).hide();
		$('#resourceCategory' + newId).hide();
		$('#currentResourceCategory' + newId).show();
	};

	function del(id){
		var newId = id.substring(4);
		var resourceCategory = $('#resourceCategory' + newId).val();
		var resourceName = $('#reso' + newId).val();
		var resourceDescription = $('#desc' + newId).val();
		$.post('remove-user-resource',{
			resourceCategory : resourceCategory,
			resourceName : resourceName,
			resourceDescription :resourceDescription
		});
		
		 $("#row" + newId).hide();
	};
	
	function add() {
		$('#myModal').modal('show');
	};
</script>

<script type="text/javascript">
	$(document).ready(function() {
		$('.resourceCategory').hide();
	});
</script>

	<script type="text/javascript">
		$(".js-example-basic-single-resourcecategoryshown").select2({
			placeholder : "Select an expertise/category: ",
			allowClear : true
		});
	</script>

</html>