<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.log4j.Logger" %>
<%
Logger log = Logger.getLogger("[loginProcess]"); 
log.debug("=======================================");


Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String userid = request.getParameter("userid");
String passwd = request.getParameter("passwd");

if(userid == null || passwd == null){
	response.sendRedirect("index.jsp");
}

//try {
	// 데이터베이스 객체 생성
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(
		"jdbc:mysql://127.0.0.1:3306/stonesoup", "root", "ted0201");
	
	String sql = "SELECT * FROM member "+ 
//			"WHERE userid = '" + userid + "' and passwd = '" + passwd +"'";
                    "WHERE userid = ? and passwd = ?";	
	log.info("SQL : " + sql);
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, userid);
        pstmt.setString(2, passwd);
	rs = pstmt.executeQuery();
	
	if(!rs.next()){
		//out.println("alert('로그인 실패');");
		log.info("로그인 실패요~~");
		%>
		<script>
		alert('로그인이 실패하였습니다.');
		history.go(-1);
		</script>
		
		<%
		//response.sendRedirect("index.jsp");
	}else{
		log.info("로그인 성공");
		HttpSession newSession = request.getSession();
		//newSession.get
		log.info("로그인 세션ID : " + newSession.getId());
		
		Cookie cookie1 = new Cookie("userid", userid);
//		Cookie cookie2 = new Cookie("passwd", passwd);
		cookie1.setMaxAge(20*60);
		
		response.addCookie(cookie1);
//		response.addCookie(cookie2);
		response.sendRedirect("board/boardList.jsp");
	}

%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<title>board main </title>
</head>	
<body>
</body>
</html>

<%
/*
} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) rs.close();
		if (pstmt != null) pstmt.close();
		if (conn != null) conn.close();
	}*/
%>
