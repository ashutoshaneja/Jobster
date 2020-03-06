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
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
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
											class='form-control' id="locationComboBox" class='event_category' name="location">
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
											class='form-control' id="skillComboBox" class='event_category' name="skill">
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
								<table id="vacancyList" class="supTable table table-light table-hover table-striped">
									<thead class="thead-light">
										<tr id="tableTitle">
											<th onclick="sortTable('supTable', 0)">Company Name <i class="fa fa-fw fa-sort"></i></th>
											<th onclick="sortTable('supTable', 1)">No. of Vacancies <i class="fa fa-fw fa-sort"></i></th>
											<th onclick="sortTable('supTable', 2)">Location <i class="fa fa-fw fa-sort"></i></th>
											<th onclick="sortTable('supTable', 3)">Skill <i class="fa fa-fw fa-sort"></i></th>
											<th onclick="sortTable('supTable', 4)">Experience (in Years) <i class="fa fa-fw fa-sort"></i></th>
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
	<form:form modelAttribute="searchVacancy" method="post" name="searchForm">
	<div class="center">
		<div class="pagination">
		</div>
	</div>
	</form:form>
	
<script>
function sortTable(tableClass, n) {
	var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;

	table = document.getElementsByClassName(tableClass)[0];
	switching = true;
	dir = "asc";
	while (switching) {
	    switching = false;
	    rows = table.getElementsByTagName("TR");
	    for (i = 1; i < (rows.length - 1); i++) {
	        shouldSwitch = false;
	        x = rows[i].getElementsByTagName("TD")[n];
	        y = rows[i + 1].getElementsByTagName("TD")[n];
	                var cmpX=isNaN(parseInt(x.innerHTML))?x.innerHTML.toLowerCase():parseInt(x.innerHTML);
	                var cmpY=isNaN(parseInt(y.innerHTML))?y.innerHTML.toLowerCase():parseInt(y.innerHTML);
	cmpX=(cmpX=='-')?0:cmpX;
	cmpY=(cmpY=='-')?0:cmpY;
	        if (dir == "asc") {
	            if (cmpX > cmpY) {
	                shouldSwitch= true;
	                break;
	            }
	        } else if (dir == "desc") {
	            if (cmpX < cmpY) {
	                shouldSwitch= true;
	                break;
	            }
	        }
	    }
	    if (shouldSwitch) {
	        rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
	        switching = true;
	        switchcount ++;      
	    } else {
	        if (switchcount == 0 && dir == "asc") {
	            dir = "desc";
	            switching = true;
	        }
	    }
	}
	}
</script>


	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	
	<script type="text/javascript" src="/jobster/resources/js/backReload.js"></script>
	<script type="text/javascript" src="/jobster/resources/js/popper.min.js"></script>
	<script type="text/javascript" src="/jobster/resources/js/seekerFeedOperations.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js"></script>
	
</body>
</html>