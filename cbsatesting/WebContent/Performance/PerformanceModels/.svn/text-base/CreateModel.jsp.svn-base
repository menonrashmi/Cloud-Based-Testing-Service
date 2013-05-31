<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>Performance Models</title>
		
		<link rel="stylesheet" type="text/css" href="/cbsatesting/style/main.css" />
		<link rel="stylesheet" type="text/css" href="/cbsatesting/script/dijit/themes/claro/claro.css" />
        
        <script type="text/javascript" src="CreateModel.js"></script>
        <script src="/cbsatesting/script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
        <script type="text/javascript">
		   dojo.require("dojox.charting.widget.SelectableLegend");
		</script>
	</head>

	<body class="claro">
		<p> <a href="/cbsatesting/Performance/SaaSEvaluation.jsp"> SaaS Evaluation </a> > <a href="../PerformanceValidation.jsp"> Performance Validation </a> > <a href="../PerformanceModels.jsp"> Performance Models </a> > Create Model </p>
		
		<h2>Create A Model</h2>
		
		<%
		   if (request.getParameter("message") != null) 
		   {
				out.print("<p id='message'> > Message: " + request.getParameter("message") + "</p>");
		   }
		%>
		
		<form name="createmodel" id="createmodel"  method="post">
			<table class="createmodel">
				<tr>
					<td> Model's Name: </td>
					<td> <input type="text" name="name" id="name" size="65" value="<% if(request.getParameter("name") != null) out.print(request.getParameter("name")); %>" />
					</td>
				</tr>
				<tr>
					<td> Description: </td>
					<td> <textarea name="description" id="description" rows="5" cols="50"><% if(request.getParameter("description") != null) out.print(request.getParameter("description")); %></textarea> </td>
				</tr>
				<tr>
					<td> Number of Metrics: </td> 
					<td> 
						<select name="numMetrics" id="numMetrics" onchange="addMetrics(event)">
							<option> 3 </option>
							<option> 4 </option>
							<option> 5 </option>
						</select>
					</td>
				</tr>

				<%
					for(int i = 1; i < 6; i++)
					{
				%>
						<tr id="metric<%=i%>">
							<td> Metric <%=i%>: </td>
							<td> 
								Metric:
								<select name="type<%=i%>" id="type">
								<%		try {
									/* Create string of connection url within specified format with machine name, 
									port number and database name. Here machine name id localhost and 
									database name is usermaster. */ 
									String connectionURL = "jdbc:mysql://localhost:3306/CBSA"; 
									
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
									resultset = statement.executeQuery("SELECT distinct Name FROM PerformanceMetric WHERE type = 'System Defined' OR type = 'User Defined'");
									while (resultset.next())
									{ 
								%>
									
								<option> <%=resultset.getString("Name")%> </option>
										
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
								</select>
									
								<br/>
				
								Statistic: 
								<select name="statistic<%=i%>" id="statistic"> 
									<option> Minimum </option>
									<option> Maximum </option>
									<option> Sum </option>
									<option> Average </option>
									<option> SampleCount </option>
								</select>						
								
							</td>
						</tr>
				<%
					}
				%>
				
				<tr>
					<td> </td>
					<td> <button name="submit" onClick="createModel(event)" style="float:right"> Create Model </button> </td>
				</tr>
			</table>
		</form>		
	</body>
</html>