<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>Login Page</title>
		
		<link rel="stylesheet" type="text/css" href="/cbsatesting/WebContent/style/main.css" />
        
        <script src="/cbsatesting/WebContent/script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
        <script type="text/javascript">
	        dojo.require("dijit.form.TextBox");
	        dojo.require("dijit.form.Button");
		   	dojo.require("dojox.charting.widget.SelectableLegend");
		</script>
	</head>
	
	<body class="claro">
		
		<h2>User Login</h2>
		
		<%
		   if (request.getParameter("message") != null) 
		   {
				out.print("<p id='message'> > Message: " + request.getParameter("message") + "</p>");
		   }
		%>
		
		<form name="login" id="login" action="action/Login.jsp" method="post">
			<table class="login">
				<tbody>
					<tr>
						<td> Username:  </td>
						<td> 
							<input type="text" dojoType="dijit.form.TextBox" id="username" name="username">
						</td>
					</tr>
					<tr>
						<td> Password:  </td>
						<td>
							<input type="password" dojoType="dijit.form.TextBox" id="password" name="password">
						</td>
					</tr>
					<tr>
					<tr>
						<td>  </td>
						<td>
							<button type="submit" value="Login"> Login </button>
						</td>
					</tr>
					<tr>
				</tbody>
			</table>
		</form>
	</body>
</html>