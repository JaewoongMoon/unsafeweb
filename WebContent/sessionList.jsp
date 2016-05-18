<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.log4j.Logger" %>
<html>
<body>
<table>
<%
Logger log = Logger.getLogger("[sessionList]");

HttpSessionContext context = session.getSessionContext();
Enumeration ids = context.getIds();

while(ids.hasMoreElements())
{
   String id = (String) ids.nextElement();
   out.println("<tr><td>");
   out.println(id);
   HttpSession foreignSession = context.getSession(id);
   String foreignUser = (String) foreignSession.getValue("userid");
   out.println("<td>"+foreignUser);
   out.println("<td>"+request.getHeader("REMOTE_ADDR"));
   out.println("<td>"+new Date(foreignSession.getCreationTime()));
   out.println("<td>"+new Date(foreignSession.getLastAccessedTime()));
   out.println("</tr>");
}

%>
</table>
</body>
</html>