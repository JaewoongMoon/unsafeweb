<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.log4j.Logger" %>
<%
Logger log = Logger.getLogger("[logoutProcess]"); 
log.debug("=======================================");


Cookie[] cookies = request.getCookies();

for(int i=0; i< cookies.length; i++){
	String name = cookies[i].getName();
	if(cookies[i].getName().equals("userid")){
		cookies[i].setMaxAge(0);
		response.addCookie(cookies[i]);
	}
}

%>    
<script>
alert('로그아웃 되었습니다.');
location.href="index.jsp";
</script>