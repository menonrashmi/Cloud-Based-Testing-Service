<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<!DOCTYPE html">
<html>
	<% 
		try {
			/* Create string of connection url within specified format with machine name, 
			port number and database name. Here machine name id localhost and 
			database name is usermaster. */ 
			String connectionURL = "jdbc:mysql://localhost:3306/CBSA"; 
			
			// declare a connection by using Connection interface 
			Connection connection = null; 
			Statement statement = null;
			ResultSet resultset = null;
			
			// Load JBBC driver "com.mysql.jdbc.Driver" 
			Class.forName("com.mysql.jdbc.Driver").newInstance(); 
			
			/* Create a connection by using getConnection() method that takes parameters of 
			string type connection url, user name and password to connect to database. */ 
			connection = DriverManager.getConnection(connectionURL, "root", "");
			
			// check weather connection is established or not by isClosed() method 
			if(connection.isClosed())
			{
				throw new Exception();
			}
			
			statement = connection.createStatement();
			resultset = statement.executeQuery("Select * from UserAccount where UserID=1");
			if(resultset.next())
			{
	%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>Edit Email</title>
		
		<link rel="stylesheet" type="text/css" href="/cbsatesting/WebContent/style/main.css" />
		<link rel="stylesheet" type="text/css" href="/cbsatesting/WebContent/script/dijit/themes/claro/claro.css" />
        
		<script src="/cbsatesting/WebContent/script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
        <script type="text/javascript">
		   dojo.require("dojox.charting.widget.SelectableLegend");
		</script>
	</head>
	<body class="claro">
	
		<p> <a href="UserProfile.jsp"> User Profile</a> > <a href="MyProfile.jsp"> My Profile </a> > <a href="AccountSettings.jsp"> Account Settings </a> > Edit Primary Email</p>
				
		<h2>Edit Primary Email</h2>
		
		<form name="changeEmail" id="changeEmail" action="action/changeEmail.jsp" method="post">
			<table class="personalinfo">
				<tbody>
					<tr>
						<td> UserName:  </td>
						<td> <%= resultset.getString("UserName") %>
							<input type="hidden" name="username" id="username" value="<%=resultset.getString("UserName")%>"/> </td>
					</tr>
					<tr>
						<td> New Email: </td>
						<td> <input type="email" name="newEmail" id="newEmail" /> </td>
					</tr>
					<tr>
						<td> </td>
						<td>
							<button dojoType="dijit.form.Button" type="submit" name="changeEmail" id="changeEmail" value="changeEmail"> Change Email </button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<%
				}
				resultset.close();
				statement.close();
				connection.close();
			}
			catch(Exception ex)
			{
				out.println("Unable to connect to database. </br>" + ex.getMessage());
			}
		%>
	</body>
</html>