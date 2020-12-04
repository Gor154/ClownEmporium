<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Create User</title>
</head>
<body>
<h1>Enter Your Information In This Super Secure Form</h1>
<form name="form1" method="post" action="login.jsp" onsubmit="return validateForm()">
<table>
<tr><td>First Name</td><td><input type="text" name="firstName" size="45"></td></tr>
<tr><td>Last Name</td><td><input type="text" name="lastName" size="45"></td></tr>
<tr><td>User Name</td><td><input type="text" name="userid" size="45"></td></tr>
<tr><td>Password</td><td><input type="password" name="password" size="45"></td></tr>
<tr><td>Email</td><td><input type="text" name="email" size="45"></td></tr>
<tr><td>Phone Number</td><td><input type="text" name="phonenum" size="45"></td></tr>
<tr><td>Address</td><td><input type="text" name="address" size="45"></td></tr>
<tr><td>City</td><td><input type="text" name="city" size="45"></td></tr>
<tr><td>State</td><td><input type="text" name="state" size="45"></td></tr>
<tr><td>Postal Code</td><td><input type="text" name="postalCode" size="45"></td></tr>
<tr><td>Country</td><td><input type="text" name="country" size="45"></td></tr>
<tr><td><input type="submit" value="Enter"><input type="reset" value="Reset"></td></tr>
</table>
</form>
<script>
    function validateForm(){
        var fn = document.forms["form1"]["firstName"].value;
        var ln = document.forms["form1"]["lastName"].value;
    
        // validate lastname and fistname
        for(var i = 0; i < 9; i++){
            if(fn.includes(i) || ln.includes(i)){
                window.alert('Invalid Name');
                return false;
            }
        }
        // validate email
        var em = document.forms["form1"]["email"].value;
        if(!em.includes('@')){
            window.alert('Invalid Email');
            return false;
        }
    }
</script>
<%
// Get items from form
// (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password)
String[] arr = {
    request.getParameter("firstName"),
    request.getParameter("lastName"),
    request.getParameter("email"),
    request.getParameter("phonenum"),
    request.getParameter("address"),
    request.getParameter("city"),
    request.getParameter("state"),
    request.getParameter("postalCode"),
    request.getParameter("country"),
    request.getParameter("userid"),
    request.getParameter("password")
};
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
    out.println("ClassNotFoundException: " +e);
}

    // Make the connection
    final String url = "jdbc:sqlserver://clownemporium.database.windows.net:1433;database=ClownStuff;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;;loginTimeout=30;";
    final String uid = "gor154@clownemporium";
    final String pw = "dydvak-godpY8-horbag";

    try(Connection conn = DriverManager.getConnection(url, uid, pw);
        PreparedStatement pst = conn.prepareStatement("INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);")
    ){
        for(int i = 0; i < arr.length; i++){
            pst.setString(i + 1, (arr[i]));// set the ? in pst to each of the users input
        }
        pst.execute();        
    }catch(SQLException a){
        out.print(a);
    }catch(Exception b){
        out.print(b);
    }
// Close connection done by try w/ res
%>
</body>
</html>
