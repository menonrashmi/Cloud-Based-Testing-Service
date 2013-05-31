<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %>

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
		
		
		// deletes any metrics that exist by the given name
		String delete = "DELETE from `cbsa`.`scalabilitymetric` WHERE `scalabilitymetric`.`Name` = '" + request.getParameter("name").replaceAll(" ", "") + "' AND `scalabilitymetric`.`Equation` <> 'System Defined' AND `scalabilitymetric`.`Equation` <> 'Based on a Model'";
		PreparedStatement removeDups = connection.prepareStatement(delete);
		removeDups.executeUpdate();
		
		
		String equation = request.getParameter("coefficient1") + " * ";
		
		String checkMetric1 = "Select * from scalabilitymetric where name = '" + request.getParameter("metric1") + "'";
		PreparedStatement checkStatement1 = connection.prepareStatement(checkMetric1);
		ResultSet result1 = checkStatement1.executeQuery();
		if(result1.next())
		{
			if(result1.getString("Type").equals("System Defined"))
				equation += request.getParameter("metric1") + " : " + request.getParameter("statistic1");
			else
				equation += request.getParameter("metric1") + " : " + "None";
		}
		else
		{
			message = "The first metric could not be found in the database.";
			throw new Exception();
		}
		
		equation += " " + request.getParameter("operation") + " " + request.getParameter("coefficient2") + " * ";
		
		String checkMetric2 = "Select * from scalabilitymetric where name = '" + request.getParameter("metric2") + "'";
		PreparedStatement checkStatement2 = connection.prepareStatement(checkMetric2);
		ResultSet result2 = checkStatement2.executeQuery();
		if(result2.next())
		{
			if(result2.getString("Type").equals("System Defined"))
				equation += request.getParameter("metric2") + " : " + request.getParameter("statistic2");
			else
				equation += request.getParameter("metric2") + " : " + "None";
		}
		else
		{
			message = "The second metric could not be found in the database.";
			throw new Exception();
		}
		

		String insert = "INSERT INTO  `scalabilitymetric` (  `MetricID` ,  `isDefault` ,  `Name` ,  `Statistic` ,  `Description` ,  `Equation` ,  `Type` )" 
				+ " VALUES ( NULL ,  '0',  '" + request.getParameter("name").replaceAll(" ", "") + "', 'None',  '" + request.getParameter("description") + "',  '" + equation + "',  'User Defined' )";
		PreparedStatement statement = connection.prepareStatement(insert);
		statement.executeUpdate();
		
		if(statement.getUpdateCount() == 1)
		{
			message = "The metric was successfully created.";
		}
		
		statement.close();
		
	}
	catch(Exception ex)
	{
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
	
	String redirectURL = "../ScalabilityMetrics.jsp?message=" + message;
	response.sendRedirect(redirectURL);
%>
