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
	String redirectURL = "../UserManagement.jsp?message=Selected users were successfully deleted.";
	boolean first = true;
	if(checks != null)
	{ 
		for (int i = 0; i < checks.length; i++) 
	   	{
			try
			{
				delete = "DELETE from `cbsa`.`useraccount` WHERE `useraccount`.`UserName` = '" + checks[i] + "'";
				statement = connection.prepareStatement(delete);
				statement.executeUpdate();
				if(statement.getUpdateCount() == 0)
				{
					if(first)
					{
						redirectURL = "../UserManagement.jsp?message=A user could not be deleted. See Error messages below. </br>";
						first = false;
					}
					redirectURL += "'" + checks[i] + "' could not be deleted. <br/> ";
				}
				
				statement.close();
			}
			catch(Exception ex)
			{
				out.println("Error: Can't Delete the User");
			}
	  	}
	}
	else
	{
		redirectURL = "../UserManagement.jsp?message=You did not select any users.";
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
