<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">      
        
    <meta charset="utf-8">
    
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    
    <title>Administrator Page</title>
</head>
<body>
    <nav class="navbar navbar-expand-md navbar-dark sticky-top">
        <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive"><span class="navbar-toggler-icon"></span>
                            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="index.jsp"><strong style="color: black;">Home</strong></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp"><p style="color: black;">Login</p></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp"><p style="color: black;">Logout</p></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="createUser.jsp"><p style="color: black;">Create New Account</p></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin.jsp"><p style="color: red;">Admin</p></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin.jsp"><p style="color: firebrick;">
                            <%
                                HttpSession sessionsa = request.getSession(false);
                                String authenticatedUser = (String) sessionsa.getAttribute("authenticatedUser");
                                if(authenticatedUser != null)
                                    out.print("Signed in as: " + authenticatedUser);
                            %>
                        </p>
                        </a>
                    </li>
                </ul>
            </div>
                        </div>
                </nav>  

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.*" %>

<%
// TODO: Write SQL query that prints out total order amount by day
final String firstsql = "SELECT orderDate, totalAmount FROM ordersummary;";
final String secondsql = "SELECT firstName, lastName FROM customer;";

try(Connection conn = DriverManager.getConnection(url, uid, pw);
    Statement firstst = conn.createStatement();
    Statement secondst = conn.createStatement()
    ){
    NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
    ResultSet rs = firstst.executeQuery(firstsql);
    ResultSet rsc = secondst.executeQuery(secondsql);
    if(rs != null){ 
        out.println("<h1>Admin Sales Report by Day</h1>");
        out.println("<table border=1 width=300px><tr><th>OrderDate</th><th>TotalAmount</th></tr>");//start the table
        while(rs.next())
		out.println("<tr><td>" + rs.getDate("orderDate") + "</td><td>" + currFormat.format(rs.getDouble("totalAmount")) + "</td></tr>");
    out.println("</table>");//end the table
    }
    if(rsc != null){
        out.println("<br><h1>All Customers</h1>");
        out.println("<table border=1 width=300px><tr><th>First Name</th><th>Last Name</th></tr>");//start the table
        while(rsc.next())
		out.println("<tr><td>" + rsc.getString("firstName") + "</td><td>" + rsc.getString("lastName") + "</td></tr>");
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

