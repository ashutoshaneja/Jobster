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
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Recruiter Feed</title>
<link rel="icon" href="/jobster/resources/img/logo.png">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="/jobster/resources/css/normalize.min.css">
<link rel='stylesheet' href="/jobster/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="/jobster/resources/css/profileDetail.css">
<link rel="stylesheet" href="/jobster/resources/css/notification.css">

<script type="text/javascript" src="/jobster/resources/js/popper.min.js"></script>
<script src="/jobster/resources/js/jquery.min.js"></script>

</head>
<body>

	<div class='container mt-5 mb-5'>
		<div>
			<h1>
				<a href="/jobster">#Jobster</a> Recruiter Feed . .
			</h1>

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
		
		<form:form method="post" modelAttribute="vacancy">
			<div class='row mt-5'>
				<div class='col-sm-12'>
					<div class='card'>
						<c:if test="${not empty error}">
							<div class="error">${error}</div>
						</c:if>
						<c:if test="${not empty output}">
							<div class="msg">${output}</div>
						</c:if>
						<div class='card-header d-flex align-items-center'>
							<i class='material-icons mr-2'>event</i> Hey, Recruiter. Add
							Vacancies for your organisation with #Jobster
						</div>
						<div class='card-body'>
							<div class='form-row'>
								<div class='col-sm-6'>
									<div class='form-group'>
										<label for='event_category'>Location</label> <select
											class='form-control' class='event_category' name="location"
											required="required">
											<option value='Mohali'>Mohali</option>
											<option value='Delhi'>Delhi</option>
											<option value='Pune'>Pune</option>
											<option value='Mumbai'>Mumbai</option>
											<option value='Noida'>Noida</option>
										</select>
									</div>
								</div>

								<div class='col-sm-6'>
									<div class='form-group'>
										<label for='event_category'>Skill</label> <select
											class='form-control' class='event_category' name="skill"
											required="required">
											<option value='Java'>Java</option>
											<option value='Python'>Python</option>
											<option value='Golang'>Golang</option>
											<option value='Node.js'>Node.js</option>
										</select>
									</div>
								</div>

							</div>
							<div class='form-row'>
								<div class='col-sm-6'>
									<div class='form-group'>
										<label for='event_startdate'>No. of Vacancies</label> <input
											class='form-control' class='event_category' type="number"
											name="vacancyCount" min="1" max="100" required="required">
									</div>
								</div>
								<div class='col-sm-6'>
									<div class='form-group'>
										<label for='event_startdate'>Years of Experience</label> <input
											class='form-control' class='event_category' type="number"
											name="experience" min="0" max="25">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


			<div class='form-group d-flex justify-content-end mt-3'>
				<button class='btn d-flex align-items-center mr-3' type="reset">
					<i class='material-icons mr-2'>close</i> Reset Form
				</button>
				<button
					class='btn btn-primary d-flex align-items-center float-right'
					type="submit">
					<i class='material-icons mr-2'>check</i> Add Vacancy
				</button>
			</div>
		</form:form>
	</div>

	<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta/js/bootstrap.min.js'></script>	
	<script type="text/javascript" src="/jobster/resources/js/backReload.js"></script>
	<script type="text/javascript" src="/jobster/resources/js/popper.min.js"></script>

</body>
</html>