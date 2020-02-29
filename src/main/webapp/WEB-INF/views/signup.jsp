<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Signup</title>
<link rel="icon" href="/jobster/resources/img/logo.png">
<link href='https://fonts.googleapis.com/css?family=Titillium+Web:400,300,600' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	
<link rel="stylesheet" type="text/css" href="resources/css/login&signup.css">
<link rel="stylesheet" href="/jobster/resources/css/notification.css">

</head>
<body>


	<h1>New to #Jobster? Signup here</h1>
	<div class="container">
		<div class="alert alert-dark alert-dismissible fade show">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			<strong>You'll be redirected to login after sign-up, to process your
				application further . .</strong>
		</div>
		
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
	</div>

				

	<div class="form">

		<ul class="tab-group">
			<li class="tab"><a href="/jobster/login">Log In</a></li>
			<li class="tab active"><a href="/jobster/signup">Sign Up</a></li>

		</ul>

		<div id="signup">

			<form:form method="post" modelAttribute="user" name="signupForm">

				<div class="top-row">
					<div class="field-wrap" id="capslockWarning"> 
					WARNING! Caps lock is ON.
					</div>
					<div class="field-wrap">

						<input type="text" id="username-input" required autocomplete="off"
							name="username" placeholder="Enter username" />
					</div>

					<div class="field-wrap">

						<input type="password" id="password-input" required autocomplete="off" 
						name="password" placeholder="Enter password" />
					</div>					
				</div>
				<div class="field-wrap" id="warning">
                      	WARNING! Username can only have a-z, A-Z, 0-9, _
                </div>
				<div class="field-wrap">
					<label class="role-heading"> Select your Profile Type<span
						class="req">..</span>
					</label>
				</div>
				<div class="field-wrap" class="form-check-inline" class="role">

					<label class="form-check-label" for="radio1" class="role">
						<input type="radio" class="form-check-input" id="radio1"
						name="role" value="ROLE_SEEKER" checked> <span
						class="role"> Seeker </span>
					</label>

				</div>
				<div class="field-wrap" class="form-check-inline" class="role">
					<label class="form-check-label" for="radio2" class="role">
						<input type="radio" class="form-check-input" id="radio2"
						name="role" value="ROLE_RECRUITER"> <span class="role">
							Recruiter </span>
					</label>
				</div>

				<button type="submit" class="button button-block">Get
					Started</button>

			</form:form>
		</div>
	</div>
	<!-- /form -->
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	
	<script type="text/javascript" src="resources/js/capslockWarning.js"></script>
	<script type="text/javascript" src="resources/js/usernameValidation.js"></script>
	<script type="text/javascript" src="resources/js/backReload.js"></script>
	
	
	<!-- <script type="text/javascript" src="resources/js/login&signup.js"></script> -->
	


</body>
</html>