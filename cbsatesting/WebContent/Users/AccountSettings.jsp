<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="/cbsatesting/WebContent/style/main.css" />
		<title>Account Settings</title>
	</head>
	<body>
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
		
		<p> <a href="UserProfile.jsp"> User Profile</a> > <a href="MyProfile.jsp"> My Profile </a> > Account Settings</p>
		
		<h2>My Profile</h2>
		
		<%
		   if (request.getParameter("message") != null) 
		   {
				out.print("<p id='message'> > Message: " + request.getParameter("message") + "</p>");
		   }
		%>
		

		<h3>Account Settings</h3>
		<hr>
		<table class="userinfo">
			<tbody>
				<tr>
					<td> Email Addresses:  </td>
					<td> <%= resultset.getString("PrimaryEmail") %> <span style="color:grey"> (Primary Email) -</span> <span> <a href="editEmail.jsp?Username='<%=resultset.getString("UserName")%>'"> Edit </a></span>
						</br> <a href="addEmail.jsp"> Add a new email account</a>
					</td>
				</tr>
				<tr>
					<td> Security:  </td>
					<td> <a href="editPassword.jsp?Username='<%=resultset.getString("UserName")%>'"> Change your password </a>
						</br> <a href="createPassword.jsp"> Recovering your password </a>
					</td>
				</tr>
				<tr>
					<td> Account Type:  </td>
					<td> <%= resultset.getString("AccountType") %></td>
				</tr>
			</tbody>
		</table>

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