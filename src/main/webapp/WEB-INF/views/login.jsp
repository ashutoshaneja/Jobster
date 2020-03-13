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
<title>Login to Jobster</title>
<!-- <link rel="icon" href="/jobster/resources/img/logo.png"> -->
<link rel="stylesheet" type="text/css" href="resources/css/login&signup.css">
<link rel="stylesheet" type="text/css" href="/jobster/resources/css/notification.css">
<link href='https://fonts.googleapis.com/css?family=Titillium+Web:400,300,600' rel='stylesheet' type='text/css'>
</head>
<body onload='document.loginForm.username.focus();'>

	<h1 class="form-heading">Login to stay updated with <span class = "jobster">#</span><span class = "jobster">Jobster</span></h1>

	<div class="form">
		<ul class="tab-group">
			<li class="tab active"><a href="/jobster/login">Log In</a></li>
			<li class="tab"><a href="/jobster/signup">Sign Up</a></li>
		</ul>

		<div class="tab-content">
			<div id="login">
				<h2>
					Share your credentials, and access your feed.
				</h2>

				<c:if test="${not empty error}">
					<div class="error">${error}</div>
				</c:if>
				<c:if test="${not empty msg}">
					<div class="msg">${msg}</div>
				</c:if>
				<div id="capslockWarning">WARNING! Caps lock is ON.</div>

				<form name='loginForm'
					action="<c:url value='/j_spring_security_check' />" method='POST'>

					<div id="warning">WARNING! Username can only have a-z, A-Z,
						0-9, _</div>

					<div class="field-wrap">
						<input type="text" id="username-input" required autocomplete="off"
							name='username' placeholder="Enter username">
					</div>

					<div class="field-wrap">
						<input type="password" id="password-input" required
							autocomplete="off" name='password' placeholder="Enter password">
					</div>

					<p class="forgot">
						<a href="/jobster" class="forgot">Back to Homepage ..</a>
					</p>

					<button class="button button-block" name="submit" type="submit">LogIn</button>

					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</form>

			</div>

			<div id="snackbar">Kindly login to initiate login for your
				account.</div>
		</div>
	</div>

	<script type="text/javascript" src="/jobster/resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="resources/js/login&signup.js"></script>
	<script type="text/javascript" src="resources/js/capslockWarning.js"></script>
	<script type="text/javascript" src="resources/js/usernameValidation.js"></script>
	<script type="text/javascript" src="resources/js/backReload.js"></script>
	
</body>
</html>