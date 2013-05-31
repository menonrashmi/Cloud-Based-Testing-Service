<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>Scalability Metrics</title>
		
		<link rel="stylesheet" type="text/css" href="/cbsatesting/style/main.css" />
		<link rel="stylesheet" type="text/css" href="/cbsatesting/script/dijit/themes/claro/claro.css" />
        
        <script type="text/javascript" src="DisplayMetric.js"></script>
        <script src="/cbsatesting/script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
        <script type="text/javascript">
		   dojo.require("dojox.charting.widget.SelectableLegend");
		</script>
	</head>

	<body class="claro">
		<p> <a href="/cbsatesting/Performance/SaaSEvaluation.jsp"> SaaS Evaluation </a> > <a href="../ScalabilityValidation.jsp"> Scalability Validation </a> > <a href="../ScalabilityMetrics.jsp"> Scalability Measurements </a> > Metric Details </p>
		
		<h2>Metric Details: <%= request.getParameter("Name") %></h2>
		
		<%
		   if (request.getParameter("message") != null) 
		   {
				out.print("<p id='message'> > Message: " + request.getParameter("message") + "</p>");
		   }
		%>
		
		<% 
			try {
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
				resultset = statement.executeQuery("Select * from ScalabilityMetric where Name = '" + request.getParameter("Name") + "' and Statistic = '" + request.getParameter("Statistic") + "'" );
				if (resultset.next())
				{ 
		%>
		
		<form name="displaymetric" id="displaymetric" method="post">
		
			<span id="scalabilitybuttons">
				<button dojoType="dijit.form.Button" name="makeDefault" onClick="selectDefault(event)">Make Default</button>
				
				<% if(resultset.getString("type").equals("User Defined"))
					{ out.println("<button dojoType='dijit.form.Button' name='delete' onClick='deleteMetric(event)'>Delete</button>" + 
						"<button dojoType='dijit.form.Button' name='update' onClick='updateMetric(event)'>Update</button>"); } %>
			</span>
					
			<br />
			<br />
			
			<table class="displaymetric">
				<tr>
					<td> Metric Name: </td>
					<td id="name"><%=resultset.getString("name")%></td>
				</tr>
				<tr>
					<td> Default: </td>
					<td><% if(resultset.getInt("isDefault") == 0) out.print("No"); else out.print("Yes"); %>  </td>
				</tr>
				<tr>
					<td> Statistic Type: </td>
					<td id="statistic"><%=resultset.getString("statistic")%></td>
				</tr>
				<tr>
					<td> Description: </td>
					<td id="description"><%=resultset.getString("description")%></td>
				</tr>
				<tr>
					<td> Equation: </td>
					<td id="equation"><%=resultset.getString("equation")%></td>
				</tr>
				<tr>
					<td> Type: </td>
					<td><%=resultset.getString("type")%></td>
				</tr>
			</table>
					
			<%
					}
					else
					{
						out.println("ERROR OCCURRED! The given name and statistic does not exist in the database.");
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
			
		</form>		
	</body>
</html>
	