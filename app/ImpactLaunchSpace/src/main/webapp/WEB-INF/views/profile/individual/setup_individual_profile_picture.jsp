<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>ImpactLaunch.Space</title>
<link rel="icon" type="image/png"
	href="<%=request.getContextPath()%>/resources/img/title_rocket_icon.png" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/profile/individual/setup_individual_profile_picture.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.css">
<link href="<%=request.getContextPath()%>/resources/css/cropper.min.css"
	rel="stylesheet">
<link
	href="<%=request.getContextPath()%>/resources/lib/select2/select2.min.css"
	rel="stylesheet" />

<script src="<%=request.getContextPath()%>/resources/lib/cropper.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery/jquery-3.2.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-migrate/jquery-migrate-1.4.1.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/select2/select2.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.js"></script>
</head>
<body class="profile">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">
				<%@include file="../../common/navigation.jspf"%>

				<div class="setup_profile_picture">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">Your Profile Picture</h3>
						</div>
						<div class="panel-body">
							<label for="editChooseIndPic"
								class="btn btn-info edit_indi_profile_save"> <i
								class="fa fa-picture-o" aria-hidden="true" style="font: none;"></i>&nbspChoose
								your profile picture
							</label> <input type="file" name="image" id="editChooseIndPic"
								style="visibility: hidden;" onchange="readURL(this);" />
							<div class="image_container" id="image_container">
								<img id="blah" src="#" alt="" />
							</div>
							<div id="crop_button" class="btn btn-info image_cropper_btns">
								<span><i class="fa fa-crop" aria-hidden="true"></i>&nbspCrop</span>
							</div>
							<div id="reset_button" class="btn btn-warning image_cropper_btns">
								<span><i class="fa fa-trash" aria-hidden="true"></i>&nbspReset Image</span>
							</div>
							<div id="cropped_result" class="cropped_result"></div>
							<div id="confirm_button"
								class="btn btn-success image_cropper_btns">
								<i class="fa fa-check" aria-hidden="true"></i>&nbsp<a
									class="btn_text">Confirm photo</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript" defer>
		function readURL(input) {
			if (input.files && input.files[0]) {

				var reader = new FileReader();
				reader.onload = function(e) {

					$('#blah').attr('src', e.target.result);

				};
				reader.readAsDataURL(input.files[0]);
				setTimeout(initCropper, 1000);
			}
		}
		function initCropper() {
			var image = document.getElementById('blah');
			var cropper = new Cropper(image, {
				aspectRatio : 1 / 1,
				crop : function(e) {
					//console.log(e.detail.x);
					//console.log(e.detail.y);
				}
			});
			
			document
			.getElementById('reset_button')
			.addEventListener(
					'click',
					function() {
						cropper.reset();
						cropper.clear();
						cropper.destroy();
						$('#blah').removeAttr('src');
						var clone = $('#blah').clone();
						$('#blah').remove();
						$('#image_container').append(clone);
						
						$('#cropped_result').children()[0].remove();
					})
			
			// On crop button clicked
			document
					.getElementById('crop_button')
					.addEventListener(
							'click',
							function() {
								var imgurl = cropper.getCroppedCanvas()
										.toDataURL();
								var img = document.createElement("img");
								img.src = imgurl;

								document.getElementById("cropped_result")
										.appendChild(img);
								document.getElementById("cropped_result").childNodes[0]
										.setAttribute(
												"style",
												"border-radius: 50%;width: 250px;display: flex;margin-left: auto;margin-right: auto;");
							})

			document.getElementById('confirm_button').addEventListener('click',
					function() {
						cropper.getCroppedCanvas().toBlob(function(blob) {
							var formData = new FormData();
							formData.append('profilePicture', blob);
							// Use `jQuery.ajax` method
							$.ajax('edit-individual-profile-pic', {
								method : "POST",
								data : formData,
								processData : false,
								contentType : false,
								success : function() {
									console.log('Upload success');
									window.location.href = '/view-my-profile';
								},
								error : function() {
									console.log('Upload error');
								}
							});
						});
					})
		}
	</script>
</body>
</html>
