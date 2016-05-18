<%@page import="filter.LucyFilter"%>
<%@page import="com.nhncorp.lucy.security.xss.XssFilter"%>
<%@page import="org.apache.log4j.Logger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<title>게시판 상세보기</title>
<style type="text/css">
	* {font-size: 9pt;}
	.btn_align {width: 600px; text-align: right;}
	table tbody tr th {background-color: gray;}
</style>
<script src="<%=request.getContextPath()%>/js/jquery-1.12.3.min.js"></script>
<script type="text/javascript">
	function goUrl(url) {
		location.href=url;
	}
	// 삭제 체크
	function deleteCheck(url) {
		if (confirm('정말 삭제하시겠어요?')) {
			location.href=url;
		}
	}
	
	function file_download(name){
		/*
		$.ajax({
			type: "POST",
			url: "fileDownload.jsp",
			data :{
					fileName : name
			},
			success :function(response){
				console.log("result : " +response);
			}
		});*/
		$("#fileName").val(name);
		$("#downFrm").submit();
	}
</script>
<%


/**************************************************************************/
	Logger log = Logger.getLogger("[게시글 열람]"); 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	// 파라미터
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
	try {
		// 데이터베이스 객체 생성
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
			"jdbc:mysql://127.0.0.1:3306/stonesoup", "root", "ted0201");
		
		
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
		/**************************************************************************/
		
		// 열람 가능한지 재 체크
		
		String sql = "select member_level from member where userid = '" + userid + "'";

		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		int level = 0;
		while(rs.next()){
			level = rs.getInt(1);
			log.debug("유저 레벨 : " + level );
		}
		
		
		if(level > 4){
			log.debug("관리자 권한으로 게시글을 열람합니다...");
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
				}else{
					log.debug("파라메터 변조 해킹시도입니다.");
					//response.sendRedirect("boardList.jsp");
					%>
					<script>
					alert('비밀글을 보려구요? 메롱~');
					</script>
					<% 
				}			
			}else{			
				log.debug("비밀글이 아니므로 열람가능합니다.");
			}
		}
		
		XssFilter xf = LucyFilter.lucyFilter;
		/***********************************************************************************/
		// 조회수 증가 쿼리 실행
		pstmt = conn.prepareStatement("UPDATE BOARD SET HIT = HIT + 1 WHERE NUM = ?");
		pstmt.setString(1, num);
		pstmt.executeUpdate();
		// 게시물 상세 조회 쿼리 실행 
		pstmt = conn.prepareStatement(
			"SELECT NUM, SUBJECT, CONTENTS, WRITER, HIT, REG_DATE, FILE_NAME, FILE_PATH FROM BOARD "+ 
			"WHERE NUM = ?");
		pstmt.setString(1, num);
		rs = pstmt.executeQuery();
		rs.next();
%>

</head>
<body>
	<form method="post" action="fileDownload.jsp" name="downFrm" id="downFrm" >
		<input type="hidden" id="fileName" name="fileName" value="" />
	</form>
	<table border="1" summary="게시판 상세조회">
		<caption>게시판 상세조회</caption>
		<colgroup>
			<col width="100" />
			<col width="500" />
		</colgroup>
		<tbody>
			<tr>
				<th align="center">제목</th>
				<td><%= xf.doFilter(rs.getString("SUBJECT")) %></td>
			</tr>
			<tr>
				<th align="center">작성자/조회수</th>
				<td><%=rs.getString("WRITER") %> / <%=rs.getInt("HIT") %></td>
			</tr>
			<tr>
				<th align="center">등록 일시</th>
				<td><%=rs.getString("REG_DATE") %></td>
			</tr>
			<tr>
				<th align="center">첨부파일</th>
				<td><a href="javascript:file_download('<%=rs.getString("FILE_NAME") %>');" ><%=rs.getString("FILE_NAME") %></a></td>
			</tr>
			<tr>
				<td colspan="2"><%=xf.doFilter(rs.getString("CONTENTS")) %></td>
			</tr>
		</tbody>
	</table>
	<p class="btn_align">
		<input type="button" value="목록" onclick="goUrl('boardList.jsp?pageNum=<%=pageNum%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>');" />
		<input type="button" value="수정" onclick="goUrl('boardModifyForm.jsp?num=<%=num%>&amp;pageNum=<%=pageNum%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>');" />
		<input type="button" value="삭제" onclick="deleteCheck('boardProcess.jsp?mode=D&amp;num=<%=num%>&amp;pageNum=<%=pageNum%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>');" />
	</p>
</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) rs.close();
		if (pstmt != null) pstmt.close();
		if (conn != null) conn.close();
	}
%>