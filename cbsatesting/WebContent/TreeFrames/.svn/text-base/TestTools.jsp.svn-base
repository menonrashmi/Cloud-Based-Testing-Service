<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>Test Tools</title>
		<link rel='stylesheet' type='text/css' href='../WebContent/style/main.css'  />
		
        
	</head>
	<h2>Test Tools</h2>
		<table class="blueTable">
				<tbody>
					<tr>
					<th>Tool ID</th>
					<th>Tool Name</th>
						<th>Project Name</th>
						<th>Project Description</th>
						<th>Tool Type</th>
						
					</tr>
	
		
		

			
		
			<% 
				try {
					/* Create string of connection url within specified format with machine name, 
					port number and database name. Here machine name id localhost and 
					database name is usermaster. */ 
					String connectionURL = "jdbc:mysql://localhost:3306/test"; 
					
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
					
					resultset = statement.executeQuery("Select `ToolId`,`ToolName`,`project_name`,`project_desc`, `tool_type`  from amazon_instance.testtool ");
					while (resultset.next())
					{
			%>
			
				<tr>
				<td> <%= resultset.getString("ToolID") %></td>
						<td> <%= resultset.getString("ToolName") %></td>
						<td> <%= resultset.getString("project_name") %></td>
					<td> <%= resultset.getString("project_desc") %></td>
						
						<td> <%= resultset.getString("tool_type") %></td>
						
					
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