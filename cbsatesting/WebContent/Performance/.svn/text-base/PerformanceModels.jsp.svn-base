<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>Performance Models</title>
		
		<link rel="stylesheet" type="text/css" href="/cbsatesting/style/main.css" />
		<link rel="stylesheet" type="text/css" href="/cbsatesting/script/dijit/themes/claro/claro.css" />
        
        <script type="text/javascript" src="PerformanceModels.js"></script>
        <script src="/cbsatesting/script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
        <script type="text/javascript">
		   dojo.require("dojox.charting.widget.SelectableLegend");
		</script>
        
	</head>
	
	<body class="claro">
		<p> <a href="/cbsatesting/Performance/SaaSEvaluation.jsp"> SaaS Evaluation </a> > <a href="PerformanceValidation.jsp"> Performance Validation </a> > Performance Models</p>
		
		<h2>Performance Models</h2>
		
		<%
		   if (request.getParameter("message") != null) 
		   {
				out.print("<p id='message'> > Message: " + request.getParameter("message") + "</p>");
		   }
		%>
		
		<form name="performancemodels" id="performancemodels" method="post">
		
		<span id="performancebuttons">
			<button dojoType="dijit.form.Button" name="selectdefault" onClick="selectDefault(event)">Select Default</button>
			<button dojoType="dijit.form.Button" name="delete" onClick="deleteModel(event)">Delete Selected</button>
			<button dojoType="dijit.form.Button" name="create" onClick="createModel(event)">Create Model</button>
		</span>
		<button dojoType="dijit.form.Button" value="Runner" onClick="goToMetric(event)"> << Metric </button>
		<button dojoType="dijit.form.Button" value="Runner" onClick="goToRunner(event)"> Runner >> </button>

		<br />
		<br />
		
			<table class="graytable">
				<tbody>
					<tr>
						<th>Select <br/> <input type="checkbox" name="selectAll" onChange="checkAllBoxes(this.checked)" value=""> </th>
						<th>Default</th>
						<th>Model Name</th>
						<th>Number of Metrics</th>
						<th>Type</th>
					</tr>
		
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
					resultset = statement.executeQuery("Select * from PerformanceModel");
					while (resultset.next())
					{
			%>
			
					<tr>
						<td> <input type="checkBox" name="checks" value="<%= resultset.getString("Name") %>"> </td>
						<td> <% if(resultset.getInt("isDefault") == 0) out.print("No"); else out.print("Yes"); %> </td>
						<td> <a href="#" onClick="displayModel('<%=resultset.getString("Name")%>')"> <%= resultset.getString("Name") %> </a> </td>
						<td> <%= resultset.getString("NumMetrics") %></td>
						<td> <%= resultset.getString("Type") %></td>
					</tr>
					
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
			
				</tbody>
			</table>
		</form>
	</body>
</html>