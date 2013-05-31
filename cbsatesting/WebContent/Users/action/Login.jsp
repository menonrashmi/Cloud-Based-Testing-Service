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
		
		if(request.getParameter("username").equals("") || request.getParameter("password").equals(""))
		{
			message = "Some requried fields were left blank. Try again.";
			throw new Exception();
		}
		
		String getUser = "SELECT UserName, Password FROM useraccount WHERE UserName='" + request.getParameter("username") +"'";
		Statement getUserStatement = connection.createStatement();
		ResultSet results = getUserStatement.executeQuery(getUser);
		
		if(results.next() && results.getString("Password").equals(request.getParameter("password")))
		{
			String redirectURL = "/cbsatesting/WebContent/MainPage.html";
			response.sendRedirect(redirectURL);
		}
		else
			message = "Invalid username and password.";
		
		
		getUserStatement.close();
	}
	catch(Exception ex)
	{
		if(!message.equals("Some requried fields were left blank. Try again."))
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
	
	String redirectURL = "../LoginPage.jsp?message=" + message;
	response.sendRedirect(redirectURL);
%>
