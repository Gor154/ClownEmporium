<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>

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

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Please Login to System</h3>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="10"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>

</div>

</body>
</html>

