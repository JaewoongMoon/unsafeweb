<%@page import="java.nio.charset.Charset"%>
<%@page import="org.apache.commons.fileupload.util.Streams"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.fileupload.FileItemStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="javax.servlet.ServletContext"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="org.apache.commons.fileupload.FileItemIterator"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>

<%
	Logger log = Logger.getLogger("[boardProcess]"); 
	log.debug("=======================================");

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
	
	
	
	
	//사용할 객체 초기화
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	// 파라미터
	String mode = request.getParameter("mode");
	String subject = request.getParameter("subject");
	String writer = userid;
	String contents = request.getParameter("contents");
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
	//String passwd = request.getParameter("passwd");
	String isSecret = request.getParameter("isSecret");
	
	String fileName = "";
	String filePath = "";

	DiskFileItemFactory factory = new DiskFileItemFactory();
	ServletContext servletContext = this.getServletConfig().getServletContext();
	File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
	factory.setRepository(repository);
		
	ServletFileUpload upload = new ServletFileUpload(factory);
	//log.debug(upload.getHeaderEncoding());
	upload.setHeaderEncoding("UTF-8");
	//log.debug("request encoding : " + request.getCharacterEncoding());
	
	
	List<FileItem> items = upload.parseRequest(request);

	if(items != null){
		for(FileItem item : items){
			
			if( item.isFormField()){
				String fieldname = item.getFieldName();
				//log.debug("filedName : " + fieldname);
				
				if(fieldname.equals("mode")){
					mode = item.getString();
				}else if(fieldname.equals("subject")){
					subject = new String( item.getString().getBytes("8859_1"), Charset.forName("UTF-8"));
				}else if(fieldname.equals("contents")){
					contents = new String( item.getString().getBytes("8859_1"), Charset.forName("UTF-8"));
				}else if(fieldname.equals("num")){
					num = item.getString();
				}else if(fieldname.equals("pageNum")){
					pageNum = item.getString();
				}else if(fieldname.equals("searchType")){
					searchType = new String( item.getString().getBytes("8859_1"), Charset.forName("UTF-8"));
				}else if(fieldname.equals("searchText")){
					searchText = new String( item.getString().getBytes("8859_1"), Charset.forName("UTF-8"));
				}else if(fieldname.equals("isSecret")){
					isSecret = new String( item.getString().getBytes("8859_1"), Charset.forName("UTF-8"));
				}
				
			}else{
				String dirPath = "D:\\fileuploads";
				//String dirPath = "FILE_UPLOAD";
				//log.debug("파일명 : " + item.getName());
				fileName = item.getName();
				if(fileName != null && !fileName.equals("")){
					
					File directory = new File(dirPath);
					if(!directory.exists()){
						directory.mkdir();
					}
					File uploadFile;
					filePath = dirPath + "/" + fileName;
					
					uploadFile = new File(filePath);
					if(uploadFile != null){
						item.write(uploadFile);						
					}
					//log.debug("사이즈 : " + item.getSize());
					}
			}
		}
	}
	
	//File uploadFile = multiReq.getFile("addFile");
	/*
	if(uploadFile == null)
		log.debug("file is null" );
	else
		log.debug("filename :" + uploadFile.getName());
	*/
	
	String ip = request.getRemoteAddr();
	//log.debug("ip : " + ip);
	//log.debug("mode : " + mode);
	//log.debug("비밀글 비번 :" + passwd);
	try {
		// 데이터베이스 객체 생성
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/stonesoup", "root", "ted0201");
		
		// 처리 (W:등록, M:수정, D:삭제)
		if ("W".equals(mode)) {
			
			pstmt = conn.prepareStatement(
				"INSERT INTO BOARD (SUBJECT, WRITER, CONTENTS, IP, HIT, REG_DATE, MOD_DATE, FILE_NAME, FILE_PATH, IS_SECRET) "+
				"VALUES (?, ?, ?, ?, 0, NOW(), NOW(), ?, ?, ?)");
			pstmt.setString(1, subject);
			pstmt.setString(2, writer);
			pstmt.setString(3, contents);
			pstmt.setString(4, ip);
			pstmt.setString(5, fileName);
			pstmt.setString(6, filePath);
			pstmt.setString(7, isSecret);
			pstmt.executeUpdate();
			
			response.sendRedirect("boardList.jsp");
		} else if ("M".equals(mode)) {
			pstmt = conn.prepareStatement(
				"UPDATE BOARD SET SUBJECT = ?, WRITER = ?, CONTENTS = ?, IP = ?, MOD_DATE = NOW() "+
				"WHERE NUM = ?");
			pstmt.setString(1, subject);
			pstmt.setString(2, writer);
			pstmt.setString(3, contents);
			pstmt.setString(4, ip);
			pstmt.setString(5, num);
			pstmt.executeUpdate();
			
			response.sendRedirect(
				"boardView.jsp?num="+num+"&pageNum="+pageNum+"&searchType="+searchType+"&searchText="+searchText);
		} else if ("D".equals(mode)) {
			pstmt = conn.prepareStatement("DELETE FROM BOARD WHERE NUM = ?");
			pstmt.setString(1, num);
			pstmt.executeUpdate();
			
			response.sendRedirect(
				"boardList.jsp?pageNum="+pageNum+"&searchType="+searchType+"&searchText="+searchText);
		} else {
			log.debug("something wrong..");
			response.sendRedirect("boardList.jsp");
		}

		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (pstmt != null) pstmt.close();
		if (conn != null) conn.close();
	}
%>