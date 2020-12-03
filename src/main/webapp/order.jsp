<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
String password = request.getParameter("password");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
// Determine if there are products in the shopping cart
// If either are not true, display an error message
// Determine if valid customer id was entered
// Make connection
int indicator = 0;
boolean idIsValid = false;
boolean cartFull = false;
final String url = "jdbc:sqlserver://clownemporium.database.windows.net:1433;database=ClownStuff;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;;loginTimeout=30;";
final String uid = "gor154@clownemporium";
final String pw = "dydvak-godpY8-horbag";
ResultSet rs;
boolean numeric = true;
String customerName = "";
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
try(Connection conn = DriverManager.getConnection(url, uid, pw);
PreparedStatement pst = conn.prepareStatement("SELECT * FROM customer WHERE customerId=?;");
PreparedStatement prst = conn.prepareStatement("SELECT userid FROM customer WHERE customerId = ? AND password = ?")){
	try {
        int num = Integer.parseInt(custId);
    } catch (NumberFormatException e) {
            numeric = false;
    } 
	if(numeric){
		pst.setString(1,custId); //Searches database to see if customer with this ID exists
		rs = pst.executeQuery();
		prst.setString(1,custId);
		prst.setString(2,password);
		ResultSet rs2 = prst.executeQuery();
		boolean passwordCorrect = false;
		if(rs2.next()){
			passwordCorrect = true;
		}
		if(rs.next() && passwordCorrect){
			customerName = rs.getString("firstName")+" "+rs.getString("lastName");
			idIsValid = true;
		}
	}
	if(!productList.isEmpty()){
		cartFull = true;
	}
	if(!(idIsValid && cartFull)){
		out.println("<h1 style=\"color: red\">Invalid Customer ID or Empty Cart, please go back and try again</h1>");
		indicator = 1;
		return;
	}


// Save order information to database
// Use retrieval of auto-generated keys.
	String sql = "INSERT INTO ordersummary (orderDate,totalAmount,customerId) values (?,?,?)";
	PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
	LocalDateTime now = LocalDateTime.now();   //Get current date
	ps.setString(1,dtf.format(now));
	Double total_price = 0.0; //Determine the total price
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
        total_price += pr*qty;
	}
	ps.setString(2,total_price+"");
	ps.setString(3,custId+"");
	ps.executeUpdate();
	ResultSet keys = ps.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	// Insert each item into OrderProduct table using OrderId from previous INSERT
	sql = "INSERT INTO orderproduct (orderId,productId,quantity,price) values ("+orderId+",?,?,?)";
	PreparedStatement ps2 = conn.prepareStatement(sql);
	iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
        ps2.setString(1,productId);
		ps2.setString(2,qty+"");
		ps2.setString(3,pr+"");
		ps2.executeUpdate();
	}

	// Print out order summary
	out.println("<h1> Your Order Summary</h1>");
	Double total = 0.0;
	iterator = productList.entrySet().iterator();
	out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th></tr>");
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");

		out.print("<td align=\"center\">"+product.get(3)+"</td>");
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");
	out.println("<h1> Order Completed. Will be shipped soon...</h1>");
	out.println("<h1> Your order reference number is "+orderId+"</h1>");
	out.println("<h1> Shipping to Customer "+custId+" Name: "+customerName+"</h1>");
	out.println("<h2><a href=\"index.jsp\">Return to Shopping</a></h2>");
}
catch(SQLException a){
	out.print(a);
}catch(Exception b){
	out.print(b);
}
finally{
	// Clear cart if order placed successfully
	if(indicator == 0)
		session.setAttribute("productList", new HashMap<String, ArrayList<Object>>());
}
%>
</BODY>
</HTML>

