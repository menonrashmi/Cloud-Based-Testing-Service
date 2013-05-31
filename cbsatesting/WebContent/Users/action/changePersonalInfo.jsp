<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<% 
	String message = "";
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
		
		if(request.getParameter("firstname").equals("") || request.getParameter("lastname").equals("") || request.getParameter("username").equals(""))
		{
			message = "Values cannot be blank.";
			throw new Exception();
		}
		
		String changePassword = "UPDATE useraccount SET FirstName ='" + request.getParameter("firstname")
					+ "' ,  LastName ='" + request.getParameter("lastname")
					+ "', UserName ='" + request.getParameter("username")
					+ "' WHERE UserID='" + request.getParameter("userid") +"'";
		Statement changePasswordStatement = connection.createStatement();
		changePasswordStatement.executeUpdate(changePassword);
		
		if(changePasswordStatement.getUpdateCount() == 1)
			message = "Your personal information was succesfully changed.";
		else
			message = "Your personal information could not not be changed.";
		
		changePasswordStatement.close();
	}
	catch(Exception ex)
	{
		if(!message.equals("Values cannot be blank."))
			message = "Unable to connect to database.";
		out.println("Unable to connect to database. </br>" + ex.getMessage());
	}
	finally {
		if (connection != null) {
			try {
				connection.close();
			} catch (Exception e) {
			}
		}
	}
	
	String redirectURL = "../PersonalInformation.jsp?message=" + message;
	response.sendRedirect(redirectURL);
%>
