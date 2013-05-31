<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %>

<% 
	/* Create string of connection url within specified format with machine name, 
	port number and database name. Here machine name id localhost and 
	database name is usermaster. */ 
	String connectionURL = "jdbc:mysql://localhost:3306/CBSA"; 
	
	// declare a connection by using Connection interface 
	Connection connection = null; 
	
	// Load JBBC driver "com.mysql.jdbc.Driver" 
	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
		
	try {
		/* Create a connection by using getConnection() method that takes parameters of 
		string type connection url, user name and password to connect to database. */ 
		connection = DriverManager.getConnection(connectionURL, "root", "");
		
		// check weather connection is established or not by isClosed() method 
		if(connection.isClosed())
		{
			throw new Exception();
		}
	}
	catch(Exception ex)
	{
		out.println("Unable to connect to database. </br>" + ex.getMessage());
	}
		
	// set all isDefault values to 0
	String delete = null;
	PreparedStatement statement = null;
	
	// set all selected isDefault values to 1
	String[] checks = request.getParameterValues("checks");
	String redirectURL = "../ScalabilityModels.jsp?message=Selected models were successfully deleted.";
	boolean first = true;
	if(checks != null)
	{ 
		for (int i = 0; i < checks.length; i++) 
	   	{
			try
			{
				delete = "DELETE from `cbsa`.`scalabilitymodel` WHERE `scalabilitymodel`.`Name` = '" + checks[i] + "' AND `scalabilitymodel`.`Status` = '(stopped)' AND `scalabilitymodel`.`Type` = 'User Defined'";
				statement = connection.prepareStatement(delete);
				statement.executeUpdate();
				if(statement.getUpdateCount() == 0)
				{
					if(first)
					{
						redirectURL = "../ScalabilityModels.jsp?message=A selected model could not be deleted. See Error messages below. </br>";
						first = false;
					}
					redirectURL += "'" + checks[i] + "' model could not be deleted. It is a system defined model or it is currently in use. <br/> ";
				}
				
				String deletemetric = "DELETE from `cbsa`.`scalabilitymetric` WHERE `scalabilitymetric`.`Name` = '" + checks[i] + "' AND `scalabilitymetric`.`Type` = 'Model Defined'";
				PreparedStatement statement2 = connection.prepareStatement(deletemetric);
				statement2.executeUpdate();
				statement2.close();
				
				statement.close();
			}
			catch(Exception ex)
			{
				out.println("Error: Can't Delete the Metric");
			}
	  	}
	}
	else if(request.getParameter("Name") != null)
	{
		redirectURL = "../ScalabilityModels.jsp?message=Selected model was successfully deleted.";
		try
		{
			delete = "DELETE from `cbsa`.`scalabilitymodel` WHERE `scalabilitymodel`.`Name` = '" + request.getParameter("Name") + "' AND `scalabilitymodel`.`Status` = '(stopped)' AND `scalabilitymodel`.`Type` = 'User Defined'";
			statement = connection.prepareStatement(delete);
			statement.executeUpdate();
			
			if(statement.getUpdateCount() == 0)
			{
				redirectURL = "DisplayModel.jsp?Name=" + request.getParameter("Name") + "&message=This model could not be deleted. It is a system defined model or it is currently in use.";
			}
			statement.close();
			
			String deletemetric = "DELETE from `cbsa`.`scalabilitymetric` WHERE `scalabilitymetric`.`Name` = '" + request.getParameter("Name") + "' AND `scalabilitymetric`.`Type` = 'Model Defined'";
			PreparedStatement statement2 = connection.prepareStatement(deletemetric);
			statement2.executeUpdate();
			statement2.close();
					
		}
		catch(Exception ex)
		{
			redirectURL = "DisplayModel.jsp?Name=" + request.getParameter("Name") + "&message=This model could not be deleted. It is currently in use.";
		}
	}
	else
	{
		redirectURL = "../ScalabilityModels.jsp?message=You did not select any models.";
	}
	
	if(statement != null)
	{
		statement.close();
	}
	if(connection != null)
	{
		connection.close();
	}

	response.sendRedirect(redirectURL);

%>
