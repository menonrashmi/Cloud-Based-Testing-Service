<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>Test Project</title>
		
		<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/dojo/1.6/dijit/themes/claro/claro.css" />
       	<link rel="stylesheet" type="text/css" href="style/main.css" />
        
        <script src="http://ajax.googleapis.com/ajax/libs/dojo/1.6.1/dojo/dojo.xd.js" djConfig="parseOnLoad: true"></script>
        <script type="text/javascript">
			dojo.require('dijit.form');
			dojo.require('dijit.form.Button');
        </script>
        
		        
		
		
			<table class="testprojects">
				<tbody>
					<tr>
						<th>TestProjectId</th>
						<th>TesterID</th>
						<th>Project Name</th>
						<th>Project Date</th>
						<th>Description</th>
						<th>Product Name</th>
                        <th>Product Version</th>
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
					resultset = statement.executeQuery("Select * from testprojects");
					while (resultset.next())
					{
			%>
			
	
					<tr>
						<td> <input type="checkBox" name="selectAll"> </td>
						<td> <%= resultset.getString("TestProjectId") %></td>
						<td> <%= resultset.getString("TesterID") %></td>
						<td> <%= resultset.getString("Project Name") %></td>
						<td> <%= resultset.getString("Project Date") %></td>
						<td> <%= resultset.getString("Description") %></td>
						<td> <%= resultset.getString("Product Name") %></td>
						<td> <%= resultset.getString("Product Version") %></td>


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