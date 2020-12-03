<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<html>
<head>
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	final String url = "jdbc:sqlserver://clownemporium.database.windows.net:1433;database=ClownStuff;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;;loginTimeout=30;";
	final String uid = "gor154@clownemporium";
	final String pw = "dydvak-godpY8-horbag";
	// TODO: Get order id
	String orderId = request.getParameter("orderId");
          
	// TODO: Check if valid order id
	try(Connection conn = DriverManager.getConnection(url, uid, pw);
PreparedStatement pst = conn.prepareStatement("SELECT * FROM ordersummary WHERE orderId=?")){
	try{
		if(orderId != null){
			pst.setString(1,orderId);
			ResultSet rs = pst.executeQuery();
			if(!rs.next()){
			out.println("<h1 style=\"color: red\">Invalid Order ID</h1>");
			}
		}
		else{
			out.println("<h1 style=\"color: red\">No Order ID</h1>");
		}
	}
	catch(Exception b){
		out.print(b);
	}
	}
	catch(SQLException a){
	out.print(a);
	}catch(Exception b){
	out.print(b);
	}
	// TODO: Start a transaction (turn-off auto-commit)
	Connection conn = DriverManager.getConnection(url, uid, pw);
	try(PreparedStatement pst = conn.prepareStatement("SELECT * FROM ordersummary JOIN orderproduct ON ordersummary.orderId=orderproduct.orderId WHERE ordersummary.orderId=?")){
	pst.setString(1,orderId);
	conn.setAutoCommit(false);
	// TODO: Retrieve all items in order with given id
	ResultSet rs = pst.executeQuery();
	// TODO: Create a new shipment record.
	PreparedStatement prst = conn.prepareStatement("INSERT INTO shipment (shipmentDate,warehouseId) VALUES (?,1)");
	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
	LocalDateTime now = LocalDateTime.now();   //Get current date
	prst.setString(1,dtf.format(now));
	prst.executeUpdate();
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	int indicator = 0;
	prst = conn.prepareStatement("SELECT * FROM productinventory WHERE warehouseId=1 AND productId=?");
	PreparedStatement ps = conn.prepareStatement("UPDATE productinventory SET quantity=quantity-? WHERE productId=?");
	while(rs.next()){
		prst.setString(1,rs.getString("productId"));
		ps.setString(1,rs.getString("quantity"));
		ps.setString(2,rs.getString("productId"));
		ResultSet prodInvRs = prst.executeQuery();
		prodInvRs.next();
		if(Integer.parseInt(prodInvRs.getString("quantity")) < Integer.parseInt(rs.getString("quantity"))){
			conn.rollback();
			out.println("<h1> Shipment not done. Insufficient inventory for product id: "+rs.getString("productId")+"</h1><br>");
			indicator = 1;
			break;
		}
		else{
			out.println("<h1>Ordered Prodcut: " +rs.getString("productId")+" Qty: "+rs.getString("quantity")+" Previous Inventory: "+prodInvRs.getString("quantity")+" New Inventory: "+(Integer.parseInt(prodInvRs.getString("quantity"))-Integer.parseInt(rs.getString("quantity")))+"</h1><br>");
			ps.executeUpdate();
		}
	}
	if(indicator == 0){
		out.println("<br><br><h1>Shipment succesfully processed</h1>");
	}
	// TODO: Auto-commit should be turned back on
	conn.setAutoCommit(true);
}
catch(SQLException a){
	out.print(a);
	conn.rollback();
}
catch(Exception b){
	out.print(b);
	conn.rollback();
}
finally{
	conn.close();
}
%>                       				

<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>
