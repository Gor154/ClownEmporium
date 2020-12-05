<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>

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

