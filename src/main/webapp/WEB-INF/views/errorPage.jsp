<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Error Encountered :(</title>
<link rel='stylesheet' type="text/css" href="resources/css/errorPage.css">
<link href='https://fonts.googleapis.com/css?family=Monoton' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
 <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'>
  </script><script  src="resources/js/errorPage.js"></script>
</head>
<body>
<div class="board">
  <p id="error">
    Error ${errorCode}
  </p>
  <p id="code">
    ${errorMsg}
  </p>
  <button class="raise" onclick="javascript:history.back();">Go Back ..</button>
</div>
<!-- partial -->

</body>
</html>