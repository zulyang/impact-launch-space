<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create New Project</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/project/project.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/project/create_project.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/bootstrap-tagsinput.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/jquery-ui/jquery-ui.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/lib/font-awesome/css/font-awesome.css">
<link href="<%=request.getContextPath() %>/resources/lib/smartwizard/dist/css/smart_wizard.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/resources/lib/smartwizard/dist/css/smart_wizard_theme_dots.css" rel="stylesheet" type="text/css" />
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.5/validator.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/resources/lib/smartwizard/dist/js/jquery.smartWizard.js"></script>
	    
<script>
	function loader() {
		$(".se-pre-con").fadeOut("slow");
	};
</script>
</head>
<body onload="loader()" class="project">
	<div class="se-pre-con"></div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">

				<!--navigation bar  -->
				<%@include file="../common/navigation.jspf"%>
<div class="container" style="margin-top: 5rem;">

				<form action="create-project" id="createProject" role="form" data-toggle="validator" method="post" accept-charset="utf-8" enctype="multipart/form-data">
				 <!-- SmartWizard html -->
        <div id="smartwizard">
            <ul>
                <li><a href="#step-1">Step 1<br /><small>Basic Information</small></a></li>
                <li><a href="#step-2">Step 2<br /><small>Story</small></a></li>
                <li><a href="#step-3">Step 3<br /><small>Resources</small></a></li>
                <li><a href="#step-4">Step 4<br /><small>Terms and Conditions</small></a></li>
            </ul>
            
            <div>
                <div id="step-1">
                    <h2>Step 1</h2>
                    <p>Fill in basic information of new project</p>
                                    <p class="required">* fields are required </p>
                    <div id="form-step-0" role="form" data-toggle="validator">
                        <div class="form-group row">
                            <label for="projectImage" class="col-sm-3 col-form-label">Image</label>
										<div class="col-sm-9">
                                            <div id="profile_upload_button" class="profile_upload_button" onclick="uploadPicture()">Upload a project display picture</div>

											<div style='height: 0px; width: 0px; overflow: hidden;'>
												<input id="uploadPicture" name="projectImage" type="file"
													value="upload" onchange="sub(this)" />
											</div>
										</div>
										</div>
                            
                     <div class="form-group row">       
                            <label for="projectTitle" class="col-sm-3 col-form-label">Title (max 69 characters)<span class="required">*</span></label>
                            <div class="col-sm-9">
                            <input type="text" class="form-control" name="projectTitle" id="projectTitle" placeholder="Write your project title" maxlength="69" required>
                            <div class="help-block with-errors"></div>
                        </div>
                    </div>
                    
                    <div class="form-group row">
                                        <label for="projectPurpose" class="col-sm-3 col-form-label">Purpose<span class="required">*</span></label>

										<div class="col-sm-9">
											<input required type="text" id="projectPurpose"
												name="projectPurpose" class="form-control"
												placeholder="Your project purpose in one line">
												<div class="help-block with-errors"></div>
										</div>
									</div>
                    
                    <div class="form-group row">
										<label for="socialImpactType" class="col-sm-3 col-form-label">Social
                                            Impact Type<span class="required">*</span></label>

										<div class="col-sm-9">
											<select required id="socialImpact"
												class="js-example-basic-multiple-targetprojectareas create-new-project-select2 form-control"
												multiple="multiple" name="selected_projectareas" style="width: 100% !important;">
												<c:forEach items="${project_area_list}" var="item">
													<option value="${item.getProject_area()}">${item.getProject_area()}</option>
												</c:forEach>
											</select>
											<div class="help-block with-errors"></div>	
										</div>
									</div>

									<div class="form-group row">
										<label for="projectOwner" class="col-sm-3 col-form-label">Project
                                            Owner<span class="required">*</span></label>

										<div class="col-sm-9" style="display: block; height: 34px;">
											<input required type="radio" id="radio_indi"
												value="individual" name="projectOwner" /> Myself <input
												required type="radio" id="radio_org" value="organization"
												name="projectOwner" /> Organization <input required
												type="hidden" id="userType" name="userType"
												value="${user_type}"> <input type="hidden"
												id="indiOrg" name="indiOrg" value="${indi_org}">
												<div class="help-block with-errors"></div>
										</div>
									</div>

									<div class="form-group row">
										<label for="projectLocation" class="col-sm-3 col-form-label">Project
                                            Location<span class="required">*</span></label>

										<div class="col-sm-9">
											<select required id="projectLocation"
												class="js-example-basic-single-projectlocation create-new-project-select2 form-control"
												name="projectLocation" style="width: 100% !important;">
												<option></option>
												<c:forEach items="${country_list}" var="item">
													<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
												</c:forEach>
											</select>
											<div class="help-block with-errors"></div>
										</div>
									</div>

									<div class="form-group row">
										<label for="projectDescription"
                                            class="col-sm-3 col-form-label">Project Description<span class="required">*</span></label>

										<div class="col-sm-9">
											<textarea required id="projectDescription" value=""
												name="projectDescription" class="form-control"
												placeholder="A short summary of project" rows="4"></textarea>
												<div class="help-block with-errors"></div>
										</div>
									</div>

									<div class="form-group row">
										<label for="projectPrivacy" class="col-sm-3 col-form-label">Project
                                            Privacy<span class="required">*</span> <i class="fa fa-info-circle info_tooltip" rel="tooltip" title="A secret project hides it from everyone except project owner and it cannot be searched. A closed project hides it from outsiders (only project members can access). "></i></label>

										<div class="col-sm-9" style="display: block; height: 34px;">
											<input required type="radio" id="projectPrivacy1"
												value="public" name="projectPrivacy" /> Public <input
												required type="radio" id="projectPrivacy2" value="hidden"
                                                name="projectPrivacy" /> Secret <input required

												type="radio" id="projectPrivacy3" value="private"
                                                name="projectPrivacy" /> Closed
                                                <div class="help-block with-errors"></div>

										</div>
									</div>

									<div class="form-group row">
										<label for="projectDuration" class="col-sm-3 col-form-label">Estimated
                                            Duration<span class="required">*</span>    </label>

										<div class="col-sm-9">
											<input required type="number" id="projectDuration" value=""
												name="projectDuration" class="form-control"
												placeholder="Number of days">
												<div class="help-block with-errors"></div>
										</div>
									</div>


									<div class="form-group row">
										<label for="projectBanList" class="col-sm-3 col-form-label">Ban
											List</label>
										<div class="col-sm-9">
											<select
												class="js-example-basic-multiple-banlistusers create-new-project-select2 form-control"
												multiple="multiple" name="selected_banlist" style="width: 100% !important;">
												<c:forEach items="${user_list}" var="item">
													<c:if test="${item.equals(username) == false}">
														<option value="${item}">${item}</option>
													</c:if>
												</c:forEach>
											</select><div class="help-block with-errors"></div> <br>
										</div>
									</div>
                    
                    
                    </div>
                </div>
                
                <div id="step-2">
                    <h2>Step 2 (optional)</h2>
                    <p>Upload relevant materials for others to know more about
										your project</p>
                    <div id="form-step-1" role="form" data-toggle="validator">
                        <div class="form-group row">
                            <label for="projectVideo" class="col-sm-3 control-label">Project
											Video</label>
										<div class="col-sm-9">
											<input type="text" maxlength="69" id="projectVideo"
													name="projectVideo" class="form-control" placeholder="URL link for video">
										</div>
										
                            <div class="help-block with-errors"></div>
                        </div>
                        
                        <div class="form-group row ">
							<label for="projectDocuments" class="col-sm-3 col-form-label">Project
								Documents</label>
							<div class="col-sm-9">
								<div id="document_upload_button" class="document_upload_button" onclick="uploadFile()">Upload your supporting document</div>
		
								<div style='height: 0px; width: 0px; overflow: hidden;'>
									<input id=uploadFile name="documents" multiple type="file"
										value="upload" onchange="docSub(this)" />
								</div>
							</div>
						</div>
									
                    </div>
                </div>
                <div id="step-3">
                    <h2>Project Resources</h2>
                    <p>Indicate the resource(s) your project need</p>
                    <div id="form-step-2" role="form" data-toggle="validator">
                    
                     <div id="resourcesNeeded" class="form-group row col-sm-9">
										<div class="col-md-12" id="resourceRow1" style="padding-top: 3rem;">
											<select required id="resourceCategory1"
                                                name="resourceCategory" class="col-md-4 form-control resourceCat" style= "width: 100%; margin-bottom: 2rem;">

												<option value="" disabled selected>Select your
													resource category</option>
												<c:forEach items="${resource_category_list}" var="item">
													<option value="${item.getSkillset()}">${item.getSkillset()}</option>
												</c:forEach>
											</select> <input required id="resourceName1" name="resourceName"
												style="padding-top: 1rem; margin-bottom: 2rem;"
												class="form-control col-md-4 resourceName"
												placeholder="What resources do you need?" type="text" />
											<textarea required id="resourceDescription1"
												style="padding-top: 3rem; margin-bottom: 2rem;" name="resourceDescription"
												class="form-control col-md-4 resourceDes"
												placeholder="Describe your resource here..."></textarea>
												
												<div class="help-block with-errors"></div>
											<button id="dele1" type="button" name="delete"
												class="btn btn-danger pull-right delete" onClick="del(this.id)">
												<i class="fa fa-trash"></i> Remove this resource
											</button>
										</div>
									</div>


									<div class="col-sm-12">
										<input id="addResource" class="btn btn-info" type="button"
											value="Add Resource" /> <br />
										<hr />
										
										
									</div>
                    </div>
                </div>
                <div id="step-4" class="">
                    <h2>Terms and Conditions</h2>
                    <div id="form-step-3" role="form" data-toggle="validator">
                        <div class="form-group">
                            <input type="checkbox" id="terms" data-error="Please accept the Terms and Conditions" required>
                            <label for="terms">I agree with the T&C</label>  
                            <div class="help-block with-errors"></div>
                        </div>
                    </div>
                    
                    
                </div>
            </div>
        </div>
				</form>
				
				
				</div>
			</div>
		</div>
	</div>

    <script type="text/javascript">
        $(document).ready(function(){
            
            // Toolbar extra buttons
            var btnFinish = $('<button></button>').text('Finish')
                                             .addClass('btn btn-info')
                                             .on('click', function(){ 
                                                    if( !$(this).hasClass('disabled')){ 
                                                        var elmForm = $("#createProject");
                                                        if(elmForm){
                                                            elmForm.validator('validate'); 
                                                            var elmErr = elmForm.find('.has-error');
                                                            if(elmErr && elmErr.length > 0){
                                                                alert('Oops! There is an error in the form');
                                                                return false;    
                                                            }else{
                                                                var userResponse = confirm('Are you sure you want to create this project?');
                                                                if(userResponse == true){
                                                                	elmForm.submit();	
                                                                } else {
                                                                	return false;	
                                                                }
                                                                return false;
                                                            }
                                                        }
                                                    }
                                                });
            var btnCancel = $('<button></button>').text('Cancel')
                                             .addClass('btn btn-danger')
                                             .on('click', function(){ 
                                                    $('#smartwizard').smartWizard("reset"); 
                                                    $('#createProject').find("input, textarea").val(""); 
                                                });                         
            
            
            
            // Smart Wizard
            $('#smartwizard').smartWizard({ 
                    selected: 0, 
                    theme: 'dots',
                    transitionEffect:'fade',
                    toolbarSettings: {toolbarPosition: 'bottom',
                                      toolbarExtraButtons: [btnFinish, btnCancel]
                                    },
                    anchorSettings: {
                                markDoneStep: true, // add done css
                                markAllPreviousStepsAsDone: true, // When a step selected by url hash, all previous steps are marked done
                                removeDoneStepOnNavigateBack: true, // While navigate back done step after active step will be cleared
                                enableAnchorOnDoneStep: true // Enable/Disable the done steps navigation
                            }
                 });
            
            $("#smartwizard").on("leaveStep", function(e, anchorObject, stepNumber, stepDirection) {
                var elmForm = $("#form-step-" + stepNumber);
                // stepDirection === 'forward' :- this condition allows to do the form validation 
                // only on forward navigation, that makes easy navigation on backwards still do the validation when going next
                if(stepDirection === 'forward' && elmForm){
                    elmForm.validator('validate'); 
                    var elmErr = elmForm.children('.has-error');
                    if(elmErr && elmErr.length > 0){
                        // Form validation failed
                        return false;    
                    }
                }
                return true;
            });
            
            $("#smartwizard").on("showStep", function(e, anchorObject, stepNumber, stepDirection) {
                // Enable finish button only on last step
                if(stepNumber == 3){ 
                    $('.btn-finish').removeClass('disabled');  
                }else{
                    $('.btn-finish').addClass('disabled');
                }
            });                               
            
        });   
    </script>  
    
    <script>
    

	function uploadPicture() {
		document.getElementById("uploadPicture").click();
	}
	
    function sub(obj) {
        var file = obj.value;
        var fileName = file.split("\\");
        if(file.length === 0){
            document.getElementById("profile_upload_button").innerHTML = "Upload a project display picture";
        } else {
        document.getElementById("profile_upload_button").innerHTML = fileName[fileName.length - 1];
        }
        event.preventDefault();
    }

    function uploadFile() {
		document.getElementById("uploadFile").click();
	}
	
	function docSub(obj) {
		var fileList = document.getElementById("uploadFile").files;
		var allFileNames;

		for (var i = 0; i < fileList.length; i++) {
			var fileName = fileList[i].name.split("\\");
			allFileNames += (fileName + "<br>");
		}

		document.getElementById("document_upload_button").innerHTML = allFileNames
				.substring(9);
		event.preventDefault();
	}
    
    </script>
    
    <script>
    $('#addResource')
	.on(
			'click',
			function() {
				var lastRow = $('#resourcesNeeded').closest(
						'#resourcesNeeded').find("div:last-child");
				var rowID = lastRow.attr('id').substring(11);
				
				var lastRowInputs = lastRow.find('input');
				var lastRowSelect = lastRow.find('select');
				var lastRowTextarea = lastRow.find('textarea');
				var lastRowButton = lastRow.find('button');

				var isClone = false;

				var checkInput = false;
				var checkSelect = false;
				var checkTextarea = false;

				lastRowInputs.each(function() {
					if ($(this).val().length) {
						checkInput = true;
					}
				});

				lastRowSelect.each(function() {
					if ($(this).val() !== null) {
						if ($(this).val().length) {
							checkSelect = true;
						}
					}
				});

				lastRowTextarea.each(function() {
					if ($(this).val().length) {
						checkTextarea = true;
					}
				});

				if (!checkInput || !checkSelect || !checkTextarea) {
					alert("Please fill in all the fields for the resources you need.");
					return false;
				}

				var cloned = lastRow.clone();
				cloned
						.find('input, select, textarea, button')
						.each(
								function() {
									var id = $(this).attr('id');
									var regIdMatch = /^(.+)(\d+)$/;
									var aIdParts = id
											.match(regIdMatch);
									var newId = aIdParts[1]
											+ (parseInt(
													aIdParts[2], 10) + 1);

									$(this).attr('id', newId);
									//$(this).attr('name', newId);
								});

				cloned.find("input[type='text']").val('');
				cloned.find("select").val('');
				cloned.find("textarea").val('');
				cloned.attr('id', "resourceRow" + (parseInt(rowID, 10) + 1));
				cloned.insertAfter(lastRow);

			});

function del(id){
var num = id.substring(4);

var resourceCat = document.getElementById("resourceCategory"
		+ num).value;
var resourceName = document.getElementById("resourceName"
		+ num).value;
var resourceDes = document.getElementById("resourceDescription"
		+ num).value;

if (resourceCat === "" || resourceName === "" || resourceDes === "") {
	alert("You cannot delete a resource with empty fields.");
	return false;
}

if (confirm("Are you sure you want to delete this resource?") == true) {
	$('#resourceRow' + num).remove();
	return true;
} else {
	return false;
}
}
    </script>
 
 <script>
 var userType = document.getElementById("userType").value;

	if (userType === "org") {
		document.getElementById("radio_org").checked = true;
		document.getElementById("radio_indi").disabled = true;
	}

	var indiOrg = document.getElementById("indiOrg").value;

	if (userType === "indi" && indiOrg === "") {
		document.getElementById("radio_indi").checked = true;
		document.getElementById("radio_org").disabled = true;
	}</script>   
	
	<script type="text/javascript">
		$(".js-example-basic-multiple-targetprojectareas").select2({
			maximumSelectionLength : 3,
			placeholder : "Where do you want to make a difference?"
		});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".js-example-basic-single-projectlocation").select2({
				placeholder : "Select a country:"
			});
		});
	</script>

	<script type="text/javascript">
		$(".js-example-basic-multiple-banlistusers").select2({
			placeholder : "Search for username : "
		});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".js-example-basic-single-organization").select2({
				placeholder : "Select an organization: "
			});
		});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".js-example-basic-single-resourcecategory").select2({
				placeholder : "Select an expertise/category: ",
				allowClear : true
			});
		});
	</script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("[rel=tooltip]").tooltip({
				placement : 'right'
			});
		});
	</script>
	
</body>



</html>