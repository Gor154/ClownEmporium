<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Your Shopping Cart</title>
</head>
<body>

<%
session.setAttribute("productList", new HashMap<String, ArrayList<Object>>());
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html> 

