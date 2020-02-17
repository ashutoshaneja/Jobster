<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Recruiter's Feed</title>
</head>
<body>

	<br>
	<div>
	<h1>WELCOME to Recruiter's Feed..</h1>
	
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
	<hr/>

	<h3>Add Vacancies Form:</h3>
	<form:form method="post" modelAttribute="vacancy">
		<table>
			<form:input path="username"  value="${username}" disabled="true"/>
			<tr>
				<td>No. of Vacancies</td>
				<td><form:input path="vacancyCount" /></td>
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
				<td>Experience</td>
				<td><form:input path="experience" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit"
					value="Add Vacancy" /></td>
			</tr>
			<tr>
				<td colspan="2">${output}</td>
			</tr>
		</table>
	</form:form>


</body>
</html>