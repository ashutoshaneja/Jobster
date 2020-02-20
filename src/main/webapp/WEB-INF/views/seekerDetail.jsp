<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Additional Seeker Details</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta/css/bootstrap.min.css'>
<link rel="stylesheet" href="/jobster/resources/css/profileDetail.css">
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
  <form:form method="post" modelAttribute="seekerInfo" name="seekerInfoForm">
    <div class='row mt-5'>
      <div class='col-sm-12'>
        <div class='card'>
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
                  <select class='form-control' id='event_category' type='text' name="location">
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
                  <select class='form-control' id='event_category' name="skill">
                    <option value='Java'>Java</option>
                    <option value='Python'>Python</option>
                    <option value='Golang'>Golang</option>
                    <option value='Node.js'>Node.js</option>
                  </select>
                </div>
              </div>
             
            </div>
            <div class='form-row'>
			 <div class='col-sm-12'>
                <div class='form-group'>
                  <label for='event_tags'>Resume URL</label>
                  <input class='form-control' id='event_tags' type='text' name="resumeURL">
                  <small class='form-text text-muted' id='emailHelp'>
                    You may ignore https:// or http://
                  </small>
                </div>
              </div>
			</div>
			<div class='form-row'>
              <div class='col-sm-6'>
                <div class='form-group'>
                  <label for='event_startdate'>Years of Experience</label>
                  <input class='form-control' id='event_category' type="number" name="experience">
                </div>
              </div>
              <div class='col-sm-6'>
                <div class='form-group'>
                  <label for='event_enddate'>Portfolio/Other Profile Link</label>
                  <input class='form-control' id='event_tags' type='text'>
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
<!-- partial -->
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta/js/bootstrap.min.js'></script>


</body>
</html>