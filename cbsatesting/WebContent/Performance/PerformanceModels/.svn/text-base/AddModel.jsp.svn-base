<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %>

<% 
	String redirectURL = "../PerformanceModels.jsp";
	if(request.getParameter("name").equals(""))
	{
		redirectURL = "CreateModel.jsp?message=" + "Your model could not be created. Enter a name for the Model.";
	}
	else
	{
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
			
			// remove duplicates
			String delete = "DELETE from `cbsa`.`performancemodel` WHERE `performancemodel`.`Name` = '" + request.getParameter("name").replaceAll(" ", "") + "' AND `performancemodel`.`Type` <> 'System Defined'";
			PreparedStatement removeDups = connection.prepareStatement(delete);
			removeDups.executeUpdate();
			
			// insert model info
			String insertModel = "INSERT INTO  `performancemodel` (  `ModelID` ,  `isDefault` ,  `Name` ,  `Description` ,  `NumMetrics` ,  `Type` ,  `Status` ,  `value` )" 
					+ " VALUES ( NULL ,  '0',  '" + request.getParameter("name").replaceAll(" ", "") + "', '" + request.getParameter("description") + "',  '" + request.getParameter("numMetrics") + "',  'User Defined', '(stopped)', 0)";
			PreparedStatement statement = connection.prepareStatement(insertModel);
			statement.executeUpdate();
			statement.close();
			
			
			String insertedModel = "SELECT ModelID FROM performancemodel WHERE Name = '" + request.getParameter("name").replaceAll(" ", "") + "'";
			PreparedStatement statementresult = connection.prepareStatement(insertedModel);
			ResultSet resultsetmodel = statementresult.executeQuery();
			if(resultsetmodel.next())
			{
				int modelId = resultsetmodel.getInt("ModelID");		
				boolean ok = true;
				for(int i = 1; i <= Integer.parseInt(request.getParameter("numMetrics")); i++)
				{
					// check if metric is userdefined
					String checkUserDef = "SELECT distinct Name FROM performancemetric WHERE Name = '" + request.getParameter("type" + i) + "' AND Type = 'System Defined'";
					PreparedStatement checkUserDefStatment = connection.prepareStatement(checkUserDef);
					ResultSet resultsetUserDef = checkUserDefStatment.executeQuery();
					
					// get Metric id
					String getMetricId = "";
					if(resultsetUserDef.next())
						getMetricId = "SELECT MetricID FROM performancemetric WHERE Name = '" + request.getParameter("type" + i) + "' AND Statistic = '" + request.getParameter("statistic" + i) + "'";
					else
						getMetricId = "SELECT MetricID FROM performancemetric WHERE Name = '" + request.getParameter("type" + i) + "' AND Statistic = 'None'";
					
					PreparedStatement statement2 = connection.prepareStatement(getMetricId);
					ResultSet resultsetmetric = statement2.executeQuery();
					if(resultsetmetric.next())
					{	
						int metricId = resultsetmetric.getInt("MetricID");
						// add to modelmetric
						String insertModelMetric = "INSERT INTO  `performancemodelmetric` (  `ModelID` ,  `MetricID` , `ModelMetric`)" 
								+ " VALUES ( " + modelId + " , " + metricId + " , 0)";
						PreparedStatement statement3 = connection.prepareStatement(insertModelMetric);
						statement3.executeUpdate();
						if(statement3.getUpdateCount() != 1)
							ok = false;
						
						statement3.close();
					}
					else
						ok = false;
					
					resultsetmetric.close();
					statement2.close();
				}
				
				// add model's metric
				String insertMetric = "INSERT INTO  `performancemetric` (  `MetricID` ,  `isDefault` ,  `Name` ,  `Statistic` ,  `Description` ,  `Equation` ,  `Type` )" 
						+ " VALUES ( NULL ,  '0',  '" + request.getParameter("name").replaceAll(" ", "") + "', 'None',  '" + request.getParameter("description") + "',  'Based on a Model',  'Model Defined' )";
				PreparedStatement statement4 = connection.prepareStatement(insertMetric);
				statement4.executeUpdate();
				statement4.close();
				
				String insertedMetric = "SELECT MetricID FROM performancemetric WHERE Name = '" + request.getParameter("name").replaceAll(" ", "") + "'";
				PreparedStatement statement4result = connection.prepareStatement(insertedMetric);
				ResultSet resultsetmetric = statement4result.executeQuery();
				if(resultsetmetric.next())
				{
					int metricId = resultsetmetric.getInt("MetricID");

					// add to model's metric to modelmetric
					String insertModelMetric = "INSERT INTO  `performancemodelmetric` (  `ModelID` ,  `MetricID` , `ModelMetric`)" 
							+ " VALUES ( " + modelId + " , " + metricId + " , '1' )";
					PreparedStatement statement3 = connection.prepareStatement(insertModelMetric);
					statement3.executeUpdate();
					
					if(statement3.getUpdateCount() != 1)
						ok = false;
					
					statement3.close();

				}
				else
					ok = false;
				
				resultsetmetric.close();
				statement4result.close();
				
				if(ok)
					redirectURL = "../PerformanceModels.jsp?message=" + "The model was successfully created.";
				else
					redirectURL =  "CreateModel.jsp?message=" + "An error Occurred. Could not finish adding your metrics.";		
			}
			else
				redirectURL =  "CreateModel.jsp?message=" + "An error Occurred. Could not add your Model.";
			
			resultsetmodel.close();
			statementresult.close();
			connection.close();
		}
		catch(Exception ex)
		{
			redirectURL =  "CreateModel.jsp?message=" + "Unable to connect to database.";
			out.println("Unable to connect to database. </br>" + ex.getMessage());
		}
	}
	
	response.sendRedirect(redirectURL);
%>
