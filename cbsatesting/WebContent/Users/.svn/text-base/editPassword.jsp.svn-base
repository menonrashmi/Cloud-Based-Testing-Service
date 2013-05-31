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
		
		<title>Edit Password</title>
		
		<link rel="stylesheet" type="text/css" href="/cbsatesting/WebContent/style/main.css" />
		<link rel="stylesheet" type="text/css" href="/cbsatesting/WebContent/script/dijit/themes/claro/claro.css" />
        
		<script src="/cbsatesting/WebContent/script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
        <script type="text/javascript">
		   dojo.require("dojox.charting.widget.SelectableLegend");
		   
		   function validate(event)
		   {
				// Not Secure way to Check oldpassword. Go back to the database to check the current password.
			   if(document.getElementById("oldPassword").value == "<%=resultset.getString("Password")%>")
			   {
				   if(document.getElementById("newPassword").value == document.getElementById("confirm").value)
				   {
					   	document.getElementById("createPassword").action = "action/changePassword.jsp";
						document.getElementById("createPassword").submit();
				   }
				   else
					   alert("Passwords do not Match.");
			   }
			   else 
				   alert("Invalid password.");
		   }
		</script>
	</head>
	<body class="claro">
	
		<p> <a href="UserProfile.jsp"> User Profile</a> > <a href="MyProfile.jsp"> My Profile </a> > <a href="AccountSettings.jsp"> Account Settings </a> > Recover Password</p>
				
		<h2>Edit Password</h2>
		
		<form name="createPassword" id="createPassword" method="post">
			<table class="password">
				<tbody>
					<tr>
						<td> Email Addresses:  </td>
						<td> <%= resultset.getString("PrimaryEmail") %> <span style="color:grey"> (Primary Email) </span> 
							<input type="hidden" name="email" id="email" value="<%=resultset.getString("PrimaryEmail")%>"/> </td>
					</tr>
					<tr>
						<td> Old Password:  </td>
						<td> <input type="password" name="oldPassword" id="oldPassword"/> </td>
					</tr>
					<tr>
						<td> New Password:  </td>
						<td> <input type="password" name="newPassword" id="newPassword"/> </td>
					</tr>
					<tr>
						<td> Confirm Password:  </td>
						<td> <input type="password" name="confirm" id="confirm"/> </td>
					</tr>
					<tr>
						<td> </td>
						<td>
							<button dojoType="dijit.form.Button" value="changePassword" onClick="validate(event)"> Change Password </button>
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