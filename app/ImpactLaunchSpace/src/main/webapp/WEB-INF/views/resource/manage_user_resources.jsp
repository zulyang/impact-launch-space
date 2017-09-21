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

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/resource.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/lib/datatables/css/jquery.dataTables.css">
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" charset="utf8"
	src="<%=request.getContextPath()%>/resources/lib/datatables/js/jquery.dataTables.js"></script>
<script type="text/javascript">
	$(window).on('load', function() {
		$('#resource_guide_modal').modal('show');
	});
</script>
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
									<button type="button" class="btn btn-warning guide pull-left"
										onClick="help()">
										<i class="fa fa-info-circle"></i> What is a resource?
									</button>
									<button type="button" class="btn btn-success create pull-right"
										onClick="add()">
										<i class="fa fa-plus-circle"></i> Add a resource
									</button>
								</div>

							</div>
							</nav>
							<div class="table-responsive col-md-12">
								<table id="resourcetable" class="table">
									<thead>
										<tr>
											<th class="col-md-4">Resource Name</th>
											<th></th>
											<th class="col-md-4">Resource Description</th>
											<th class="col-md-2">Category</th>
											<th></th>
											<th class="col-md-2">Actions</th>
										</tr>
									</thead>
									<tbody id="userResourceTable">
										<%
											int id = 0;
										%>
										<c:forEach items="${user_resource_offering}" var="uro">
											<tr id="row<%=++id%>">
												<td><p>
														<textarea class="editable-field form-control"
															id="reso<%=id%>" type="text"
															value="${uro.getResourceName()}" disabled="true">${uro.getResourceName()}</textarea>

														<input type="hidden" id="old_reso<%=id%>"
															value="${uro.getResourceName()}" />
													</p></td>
												<td><p>${uro.getResourceName()}</p></td>
												<td><p>
														<textarea class="editable-field form-control"
															id="desc<%=id %>" rows="4"
															value="${uro.getResourceDescription()}" disabled="true">${uro.getResourceDescription()}</textarea>
														<input type="hidden" id="old_desc<%=id%>"
															value="${uro.getResourceDescription()}" />
													</p></td>
												<td><p>
														<input type="hidden" id="old_rc<%=id%>"
															value="${uro.getResourceCategory()}" /> <span
															class="label label-success"
															id="currentResourceCategory<%=id%>">${uro.getResourceCategory()}</span>
														<select id="resourceCategory<%=id%>"
															name="resourceCategory" class="resourceCategory">
															<option disabled>Select a Category:</option>
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
														</select>

													</p></td>

												<td>${uro.getResourceCategory()}</td>

												<td><p>
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
										Resource Category:<select id="modalResourceCategory"
											name="modalResourceCategory" class="col-md-4 form-control"
											style="width: 100%" required>
											<option value="" disabled selected>Select a
												Category:</option>
											<c:forEach items="${resource_category_list}" var="item">
												<option value="${item.getSkillset()}">${item.getSkillset()}</option>
											</c:forEach>
										</select> <br> Resource Name:<input id="modalResourceName"
											name="modalResourceName"
											class="form-control col-md-4 create-project-add"
											placeholder="What resource can you provide?" type="text" />
										<br> Resource Description:
										<textarea id="modalResourceDescription" rows="4"
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

		<div id="resource_guide_modal" class="modal fade" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content resource_modal_content">
					<div class="modal-header resource_modal_header">
						<button type="button" class="close" data-dismiss="modal">
							<img class="close_img"
								src="<%=request.getContextPath()%>/resources/img/close-btn.svg"
								width="42" height="42">
						</button>
						<h4 class="modal-title">What is a resource?</h4>
					</div>
					<div class="modal-body resource_modal_body">
						<div class="row">
							<div class="col-xs-6 assets_column">
								<div class="asset_header">
									<img
										src="<%=request.getContextPath()%>/resources/img/database.png">
									<h3>Assets</h3>
								</div>
								<div class="assets_description">
									<p>Resources can be in the form of assets, such as:</p>
									<ul>
										<li>Monetary aid</li>
										<li>Books</li>
										<li>Computers</li>
										<li>Construction materials</li>
										<li>Manpower</li>
										<li>Others</li>
									</ul>
								</div>
							</div>
							<div class="col-xs-6 skills_column">
								<div class="skills_header">
									<img
										src="<%=request.getContextPath()%>/resources/img/employee.png">
									<h3>Skills</h3>
								</div>
								<div class="skills_description">
									<p>Resources can be in the form of skills, such as:</p>
									<ul>
										<li>Teaching experience</li>
										<li>Software development skills</li>
										<li>Pro-bono legal services</li>
										<li>Sports coaching</li>
										<li>Photography skills</li>
										<li>Others</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer resource_modal_footer" data-dismiss="modal">
						<p class="modal_start_text">GET STARTED!</p>
					</div>
				</div>

			</div>
		</div>

	</div>
</body>
<script>
	$(".assets_column, .skills_column").hide().each(function(i) {
		$(this).delay(i * 700).fadeIn(700);
	});

	$(document)
			.ready(
					function() {

						$('#resourcetable').DataTable({
							responsive : true,
							"columnDefs" : [ {
								"targets" : [ 0 ],
								"searchable" : false
							}, {
								"targets" : [ 1 ],
								"visible" : false
							}, {
								"targets" : [ 3 ],
								"searchable" : false
							}, {
								"targets" : [ 4 ],
								"visible" : false
							}, {
								"targets" : [ 5 ],
								"orderable" : false,
								"searchable" : false
							} ]
						});

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

											if (resourceCategory === null
													|| resourceName === ""
													|| resourceDescription === "") {
												alert("Please fill up all the fields.");
												return false;
											}

											var newId = $('#userResourceTable tr').length + 1;
											$('#userResourceTable')
													.append(
															'<tr id="row'+newId+'"><td><p><textarea class="editable-field form-control"id="reso'+newId+'" type="text" value="'+resourceName+'"disabled="true">'
																	+ resourceName
																	+ '</textarea><input type="hidden" id="old_reso'+newId+'"value="'+resourceName+'"/></p></td><td><p>'
																	+ resourceName
																	+ '</p></td><td><p><textarea class="editable-field form-control"id="desc'+newId+'" rows="4" value="'+resourceDescription+'" disabled="true">'
																	+ resourceDescription
																	+ '</textarea><input type="hidden" id="old_desc'+newId+'"value="'+resourceDescription+'" /></p></td><td><p><input type="hidden" id="old_rc'+newId+'"value="'+resourceCategory+'" />  <span class="label label-success"	id="currentResourceCategory'+newId+'">'
																	+ resourceCategory
																	+ '</span><select id="resourceCategory'+newId+'" name="resourceCategory"	class="resourceCategory"><option></option><c:forEach items="${resource_category_list}" var="item"><c:choose><c:when test="${item.getSkillset().equals('
																	+ resourceCategory
																	+ ')}"><option value="${item.getSkillset()}"selected="selected">${item.getSkillset()}</option></c:when><c:otherwise><option value="${item.getSkillset()}">${item.getSkillset()}</option></c:otherwise></c:choose></c:forEach></select></p></td><td>'
																	+ resourceCategory
																	+ '</td><td class="col-md-2"><p><button id="edit'
																	+ newId
																	+ '" type="btn" name="edit" class="btn btn-primary edit" onClick="edit(this.id)" href="#"><i class="fa fa-pencil"></i> Edit</button><button id="save'
																	+ newId
																	+ '" type="button" name="save" class="btn btn-success save" onClick="save(this.id)"	href="#"><i class="fa fa-save"></i> Save</button><button id="dele'
																	+ newId
																	+ '" type="submit" name="delete"	class="btn btn-danger delete" onClick="del(this.id)" href="#"><i class="fa fa-trash"></i> Delete</button><button id="canc'
																	+ newId
																	+ '" type="btn" name="cancel" class="btn btn-default cancel" onClick="cancel(this.id)" href="#"><i class="fa fa-close"></i> Cancel</button></p></td></tr>');

											var t = $('#resourcetable')
													.DataTable();

											t.row
													.add(
															$('<tr id="row'+newId+'"><td><p><textarea class="editable-field form-control"id="reso'+newId+'" type="text"	value="'+resourceName+'"disabled="true">'
																	+ resourceName
																	+ '</textarea><input type="hidden" id="old_reso'+newId+'"value="'+resourceName+'"/></p></td><td><p>'
																	+ resourceName
																	+ '</p></td><td><p><textarea class="editable-field form-control"id="desc'+newId+'" rows="4" value="'+resourceDescription+'" disabled="true">'
																	+ resourceDescription
																	+ '</textarea><input type="hidden" id="old_desc'+newId+'"value="'+resourceDescription+'" /></p></td><td><p><input type="hidden" id="old_rc'+newId+'"value="'+resourceCategory+'" /> <span class="label label-success"	id="currentResourceCategory'+newId+'">'
																	+ resourceCategory
																	+ '</span><select id="resourceCategory'+newId+'" name="resourceCategory"	class="resourceCategory"><option></option><c:forEach items="${resource_category_list}" var="item"><c:choose><c:when test="${item.getSkillset().equals('
																	+ resourceCategory
																	+ ')}"><option value="${item.getSkillset()}"selected="selected">${item.getSkillset()}</option></c:when><c:otherwise><option value="${item.getSkillset()}">${item.getSkillset()}</option></c:otherwise></c:choose></c:forEach></select></p></td><td>'
																	+ resourceCategory
																	+ '</td><td class="col-md-2"><p><button id="edit'
																	+ newId
																	+ '" type="btn" name="edit" class="btn btn-primary edit" onClick="edit(this.id)" href="#"><i class="fa fa-pencil"></i> Edit</button><button id="save'
																	+ newId
																	+ '" type="button" name="save" class="btn btn-success save" onClick="save(this.id)"	href="#"><i class="fa fa-save"></i> Save</button><button id="dele'
																	+ newId
																	+ '" type="submit" name="delete"	class="btn btn-danger delete" onClick="del(this.id)" href="#"><i class="fa fa-trash"></i> Delete</button><button id="canc'
																	+ newId
																	+ '" type="btn" name="cancel" class="btn btn-default cancel" onClick="cancel(this.id)" href="#"><i class="fa fa-close"></i> Cancel</button></p></td></tr>')[0])
													.draw(false);

											$
													.post(
															'add-user-resource',
															{
																modalResourceCategory : resourceCategory,
																modalResourceName : resourceName,
																modalResourceDescription : resourceDescription
															});

											$('#myModal').modal('hide');
											$('#resourceCategory' + newId).val(
													resourceCategory);
											$('.resourceCategory').hide();

											t.rows().invalidate().draw();
										});

						$('#myModal').on(
								'hidden.bs.modal',
								function() {
									$(this).find("input,textarea,select").val(
											'').end();
								});
					});
</script>
<script type="text/javascript">
	function edit(id) {
		var newId = id.substring(4);

		$('#reso' + newId).prop('disabled', false);
		$('#desc' + newId).prop('disabled', false);
		$('#desc' + newId).css({
			'border' : '1px solid #ccc',
			'background-colour' : '#fff'
		});

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
		$.post('save-user-resource', {
			resourceCategory : resourceCategory,
			resourceName : resourceName,
			resourceDescription : resourceDescription,
			oldResourceCategory : oldResourceCategory,
			oldResourceName : oldResourceName,
			oldResourceDescription : oldResourceDescription
		});

		$("#row" + oldId).hide();

		var newId = $('#userResourceTable tr').length + 1;
		var theRow = $('#userResourceTable tr').length;

		$('tr#row' + oldId)
				.after(
						'<tr id="row'+newId+'"><td><p><textarea class="editable-field form-control" id="reso'+newId+'" type="text" value="'+resourceName+'" disabled="true">'
								+ resourceName
								+ '</textarea> <input type="hidden" id="old_reso'+newId+'" value="'+resourceName+'"/></p></td> <td><p> <textarea rows="4" class="editable-field form-control" style="border: 1px solid transparent;background-color: transparent;" id="desc'+newId+'" value="'+resourceDescription+'" disabled="true">'
								+ resourceDescription
								+ '</textarea> <input type="hidden" id="old_desc'+newId+'" value="'+resourceDescription+'"/></p></td> <td><p> <input type="hidden" id="old_rc'+newId+'" value="'+resourceCategory+'"/> <select id="resourceCategory'+newId+'"name="resourceCategory"class="js-example-basic-single-resourcecategory resourceCategory"> <option></option> <c:forEach items="${resource_category_list}" var="item"> <c:choose> <c:when test="${item.getSkillset().equals('
								+ resourceCategory
								+ ')}"> <option value="${item.getSkillset()}"selected="selected">${item.getSkillset()}</option> </c:when> <c:otherwise> <option value="${item.getSkillset()}">${item.getSkillset()}</option> </c:otherwise> </c:choose> </c:forEach> </select> <span class="label label-success"id="currentResourceCategory'+newId+'">'
								+ resourceCategory
								+ '</span> </p></td><td class="col-md-2"><p> <button id="edit'
								+ newId
								+ '" type="btn" name="edit"class="btn btn-primary edit" onClick="edit(this.id)"href="#"> <i class="fa fa-pencil"></i> Edit </button> <button id="save'
								+ newId
								+ '" type="button" name="save"class="btn btn-success save" onClick="save(this.id)"href="#"> <i class="fa fa-save"></i> Save </button> <button id="dele'
								+ newId
								+ '" type="submit" name="delete"class="btn btn-danger delete" onClick="del(this.id)"href="#"> <i class="fa fa-trash"></i> Delete </button> <button id="canc'
								+ newId
								+ '" type="btn" name="cancel"class="btn btn-default cancel" onClick="cancel(this.id)"href="#"> <i class="fa fa-close"></i> Cancel </button> </p></td></tr>');
		$('#resourceCategory' + newId).hide();

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

	function del(id) {
		if (confirm("Are you sure you want to delete this resource?") == true) {
			var newId = id.substring(4);
			var resourceCategory = $('#resourceCategory' + newId).val();
			var resourceName = $('#reso' + newId).val();
			var resourceDescription = $('#desc' + newId).val();
			$.post('remove-user-resource', {
				resourceCategory : resourceCategory,
				resourceName : resourceName,
				resourceDescription : resourceDescription
			});

			$("#row" + newId).hide();

			return true;
		} else {
			return false;
		}
	};

	function add() {
		$('#myModal').modal('show');
	};

	function help() {
		$('#resource_guide_modal').modal('show');
		$(".assets_column, .skills_column").hide().each(function(i) {
			$(this).delay(i * 700).fadeIn(700);
		});
	};
	
	$('.resource_modal_footer').click(function() {
		$('#myModal').modal('show');
	});
</script>

<script type="text/javascript">
	$(document).ready(function() {
		$('.resourceCategory').hide();
	});
</script>

</html>