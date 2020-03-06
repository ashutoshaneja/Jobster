<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Error Encountered :(</title>

<link rel="icon" href="/jobster/resources/img/logo.png">
<link href='https://fonts.googleapis.com/css?family=Monoton' rel='stylesheet' type='text/css'>

<link rel="stylesheet" type="text/css" href="/jobster/resources/css/errorPage.css">
<link rel="stylesheet" type="text/css" href="/jobster/resources/css/reset.min.css">

</head>

<body>
	<div class="board">
		<p id="error">Error ${errorCode}</p>
		<p id="code">${errorMsg}</p>

		<button class="raise" onclick="javascript:history.back();">
			Go Back ..</button>
	</div>

	<script type="text/javascript" src="/jobster/resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="/jobster/resources/js/errorPage.js"></script>
	
</body>
</html>