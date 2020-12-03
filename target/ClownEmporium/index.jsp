<!DOCTYPE html>
<html>
<head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ray's Grocery Main Page</title>
</head>
<body>
<h1 align="center">Welcome to Ray's Grocery</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" session="false"%>
<%
// TODO: Display user name that is logged in (or nothing if not logged in)
HttpSession sessionsa = request.getSession(true);
String authenticatedUser = (String) sessionsa.getAttribute("authenticatedUser");
if(authenticatedUser != null){
        out.print("<h3 align=\"center\">" + "Signed in as: " + authenticatedUser + "</h3>");
}
%>
</body>
</html>

