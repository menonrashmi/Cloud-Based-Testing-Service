<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Scalability Monitor</title>
	
	<link rel="stylesheet" type="text/css" href="/cbsatesting/script/dijit/themes/claro/claro.css" />
	<link rel="stylesheet" type="text/css" href="/cbsatesting/style/main.css" />
	
	<script src="/cbsatesting/script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
	<script type="text/javascript">
	   dojo.require("dojox.charting.Chart2D");
	   dojo.require("dojox.charting.themes.Wetland");
	   dojo.require("dojox.charting.widget.SelectableLegend");
	   dojo.require("dojox.charting.action2d.Tooltip");
	   
	   var modelName="<%=request.getParameter("Name")%>";
	   
	   dojo.addOnLoad(function() {
	        dojo.xhrGet({
	        url: "/cbsatesting/Scalability/ChartData?modelName="+modelName,
	        handleAs:"json",
	        load:function(data){
	           showChart(data);
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
		         url: "/cbsatesting/Scalability/ChartData?modelName="+modelName,
		         handleAs:"json",
		         load:function(data){
		            chart.updateSeries(time1,data[5]);
		            chart.updateSeries(time2,data[3]);
		            chart.updateSeries(time3,data[1]); 
		      }});
	      },60000);
	   }
	</script>
	
	<script type="text/javascript"> 
		function displayModel(modelName)
		{
			var name = modelName.replace(/ /g, '%20');
			document.location.href = "/cbsatesting/ScalabilityModels/DisplayModel.jsp?Name=" + name;
		}
	</script>
	
</head>
<body class="claro">

		<p> <a href="../Performance/SaaSEvaluation.jsp"> SaaS Evaluation </a> > <a href="../ScalabilityValidation.jsp"> Scalability Validation </a> > <a href="../ScalabilityMonitor.jsp"> Scalability Monitor </a> > View Polygon </p>
		
		<h2>Model Monitor: <a href="#" onClick="displayModel('<%=request.getParameter("Name")%>')"> <%= request.getParameter("Name") %> </a> </td> </h2>
		
	<div> Legend: <span id="legend" style="width: 300px;  height: 300px;"></span>	</div>
	<div id="chart" style="width: 500px; height: 500px;"></div>
	
</body>

</html>