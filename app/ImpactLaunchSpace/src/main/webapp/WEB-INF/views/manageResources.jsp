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
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<!--custom css codes -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/resource.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/project.css" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
	integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
	crossorigin="anonymous"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>

</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">
				<%@include file="common/navigation.jspf"%>

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
									<button type="submit" class="btn btn-success create pull-right">
										<i class="fa fa-plus-circle"></i> Add
									</button>
								</div>

							</div>
							</nav>
							<div class="table-responsive col-md-12">
								<table class="table table-striped table-hover">
									<thead>
										<tr>
											<th>S/N</th>
											<th>Resource Name</th>
											<th>Resource Description</th>
											<th>Category</th>
											<th>Actions</th>
										</tr>
									</thead>
									<tbody>
										<%
											int id = 0;
										%>
										<c:forEach items="${user_resource_offering}" var="usf">
											<tr>
												<td><p><%=++id%></p></td>
												<td><p>
														<input class="editable-field form-control" id="reso<%=id %>" type="text"
															value="${usf.getResourceName()}" disabled="true" />
													</p></td>
												<td><p>
														<input class="editable-field form-control"  id="desc<%=id %>" type="textarea"
															value="${usf.getResourceDescription()}" disabled="true" />
													</p></td>
												<td><p>

														<select id="resourceCategory<%=id %>" name="resourceCategory"
															class="col-md-4 js-example-basic-single-resourcecategory resourceCategory">
															<option></option>
															<c:forEach items="${resource_category_list}" var="item">
																<c:choose>
																	<c:when
																		test="${item.getSkillset().equals(usf.getResourceCategory())}">
																		<option value="${item.getSkillset()}"
																			selected="selected">${item.getSkillset()}</option>
																	</c:when>
																	<c:otherwise>
																		<option value="${item.getSkillset()}">${item.getSkillset()}</option>
																	</c:otherwise>
																</c:choose>
															</c:forEach>

														</select> <span class="label label-success"
															id="currentResourceCategory<%=id%>">${usf.getResourceCategory()}</span>
													</p></td>
												<td class="col-md-2"><p>
														<button id="edit<%=id%>" type="btn" name="edit"
															class="btn btn-primary edit" onClick="edit(this.id)" href="#">
															<i class="fa fa-pencil"></i> Edit
														</button>
														<button id="save<%=id%>" type="button" name="save"
															class="btn btn-success save" onClick="save(this.id)" href="#">
															<i class="fa fa-save"></i> Save
														</button>
														<button id="dele<%=id%>" type="submit" name="delete"
															class="btn btn-danger delete" onClick="delete(this.id)" href="#">
															<i class="fa fa-trash"></i> Delete
														</button>
														<button id="canc<%=id%>" type="btn" name="cancel"
															class="btn btn-default cancel" onClick="cancel(this.id)" href="#">
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
									<li><a href="#">«</a></li>
									<li><a href="#">1</a></li>
									<li><a href="#">2</a></li>
									<li><a href="#">3</a></li>
									<li><a href="#">»</a></li>
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

					<form action="addUserResource" role="form" method="post">
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
											class="col-md-4 js-example-basic-single-resourcecategory">
											<option></option>
											<c:forEach items="${resource_category_list}" var="item">
												<option value="${item.getSkillset()}">${item.getSkillset()}</option>
											</c:forEach>
										</select> <input id="modalResourceName" name="modalResourceName"
											class="form-control col-md-4 create-project-add"
											placeholder="What resources do you need?" type="text" />
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
							<button type="submit" class="btn btn-success">Add</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- End of modal -->


	</div>
</body>
<script type="text/javascript">
function edit(id){
	 var disabledStatus = $('.editable-field').attr('disabled');
	 console.log("disabledstatus: " + disabledStatus);
	 
	 var newId = id.substring(4);
  
    	 console.log("id: " + id);
    	 
       	 $('#reso'+newId).prop('disabled', false);
       	 $('#desc'+newId).prop('disabled', false);
	     $('#edit'+newId).hide();
	     $('#dele'+newId).hide();
	     $('#save'+newId).show();
	     $('#canc'+newId).show();
	     $('#resourceCategory' + newId).show();
	     $('#currentResourceCategory' + newId).hide();


};

function save(id){
	 var disabledStatus = $('.editable-field').attr('disabled');
	 
	 var newId = id.substring(4);

   	 console.log("id: " + newId);
   	 
      	 $('#reso'+newId).prop('disabled', true);
      	 $('#desc'+newId).prop('disabled', true); 
	     $('#edit'+newId).show();
	     $('#dele'+newId).show();
	     $('#save'+newId).hide();
	     $('#canc'+newId).hide();
	     $('#resourceCategory' + newId).hide();
	     $('#currentResourceCategory' + newId).show();


};

function cancel(id){
	 var disabledStatus = $('.editable-field').attr('disabled');
	 
	 var newId = id.substring(4);

   	 console.log("id: " + newId);
   	 
      	 $('#reso'+newId).prop('disabled', true);
      	 $('#desc'+newId).prop('disabled', true); 
	     $('#edit'+newId).show();
	     $('#dele'+newId).show();
	     $('#save'+newId).hide();
	     $('#canc'+newId).hide();
	     $('#resourceCategory' + newId).hide();
	     $('#currentResourceCategory' + newId).show();

}
</script>

<script type="text/javascript">

$(document).ready(function(){
		$('button[type="submit"]').click(function (e) {
				$('#myModal').modal('show');
				return true;
		});
		
		    $('.resourceCategory').hide();
		    

	});
	
	</script>

</html>