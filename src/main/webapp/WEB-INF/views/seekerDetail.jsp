<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Additional Seeker Details</title>
<link rel="icon" href="/jobster/resources/img/logo.png">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="/jobster/resources/css/normalize.min.css">
<link rel='stylesheet' href='/jobster/resources/css/bootstrap.min.css'>
<link rel="stylesheet" href="/jobster/resources/css/profileDetail.css">
<link rel="stylesheet" href="/jobster/resources/css/bootstrap-select.css" />

</head>
<body>

	<c:url value="/j_spring_security_logout" var="logoutUrl" />
	<form action="${logoutUrl}" method="post" id="logoutForm">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
	</form>
	<script>
		function formSubmit() {
			document.getElementById("logoutForm").submit();
		}
	</script>
	
	<c:if test="${not empty error}">
					<div class="alert alert-danger alert-dismissible fade show">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<strong>${error}</strong>
					</div>
	</c:if>
	<c:if test="${not empty msg}">
					<div class="alert alert-info alert-dismissible fade show">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<strong>${msg}</strong>
					</div>
	</c:if>


	<div class='container mt-5 mb-5'>
		<form:form method="post" modelAttribute="seekerInfo"
			name="seekerInfoForm" autocomplete="off">
			<div class='row mt-5'>
				<div class='col-sm-12'>
					<div class='card'>
						<div class='card-header d-flex align-items-center'>
							<i class='material-icons mr-2'>event</i>
							<c:if test="${pageContext.request.userPrincipal.name != null}">
								<h4>
									Hey, ${pageContext.request.userPrincipal.name}! Add Additional
									Profile Details to Complete your Profile | <a
										href="javascript:formSubmit()"> Not now? Logout</a>
								</h4>
							</c:if>
						</div>
						<div class='card-body'>
							<div class='form-row'>
								<div class='col-sm-6'>
									<div class='form-group'>
										<label for='event_category'>Location: </label> 
										<select class="selectpicker" data-live-search="true"
										class='form-control' class='event_category' 
										name="location" required="required">
											<option disabled="disabled"></option>
											<option value='Mohali'>Mohali</option>
											<option value='Delhi'>Delhi</option>
											<option value='Pune'>Pune</option>
											<option value='Mumbai'>Mumbai</option>
											<option value='Noida'>Noida</option>
										</select>
									</div>
								</div>

								<div class='col-sm-6'>
									<div class='form-group'>
										<label for='event_category'>Skill: </label> 
										<select class="selectpicker" multiple data-live-search="true"
											class='form-control' class='event_category' 
											name="skill" required="required">
											<option disabled="disabled"></option>
											<option value='Java'>Java</option>
											<option value='Python'>Python</option>
											<option value='Golang'>Golang</option>
											<option value='Node.js'>Node.js</option>
											<option value='C#'>C#</option>
										</select>
									</div>
								</div>

							</div>
							<div class='form-row'>
								<div class='col-sm-12'>
									<div class='form-group'>
										<label for='event_tags'>Resume URL</label> 
										<input class='form-control' class="resumeURL" type='text' name="resumeURL" 
										maxlength="125" required="required" onblur="validateURL(event)"> 
											<small class='form-text text-muted' id='emailHelp'>
											 You may ignore https:// or http:// 
											 </small>
									</div>
								</div>
							</div>
							<div class='form-row'>
								<div class='col-sm-6'>
									<div class='form-group'>
										<label for='event_startdate'>Years of Experience</label> <input
											class='form-control' class='event_category' type="number"
											name="experience" min="0" max="25" required="required">
									</div>
								</div>
								<div class='col-sm-6'>
									<div class='form-group'>
										<label for='event_enddate'>Portfolio/Other Profile
											Link</label> <input class='form-control' type='text'>
									</div>
								</div>
							</div>
							<div class='form-group'>
								<label for='event_description'>Profile Bio</label>
								<textarea class='form-control' id='event_description'
									placeholder='Write something about yourself . . .' rows='4'></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>


			<div class='form-group d-flex justify-content-end mt-3'>
				<button class='btn d-flex align-items-center mr-3' type="reset">
					<i class='material-icons mr-2'>close</i> Reset Form
				</button>
				<button
					class='btn btn-primary d-flex align-items-center float-right'
					type="submit">
					<i class='material-icons mr-2'>check</i> Complete My Profile
				</button>
			</div>
		</form:form>
	</div>
	<script> 
        function validateURL(e) { 
        	var expression =  /[-a-zA-Z0-9@:%_\+.~#?&//=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?/gi; 
          	var regex = new RegExp(expression); 
          	//var url = document.getElementsByClassName("resumeURL")[0].value;
          	//var url = document.querySelector('.resumeURL').value;
          	var url = e.target.value;
          	alert(url); 
            if (url.match(regex)) { 
                alert("Valid URL " + url); 
            } else { 
                alert("Invalid URL " + url); 
            } 
        } 
    </script> 
    <!-- <script type="text/javascript" src="/jobster/resources/js/popper.min.js"></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta/js/bootstrap.min.js'></script>
	<script type="text/javascript" src="/jobster/resources/js/backReload.js"></script>
	 -->
	<script type="text/javascript" src="/jobster/resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="/jobster/resources/js/popper.min.js"></script>
	<script type="text/javascript" src="/jobster/resources/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript" src="/jobster/resources/js/bootstrap-select.min.js"></script>
	
</body>
</html>