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
<meta http-equiv="pragma" content="nocache">
<title>Seeker Feed</title>
<link rel="icon" href="/jobster/resources/img/logo.png">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="/jobster/resources/css/normalize.min.css">
<link rel='stylesheet' href='/jobster/resources/css/bootstrap.min.css'>
<link rel="stylesheet" href="/jobster/resources/css/profileDetail.css">
<link rel="stylesheet" href="/jobster/resources/css/showVacancyData.css">
<link rel="stylesheet" href="/jobster/resources/css/notification.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.css" />

<!-- <script type="text/javascript">
	$(document).ready(function() {
		$('button[type=submit]#searchButton').click(function(e) {
			   
		     //Prevent default submission of form
		     e.preventDefault();
			
		     //Post form data to corresponding controller
			 $.post({
				url : '${pageContext.request.userPrincipal.name}',
				data : $('form[name=searchForm]').serialize(),
				success : function(result) {
					
					$("#vacancyList > tbody").html("");
					 console.log(result);
					 if(!$.trim(result)){
						 alert("No Vacancy Found");
					 }
					 
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
					    hiddenCell1 = newRow.insertCell(5);
					    hiddenCell1.innerHTML = result[i].vacancyID;
					    hiddenCell1.style.visibility = 'hidden';
					    cell6 = newRow.insertCell(6);
					    cell6.innerHTML = '<a class="apply-job">Apply</a>'; 
					}
				}
			})	
		});
		

	});		 
</script>

<script type="text/javascript">
$(document).ready(function(){
	$('#vacancyList').on('click','.apply-job',function (e) {
    	var selectedRow = this.parentElement.parentElement;
    	var a = selectedRow.cells[0].innerHTML;
    	var b = selectedRow.cells[1].innerHTML;
    	var c = selectedRow.cells[2].innerHTML;
        var d = selectedRow.cells[3].innerHTML;
        var e = selectedRow.cells[4].innerHTML;
        var f = selectedRow.cells[5].innerHTML;
        
       console.log(a+" : "+b+" "+c+" "+d+" "+e+" "+f);
       
	     //Post form data to corresponding controller
		 $.get({
			url : '${pageContext.request.userPrincipal.name}/applyVacancy',
			data: {value: f},
			success : function(result) {
				alert(result);
				selectedRow.cells[6].innerHTML = "Applied!";
				$(".apply-job").removeAttr('href');
			}
		})	
        
    }); 	

});
</script>


<script type="text/javascript">
$(document).ready(function(){
	$("#recordBox").change(function() {
		$("#searchButton").click()
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
				    hiddenCell1 = newRow.insertCell(5);
				    var id = result[i].vacancyID;
				    hiddenCell1.innerHTML = id;
				    //hiddenCell1.innerHTML = '<input type="text" name="vacancyID" disabled class="vacancyID-input" value="' + id + '" >';
				    //$('.vacancyID-input').val(result[i].vacancyID);
				    hiddenCell1.style.visibility = 'hidden';
				    cell6 = newRow.insertCell(6);
				    cell6.innerHTML = '<a class="apply-job" href="javaScript:void(0);">Apply</a>'; 
				}
			}
		});
	});
</script>
 -->
</head>
<body>

	<div class='container mt-5 mb-5'>
		<div>
			<h1>
				<a href="/jobster">#Jobster</a> Seeker Feed . .
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
		<form:form modelAttribute="searchVacancy" method="post"
			name="searchForm">
			<div class='row mt-5'>
				<div class='col-sm-12'>
					<div class='card'>
						<c:if test="${not empty error}">
							<div class="error">${error}</div>
						</c:if>
						<c:if test="${not empty msg}">
							<div class="msg">${msg}</div>
						</c:if>

						<div class='card-header d-flex align-items-center'>
							<i class='material-icons mr-2'>event</i> Hey, Job Seeker! Search
							for your dream job . . .
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
								<%-- <div class='col-sm-3'>
									<div class='form-group'>
										<label for='event_name'>Username</label>
										<form:input path="username"
											value="${pageContext.request.userPrincipal.name}"
											disabled="true" cssClass="form-control" id="event_name" />
										<small class='form-text text-muted' id='emailHelp'>
											Disabled </small>
									</div>
								</div> --%>

								<div class='col-sm-4'>
									<div class='form-group'>
										<label for='event_category'>Location: </label> <select
											class="selectpicker" multiple data-live-search="true"
											class='form-control' class='event_category' name="location">
											<option value='Any' selected>Any</option>
											<option value='Mohali'>Mohali</option>
											<option value='Delhi'>Delhi</option>
											<option value='Pune'>Pune</option>
											<option value='Mumbai'>Mumbai</option>
											<option value='Noida'>Noida</option>
										</select>
									</div>
								</div>

								<div class='col-sm-4'>
									<div class='form-group'>
										<label for='event_category'>Skill: </label> <select
											class="selectpicker" multiple data-live-search="true"
											class='form-control' class='event_category' name="skill">
											<option value='Any' selected>Any</option>
											<option value='Java'>Java</option>
											<option value='Python'>Python</option>
											<option value='Golang'>Golang</option>
											<option value='Node.js'>Node.js</option>
										</select>
									</div>
								</div>

								<div class='form-group d-flex justify-content-end mt-4'>

									<button
										class='btn btn-outline-primary btn-sm  d-flex align-items-center float-right'
										type="submit" id="searchButton"
										style="height: 40px; margin-top: -23px;">
										<i class='material-icons mr-2'>check</i> Search for Vacancy
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="center">
				<h1>-</h1>
				<div class="record-count">
					<!-- <a href="#" class="active">5</a> <a href="#">10</a> <a href="#">20</a> -->
					<label for='event_category'>No. of records in one page</label> <select
						class='form-control' class='event_category' id="recordBox"
						name="recordCount">
						<option value='5' selected="selected">5</option>
						<option value='10'>10</option>
						<option value='20'>20</option>
					</select>
				</div>
			</div>
		</form:form>
	</div>

	<div class='container mt-5 mb-5'>
		<form:form modelAttribute="applyVacancy" method="post"
			name="vacancyTable">
			<div class='row mt-5'>
				<div class='col-sm-12'>
					<div class='card'>
						<div class='card-header d-flex align-items-center'>
							<i class='material-icons mr-2'>event</i> Available Vacancies . .
							.
						</div>
						<div class='card-body'>
							<div class='form-group' class="table-responsive">
								<table id="vacancyList"
									class="table table-light table-hover table-striped">
									<thead class="thead-light">
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

	<div class="center">
		<div class="pagination">
			<a href="#">&laquo;</a> <a href="#" class="active">1</a> <a href="#">2</a>
			<a href="#">3</a> <a href="#">4</a> <a href="#">5</a> <a href="#">6</a>
			<a href="#">&raquo;</a>
		</div>
	</div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="/jobster/resources/js/backReload.js"></script>
	<script type="text/javascript" src="/jobster/resources/js/popper.min.js"></script>
	<script type="text/javascript" src="/jobster/resources/js/seekerFeedOperations.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js"></script>
	
</body>
</html>