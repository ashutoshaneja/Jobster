<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>CodePen - CodePenChallenge: 403 Forbidden</title>
<link rel="icon" href="/jobster/resources/img/logo.png">

<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Squada+One'>
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Montserrat:500,600'>

<link rel="stylesheet" type="text/css" href="/jobster/resources/css/normalize.min.css">
<link rel='stylesheet' type="text/css" href="/jobster/resources/css/403page.css">
</head>
<body>
	<h1>HTTP Status 403 - Access is denied</h1>

	<p>
		<c:choose>
			<c:when test="${empty username}">
				You do not have permission to access this page!
			</c:when>
			<c:otherwise>
				
					Username : ${username} <br /> You do not have permission to access
					this page!
			
			</c:otherwise>
		</c:choose>
	</p>
	<h1>Forbidden resource</h1>
	<p>The server understood the request but refuses to authorize it.</p>

	<button class="raise" onclick="javascript:history.back();">Go
		Back ..</button>

	<script type="text/javascript" src="/jobster/resources/js/403page.js"></script>
	<script type="text/javascript" src="/jobster/resources/js/backReload.js"></script>
	
</body>
</html>