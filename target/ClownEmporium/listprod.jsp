<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>YOUR NAME Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>
<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="45">
<input type="submit" value="Search"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String userinputname = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
final String url = "jdbc:sqlserver://clownemporium.database.windows.net:1433;database=ClownStuff;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;;loginTimeout=30;";
final String uid = "gor154@clownemporium";
final String pw = "dydvak-godpY8-horbag";
ResultSet prs;
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try(Connection conn = DriverManager.getConnection(url, uid, pw);
	PreparedStatement pst = conn.prepareStatement("SELECT productName, productPrice, productId, productImageUrl FROM product WHERE productName LIKE ? OR categoryId LIKE ?;")
){ 
	pst.setString(1, ("%" + userinputname + "%"));// set the ? in pst to the users input, need % for the like clause
	pst.setString(2, ("%" + userinputname + "%"));// set the ? in pst to the users input, need % for the like clause

	prs = pst.executeQuery();// capture the returned table in a resultset
	while(prs.next()){
		out.println("<table border=1 width=300px><tr><th>Name</th><th>Price</th><th>ID</th><th>img</th></tr>");
		// make productName, productPrice, productId available to other .jsps
		// print out the ResultSet.
		out.println("<tr><td><a href = \"product.jsp?id=" + prs.getString("productId") + "\" > " + prs.getString("productName") + " </a></td><td>"+ prs.getString("productPrice") + "</td><td>"+ prs.getString("productId")+ "</td><td><img src=\"" + prs.getString("productImageURL") + "\"></tr></table>");
		 out.print("<form method = \"POST\" action = \"addcart.jsp?id="+prs.getString("productId")+"&name="+prs.getString("productName")+"&price="+prs.getDouble("productPrice")+"\"><input type=\"submit\" value=\"Add to Cart\"></form>");
	}
}catch(SQLException a){
	out.print(a);
}catch(Exception b){
	out.print(b);
}
// Close connection done by try w/ res

// addcart.jsp?id=(productId)&name=(productName)&price=(productPrice)

// request.setAttribute("id", prs.getString("productId"));
// request.setAttribute("name", prs.getString("productName"));
// request.setAttribute("price", prs.getString("productPrice"));
// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>
</body>
</html>