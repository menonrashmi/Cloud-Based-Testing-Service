<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Performance Metrics</title>

<link rel="stylesheet" type="text/css"
	href="/cbsatesting/style/main.css" />
<link rel="stylesheet" type="text/css"
	href="/cbsatesting/script/dijit/themes/claro/claro.css" />

<script type="text/javascript" src="PerformanceMetrics.js"></script>
<script src="/cbsatesting/script/dojo/dojo.js"
	djConfig="parseOnLoad: true"></script>
<script type="text/javascript">
		   dojo.require("dojox.charting.widget.SelectableLegend");
		   dojo.require("dijit.layout.TabContainer");
           dojo.require("dijit.layout.ContentPane");
		</script>

</head>

<body class="claro">
	<p>
		<a href="/cbsatesting/Performance/SaaSEvaluation.jsp"> SaaS
			Evaluation </a> > <a href="PerformanceValidation.jsp"> Performance
			Validation </a> > Performance Measurements
	</p>

	<h2>Performance Measurements</h2>

	<%
		   if (request.getParameter("message") != null) 
		   {
				out.print("<p id='message'> > Message: " + request.getParameter("message") + "</p>");
		   }
		%>

	<form name="performancemetrics" id="performancemetrics" method="post">

		<span id="performancebuttons">
			<button dojoType="dijit.form.Button" name="selectdefault"
				onClick="selectDefault(event)">Select Defaults</button>
			<button dojoType="dijit.form.Button" name="delete"
				onClick="deleteMetric(event)">Delete Selected</button>
			<button dojoType="dijit.form.Button" name="create"
				onClick="createMetric(event)">Create Metric</button>
		</span>
		<button dojoType="dijit.form.Button" value="Model"
			onClick="goToModel(event)">Model >></button>

		<br /> <br />


		<div style="width: 98%; height: 300px; overflow: visible;">

			<div dojoType="dijit.layout.TabContainer"
				style="width: 100%; height: 100%;">

				<div dojoType="dijit.layout.ContentPane"
					title="System Defined Metrics" selected="true">
					<h3>System Defined Metrics</h3>

					<table class="graytable">
						<tbody>
							<tr>
								<th>Select <br /> <input type="checkbox" name="selectAll"
									onChange="checkAllBoxes(this.checked)" value="">
								</th>
								<th>Default</th>
								<th>Metrics Name</th>
								<th>Statistic</th>
								<th>Equation</th>
							</tr>

							<% 
						try {
							/* Create string of connection url within specified format with machine name, 
							port number and database name. Here machine name id localhost and 
							database name is usermaster. */ 
							//out.println("MNJ 0 ; before jdbc connection");
							String dburl ="jdbc:mysql://localhost:3306/cbsa"; 
							
							// declare a connection by using Connection interface 
							Connection connection = null; 
							Statement statement = null;
							ResultSet resultset = null;
							
							// Load JBBC driver "com.mysql.jdbc.Driver" 
							Class.forName("com.mysql.jdbc.Driver").newInstance();
														
							/* Create a connection by using getConnection() method that takes parameters of 
							string type connection url, user name and password to connect to database. */ 
							connection = DriverManager.getConnection(dburl, "root", "");
							
							// check weather connection is established or not by isClosed() method 
							if(connection.isClosed())
							{
								
								//out.println("MNJ 1");
								throw new Exception();
							}
							
							statement = connection.createStatement();
							//out.println("MNJ - going to select system defined rows from db"); 
							resultset = statement.executeQuery("Select * from performancemetric where type = 'System Defined' ");
							while (resultset.next())
							{ 
					%>

							<tr>
								<td><input type="checkbox" name="checks"
									value="<%= resultset.getString("Name")  + ":" + resultset.getString("Statistic")%>">
								</td>
								<td>
									<% if(resultset.getInt("isDefault") == 0) out.print("No"); else out.print("Yes"); %>
								</td>
								<td><a href="#"
									onClick="displayMetric('<%= resultset.getString("Name") %>', '<%= resultset.getString("Statistic") %>')">
										<%= resultset.getString("Name") %>
								</a></td>
								<td><%= resultset.getString("Statistic") %></td>
								<td><%= resultset.getString("Equation") %></td>
							</tr>

							<%
							}
							
							resultset.close();
							statement.close();
					%>

						</tbody>
					</table>

				</div>

				<div dojoType="dijit.layout.ContentPane"
					title="User Defined Metrics">

					<h3>User Defined Metrics</h3>

					<table class="graytable">
						<tbody>
							<tr>
								<th>Select <br /> <input type="checkbox" name="selectAll"
									onChange="checkAllBoxes(this.checked)" value="">
								</th>
								<th>Default</th>
								<th>Metrics Name</th>
								<th>Statistic</th>
								<th>Equation</th>
							</tr>

							<%
			            statement = connection.createStatement();
						resultset = statement.executeQuery("Select * from PerformanceMetric where type = 'User Defined' ");
						while (resultset.next())
						{ 
							//out.println("MNJ 3");
					%>

							<tr>
								<td><input type="checkbox" name="checks"
									value="<%= resultset.getString("Name") + ":" + resultset.getString("Statistic") %>">
								</td>
								<td>
									<% if(resultset.getInt("isDefault") == 0) out.print("No"); else out.print("Yes"); %>
								</td>
								<td><a href="#"
									onClick="displayMetric('<%= resultset.getString("Name") %>', '<%= resultset.getString("Statistic") %>')">
										<%= resultset.getString("Name") %>
								</a></td>
								<td><%= resultset.getString("Statistic") %></td>
								<td><%= resultset.getString("Equation") %></td>
							</tr>

							<%
							}
							
							resultset.close();
							statement.close();
					%>

						</tbody>
					</table>

				</div>

				<div dojoType="dijit.layout.ContentPane"
					title="Model Defined Metrics">

					<h3>Model Defined Metrics</h3>

					<table class="graytable">
						<tbody>
							<tr>
								<th>Select <br /> <input type="checkbox" name="selectAll"
									onChange="checkAllBoxes(this.checked)" value="">
								</th>
								<th>Default</th>
								<th>Metrics Name</th>
								<th>Statistic</th>
								<th>Equation</th>
							</tr>

							<%
				            statement = connection.createStatement();
							resultset = statement.executeQuery("Select * from PerformanceMetric where type = 'Model Defined' ");
							while (resultset.next())
							{ 
					%>

							<tr>
								<td><input type="checkbox" name="checks"
									value="<%= resultset.getString("Name") + ":" + resultset.getString("Statistic") %>">
								</td>
								<td>
									<% if(resultset.getInt("isDefault") == 0) out.print("No"); else out.print("Yes"); %>
								</td>
								<td><a href="#"
									onClick="displayMetric('<%= resultset.getString("Name") %>', '<%= resultset.getString("Statistic") %>')">
										<%= resultset.getString("Name") %>
								</a></td>
								<td><%= resultset.getString("Statistic") %></td>
								<td><%= resultset.getString("Equation") %></td>
							</tr>


							<%
							}
							resultset.close();
							statement.close();
							connection.close();
						}
						catch(Exception ex)
						{
							//out.println("MNJ 2");
							out.println("Unable to connect to database. </br>" + ex.getMessage());
						}
					%>

						</tbody>
					</table>
				</div>

			</div>

		</div>

	</form>
</body>
</html>