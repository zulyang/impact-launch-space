<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/bootstrap-tagsinput.js"></script>
</head>
<body>
	<button id="add">Add resource category</button>

	<table id="mytable" width="300" border="1" cellspacing="0"
		cellpadding="2">
		<tbody>
			<tr class="person">
				<td><select id="category1"
					class="js-example-basic-single-resourcecategory"
					name="selected_resourcecategory1">
						<option></option>
						<option>booty</option>
						<option>edward</option>
				</select></td>
				<td><input type="text" name="name" id="name" /></td>
			</tr>
			<br>
			<button id="addResource">Add resource</button>
		</tbody>
	</table>

	<div class="bs-example">
		<div class="bootstrap-tagsinput">
			<input id="tags" onChange="checkInput();" type="text"
				data-role="tagsinput" style="display: none;" />
		</div>
	</div>

	<script type="text/javascript">
		function checkInput() {
			var info = $("#tags").val();
			console.log("info: " + info);
		}

		$(document).ready(
				function() {

					$("#add").click(
							function() {
								var row = $('#mytable tbody>tr:last').clone(
										true);

								var newRow = row.children().last().children()
										.slice(1).remove();
								console.log(row);
								newRow.insertAfter('#mytable tbody>tr:last');
								$('#mytable tbody>tr:last #name').val('');
								return false;
							});

					$("#addResource").click(
							function() {
								$('#mytable tbody>tr>td:last').clone(true)
										.insertAfter(
												'#mytable tbody>tr>td:last');
								$('#mytable tbody>tr>td:last #name').val('');
								return false;
							});
				});
	</script>
</body>
</html>