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


</head>
<body>
<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">
<%@include file="common/navigation.jspf" %>

<div class="manage-resource-container">
<div class="container">
	<div class="row">
		<h2>Manage Resources</h2>
		<hr>
        <nav class="navbar navbar-default query" role="query">
            <div class="container-fluid">
                <div class="collapse navbar-collapse" id="">
                    <div class="navbar-form navbar-left">
                        <input type="text" class="form-control" placeholder="Search resources"/>
                    </div>
                    <button type="submit" class="btn btn-success create pull-right"><i class="fa fa-plus-circle"></i> Add</button>
                </div>
                
            </div>
        </nav>
        <div class="table-responsive col-md-12">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>S/N</th><th>Resource Name</th><th>Resource Description</th><th>Category</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><p>1</p></td>
                        <td><p>First Aid Skills</p></td>
                        <td><p>other form of description here?</p></td>
                        <td><p><span class="label label-success">Healthcare</span></p></td>
                        <td class="col-md-2"><p>
                            <button type="btn" class="btn btn-primary" href="#"><i class="fa fa-pencil"></i> Edit</button>
                            <button type="btn" class="btn btn-danger" href="#"><i class="fa fa-trash"></i> Delete</button>
                        </p></td>
                    </tr>
                    <tr>
                        <td><p>2</p></td>
                        <td><p>
                            JavaScript professional</p></td>
                            <td><p>3 years of experience
                        </p></td>
                        <td><p><span class="label label-danger">IT</span></p></td>
                        <td class="col-md-2"><p>
                            <button type="btn" class="btn btn-primary" href="#"><i class="fa fa-pencil"></i> Edit</button>
                            <button type="btn" class="btn btn-danger" href="#"><i class="fa fa-trash"></i> Delete</button>
                        </p></td>
                    </tr>
                    
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
</div></div></div>

<!-- Add new resources modal-->
<div class="modal fade" tabindex="-1" role="dialog" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add New Resource(s)</h4>
      </div>
      <div class="modal-body">
	  <div class="container">
		<div class=row>
		<h3>test test</h3>
	  </div>
	  </div>
	  
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-success">Add</button>
      </div>
    </div>
  </div>
</div>
<!-- End of modal -->	
  

</div>
</body>

<script type="text/javascript">

$(document).ready(function(){
		$('button[type="submit"]').click(function (e) {
				$('#myModal').modal('show');
				return true;
		});
	});
	
	</script>

</html>