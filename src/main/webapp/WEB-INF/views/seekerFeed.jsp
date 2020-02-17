<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Seeker's Feed</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('input[type=submit]').click(function(e) {
		   
	      //Prevent default submission of form
	      e.preventDefault();
	      
	      //Post form data to corresponding controller
	      $.post({
	         url : 'seeker/feed/{username}',
	         data : $('form[name=searchForm]').serialize(),
	         success : function(result) {
	         		document.write(result);
	         		document.close();
	         }
	      })
	});
});
</script> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('input[type=submit]').click(function(e) {
		   
	      //Prevent default submission of form
	      e.preventDefault();
	      
	      //Post form data to corresponding controller
	      $.post({
	         url : '{username}',
	         data : $('form[name=searchForm]').serialize(),
	         success : function(result) {
	         		document.write(result);
	         		document.close();
	         }
	      })
	});
});
</script> 
</head>
<body>
	<div>
	<h1>WELCOME to Seeker's Feed..</h1>
	
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
			Welcome : ${pageContext.request.userPrincipal.name} | <a
				href="javascript:formSubmit()"> Logout</a>
		</h2>
	</c:if>
	
	</div>

	<hr>

	<form:form modelAttribute="searchVacancy" method="post" name="searchForm">
	<form:input path="username"  value="${username}" disabled="true"/>
		<form:select path="location">
			<form:option value="">Any</form:option>
			<form:option value="Mohali"></form:option>
			<form:option value="Pune"></form:option>
			<form:option value="Mumbai"></form:option>
			<form:option value="Delhi"></form:option>
		</form:select>

		<form:select path="skill">
			<form:option value="">Any</form:option>
			<form:option value="Java"></form:option>
			<form:option value="Python"></form:option>
			<form:option value="Golang"></form:option>
			<form:option value="Node.js"></form:option>
		</form:select>

		<input type="submit" value="Search..">

	</form:form> 
	<br/><br/>
	<table border="1" cellspacing="4" cellpadding="4">
		<tr>
			<th>Company Name</th>
			<th>Vacancy Count</th>
			<th>Location</th>
			<th>Skill</th>
			<th>Experience</th>
		</tr>
		<c:forEach items="${vacancies}" var="Vacancy">
			<tr>
				<td>${Vacancy.companyName}</td>
				<td>${Vacancy.vacancyCount}</td>
				<td>${Vacancy.location}</td>
				<td>${Vacancy.skill}</td>
				<td>${Vacancy.experience}</td>
				<td><input type="button" value=" Apply "></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>