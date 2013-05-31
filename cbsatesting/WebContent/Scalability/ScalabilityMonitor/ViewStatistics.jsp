<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Performance Monitor</title>
	
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
		        url: "/cbsatesting/Scalability/StatsData?modelName="+modelName,
		        load:function(data){
		           var targetNode = dojo.byId("table");
		           targetNode.innerHTML = data;
		        },
		        error: function(error) {
		        	var targetNode = dojo.byId("table");
	                targetNode.innerHTML = "An unexpected error occurred: " + error;
           }});
	   });
	
	      //update every minutes
	      setInterval(function(){
		      dojo.xhrGet({
		         url: "/cbsatesting/Scalability/StatsData?modelName="+modelName,
		         load:function(data){
			           var targetNode = dojo.byId("table");
			           targetNode.innerHTML = data;
			        },
			        error: function(error) {
			        	var targetNode = dojo.byId("table");
		                targetNode.innerHTML = "An unexpected error occurred: " + error;
	           }});
	      },60000);
	      
	</script>
	
	<script type="text/javascript"> 
		function displayModel(modelName)
		{
			var name = modelName.replace(/ /g, '%20');
			document.location.href = "../ScalabilityModels/DisplayModel.jsp?Name=" + name;
		}
	</script>
	
</head>
<body class="claro">

		<p> <a href="/cbsatesting/Performance/SaaSEvaluation.jsp"> SaaS Evaluation </a> > <a href="../ScalabilityValidation.jsp"> Scalability Validation </a> > <a href="../ScalabilityMonitor.jsp"> Scalability Monitor </a> > View Statistics </p>
		
		<h2>Model Monitor: <a href="#" onClick="displayModel('<%=request.getParameter("Name")%>')"> <%= request.getParameter("Name") %> </a> </td> </h2>
		

	<div id="table"></div>
</body>

</html>