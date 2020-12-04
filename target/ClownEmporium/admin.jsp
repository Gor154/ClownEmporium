<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Administrator Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.*" %>

<%
// TODO: Write SQL query that prints out total order amount by day
final String sql = "SELECT orderDate, totalAmount FROM ordersummary";
try(Connection conn = DriverManager.getConnection(url, uid, pw); Statement st = conn.createStatement()){
    NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
    ResultSet rs = st.executeQuery(sql);

    if(rs != null){ 
        out.println("<h1>Admin Sales Report by Day</h1>");
        out.println("<table border=1 width=300px><tr><th>OrderDate</th><th>TotalAmount</th></tr>");//start the table
        while(rs.next())
		out.println("<tr><td>" + rs.getDate("orderDate") + "</td><td>" + currFormat.format(rs.getDouble("totalAmount")) + "</td></tr>");
    out.println("</table>");//end the table
    }
}catch(SQLException sqlex){
    out.println("SQLException: " + sqlex); 
}catch(Exception ex){
    out.println("Exception: " + ex); 
}
%>
</body>
</html>

