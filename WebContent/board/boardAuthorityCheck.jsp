<%@page import="java.sql.DriverManager"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

Logger log = Logger.getLogger("[게시글 열람 권한체크]"); 

String num = request.getParameter("num");  //글번호 

//접속한 유저의 권한 확인 
/***************************************************************************/
// 세션 처리  
Cookie[] cookies = request.getCookies();
String userid = "";
if(cookies != null){
	for(int i=0; i < cookies.length; i++){
		if(cookies[i].getName().equals("userid")){
			userid = cookies[i].getValue();
		}
	}
}
if(userid.equals("")){
	response.sendRedirect(request.getContextPath() + "/index.jsp");
}

String sql = "select member_level from member where userid = '" + userid + "'";
log.debug("쿼리 : " + sql);


try{
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(
		"jdbc:mysql://127.0.0.1:3306/stonesoup", "root", "ted0201!");
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	int level = 0;
	while(rs.next()){
		level = rs.getInt(1);
		log.debug("유저 레벨 : " + level );
	}
	
	
	if(level > 4){
		log.debug("관리자 권한으로 게시글을 열람합니다...");
		response.getWriter().write("Y");
	}else{
		String sql2 = "select is_secret, writer from board where num =  " +  num;		
		pstmt = conn.prepareStatement(sql2);
		rs = pstmt.executeQuery();
		String isSecret = "";
		String writer  = "";
		if(rs != null){
			while(rs.next()){
				isSecret = rs.getString(1);
				writer = rs.getString(2); 
				log.debug("비밀글 여부: " + isSecret);
				log.debug("작성자 : " + writer);
			}
		}
		
		if(isSecret.equals("Y")){
			if(userid.equals(writer)){ 
				log.debug("글작성자 이므로 열람가능합니다."); 
				response.getWriter().write("Y");		
			}else{
				log.debug("비밀글 열람권한이 없습니다.");
				response.getWriter().write("N");
			}			
		}else{			
			log.debug("비밀글이 아니므로 열람가능합니다.");
			response.getWriter().write("Y");
		}
		
	}
	

/**************************************************************************/
}catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) rs.close();
		if (pstmt != null) pstmt.close();
		if (conn != null) conn.close();
	}
%>