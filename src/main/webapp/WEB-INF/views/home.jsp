<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="false" %>
<html>
<meta charset="ISO-8859-1">
<head>
	<title>Home</title>
	
<script>
function startTime() {
  var today = new Date();
  var h = today.getHours();
  var m = today.getMinutes();
  var s = today.getSeconds();
  var TimeMeridian = getMeridian(h);
  h = changeFormat(h);
  m = checkTime(m);
  s = checkTime(s);
  document.getElementById('dynamicTime').innerHTML =
  h + ":" + m + ":" + s + " " + TimeMeridian;
  var t = setTimeout(startTime, 500);
}
function getMeridian(h){
	if(h>12)	{	return "PM IST";}
	else		{return "AM IST";}
}
function changeFormat(h){
	if(h>12){
		h-=12;
	}
	return h;
}
function checkTime(i) {
  if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
  return i;
}
</script>	
</head>
<body onload="startTime()">
<h1>
 <span style='font-size:50px;'>Jobster &#9757;&#127995;</span>
</h1>


<h1>Title : ${title}</h1>	
	<h1>Message : ${message}</h1>	

<p> Current Time: <a id="dynamicTime"></a></p>
<div>
<a href="/jobster/login">Already on Jobster? Login</a>	&emsp;&emsp;&emsp;	<a href="/jobster/signup">New to Jobster? Signup here</a>
</div>

<sec:authorize access="hasRole('ROLE_SEEKER')">
		<!-- For login user -->
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
				User : ${pageContext.request.userPrincipal.name} | <a
					href="javascript:formSubmit()"> Logout</a>
			</h2>
		</c:if>


	</sec:authorize>


</body>
</html>
