<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="../../../../../COSC%20304%20Stuff/COSC304-Lab10/WebContent/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");
final String url = "jdbc:sqlserver://clownemporium.database.windows.net:1433;database=ClownStuff;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;;loginTimeout=30;";
final String uid = "gor154@clownemporium";
final String pw = "dydvak-godpY8-horbag";

try(Connection conn = DriverManager.getConnection(url, uid, pw);
	PreparedStatement pst = conn.prepareStatement("SELECT productName, productPrice, productId, productImageURL, productImage FROM product WHERE productId =?;")
){ 
   
	pst.setInt(1, Integer.parseInt(productId));
    ResultSet rst = pst.executeQuery();
    rst.next();
    out.println("<h2>" + rst.getString("productName") + "</h2>");
    
    // TODO: If there is a productImageURL, display using IMG tag
    String imageURL = rst.getString("productImageURL"); 
    if(imageURL != null)
        out.println("<img src =\""+imageURL+"\">"); 

    String imageData= rst.getString("productImage"); 
   
    // TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
    if (imageData != null)
        out.println("<img src = \"displayImage.jsp?id="+productId+"\">"); 
    
    
    out.println("<table> <tr> <td>ID</td> <td>" + rst.getInt("productId") + "</td> </tr> </table>");
    out.println("<table> <tr> <td>Price$</td> <td>" + rst.getDouble("productPrice") + "</td> </tr> </table>");
    
    // TODO: Add links to Add to Cart and Continue Shopping
    out.println("<h4 ><a href=\"addcart.jsp?id=" +productId+ "&name=" + rst.getString("productName") + "&price=" + rst.getDouble("productPrice") + "\">Add to Cart</a></h4>");
    out.println("<h4> <a href= \"listprod.jsp\"> Continue Shopping </a></h4>");

}
catch(SQLException a){
	out.print(a);
}catch(Exception b){
	out.print(b);
}

%>

</body>
</html>

