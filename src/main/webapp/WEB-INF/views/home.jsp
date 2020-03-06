<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" %>
<html>
<meta charset="ISO-8859-1">
<head>
	<title>Home</title>
	<link rel="icon" href="resources/img/logo.png">
	<link rel='stylesheet' type="text/css" href='resources/css/bootstrap-3.3.7.min.css'>
	<link rel='stylesheet' type="text/css" href='resources/css/font-awesome.min.css'>
	<link rel="stylesheet" type="text/css" href="resources/css/home.css">
	<link rel="stylesheet" type="text/css" href="resources/css/notification.css">
	
</head>
<body onload="startTime()">

	<div class="site-wrapper">

		<div class="site-wrapper-inner clearfix">

			<div class="cover-container container">

				<div class="inner cover clearfix">
					<div class="col-xs-12 col-sm-6 intro-cont">
						<span id="typed"></span>
						<h1 class="page-intro">
							Welcome to <span style="color: #337ab7;">Jobster</span> <span
								id="emoji"></span>
						</h1>
						<p>Jobster is job search based application, built on top of
							Spring MVC and Spring Security frameworks.</p>
						<p>
							<strong>New Here?</strong>
						</p>
						<a href="/jobster/signup" class="btn signup">Sign Up</a>
						<p>
							Already on Jobster? <strong><a href="/jobster/login"><span
									style="text-decoration: underline;">Login to Jobster ..</span></a></strong>
						<p style="color: rgba(80, 144, 204, 0.9);">
							Current Time: <a id="dynamicTime"></a><br /> - <a
								target="_blank"
								href="/jobster/resources/Documentation/index.html">Read
								Project Documentation here</a>
						</p>

					</div>
					<div class="col-xs-12 col-sm-5 col-sm-offset-1 sign-in-outer">
						<div class="sign-in-wrap">
							<h2 class="form-heading">Sign In</h2>
							<form class="row" id="login-form" name='loginForm'
								action="<c:url value='/j_spring_security_check' />"
								method='POST' autocomplete="off">
								<div class="input-group">
									<i class="fa fa-envelope-o" aria-hidden="true"></i> <input
										tabindex="1" class="form-control input-lg" id="username-input"
										type="text" size="30" maxlength="45" name='username'
										title="username" placeholder="Enter Username"
										required="required">
								</div>
								<div class="input-group">
									<i class="fa fa-lock" aria-hidden="true"></i> <input
										tabindex="1" class="form-control input-lg" id="password-input"
										name="password" type="password" size="30" maxlength="45"
										name='password' title="password" placeholder="Enter password"
										required="required">
								</div>
								<div class="checkbox-group">
									<input id="toggle-checkbox" type="checkbox"
										class="form-control" onclick="togglePassword()"><span>Show
										Password</span>
								</div>
								<div id="capslockWarning">WARNING! Caps lock is ON.</div>
								<div id="warning">WARNING! Username can only have a-z,
									A-Z, 0-9, _</div>


								<input class="btn" type="submit" value="Sign In" title="Sign In"
									tabindex="3"> <a class="reset" href="#">Don't
									worry! Your data is safe with us.</a>

								<div>
									<c:if test="${not empty error}">
										<div class="error">${error}</div>
									</c:if>
									<c:if test="${not empty msg}">
										<div class="msg">${msg}</div>
									</c:if>

									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" />
								</div>

							</form>
						</div>
					</div>

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

					<c:if test="${pageContext.request.userPrincipal.name != null}">
						<h2>
							LoggedIn User : ${pageContext.request.userPrincipal.name} | <a
								href="javascript:formSubmit()"> Logout</a>
						</h2>
					</c:if>

				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="resources/js/checkInternetConnectivity.js"></script>
	<script type="text/javascript" src="resources/js/home.js"></script>
	<script type="text/javascript" src="resources/js/capslockWarning.js"></script>
	<script type="text/javascript" src="resources/js/backReload.js"></script>

</body>
</html>
