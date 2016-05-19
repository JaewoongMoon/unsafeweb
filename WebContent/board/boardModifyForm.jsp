<%@page import="org.apache.log4j.Logger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%

Logger log = Logger.getLogger("[게시글 수정]"); 
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
/***************************************************************************/


	// 사용할 객체 초기화
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
			log.debug("관리자 권한으로 게시글을 수정합니다...");
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
			
			if(userid.equals(writer)){ 
					log.debug("글작성자 이므로 수정가능합니다."); 
			}else{
					response.sendRedirect("boardList.jsp");
				}			
			}
		
		// 게시물 상세 조회 쿼리 실행 
		pstmt = conn.prepareStatement(
			"SELECT NUM, SUBJECT, CONTENTS, WRITER, HIT, REG_DATE FROM BOARD "+ 
			"WHERE NUM = ?");
		pstmt.setString(1, num);
		rs = pstmt.executeQuery();
		rs.next();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<title>게시판 수정 폼</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-1.12.3.min.js"></script>
<style type="text/css">
	* {font-size: 9pt;}
	p {width: 600px; text-align: right;}
	table tbody tr th {background-color: gray;} 
</style>
<script type="text/javascript">
	function goUrl(url) {
		location.href=url;
	}
	// 수정 폼 체크
	function boardModifyCheck() {
		var form = document.boardModifyForm;
		if (form.subject.value == '') {
			alert('제목을 입력하세요.');
			form.subject.focus();
			return false;
		}
		if (form.writer.value == '') {
			alert('작성자을 입력하세요');
			form.writer.focus();
			return false;
		}
		
		if( $("#addFile").val() != "" ){
			var ext = $('#addFile').val().split('.').pop().toLowerCase();
		    if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
				 alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
				 return false;
		    }
		}
		

		return true;
	}
</script>
</head>
<body>
	<form name="boardModifyForm" action="boardProcess.jsp" method="post" onsubmit="return boardModifyCheck();">
	<input type="hidden" name="mode" value="M" />
	<input type="hidden" name="num" value="<%=num %>" />
	<input type="hidden" name="pageNum" value="<%=pageNum %>" />
	<input type="hidden" name="searchType" value="<%=searchType %>" />
	<input type="hidden" name="searchText" value="<%=searchText %>" />
	<table border="1" summary="게시판 수정 폼">
		<caption>게시판 수정 폼</caption>
		<colgroup>
			<col width="100" />
			<col width="500" />
		</colgroup>
		<tbody>
			<tr>
				<th align="center">제목</th>
				<td><input type="text" name="subject" size="80" maxlength="100" value="<%=rs.getString("SUBJECT") %>" /></td>
			</tr>
			<tr>
				<th align="center">작성자</th>
				<td><input type="text" name="writer" maxlength="20" value="<%=rs.getString("WRITER") %>" /></td>
			</tr>
			<tr>
				<th align="center">첨부파일</th>
				<td><input type="file" name="addFile" id="addFile" maxlength="20" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea name="contents" cols="80" rows="10"><%=rs.getString("CONTENTS") %></textarea>
					<script>
					CKEDITOR.replace('contents');
					</script>
				</td>
			</tr>
		</tbody>
	</table>
	<p>
		<input type="button" value="목록" onclick="goUrl('boardList.jsp?pageNum=<%=pageNum%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>');" />
		<input type="submit" value="글수정" />
	</p>
	</form>
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
