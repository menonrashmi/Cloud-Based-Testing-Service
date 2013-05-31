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
		resultset = statement.executeQuery("Select * from PerformanceModel where Name = '" + request.getParameter("Name") + "'");
		if (resultset.next())
		{ 
			Statement statement2 = connection.createStatement();
			ResultSet resultset2 = statement2.executeQuery("Select PerformanceMetric.Name, PerformanceMetric.Statistic from PerformanceMetric where PerformanceMetric.MetricID in "
					+ "(Select PerformanceModelMetric.MetricID from PerformanceModelMetric where PerformanceModelMetric.ModelMetric = 0 and PerformanceModelMetric.ModelID in "
					+ "(Select PerformanceModel.ModelID from PerformanceModel where PerformanceModel.Name = '" + request.getParameter("Name") + "'))");
			
			int divisions = 0;
   			while(resultset2.next())
   			{
   				divisions++;
   			}
	%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>Performance Report</title>
		
		<link rel="stylesheet" type="text/css" href="/cbsatesting/style/main.css" />
		<link rel="stylesheet" type="text/css" href="/cbsatesting/script/dijit/themes/claro/claro.css" />
        
        <script type="text/javascript" src="DisplayModel.js"></script>
        <script src="/cbsatesting/script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
		<script type="text/javascript">
		dojo.require("dojox.charting.Chart2D");
		   dojo.require("dojox.charting.themes.Wetland");
		   dojo.require("dojox.charting.widget.SelectableLegend");
		   dojo.require("dojox.charting.action2d.Tooltip");
		   
		   var modelName="<%=request.getParameter("Name")%>";
		   
		   dojo.addOnLoad(function() {
		        dojo.xhrGet({
		        url: "/cbsatesting/Performance/ChartData?modelName="+modelName,
		        handleAs:"json",
		        load:function(data){
		           showChart(data);
		        }});
		        
		        dojo.xhrGet({
			        url: "/cbsatesting/Performance/StatsData?modelName="+modelName,
			        load:function(data){
			           var targetNode = dojo.byId("table");
			           targetNode.innerHTML = data;
			        },
			        error: function(error) {
			        	var targetNode = dojo.byId("table");
		                targetNode.innerHTML = "An unexpected error occurred: " + error;
	           }});
		   });
		   
		   function showChart(data){
		      var chart = new dojox.charting.Chart2D("chart");
		      chart.setTheme(dojox.charting.themes.Wetland);
		      chart.addPlot("default", {
		      type : "Spider",
		      labelOffset : -20,
		      divisions : 5,
		      seriesFillAlpha : .05,
		      markerSize : 4,
		      precision : 0,
		      spiderType : "polygon",
		      htmlLabels: true,
		      animationType: dojo.fx.easing.backOut
		      });
		      var time1=data[4].time;
		      var time2=data[2].time;
		      var time3=data[0].time;
		      chart.addSeries(time1, {
		         data : data[5]
		      }, {
		         fill : "blue"
		      });
		      chart.addSeries(time2, {
		         data : data[3]
		      }, {
		         fill : "green"
		      });
		
		      chart.addSeries(time3, {
		         data : data[1]
		         
		      }, {
		         fill : "purple",
		      });
		      new dojox.charting.action2d.Tooltip(chart,"default",{text: function(o){
		         var value=o.y;
		         return value;
		      }
		      });
		      chart.render();
		
		      var legend = new dojox.charting.widget.SelectableLegend({
		      chart : chart,
		      horizontal : true
		      }, "legend");
		      
		
		
		      //update every minutes
		      setInterval(function(){
		      dojo.xhrGet({
		         url: "/cbsatesting/Performance/ChartData?modelName="+modelName,
		         handleAs:"json",
		         load:function(data){
		            chart.updateSeries(time1,data[5]);
		            chart.updateSeries(time2,data[3]);
		            chart.updateSeries(time3,data[1]); 
		      }});
		      },60000);
		      
		      setInterval(function(){
			      dojo.xhrGet({
			         url: "/cbsatesting/Performance/StatsData?modelName="+modelName,
			         load:function(data){
				           var targetNode = dojo.byId("table");
				           targetNode.innerHTML = data;
				        },
				        error: function(error) {
				        	var targetNode = dojo.byId("table");
			                targetNode.innerHTML = "An unexpected error occurred: " + error;
		           }});
		      },60000);
		   }
		   
		   function displayMetric(metric, statistic)
		   {
		   	var name = metric.replace(/ /g, '%20');
		   	document.getElementById("displaymodel").action = "../PerformanceMetrics/DisplayMetric.jsp?Name=" + name + "&Statistic=" + statistic;
		   	document.getElementById("displaymodel").submit();
		   }
		</script>
	</head>

	<body class="claro">
		<p> <a href="/cbsatesting/Performance/SaaSEvaluation.jsp"> SaaS Evaluation </a> > <a href="../PerformanceValidation.jsp"> Performance Validation </a> > <a href="../PerformanceReports.jsp"> Performance Reports </a> > Model Report </p>
		
		<h2>Model Report: <%= request.getParameter("Name") %></h2>
		
		<form name="displaymodel" id="displaymodel" method="post">	
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
				<tr>
					<td> Graph: </td>
					<td> 
						<div id="chart" style="width: 500px; height: 500px;"></div>
					</td> 
				</tr>
				<tr>
					<td> Graph's Legend: </td>
					<td> 
						<div id="legend" style="width: 300px; height: 300px;"></div>				
					</td> 
				</tr>
				<tr>
					<td> Data: </td>
					<td> 
						<div id="table"></div>				
					</td> 
				</tr>
			</table>
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
