<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %>

<% 
	String redirectURL = "";

	try {
		/* Create string of connection url within specified format with machine name, 
		port number and database name. Here machine name id localhost and 
		database name is usermaster. */ 
		String connectionURL = "jdbc:mysql://localhost:3306/CBSA"; 
		
		// declare a connection by using Connection interface 
		Connection connection = null; 
		
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
		
		PreparedStatement statement = null;
		
		// set all selected isDefault values to 1
		String[] checks = request.getParameterValues("checks");
		if(checks != null)
		{ 
			// set all isDefault values to 0
			String update = "UPDATE  `scalabilitymodel` SET  `isDefault` =  '0'";
			statement = connection.prepareStatement(update);
			statement.executeUpdate();
			
			update = "UPDATE  `scalabilitymodel` SET  `isDefault` =  '1' WHERE `scalabilitymodel`.`Name` = '" + checks[0] + "'";
			statement = connection.prepareStatement(update);
			statement.executeUpdate();
			
			redirectURL = "../ScalabilityModels.jsp?message=Default value was sucessfully changed.";
			
			if(checks.length > 1)
			{
				redirectURL = "../ScalabilityModels.jsp?message=You choose more than one model. Default was set to the first choice in the list.";
			}
			
			
			statement.close();
		}
		else if(request.getParameter("Name") != null)
		{
			String update = "UPDATE  `scalabilitymodel` SET  `isDefault` =  '0'";
			statement = connection.prepareStatement(update);
			statement.executeUpdate();
			
			update = "UPDATE  `scalabilitymodel` SET  `isDefault` =  '1' WHERE `scalabilitymodel`.`Name` = '" + request.getParameter("Name") + "'";
			statement = connection.prepareStatement(update);
			statement.executeUpdate();
			
			if(statement.getUpdateCount() == 1)
				redirectURL = "DisplayModel.jsp?Name=" + request.getParameter("Name") + "&message=This model was successfully set as defualt.";
			else
				redirectURL = "DisplayModel.jsp?Name=" + request.getParameter("Name") + "&message=An Error Occurred. This model could not be set as a default.";
			
			statement.close();
		}
		else
		{
			redirectURL = "../ScalabilityModels.jsp?message=No Default values were choosen.";
		}

		connection.close();
		
		response.sendRedirect(redirectURL);
	}
	catch(Exception ex)
	{
		redirectURL = "../ScalabilityModels.jsp?message=Unable to connect to database.";
		out.println("Unable to connect to database. </br>" + ex.getMessage());
	}

	
%>
