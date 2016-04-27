<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="org.apache.log4j.Logger" %>
<%
Logger log = Logger.getLogger("[중복체크]");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String userid = request.getParameter("userid");

try {
	// 데이터베이스 객체 생성
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(
		"jdbc:mysql://127.0.0.1:3306/stonesoup", "root", "ted0201");
	
	String sql = "select count(*) from member "
			+ "where userid = '" + userid  +"'";
	log.info("중복체크 SQL : " + sql);
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery(sql);
	while(rs.next()){
		int result = rs.getInt(1);
		log.debug("중복체크 결과 : " + result);
		if(result > 0){
			response.getWriter().write("N");
		}else{
			response.getWriter().write("Y");
		}
	}
} catch (Exception e) {
	e.printStackTrace();
} finally {
	if (pstmt != null) pstmt.close();
	if (conn != null) conn.close();
}
%>