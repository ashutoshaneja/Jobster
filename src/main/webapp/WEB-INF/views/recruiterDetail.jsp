<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Additional Recruiter Details</title>
<link rel="icon" href="/jobster/resources/img/logo.png">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta/css/bootstrap.min.css'>
<link rel="stylesheet" href="/jobster/resources/css/profileDetail.css">

</head>
<body>

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
	

 <div class='container mt-5 mb-5'>
  <form:form method="post" modelAttribute="recruiterInfo" name="recruiterInfoForm">
    <div class='row mt-5'>
      <div class='col-sm-12'>
        <div class='card'>
            <i class='material-icons mr-2'>event</i>
            <c:if test="${pageContext.request.userPrincipal.name != null}">
								<h2>
									Hey, ${pageContext.request.userPrincipal.name}! Add Additional
									Profile Details to Complete your Profile | <a
										href="javascript:formSubmit()"> Not now? Logout</a>
								</h2>
			</c:if>
			
			<c:if test="${not empty error}">
					<div class="alert alert-danger alert-dismissible fade show">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<strong>${error}</strong>
					</div>
				</c:if>
				<c:if test="${not empty msg}">
					<div class="alert alert-info alert-dismissible fade show">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<strong>${msg}</strong>
					</div>
			</c:if>
          <div class='card-body'>
           
            <div class='form-row'>
			 <div class='col-sm-12'>
                <div class='form-group'>
                  <label for='event_tags'>Organisation Name</label>
                  <input class='form-control' id='event_tags' type='text' name="companyName" required="required">
                  <small class='form-text text-muted' id='emailHelp'>
                    Enter the Current Organisation's name
                  </small>
                </div>
              </div>
			</div>
			<div class='form-row'>
			 <div class='col-sm-12'>
                <div class='form-group'>
                  <label for='event_tags'>Designation</label>
                  <input class='form-control' id='event_tags' type='text' name="designation" required="required">
                  <small class='form-text text-muted' id='emailHelp'>
                    Your designation in concerned organisation
                  </small>
                </div>
              </div>
			</div>
            <div class='form-group'>
              <label for='event_description'>Profile Bio</label>
              <textarea class='form-control' id='event_description' placeholder='Write something about yourself . . .' rows='4'></textarea>
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
 		Complete My Profile
       </button>
    </div>
  </form:form>
</div>

<script src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta/js/bootstrap.min.js'></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="/jobster/resources/js/backReload.js"></script>

</body>
</html>