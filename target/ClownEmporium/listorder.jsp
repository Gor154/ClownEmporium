<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">      
        
<meta charset="utf-8">

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

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

<h1>Order List</h1>
<%
//Note: Forces loading of SQL Server driver
try {	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e) {
	out.println("ClassNotFoundException: " +e);
}
// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00
// Make connection
final String url = "jdbc:sqlserver://clownemporium.database.windows.net:1433;database=ClownStuff;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;;loginTimeout=30;";
final String uid = "gor154@clownemporium";
final String pw = "dydvak-godpY8-horbag";
try(Connection conn = DriverManager.getConnection(url, uid, pw); Statement stmt = conn.createStatement(); 
	PreparedStatement pps = conn.prepareStatement("SELECT * FROM orderproduct WHERE orderId = ?;")
){
	// Write query to retrieve all order summary records
	ResultSet rs = stmt.executeQuery("SELECT * FROM ordersummary O LEFT JOIN customer C on O.customerId = C.customerId;");
	ResultSet prs;// for the products in the order
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
	// For each order in the ResultSet
	out.println("<table border=1 width=450px><tr><th>orderId</th><th>orderDate</th><th>customerId</th><th>customerName</th><th>totalAmount</th></tr>");
	while(rs.next()){
		// Print out the order summary information
		pps.setInt(1, rs.getInt("orderId"));// set the ? in pps to the current order
		out.println("<tr><td>" + rs.getInt("orderId") + "</td><td>" + rs.getDate("orderDate") + "</td><td>" + rs.getInt("customerId") + "</td><td>" + rs.getString("firstName") + " " + rs.getString("lastName") + "</td><td>" + currFormat.format(rs.getDouble("totalAmount")) + "</td></tr><tr align=right><td colspan=5>");
		prs = pps.executeQuery();
		out.println("<table border=1><tr><th>productId</th><th>quantity</th><th>price</th></tr>");
		while(prs.next())
			out.println("<tr><td>" + prs.getInt("productId") + "</td><td>" + prs.getInt("quantity") + "</td><td>" + currFormat.format(prs.getDouble("price")) + "</td></tr>");
		out.println("</table></td></tr>");
	}
	out.println("</table>");
	// Close connection done by try block
} catch(SQLException a){
	out.println(a);
} catch(Exception b){
	out.print(b);
}
%>
</body>
</html>

