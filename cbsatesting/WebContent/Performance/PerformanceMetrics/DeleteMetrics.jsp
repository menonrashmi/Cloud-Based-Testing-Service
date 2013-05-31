<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %>

<% 
	String redirectURL = "../PerformanceMetrics.jsp?message=Selected metrics were successfully deleted.";
	
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
		redirectURL = "../PerformanceMetrics.jsp?message=Unable to connect to database.";
		out.println("Unable to connect to database. </br>" + ex.getMessage());
	}
		
	// set all isDefault values to 0
	String delete = null;
	PreparedStatement statement = null;
	
	// set all selected isDefault values to 1
	String[] checks = request.getParameterValues("checks");
	
	boolean first = true;
	if(checks != null)
	{ 
		for (int i = 0; i < checks.length; i++) 
	   	{
			try
			{
				String[] checksValue = checks[i].split(":");
				delete = "DELETE from `cbsa`.`performancemetric` WHERE `performancemetric`.`Name` = '" + checksValue[0] + "' AND `performancemetric`.`Equation` <> 'System Defined' AND `performancemetric`.`Equation` <> 'Based on a Model'";
				statement = connection.prepareStatement(delete);
				statement.executeUpdate();
				if(statement.getUpdateCount() == 0)
				{
					if(first)
					{
						redirectURL = "../PerformanceMetrics.jsp?message=A selected metrics could not be deleted. See Error messages below. </br>";
						first = false;
					}
					redirectURL += "'" + checks[i] + "' metric could not be deleted. It is a System Defined value or it is part of another Metric or Model. <br/> ";
				}
						
			}
			catch(Exception ex)
			{
				if(first)
				{
					redirectURL = "../PerformanceMetrics.jsp?message=A selected metrics could not be deleted. See Error messages below. </br>";
					first = false;
				}
				redirectURL += "'" + checks[i] + "' metric could not be deleted. It is being used in a model. <br/> ";
			}
			
			out.println("--" + delete + "</br>");
			out.println(redirectURL + "<br />");
			statement.close();
	  	}
	}
	else if(request.getParameter("Name") != null)
	{
		redirectURL = "../PerformanceMetrics.jsp?message=Selected metrics were successfully deleted.";
		try
		{
			delete = "DELETE from `cbsa`.`performancemetric` WHERE `performancemetric`.`Name` = '" + request.getParameter("Name") + "' AND `performancemetric`.`Equation` <> 'System Defined' AND `performancemetric`.`Equation` <> 'Based on a Model'";
			statement = connection.prepareStatement(delete);
			statement.executeUpdate();
			
			if(statement.getUpdateCount() == 0)
			{
				redirectURL = "DisplayMetric.jsp?Name=" + request.getParameter("Name") + "&Statistic=" + request.getParameter("Statistic") + "&message=This metric could not be deleted. It is a System Defined value or part of a Model.";
			}
					
		}
		catch(Exception ex)
		{
			redirectURL = "DisplayMetric.jsp?Name=" + request.getParameter("Name") + "&Statistic=" + request.getParameter("Statistic") + "&message=This metric could not be deleted. It is being used in a Model.";
		}
	}
	else
	{
		redirectURL = "../PerformanceMetrics.jsp?message=You did not select any metrics.";
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
