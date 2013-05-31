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
		
		//out.println("able to connect to database MNJ");
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
			//out.println("going to update performance metric table MNJ");
			// set all isDefault values to 0
			String update = "UPDATE  `performancemetric` SET  `isDefault` =  '0'";
			statement = connection.prepareStatement(update);
			statement.executeUpdate();
			
			for (int i = 0; i < checks.length; i++) 
		   	{
				String[] checksValue = checks[i].split(":");
				update = "UPDATE  `performancemetric` SET  `isDefault` =  '1' WHERE `performancemetric`.`Name` = '" + checksValue[0] + "' AND `performancemetric`.`Statistic` = '" + checksValue[1] + "'";
				statement = connection.prepareStatement(update);
				statement.executeUpdate();
		  	}
			
			statement.close();
			
			//out.println("redirecting to performance metrics.jsp page MNJ");
			
			redirectURL = "../PerformanceMetrics.jsp?message=Default Values were successfully changed.";
		}
		else if(request.getParameter("Name") != null)
		{
			String update = "UPDATE  `performancemetric` SET  `isDefault` =  '1' WHERE `performancemetric`.`Name` = '" + request.getParameter("Name") + "' AND `performancemetric`.`Statistic` = '" + request.getParameter("Statistic") + "'";
			statement = connection.prepareStatement(update);
			statement.executeUpdate();
			
			if(statement.getUpdateCount() == 1)
				redirectURL = "DisplayMetric.jsp?Name=" + request.getParameter("Name") + "&Statistic=" + request.getParameter("Statistic") + "&message=This metric was successfully set as a defualt.";
			else
				redirectURL = "DisplayMetric.jsp?Name=" + request.getParameter("Name") + "&Statistic=" + request.getParameter("Statistic") + "&message=An Error Occurred. This metric could not be set as a default.";
			
			statement.close();
		}
		else
		{
			redirectURL = "../PerformanceMetrics.jsp?message=No Default values were choosen.";
		}
		
		connection.close();
		
		response.sendRedirect(redirectURL);
	}
	catch(Exception ex)
	{
		redirectURL = "../PerformanceMetrics.jsp?message=Unable to connect to database.";
		out.println("Unable to connect to database. </br>" + ex.getMessage());
	}	
%>
