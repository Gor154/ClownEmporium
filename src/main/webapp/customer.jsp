<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");

%>

<%

if(userName == null){
	session.setAttribute("authenticatedUser",null);
	session.setAttribute("loginMessage","Cannot access customer info since you're not logged in. Please log in.");

}

// TODO: Print Customer information
final String url = "jdbc:sqlserver://clownemporium.database.windows.net:1433;database=ClownStuff;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;;loginTimeout=30;";
final String uid = "gor154@clownemporium";
final String pw = "dydvak-godpY8-horbag";
String sql = "SELECT * FROM customer WHERE userId = ?";

try(Connection conn = DriverManager.getConnection(url, uid, pw); Statement stmt = conn.createStatement(); 
		PreparedStatement pps = conn.prepareStatement(sql);)
{
	pps.setString(1, userName);
	ResultSet rs = pps.executeQuery();
	rs.next();
	out.println("<h3>Customer Profile</h3>");
	out.println("<table border = 1 width =300px> <tr><th>ID</th><td>" + rs.getString("customerId") + "</td></tr>");
	out.println("<tr><th>First Name</th><td>" + rs.getString("firstName") + "</td></tr>");
	out.println("<tr><th>Last Name</th><td>" + rs.getString("lastName") + "</td></tr>");
	out.println("<tr><th>E-mail</th><td>" + rs.getString("email") + "</td></tr>");
	out.println("<tr><th>Phone</th><td>" + rs.getString("phonenum") + "</td></tr>");
	out.println("<tr><th>Address</th><td>" + rs.getString("address") + "</td></tr>");
	out.println("<tr><th>City</th><td>" + rs.getString("city") + "</td></tr>");
	out.println("<tr><th>State</th><td>" + rs.getString("state") + "</td></tr>");
	out.println("<tr><th>Postal Code</th><td>" + rs.getString("postalCode") + "</td></tr>");
	out.println("<tr><th>Country</th><td>" + rs.getString("country") + "</td></tr>");
	out.println("<tr><th>User Id</th><td>" + rs.getString("userid") + "</td></tr> </table>");
}catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}
%>

</body>
</html>

