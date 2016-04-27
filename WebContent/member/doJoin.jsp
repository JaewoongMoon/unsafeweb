<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="org.apache.log4j.Logger" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 가입</title>
<%
Logger log = Logger.getLogger("[JoinPage]");

Connection conn = null;
PreparedStatement pstmt = null;
//ResultSet rs = null;

	
String userid = request.getParameter("userid");
String name = request.getParameter("name");
//String name2 = new String (request.getParameter("name").getBytes("8859_1"), "UTF-8");
//String decoded_name = URLDecoder.decode(new String(name.getBytes(),""),"UTF-8");
String passwd = request.getParameter("passwd");

log.info("name : " + name);
//log.info("decoded_name : " + name2);

try {
	// 데이터베이스 객체 생성
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(
		"jdbc:mysql://127.0.0.1:3306/stonesoup", "root", "ted0201");
	
	String sql = "insert into member (userid, username, passwd, member_level)"+ 
			"values ('"+userid +"','" + name + "','" + passwd + "','1')" ;
	
	log.info("SQL : " + sql);
	pstmt = conn.prepareStatement(sql);
	int result = pstmt.executeUpdate();
	log.info("실행결과 : " + result);
	if(result == 1){
		out.println("<h1>회원가입이 완료되었습니다.</h1>");
	}else{
		out.println("<h1>회원가입이 실패하였습니다.</h1>");
	}
%>
<script>
function goLogin(){
	location.href= "<%=request.getContextPath() %>" + "/index.jsp";	
}
</script>
</head>
<body>
	<div style="margin:auto; width:500px">
		<input type="button" value="로그인페이지로" onclick="goLogin();" />
	</div>
</body>
</html>

<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (pstmt != null) pstmt.close();
		if (conn != null) conn.close();
	}
%>