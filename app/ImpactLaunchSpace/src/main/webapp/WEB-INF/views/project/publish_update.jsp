<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Publish Update</title>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/project/project.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/project/publish_update.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/bootstrap-tagsinput.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.css">
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>

<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/project.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/bootstrap-tagsinput.js"></script>
<link
    href='<%=request.getContextPath()%>/resources/lib/froala-editor/css/froala_editor.min.css'
	rel='stylesheet' type='text/css' />
<link
    href='<%=request.getContextPath()%>/resources/lib/froala-editor/css/froala_style.min.css'
    rel='stylesheet' type='text/css' />    


<link
	href='<%=request.getContextPath()%>/resources/lib/froala-editor/css/plugins/image.min.css'
	rel='stylesheet' type='text/css' />
<link
	href='<%=request.getContextPath()%>/resources/lib/froala-editor/css/plugins/video.min.css'
	rel='stylesheet' type='text/css' />
<link
	href='<%=request.getContextPath()%>/resources/lib/froala-editor/css/plugins/char_counter.min.css'
	rel='stylesheet' type='text/css' />
<link
	href='<%=request.getContextPath()%>/resources/lib/froala-editor/css/plugins/line_breaker.min.css'
	rel='stylesheet' type='text/css' />	
<link
	href='<%=request.getContextPath()%>/resources/lib/froala-editor/css/plugins/table.min.css'
	rel='stylesheet' type='text/css' />		
<script type='text/javascript'
    src='<%=request.getContextPath()%>/resources/lib/froala-editor/js/froala_editor.min.js'></script>

<script type='text/javascript'
	src='<%=request.getContextPath()%>/resources/lib/froala-editor/js/plugins/video.min.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/resources/lib/froala-editor/js/plugins/image.min.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/resources/lib/froala-editor/js/plugins/url.min.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/resources/lib/froala-editor/js/plugins/font_size.min.js'></script>	
<script type='text/javascript'
	src='<%=request.getContextPath()%>/resources/lib/froala-editor/js/plugins/line_breaker.min.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/resources/lib/froala-editor/js/plugins/lists.min.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/resources/lib/froala-editor/js/plugins/char_counter.min.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/resources/lib/froala-editor/js/plugins/table.min.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/resources/lib/froala-editor/js/plugins/align.min.js'></script>	

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
				
				<div class="container publish_update_container">
					
					<div class="row">
						<div class="page-header">
							<h2>Publish Update</h2>
							<p>You may post a short description of the progress of your project</p>
							<form action="post-update" method="POST">
								<input type="hidden" name="project_name" value="${project_name }"/>
								<input type="hidden" name="project_proposer" value="${project_proposer }"/>
								<input class="form-control update_post_title" type="text" id="update_title" name="update_title" placeholder = "Title of post" required/>
								<p></p>
								<textarea id="update_text" name="update_contents" required></textarea>
								<br/>
								<input id="publish" type="submit"
									class="publish_button" value="Submit"/>
							
							</form>
						</div>

					</div>
					
					
				</div>
			</div>
		</div>
	</div>


</body>
<script>
	$(function() {
		$('textarea#update_text').froalaEditor({
	    });
	});
	
	$(function() {
		  $( "#publish" ).click(function() {
		    $( "#publish" ).addClass( "onclic", 250, validate);
		  });

		  function validate() {
		    setTimeout(function() {
		      $( "#publish" ).removeClass( "onclic" );
		      $( "#publish" ).addClass( "validate", 450, callback );
		    }, 2250 );
		  }
		    function callback() {
		      setTimeout(function() {
		        $( "#publish" ).removeClass( "validate" );
		      }, 1250 );
		    }
		  });
</script>

</html>