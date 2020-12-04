<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" session="false"%>
<!DOCTYPE html>
<html>
<head>
        <title>Ray's Grocery Main Page</title>

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
                                        <a class="nav-link" href="index.jsp"><strong>Home</strong></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="login.jsp">Login</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="logout.jsp">Logout</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="createUser.jsp">Create New Account</a>
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
                <h1 align="center">Welcome to Ray's Grocery</h1>

                <h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

                <h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

                <h2 align="center"><a href="customer.jsp">Customer Info</a></h2>
</body>
</html>

