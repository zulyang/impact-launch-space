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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<!--custom css codes -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/app.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
	integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
	crossorigin="anonymous"></script>

<!--for multiple select (Select2)-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>

</head>
<body class="profile">
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12">
<%@include file="common/navigation.jspf" %>
					<div class="col-lg-12 form_container indi_profile_container">
					<form method="post" action="setup-individual"
						onsubmit="return checkFields();" enctype="multipart/form-data"
						class="form-horizontal indi_profile_form">
						<h3>Personal information</h3>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="text" name="username" value="${username}" readonly
									class="form-control profileField">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="text" name="email" value="${email}" readonly
									class="form-control profileField">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="text" name="firstName" placeholder="First name"
									required class="form-control profileField"> <input
									type="text" name="lastName" placeholder="Last name" required
									class="form-control profileField">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12 custom-file-upload"">
								<input type="file" placeholder="Choose your display picture" name="profilePicture" id="file" /> 
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="date" name="dateOfBirth" required
									placeholder="Date of Birth (dd/mm/yyyy) class="form-control profileField">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select class="js-example-basic-single-country" name="country"
									required>
									<option></option>
									<c:forEach items="${country_list}" var="item">
										<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<h3>Work</h3>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="jobTitle" type="text"
									class="form-control profileField"
									placeholder="Current job title">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select
									class="js-example-basic-single-organization profileField"
									name="organization">
									<option></option>
									<c:forEach items="${organization_list}" var="item">
										<option value="${item}">${item}</option>
									</c:forEach>
								</select>


							</div>
						</div>

						<div class="form-group">
							<div class="col-lg-12">
								<select
									class="js-example-basic-single-jobsector-required profileField"
									name="jobSector1" id="jsIndi1Value">
									<option></option>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select> <input name="js1Years" type="number" id="js1experience"
									class="form-control profileField"
									placeholder="Years of experience">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select
									class="js-example-basic-single-jobsector-optional profileField"
									name="jobSector2" id="jsIndi2Value">
									<option></option>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select> <input name="js2Years" type="number" id="js2experience"
									class="form-control profileField"
									placeholder="Years of experience">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select
									class="js-example-basic-single-jobsector-optional profileField"
									name="jobSector3" id="jsIndi3Value">
									<option></option>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select> <input name="js3Years" type="number" id="js3experience"
									class="form-control profileField"
									placeholder="Years of experience">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select class="js-example-basic-multiple-skills profileField"
									multiple="multiple" name="selected_skillsets" required>
									<c:forEach items="${skillset_list}" var="item">
										<option value="${item.getSkillset()}">${item.getSkillset()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select
									class="js-example-basic-multiple-preferredjobsector profileField"
									multiple="multiple" name="selected_preferredjobsectors"
									required>
									<c:forEach items="${job_sector_list}" var="item">
										<option value="${item.getJob_sector()}">${item.getJob_sector()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select
									class="js-example-basic-multiple-projectareas profileField"
									multiple="multiple" name="selected_projectareas" required>
									<c:forEach items="${project_area_list}" var="item">
										<option value="${item.getProject_area()}">${item.getProject_area()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="number" name="minimumHours" min="1" max="100"
									id="minHours" class="form-control profileField"
									placeholder="Minimum Hours" required> <input
									type="number" name="maximumHours" id="maxHours" min="1"
									max="100" class="form-control profileField"
									placeholder="Maximum Hours" required>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<select
									class="js-example-basic-multiple-preferredcountries profileField"
									multiple="multiple" name="selected_preferredcountries" required>
									<c:forEach items="${country_list}" var="item">
										<option value="${item.getCountry_name()}">${item.getCountry_name()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<textarea rows="4" name="personalBio"
									class="form-control personalBio"
									placeholder="A short personal bio"></textarea>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input name="contactDetails" type="text"
									class="form-control profileField" placeholder="Mobile Number">
							</div>
						</div>
						<br>
						<div class="form-radio center">
							<div class="radio_public">
								<input name="isPublicProfile" required="required" value="true"
									type="radio" value="Public Profile">Public Profile
							</div>
							<div class="radio_private">
								<input name="isPublicProfile" required="required" value="false"
									type="radio" value="Private Profile">Private Profile
							</div>
						</div>
						<br>
						<div class="form-group">
							<div
								class="col-lg-12 custom-file-upload">
								<input type="file" name="documents" multiple>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12">
								<input type="submit" class="btn btn-success profile_save"
									value="Set Account Details">
							</div>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>

	<script type="text/javascript">
		function checkFields() {
			var minHours = document.getElementById("minHours");
			console.log("minHours: " + minHours.value);

			var maxHours = document.getElementById("maxHours");
			console.log("maxHours: " + maxHours.value);

			if (minHours !== "" && maxHours !== "") {
				var min = parseInt(minHours.value);
				var max = parseInt(maxHours.value);

				if (min < 0 || max < 0) {
					alert('Please enter numbers greater than 0 for hours to volunteer.')
					return false;
				}

				if (min > max) {
					alert('Your minimum hours cannot be greater than maximum hours.')
					return false;
				}
			}
			
			var jsIndi1A = document.getElementById("jsIndi1Value");
			console.log("1a " + jsIndi1A);

			var jsIndiEx1B = document.getElementById("js1experience");

			if (jsIndi1A !== null) {
				console.log("1a: " + jsIndi1A.value);
				if (jsIndi1A.value !== "" && jsIndiEx1B.value === "") {
					console.log("js indi xperience value 2: "
							+ jsIndiEx1B.value);
					change('js1experience', 'required');
					alert('Please fill in the years of experience you have for the sector(s) chosen.')
					return false;
				}

				if (jsIndi1A.value === "" && jsIndiEx1B.value !== "") {
					console.log("js indi xperience value 1: "
							+ jsIndiEx1B.value);
					change('jsIndi1Value', 'required');
					alert('Please select a sector for the number of years of experience that you have for.')
					return false;
				}
			}

			var jsIndi2A = document.getElementById("jsIndi2Value");
			console.log("2A: " + jsIndi2A);

			var jsIndiEx2B = document.getElementById("js2experience");

			if (jsIndi2A !== null) {
				console.log("2b: " + jsIndi2A.value);
				if (jsIndi2A.value !== "" && jsIndiEx2B.value === "") {
					console.log("js indi xperience value 2: "
							+ jsIndiEx2B.value);
					change('js2experience', 'required');
					alert('Please fill in the years of experience you have for the sector(s) chosen.')
					return false;
				}

				if (jsIndi2A.value === "" && jsIndiEx2B.value !== "") {
					console.log("js indi xperience value 2B: "
							+ jsIndiEx2B.value);
					change('jsIndi2Value', 'required');
					alert('Please select a sector for the number of years of experience that you have for.')
					return false;
				}
			}

			console.log("BREAK -------------------");

			var jsIndi3A = document.getElementById("jsIndi3Value");
			console.log("3A: " + jsIndi3A);

			var jsIndiEx3B = document.getElementById("js3experience");

			if (jsIndi3A !== null) {
				console.log("3b: " + jsIndi3A.value);
				if (jsIndi3A.value !== "" && jsIndiEx3B.value === "") {
					console.log("js indi xperience value 3: "
							+ jsIndiEx3B.value);
					change('js3experience', 'required');
					alert('Please fill in the years of experience you have for the sector(s) chosen.')
					return false;
				}

				if (jsIndi3A.value === "" && jsIndiEx3B.value !== "") {
					console.log("js indi xperience value 3A: "
							+ jsIndiEx3B.value);
					change('jsIndi3Value', 'required');
					alert('Please select a sector for the number of years of experience that you have for.')
					return false;
				}
			}

			return true;
		}

		function change(id, newClass) {
			identity = document.getElementById(id);
			identity.required = true;
		}
	</script>
	
	<script>
	;(function($) {

			  // Browser supports HTML5 multiple file?
			  var multipleSupport = typeof $('<input/>')[0].multiple !== 'undefined',
			      isIE = /msie/i.test( navigator.userAgent );

			  $.fn.customFile = function() {

			    return this.each(function() {

			      var $file = $(this).addClass('custom-file-upload-hidden'), // the original file input
			          $wrap = $('<div class="file-upload-wrapper">'),
			          $input = $('<input type="text" class="file-upload-input" />'),
			          // Button that will be used in non-IE browsers
			          $button = $('<button type="button" class="file-upload-button">Select a File</button>'),
			          // Hack for IE
			          $label = $('<label class="file-upload-button" for="'+ $file[0].id +'">Select a File</label>');

			      // Hide by shifting to the left so we
			      // can still trigger events
			      $file.css({
			        position: 'absolute',
			        left: '-9999px'
			      });

			      $wrap.insertAfter( $file )
			        .append( $file, $input, ( isIE ? $label : $button ) );

			      // Prevent focus
			      $file.attr('tabIndex', -1);
			      $button.attr('tabIndex', -1);

			      $button.click(function () {
			        $file.focus().click(); // Open dialog
			      });

			      $file.change(function() {

			        var files = [], fileArr, filename;

			        // If multiple is supported then extract
			        // all filenames from the file array
			        if ( multipleSupport ) {
			          fileArr = $file[0].files;
			          for ( var i = 0, len = fileArr.length; i < len; i++ ) {
			            files.push( fileArr[i].name );
			          }
			          filename = files.join(', ');

			        // If not supported then just take the value
			        // and remove the path to just show the filename
			        } else {
			          filename = $file.val().split('\\').pop();
			        }

			        $input.val( filename ) // Set the value
			          .attr('title', filename) // Show filename in title tootlip
			          .focus(); // Regain focus

			      });

			      $input.on({
			        blur: function() { $file.trigger('blur'); },
			        keydown: function( e ) {
			          if ( e.which === 13 ) { // Enter
			            if ( !isIE ) { $file.trigger('click'); }
			          } else if ( e.which === 8 || e.which === 46 ) { // Backspace & Del
			            // On some browsers the value is read-only
			            // with this trick we remove the old input and add
			            // a clean clone with all the original events attached
			            $file.replaceWith( $file = $file.clone( true ) );
			            $file.trigger('change');
			            $input.val('');
			          } else if ( e.which === 9 ){ // TAB
			            return;
			          } else { // All other keys
			            return false;
			          }
			        }
			      });

			    });

			  };

			  // Old browser fallback
			  if ( !multipleSupport ) {
			    $( document ).on('change', 'input.customfile', function() {

			      var $this = $(this),
			          // Create a unique ID so we
			          // can attach the label to the input
			          uniqId = 'customfile_'+ (new Date()).getTime(),
			          $wrap = $this.parent(),

			          // Filter empty input
			          $inputs = $wrap.siblings().find('.file-upload-input')
			            .filter(function(){ return !this.value }),

			          $file = $('<input type="file" id="'+ uniqId +'" name="'+ $this.attr('name') +'"/>');

			      // 1ms timeout so it runs after all other events
			      // that modify the value have triggered
			      setTimeout(function() {
			        // Add a new input
			        if ( $this.val() ) {
			          // Check for empty fields to prevent
			          // creating new inputs when changing files
			          if ( !$inputs.length ) {
			            $wrap.after( $file );
			            $file.customFile();
			          }
			        // Remove and reorganize inputs
			        } else {
			          $inputs.parent().remove();
			          // Move the input so it's always last on the list
			          $wrap.appendTo( $wrap.parent() );
			          $wrap.find('input').focus();
			        }
			      }, 1);

			    });
			  }

	}(jQuery));

	$('input[type=file]').customFile();
	</script>
	<script type="text/javascript">
		$(".js-example-basic-multiple-preferredcountries").select2({
			placeholder : "Select countries where you wish to be involved in"
		});
	</script>
	<script type="text/javascript">
		$(".js-example-basic-multiple-preferredjobsector").select2({
			maximumSelectionLength : 3,
			placeholder : "Select Up to 3 Job Sectors that interest you"
		});
	</script>
	<script type="text/javascript">
		$(".js-example-basic-multiple-projectareas").select2({
			maximumSelectionLength : 5,
			placeholder : "Where do you want to make a difference?"
		});
	</script>
	<script type="text/javascript">
		$(".js-example-basic-multiple-skills").select2({
			placeholder : "Select Your Skills"
		});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".js-example-basic-single-jobsector-required").select2({
				placeholder : "Select Primary Job Sector (required):",
				allowClear : true
			});
		});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".js-example-basic-single-jobsector-optional").select2({
				placeholder : "Select Additional Job Sector (optional):",
				allowClear : true
			});
		});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".js-example-basic-single-country").select2({
				placeholder : "Country which you are based in: ",
				allowClear : true
			});
		});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".js-example-basic-single-organization").select2({
				placeholder : "Current Organization: "
			});
		});
	</script>
</body>
</html>
