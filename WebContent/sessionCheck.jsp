<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.log4j.Logger" %>
<%-- @ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>--%>
<%@ page session="true"%>
<html>
    <head>
        <title>세션 사용</title>
    </head>
    <body>
        <h2>세션 사용</h2>
        <p> 세션 ID : <b> <%= session.getId() %> </b></p>

    </body>
</html>
