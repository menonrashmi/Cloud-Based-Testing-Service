<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
		resultset = statement.executeQuery("Select * from ScalabilityModel where Name = '" + request.getParameter("Name") + "'");
		if (resultset.next())
		{ 
			String sql = "Select ScalabilityMetric.Name, ScalabilityMetric.Statistic from ScalabilityMetric where ScalabilityMetric.MetricID in "
				+ "(Select ScalabilityModelMetric.MetricID from ScalabilityModelMetric where ScalabilityModelMetric.ModelMetric = 0 and ScalabilityModelMetric.ModelID in "
				+ "(Select ScalabilityModel.ModelID from ScalabilityModel where ScalabilityModel.Name = '" + request.getParameter("Name") + "'))";
			Statement statement2 = connection.createStatement();
			ResultSet resultset2 = statement2.executeQuery(sql);
			
			//out.println(sql);
	%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>Scalability Models</title>
		
		<link rel="stylesheet" type="text/css" href="/cbsatesting/style/main.css" />
		<link rel="stylesheet" type="text/css" href="/cbsatesting/script/dijit/themes/claro/claro.css" />
        
        <script type="text/javascript" src="DisplayModel.js"></script>
        <script src="/cbsatesting/script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
		<script type="text/javascript">
		   dojo.require("dojox.charting.Chart2D");
		   dojo.require("dojox.charting.themes.Wetland");
		   dojo.require("dojox.charting.widget.SelectableLegend");
		   dojo.require("dojox.charting.action2d.Tooltip");
		   
		   dojo.require("dijit.layout.TabContainer");
           dojo.require("dijit.layout.ContentPane");
		
		   dojo.addOnLoad(function() {
		      var chart = new dojox.charting.Chart2D("sampleGraph");
		      chart.setTheme(dojox.charting.themes.Wetland);
		      chart.addPlot("default", {
		      type : "Spider",
		      labelOffset : -20,
		      divisions : 5,
		      seriesFillAlpha : .05,
		      markerSize : 2,
		      precision : 0,
		      spiderType : "polygon",
		      htmlLabels: true,
		      animationType: dojo.fx.easing.backOut
		      });
		      chart.addSeries("Time1", {
		         data : {
		       		<%
		       			int randomTime1 = 50;
		       			Random random = new Random();
		       		
		       			resultset2.first();
		       			out.println( "'" + resultset2.getString("Name") + " (" + resultset2.getString("Statistic") + ")' : " + (randomTime1 + random.nextInt(10)));
		       			
		       			while(resultset2.next())
		       			{
		       				out.println( ", '" + resultset2.getString("Name") + " (" + resultset2.getString("Statistic") + ")' : " + (randomTime1 + random.nextInt(10)));
		       			}
		       		%>
		         }
		      }, {
		         fill : "purple"
		      });
		      chart.addSeries("Time2", {
		         data : {
			       <%
			      	 	int randomTime2 = 70;
			       
		       			resultset2.first();
		       			out.println( "'" + resultset2.getString("Name") + " (" + resultset2.getString("Statistic") + ")' : " + (randomTime2 + random.nextInt(10)));
		       			
		       			while(resultset2.next())
		       			{
		       				out.println( ", '" + resultset2.getString("Name") + " (" + resultset2.getString("Statistic") + ")' : " + (randomTime2 + random.nextInt(10)));
		       			}
		       		%>
		         }
		      }, {
		         fill : "blue"
		      });
		
		      chart.addSeries("Time3", {
		         data : {
				   <%
				   		int randomTime3 = 90;
				   
		       			resultset2.first();
		       			out.println( "'" + resultset2.getString("Name") + " (" + resultset2.getString("Statistic") + ")' : " + (randomTime3 + random.nextInt(10)));
		       			
		       			while(resultset2.next())
		       			{
		       				out.println( ", '" + resultset2.getString("Name") + " (" + resultset2.getString("Statistic") + ")' : " + (randomTime3 + random.nextInt(10)));
		       			}
		       		%>
		         }
		      }, {
		         fill : "green"
		      });

		      
		      new dojox.charting.action2d.Tooltip(chart, "default", {text: function(o) {
		          var value=o.y;
		          return value;
		       }});
		      
		      chart.render();
		      
		      var legend = new dojox.charting.widget.SelectableLegend({
		          chart : chart,
		          horizontal : true
		          }, "legend");
		      
		   });
		   
</script>
	</head>

	<body class="claro">
		<p> <a href="/cbsatesting/Performance/SaaSEvaluation.jsp"> SaaS Evaluation </a> > <a href="../ScalabilityValidation.jsp"> Scalability Validation </a> > <a href="../ScalabilityModels.jsp"> Scalability Models </a> > Model Details </p>
		
		<h2>Model Details: <%= request.getParameter("Name") %></h2>
		
		<%
		   if (request.getParameter("message") != null) 
		   {
				out.print("<p id='message'> > Message: " + request.getParameter("message") + "</p>");
		   }
		%>
		
		<form name="displaymodel" id="displaymodel" method="post">
		
			<span id="scalabilitybuttons">
				<button dojoType="dijit.form.Button" name="makeDefault" onClick="selectDefault(event)">Make Default</button>
				
				<% 	if(resultset.getString("Type").equals("User Defined") && resultset.getString("Status").equals("(running)"))
					{ out.println("<button dojoType='dijit.form.Button' name='update' onClick='updateModel(event)' disabled='true'>Update</button>"
								+ "<button dojoType='dijit.form.Button' name='delete' onClick='deleteModel(event)' disabled='true'>Delete</button>"); }
					else if(resultset.getString("Type").equals("User Defined"))
					{ out.println("<button dojoType='dijit.form.Button' name='update' onClick='updateModel(event)'>Update</button>" 
							+ "<button dojoType='dijit.form.Button' name='delete' onClick='deleteModel(event)'>Delete</button>"); }
				%>
			</span>
					
			<br />
			<br />
			
			
			<div style="width: 97%; height: 300px; overflow: visible;">
		
			    <div dojoType="dijit.layout.TabContainer" style="width: 100%; height: 100%;">
			    
			        <div dojoType="dijit.layout.ContentPane" title="Details" selected="true">
			           	<table class="displaymodel">
							<tr>
								<td> Model Name: </td>
								<td id="name"><%=resultset.getString("Name")%></td>
							</tr>
							<tr>
								<td> Default: </td>
								<td><% if(resultset.getInt("isDefault") == 0) out.print("No"); else out.print("Yes"); %>  </td>
							</tr>
							<tr>
								<td> Description: </td>
								<td id="description"><%=resultset.getString("Description")%></td>
							</tr>
							<tr>
								<td> Type: </td>
								<td><%=resultset.getString("Type")%></td>
							</tr>
							<tr>
								<td> Number of Metrics: </td>
								<td id="numMetrics"><%=resultset.getString("NumMetrics")%></td>
							</tr>
							<tr>
								<td> Metrics: </td>
								<td><%
									resultset2.first();
									out.println("<a href='#' onClick=\"displayMetric( '" +  resultset2.getString("Name") + "' , '" + resultset2.getString("Statistic") + "') \" > " + resultset2.getString("Name") + " (" + resultset2.getString("Statistic") + ") </a> <br/>");
									while (resultset2.next())
									{
										out.println("<a href='#' onClick=\"displayMetric( '" +  resultset2.getString("Name") + "' , '" + resultset2.getString("Statistic") + "') \" > " + resultset2.getString("Name") + " (" + resultset2.getString("Statistic") + ") </a> <br/>");
									}
								%></td>
							</tr>
						</table>
			        </div>
			        
			        <div dojoType="dijit.layout.ContentPane" title="Sample Graph">
			        	
			        	Graph's Legend: 
			        	<div id="legend" style="width: 500px; "></div>
			        	
			        	<hr>
			        	
			        	Graph: 
			        	<div id="sampleGraph" style="width: 800px; height: 800px;"></div>
			        	
			    </div>
			    
			</div>
				
	<%
			}
			else
			{
				out.println("ERROR OCCURRED! The given name does not exist in the database.");
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
