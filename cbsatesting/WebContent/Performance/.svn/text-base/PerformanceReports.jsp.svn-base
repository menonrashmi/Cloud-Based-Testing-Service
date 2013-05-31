<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>Performance Monitor</title>
		
		<link rel="stylesheet" type="text/css" href="/cbsatesting/style/main.css" />
		<link rel="stylesheet" type="text/css" href="/cbsatesting/script/dijit/themes/claro/claro.css" />
        
        <script src="/cbsatesting/script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
        <script type="text/javascript">
		   dojo.require("dojox.charting.widget.SelectableLegend");
		</script>
		<script type="text/javascript">
			function goToMonitor(event)
			{
				document.location.href = "PerformanceMonitor.jsp";
			}
			function generateReport(model)
			{
				var name = model.replace(/ /g, '%20');
				document.location.href = "PerformanceMonitor/DisplayReport.jsp?Name=" + name;
			}
		</script>
        
	</head>
	
	<body class="claro">
		<p> <a href="/cbsatesting/Performance/SaaSEvaluation.jsp"> SaaS Evaluation </a> > <a href="PerformanceValidation.jsp"> Performance Validation </a> > Performance Monitor</p>
		
		<h2>Performance Reports</h2>
		
		<span id="performancebuttons">
<!-- 			<button dojoType="dijit.form.Button" name="polygon" onClick="viewPolygon(event)">View Polygon</button> -->
<!-- 			<button dojoType="dijit.form.Button" name="statistics" onClick="viewStatistics(event)">View Statistics</button> -->
<!-- 			<button dojoType="dijit.form.Button" name="statistics" onClick="generateReport(event)">Generate Report</button> -->
		</span>
		<button dojoType="dijit.form.Button" value="monitor" onClick="goToMonitor(event)"> << Monitor </button>
			
		<br />
		<br />
	
		<table class="graytable">
			<tbody>
				<tr>
<!-- 					<th>Select <br/> <input type="checkbox" name="selectAll" onChange="checkAllBoxes(this.checked)" value=""> </th> -->
					<th>Model Name</th>
					<th>Actions Available</th>
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
				resultset = statement.executeQuery("Select * from PerformanceModel where status='(running)'");
				while (resultset.next())
				{
		%>
		
				<tr>
<%-- 					<td> <input type="checkBox" name="checks" value="<%= resultset.getString("Name") %>"> </td> --%>
					<td> <a href="#" onClick="generateReport('<%=resultset.getString("Name")%>')"> <%= resultset.getString("Name") %> </a> </td>
					<td>
						<button dojoType="dijit.form.Button" name="statistics" onClick="generateReport('<%= resultset.getString("Name") %>')">Generate Report</button>
					</td>
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
	</body>
</html>