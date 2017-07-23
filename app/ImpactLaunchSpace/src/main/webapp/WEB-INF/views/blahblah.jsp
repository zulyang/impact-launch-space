<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script>
	            $(document).ready(function() {
		$('#delete').click(function(event) {
			var username = $('#user').val();
			$.get('edit-project-delete', {
				new_project_resource_category : resource_category,
				new_project_resource_name : resource_name,
				new_project_resource_description : resource_description
			}, function(responseText) {
				$('#welcometext').text(responseText);
			});
		});
	});
</script>

<script>
	            $(document).ready(function() {
		$('#update').click(function(event) {

			$.get('edit-project-update', {
	
			}, function(responseText) {

			});
		});
	});
</script>
</head>
<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="5"
		id="resourcesNeeded" class="table table-striped table-hover">
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
			<c:forEach items="${project_requested_resources}" var="item"
				varStatus="loop">

				<tr>
					<td><p>${loop.index + 1}</p></td>
					<td><p>
							<input type="hidden" id="old_resource_name" name="old_resource_name" value="${item.getResource_name()}" />
							
							<input class="editable-field form-control" type="text" id="resource_name" name="resource_name"
								value="${item.getResource_name()}" />
						</p></td>
					<td><p>
							<input type="hidden" id="old_resource_description" name="old_resource_description" value="${item.getResource_name()}" />
							<input class="editable-field form-control" type="textarea" id="resource_description" name="resource_description"
								value="${item.getRequest_description()}" />
						</p></td>
					<td><p>
							<input type="hidden" id="old_resource_category" name="old_resource_category" value="${item.getResource_category()}">
							<select id="resource_category" name="resource_category"
								class="col-md-4 js-example-basic-single-resourcecategory"><option></option>
								<c:forEach items="${resource_category_list}" var="item1">
									<c:choose>
										<c:when test="${item1.getSkillset().equals(item.getResource_category())}">
											<option value="${item1.getSkillset()}" selected="selected">${item1.getSkillset()}</option>
										</c:when>
										<c:otherwise>
											<option value="${item1.getSkillset()}">${item1.getSkillset()}</option>
										</c:otherwise>
									</c:choose>
									
								</c:forEach></select>
					<td class="col-md-2"><p>
							<button type="btn" class="btn btn-primary manage-edit-button"
								href="#">
								<i class="fa fa-pencil"></i> Edit
							</button>
							<button type="submit" class="btn btn-success save" id="update">
								<i class="fa fa-save"></i> Save
							</button>
							<button type="submit" class="btn btn-danger delete" id="delete">
								<i class="fa fa-trash"></i> Delete
							</button>
							<button type="btn" class="btn btn-default cancel" href="#">
								<i class="fa fa-close"></i> Cancel
							</button>
						</p></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>