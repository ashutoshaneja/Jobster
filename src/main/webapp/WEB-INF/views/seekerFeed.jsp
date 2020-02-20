<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Seeker Feed</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta/css/bootstrap.min.css'>
<link rel="stylesheet" href="/jobster/resources/css/profileDetail.css">
<link rel="stylesheet" href="/jobster/resources/css/showVacancyData.css">
<link rel="stylesheet" href="/jobster/resources/css/notification.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$('button[type=submit]').click(function(e) {
			   
		      //Prevent default submission of form
		      e.preventDefault();
			//Post form data to corresponding controller
			$.post({
				url : '${pageContext.request.userPrincipal.name}',
				data : $('form[name=searchForm]').serialize(),
				success : function(result) {
					
					$("#vacancyList > tbody").html("");
					 console.log(result);
					 
					for(var i=0;i<(result.length);i++){ 
						var table = document.getElementById("vacancyList").getElementsByTagName('tbody')[0];
					    var newRow = table.insertRow(table.length);
					    cell1 = newRow.insertCell(0);
					    cell1.innerHTML = result[i].companyName;
					    cell2 = newRow.insertCell(1);
					    cell2.innerHTML = result[i].vacancyCount;
					    cell3 = newRow.insertCell(2);
					    cell3.innerHTML = result[i].location;
					    cell4 = newRow.insertCell(3);
					    cell4.innerHTML = result[i].skill;
					    cell5 = newRow.insertCell(4);
					    cell5.innerHTML = result[i].experience;
					    /* cell6 = newRow.insertCell(5);
					    cell6.innerHTML = '<a onClick="applyVacancy(this)">Apply</a>'; */
					}
				}
			})	
		});
	});		 
</script>
<script type="text/javascript">
	$(document).ready(function() {

			//Post form data to corresponding controller
			$.post({
				url : '${pageContext.request.userPrincipal.name}/showVacancyData',
				data : $('form[name=searchForm]').serialize(),
				success : function(result) {
					 console.log(result);
					 
				 	for(var i=0;i<(result.length);i++){ 
					var table = document.getElementById("vacancyList").getElementsByTagName('tbody')[0];
				    var newRow = table.insertRow(table.length);
				    cell1 = newRow.insertCell(0);
				    cell1.innerHTML = result[i].companyName;
				    cell2 = newRow.insertCell(1);
				    cell2.innerHTML = result[i].vacancyCount;
				    cell3 = newRow.insertCell(2);
				    cell3.innerHTML = result[i].location;
				    cell4 = newRow.insertCell(3);
				    cell4.innerHTML = result[i].skill;
				    cell5 = newRow.insertCell(4);
				    cell5.innerHTML = result[i].experience;
				   /*  cell6 = newRow.insertCell(5);
				    cell6.innerHTML = '<a onClick="applyVacancy(this)">Apply</a>'; */
					
				   
				}
			}
		});
	});
</script>
</head>
<body>


	
	<div class='container mt-5 mb-5'>
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
  <form:form modelAttribute="searchVacancy" method="post" name="searchForm">
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
            Hey, Job Seeker! Search for your dream job . . .
          </div>
          <div class='card-body'>
           <%--  <div class='form-group'>
              <label for='event_name'>Username</label>
              <form:input path="username" value="${pageContext.request.userPrincipal.name}" disabled="true" cssClass="form-control" id="event_name" />
             <!--  <input class='form-control' id='event_name' type='text' disabled> -->
              <small class='form-text text-muted' id='emailHelp'>
                Disabled
              </small>
            </div> --%>
            <div class='form-row'>
            	<div class='col-sm-3'>
                <div class='form-group'>
                 <label for='event_name'>Username</label>
              <form:input path="username" value="${pageContext.request.userPrincipal.name}" disabled="true" cssClass="form-control" id="event_name" />
             <small class='form-text text-muted' id='emailHelp'>
                Disabled
              </small>
                </div>
              </div>
            	
              <div class='col-sm-3'>
                <div class='form-group'>
                  <label for='event_category'>Location</label>
                  <select class='form-control' id='event_category' name="location">
                  	<option value='Any'>Any</option>
                    <option value='Mohali'>Mohali</option>
                    <option value='Delhi'>Delhi</option>
                    <option value='Pune'>Pune</option>
                    <option value='Mumbai'>Mumbai</option>
                    <option value='Noida'>Noida</option>
                  </select>
                </div>
              </div>
			  
			  <div class='col-sm-3'>
                <div class='form-group'>
                  <label for='event_category'>Skill</label>
                  <select class='form-control' id='event_category' name="skill">
                  	<option value='Any'>Any</option>
                    <option value='Java'>Java</option>
                    <option value='Python'>Python</option>
                    <option value='Golang'>Golang</option>
                    <option value='Node.js'>Node.js</option>
                  </select>
                </div>
              </div>
              
              <div class='form-group d-flex justify-content-end mt-3'>
      
     		 <button class='btn btn-outline-primary btn-sm  d-flex align-items-center float-right' type="submit" style="height: 55px;">
        		<i class='material-icons mr-2'>check</i>
 					Search for Vacancy
       			</button>
    		</div>
          </div>
        </div>
      </div>
    </div>
    </div>
   </form:form> 
  </div> 
   
   
   <div class='container mt-5 mb-5'>
   <form:form modelAttribute="applyVacancy" method="post" name="vacancyTable">
   <div class='row mt-5'>
      <div class='col-sm-12'>
        <div class='card'>
          <div class='card-header d-flex align-items-center'>
            <i class='material-icons mr-2'>event</i>
            Available Vacancies . . .
          </div>
          <div class='card-body'>
            <div class='form-group'>
             <table id="vacancyList"  class="table table-light table-hover table-striped">
			<thead>
				<tr id="tableTitle">
					<th>Company Name</th>
					<th>No. of Vacancies</th>
					<th>Location</th>
					<th>Skill</th>
					<th>Experience (in Years)</th>
				</tr>
			</thead>
			<tbody id="vacancyListBody">
				<%-- 	<c:forEach items="${vacancies}" var="Vacancy">
				<tr>
					<td>${Vacancy.companyName}</td>
					<td>${Vacancy.vacancyCount}</td>
					<td>${Vacancy.location}</td>
					<td>${Vacancy.skill}</td>
					<td>${Vacancy.experience}</td>
					<td><input type="button" value=" Apply "></td>
				</tr>
			</c:forEach> --%>
			</tbody>
		</table>
            </div>
           
        </div>
      </div>
    </div>
    </div>  
</form:form>
</div>







	<%-- <div>
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
		<form:input path="username" value="${pageContext.request.userPrincipal.name}" disabled="true" />
		<form:select path="location">
			<form:option value="Any">Any</form:option>
			<form:option value="Mohali"></form:option>
			<form:option value="Pune"></form:option>
			<form:option value="Mumbai"></form:option>
			<form:option value="Delhi"></form:option>
			<form:option value="Noida"></form:option>
		</form:select>

		<form:select path="skill">
			<form:option value="Any">Any</form:option>
			<form:option value="Java"></form:option>
			<form:option value="Python"></form:option>
			<form:option value="Golang"></form:option>
			<form:option value="Node.js"></form:option>
		</form:select>

		<input type="submit" value="Search..">

	</form:form>
	<br />
	<br />




	<form:form modelAttribute="applyVacancy" method="post"
		name="vacancyTable">
		<table border="1" cellspacing="4" cellpadding="4" id="vacancyList">
			<thead>
				<tr>
					<th>Company Name</th>
					<th>Vacancy Count</th>
					<th>Location</th>
					<th>Skill</th>
					<th>Experience</th>
				</tr>
			</thead>
			<tbody id="vacancyListBody">
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
			</tbody>
		</table>
	</form:form> --%>
</body>
</html>