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
<link rel="icon" href="resources/img/logo.png">
<link href='https://fonts.googleapis.com/css?family=Titillium+Web:400,300,600' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="resources/css/normalize.min.css">
<link rel="stylesheet" type="text/css" href="resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="resources/css/login&signup.css">
<link rel="stylesheet" type="text/css" href="resources/css/notification.css">

</head>
<body onload="showSnackbar();">

	<h1>New to #Jobster? Signup here</h1>
	<div class="container">
		<div class="alert alert-dark alert-dismissible fade show">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			<strong>You'll be redirected to login after sign-up, to
				process your application further . .</strong>
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
					<div class="field-wrap" id="capslockWarning">WARNING! Caps
						lock is ON.</div>
					<div class="field-wrap">

						<input type="text" id="username-input" autocomplete="off"
							name="username" placeholder="Enter username" />
						<form:errors path="username" cssClass="errormsg" />
					</div>

					<div class="field-wrap">

						<input type="password" id="password-input" autocomplete="off"
							name="password" placeholder="Enter password" />
						<form:errors path="password" cssClass="errormsg" />
					</div>
				</div>
				<div class="field-wrap" id="warning">WARNING! Username can
					only have a-z, A-Z, 0-9, _</div>
				<div class="field-wrap">
					<label class="role-heading"> Select your Profile Type<span
						class="req">..</span>
					</label> <br />
					<form:errors path="role" cssClass="errormsg" />
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

			<div id="snackbar">Kindly login after sign up to initiate your
				account activation.</div>
		</div>
	</div>
	<!-- /form -->

	<script type="text/javascript" src="resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="resources/js/popper.min.js"></script>
	<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="resources/js/login&signup.js"></script>
	<script type="text/javascript" src="resources/js/capslockWarning.js"></script>
	<script type="text/javascript" src="resources/js/usernameValidation.js"></script>
	<script type="text/javascript" src="resources/js/backReload.js"></script>

</body>
</html>
