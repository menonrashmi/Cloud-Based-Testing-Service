<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>User Management</title>
		
			<link rel="stylesheet" type="text/css" href="/cbsatesting/WebContent/style/main.css" />
		<link rel="stylesheet" type="text/css" href="/cbsatesting/WebContent/script/dijit/themes/claro/claro.css" />
        
        <script type="text/javascript" src="UserManagement.js"></script>
        <script src="/cbsatesting/WebContent/script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
        <script type="text/javascript">
		   dojo.require("dojox.charting.widget.SelectableLegend");
		</script>
	</head>
	
	<body class="claro">
		<p> <a href="UserProfile.jsp"> User Profile</a> > User Management</p>
		
		<h2>User Accounts</h2>
		
		<%
		   if (request.getParameter("message") != null) 
		   {
				out.print("<p id='message'> > Message: " + request.getParameter("message") + "</p>");
		   }
		%>
		
		<form name="users" id="users" method="post">
			<span id="userManagement">
				<button dojoType="dijit.form.Button" name="Create Account" onClick="createAccount(event)">Create Account</button>
				<button dojoType="dijit.form.Button" name="Delete Selected" onClick="deleteUsers(event)">Delete</button>
			</span>

			<br/>
			<br/>
			
			<table class="graytable">
				<tbody>
					<tr>
						<th>Select <br/> <input type="checkbox" name="selectAll" onChange="checkAllBoxes(this.checked)" value=""> </th>
						<th>Username</th>
						<th>First Name</th>
						<th>Last Name</th>
						<th>Primary Email</th>
						<th>Account Type</th>
					</tr>
		
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
					resultset = statement.executeQuery("Select * from UserAccount");
					while (resultset.next())
					{
			%>
			
	
					<tr>
						<td> <input type="checkbox" name="checks" value="<%= resultset.getString("UserName")%>"> </td>
						<td><a href="#" onClick="displayUser('<%= resultset.getString("UserName") %>')"> <%= resultset.getString("UserName") %> </a> </td>
						<td> <%= resultset.getString("FirstName") %></td>
						<td> <%= resultset.getString("LastName") %></td>
						<td> <%= resultset.getString("PrimaryEmail") %></td>
						<td> <%= resultset.getString("AccountType") %></td>
					</tr>
					
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
			
				</tbody>
			</table>
		</form>
	</body>
</html>