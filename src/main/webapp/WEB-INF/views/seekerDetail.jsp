<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Additional Seeker Details</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- <script type="text/javascript">
$(document).ready(function(){
	$('input[type=submit]').click(function(e) {
		   
	      //Prevent default submission of form
	      e.preventDefault();
	      
	      //Post data to corresponding controller
	      $.post({
	         url : 'seeker/{username}',
	         data : $('form[name=seekerInfoForm]').serialize(),
	         success : function(result) {
	         		document.write(result);
	         		document.close();
	         }
	      })
	});
});
</script> -->
<body>
	<h1>SIGNUP SUCCESSFULL!!</h1>
	<br />
	<h3>Kindly fill additional details, to complete your profile..</h3>
	<form:form method="post" modelAttribute="seekerInfo" name="seekerInfoForm">
		<table>
			<tr>
				<td>Username</td>
				<td><form:input path="username" value="${username}" disabled="true" /></td>
			</tr>
			<tr>
				<td>Location</td>
				<td><form:input path="location" /></td>
			</tr>
			<tr>
				<td>Skill</td>
				<td><form:select path="skill">
					<form:option value="Java"></form:option>
					<form:option value="Python"></form:option>
					<form:option value="Golang"></form:option>
					<form:option value="Node.js"></form:option>
					</form:select>
				</td>
			</tr>
			<tr>
				<td>Resume URL</td>
				<td><form:input path="resumeURL"/></td>
			</tr>
			<tr>
				<td>Experience</td>
				<td><form:input path="experience"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit"
					value="Complete my Profile" /></td>
			</tr>
		</table>
	</form:form>
</body>
</html>