<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="false" %>
<html>
<meta charset="ISO-8859-1">
<head>
	<title>Home</title>
	<script type="text/javascript" src="resources/js/homeClock.js"></script>
	<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css'>
	<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css'>
	<link rel="stylesheet" type="text/css" href="resources/css/home.css">
	<link rel="stylesheet" href="resources/css/notification.css">
	<script type="text/javascript" src="resources/js/backReload.js"></script>
</head>
<body onload="startTime()">

<div class="site-wrapper">

    <!-- start site-wrapper-inner -->
    <div class="site-wrapper-inner clearfix">

        <!-- start cover-container -->
        <div class="cover-container container">

            <!-- start inner cover -->
            <div class="inner cover clearfix">
                <div class="col-xs-12 col-sm-6 intro-cont">
                    <h1 class="page-intro">Welcome to Jobster &#x2714;&#xFE0F;</h1>
                    <p>Jobster is job search based application, built on top of Spring MVC and Spring Security frameworks.</p>
                    <p><strong>New Here?</strong></p>
                    <a href="/jobster/signup" class="btn signup">Sign Up</a>
                  <p>Already on Jobster? <strong><a href="/jobster/login"><span style="text-decoration: underline;">Login to Jobster ..</span></a></strong>
                  <p style="color: rgba(80, 144, 204, 0.9);"> Current Time: <a id="dynamicTime"></a></p>
                  
                </div>
                <div class="col-xs-12 col-sm-5 col-sm-offset-1 sign-in-outer">
                  <div class="sign-in-wrap">
                  <h2 class="form-heading">Sign In</h2>
                    <form class="row" id="login-form" name='loginForm' action="<c:url value='/j_spring_security_check' />" method='POST'>
                                <div class="input-group">
                        <i class="fa fa-envelope-o" aria-hidden="true"></i>
                                <input tabindex="1" class="form-control input-lg" type="text" size="30" maxlength="100" name='username' title="username" placeholder="Enter Username" required="required">
                      </div>
                                <div class="input-group">
                                  <i class="fa fa-lock" aria-hidden="true"></i>
                      <input tabindex="1" class="form-control input-lg" name="password" type="password" size="30" maxlength="100" name='password' title="password" placeholder="Enter password" required="required">
                      </div>


                            <input class="btn" type="submit" value="Sign In" title="Sign In" tabindex="3">

                        <a class="reset" href="#">Don't worry! Your data is safe with us.</a>
                        
                        <div>
                        <c:if test="${not empty error}">
							<div class="error">${error}</div>
						</c:if>
						<c:if test="${not empty msg}">
							<div class="msg">${msg}</div>
						</c:if>
                        	
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
                        </div>
                      
                    </form>
                      
                  </div>

						<!--    <div class="social-login clearfix">
                    <p>- or sign in with -</p>
                    <ul class="social-buttons">
                      <li><a href="" class="facebook"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                      <li><a href="" class="twitter"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                      <li><a href="" class="google-plus"><i class="fa fa-google-plus" aria-hidden="true"></i></a></li>
                      <li><a href="" class="linkedin"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                      <li><a href="" class="windows"><i class="fa fa-windows" aria-hidden="true"></i></a></li>
                    </ul>
                  </div> -->
				</div>

				<%-- 	<sec:authorize access="hasRole('ROLE_SEEKER')"> --%>
						<!-- For login user -->
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
				<%-- 	</sec:authorize> --%>

				</div>
            <!-- end inner cover -->

        </div>
        <!-- end cover-container -->

    </div>
    <!-- end site-wrapper-inner -->

</div>
<!-- end site-wrapper -->
<!-- partial -->
  








<!-- <h1>
 <span style='font-size:50px;'>Jobster &#9757;&#127995;</span>
</h1> -->


<!-- <div>
<a href="/jobster/login">Already on Jobster? Login</a>	&emsp;&emsp;&emsp;	<a href="/jobster/signup">New to Jobster? Signup here</a>
</div> -->




</body>
</html>
