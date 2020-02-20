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
<link rel="stylesheet" type="text/css" href="resources/css/login&signup.css">
<link rel="stylesheet" href="/jobster/resources/css/notification.css">
<link href='https://fonts.googleapis.com/css?family=Titillium+Web:400,300,600' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript" src="resources/js/login&signup.js"></script>
<script type="text/javascript" src="resources/js/backReload.js"></script>
</head> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- <script type="text/javascript">
$(document).ready(function(){
	$('input[type=submit]').click(function(e) {
		   
	      //Prevent default submission of form
	      e.preventDefault();
	      
	      //Post data to corresponding controller
	      $.post({
	         url : 'login',
	         data : $('form[name=loginForm]').serialize(),
	         success : function(result) {
	         		document.write(result);
	         		document.close();
	         }
	      })
	});
});
</script> -->
<body onload='document.loginForm.username.focus();'>

	<h1>Spring Security Login Form (Database Authentication)</h1>

<%-- 	<div id="login-box">
		
		<h2>Login with Username and Password</h2>

		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>
		<c:if test="${not empty msg}">
			<div class="msg">${msg}</div>
		</c:if>	
	
		<form name='loginForm' action="<c:url value='/j_spring_security_check' />" method='POST'>

		<table>
			<tr>
				<td>User:</td>
				<td><input type='text' name='username'></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type='password' name='password' /></td>
			</tr>
			<tr>
				<td colspan='2'><input name="submit" type="submit"
				  value="submit" /></td>
			</tr>
		  </table>

		  <input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />

		</form>
	</div> --%>

	
	
	
	<div class="form">
      
      <ul class="tab-group">
      	<li class="tab active"><a href="/jobster/login">Log In</a></li>
        <li class="tab"><a href="/jobster/signup">Sign Up</a></li>
        
      </ul>
      
      <div class="tab-content">
      	
      	<div id="login">   
          <h1>Welcome Back!</h1>

				<c:if test="${not empty error}">
					<div class="error">${error}</div>
				</c:if>
				<c:if test="${not empty msg}">
					<div class="msg">${msg}</div>
				</c:if>

				
			<form name='loginForm' action="<c:url value='/j_spring_security_check' />" method='POST'>
          
            <div class="field-wrap">
            <input type="text" required autocomplete="off" name='username' placeholder="Enter username">
          	</div>
          
          <div class="field-wrap">
            <input type="password" required autocomplete="off" name='password' placeholder="Enter password">
          </div>
          
          <p class="forgot"><a href="/jobster" class="forgot">Back to Homepage ..</a></p>
          
          <button class="button button-block" name="submit" type="submit">Log In</button>
          
            <input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
          </form>

        </div>
      	
        <div id="signup">   
          <h1>Sign Up for Free</h1>
          
          <form action="/" method="post">
          
          <div class="top-row">
            <div class="field-wrap">
              <label>
                First Name<span class="req">*</span>
              </label>
              <input type="text" required autocomplete="off" />
            </div>
        
            <div class="field-wrap">
              <label>
                Last Name<span class="req">*</span>
              </label>
              <input type="text"required autocomplete="off"/>
            </div>
          </div>

          <div class="field-wrap">
            <label>
              Email Address<span class="req">*</span>
            </label>
            <input type="email"required autocomplete="off"/>
          </div>
          
          <div class="field-wrap">
            <label>
              Set A Password<span class="req">*</span>
            </label>
            <input type="password"required autocomplete="off"/>
          </div>
          
          <button type="submit" class="button button-block">Get Started</button>
          
          </form>

        </div>
        
        
        
      </div><!-- tab-content -->
      
</div> <!-- /form -->
<!-- partial -->
  <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
	

	
</body>
</html>