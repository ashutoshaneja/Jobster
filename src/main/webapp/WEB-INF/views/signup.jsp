<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Signup</title>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('input[type=submit]').click(function(e) {
		   
	      //Prevent default submission of form
	      e.preventDefault();
	      
	      //Post data to corresponding controller
	      $.post({
	         url : 'signup',
	         data : $('form[name=signupForm]').serialize(),
	         success : function(result) {
	         		document.write(result);
	         		document.close();
	         }
	      })
	});
});
</script> -->
</head>
<body>
	<form:form method="post" modelAttribute="user" name="signupForm">
		<table>
			<tr>
				<td>Username</td>
				<td><form:input path="username" /></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><form:input path="password" /></td>
			</tr>
			<tr>
				<td>Role</td>
				<td><form:radiobutton path="role" value="ROLE_SEEKER"/>Seeker</td>
				<td><form:radiobutton path="role" value="ROLE_RECRUITER"/>Recruiter</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit"
					value="Add User to Jobster" /></td>
			</tr>
		</table>
	</form:form>
</body>
</html>