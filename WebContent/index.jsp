<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%



%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<title>Login Page</title>
<script>
function goLogin(){
	$("form").submit();
}

function goJoin(){
	location.href="member/join.jsp";
}

</script>
</head>
<body>
	<div style="margin:auto; width:500px;">
	<h1>Vulnerable Board </h1>
	<h2>Do some hack, and enjoy!</h2>
	<p>
		<form name="loginForm" action="loginProcess.jsp" method="post" >
		Id : <input type="text" name="userid" id="userid"></input> <br/>
		password : <input type="password" name="passwd" id="passwd" onkeydown=""/> <br/>
		<input type="submit" value="login" onclick="goLogin();"></input>
		</form>
		
		<br/><br/>
		
		<input type="button" value="회원가입" onclick="goJoin();"></input>
	</p>
	</div>
</body>
</html>


