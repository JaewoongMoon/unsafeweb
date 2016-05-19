<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

Logger log = Logger.getLogger("[파일다운로드]");


String fileName = request.getParameter("fileName");
//String filePath = request.getParameter("filePath");
log.debug("파일명 필터링 전 :" +fileName);
fileName = fileName.replaceAll("../","");
log.debug("파일명 필터링 후 : " +fileName);
/*
ServletContext context = getServletContext();
String realDirectory = context.getRealPath("File");
log.debug("실제 디렉: " + realDirectory);
*/
try{
    if(fileName.toLowerCase().endsWith(".jpg") ||
        fileName.toLowerCase().endsWith(".png") ||
        fileName.toLowerCase().endsWith(".gif") ||
        fileName.toLowerCase().endsWith(".jpeg")){

	String filePath = "C:\\Users\\jwmoon\\workspace\\unsafeweb\\WebContent\\fileuploads\\"+fileName;
	log.debug(filePath + "의 파일스트림을 생성합니다..");
	File file = new File(filePath);
	byte b[] = new byte[4096];
	
	// page의 contentType 변경
	response.reset();
	response.setContentType("application/octet-stream");
	
	//인코딩
	String encodedFileName = new String(fileName.getBytes("UTF-8"), "8859_1");  
	
	response.setHeader("Content-Disposition", "attachment;filename="+encodedFileName);
	
	// 서버에 저장된 파일 정보 읽기
	FileInputStream in = new FileInputStream(filePath);
	
	// Output Stream
	ServletOutputStream out2 = response.getOutputStream();
	
	
	out.clear();
	out = pageContext.pushBody();
	
	int numRead;
	
	while((numRead = in.read(b, 0, b.length)) != -1){
		out2.write(b, 0, numRead);
	}
	
	out2.flush();
	out2.close();
	in.close();
}else{
    log.debug("비정상 적인 파일 다운로드 요청입니다. :" + fileName);
}	
	
}catch(Exception e){
	e.printStackTrace();
}

%>
