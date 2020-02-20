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
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta/css/bootstrap.min.css'>
<link rel="stylesheet" href="/jobster/resources/css/profileDetail.css">
<link rel="stylesheet" href="/jobster/resources/css/notification.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="/jobster/resources/js/backReload.js"></script>
<script type="text/javascript">
	if(!!window.performance && window.performance.navigation.type === 2)
	{
	    console.log('Reloading');
	    window.location.reload();
	}
</script>
</head>
<body>


	<div class='container mt-5 mb-5'>
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
            <i class='material-icons mr-2'>event</i>
            Hey, Job Seeker! Add Additional Profile Details to Complete your Profile
          </div>
          <div class='card-body'>
            <div class='form-group'>
              <label for='event_name'>Username</label>
              <form:input path="username" value="${username}" disabled="true" cssClass="form-control" id="event_name" />
             <!--  <input class='form-control' id='event_name' type='text' disabled> -->
              <small class='form-text text-muted' id='emailHelp'>
                Disabled
              </small>
            </div>
            <div class='form-row'>
              <div class='col-sm-6'>
                <div class='form-group'>
                  <label for='event_category'>Location</label>
                  <select class='form-control' id='event_category' name="location" required="required">
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
                  <label for='event_category'>Skill</label>
                  <select class='form-control' id='event_category' name="skill" required="required">
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
                  <label for='event_startdate'>No. of Vacancies</label>
                  <input class='form-control' id='event_category' type="number" name="vacancyCount" required="required">
                </div>
              </div>
              <div class='col-sm-6'>
                <div class='form-group'>
                  <label for='event_enddate'>Organisation's Info. Link</label>
                  <input class='form-control' id='event_tags' type='text'>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    
     
    <div class='form-group d-flex justify-content-end mt-3'>
      <button class='btn d-flex align-items-center mr-3' type="reset">
        <i class='material-icons mr-2'>close</i>
        Reset Form
      </button>
      <button class='btn btn-primary d-flex align-items-center float-right' type="submit">
        <i class='material-icons mr-2'>check</i>
 		Add Vacancy
       </button>
    </div>
  </form:form>
</div>
<!-- partial -->
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta/js/bootstrap.min.js'></script>

	



<%-- 
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
	</form:form> --%>


</body>
</html>