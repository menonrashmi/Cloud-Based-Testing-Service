<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>Performance Validation</title>
		
		<link rel="stylesheet" type="text/css" href="/cbsatesting/style/main.css" />
		<link rel="stylesheet" type="text/css" href="/cbsatesting/script/dijit/themes/claro/claro.css" />
        
        <script src="/cbsatesting/script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
        <script type="text/javascript">
		   dojo.require("dojox.charting.widget.SelectableLegend");
		   
		</script>
	</head>

	<body class="claro" style="height: 95%; width: 99%;">
		<p> <a href="/cbsatesting/Performance/SaaSEvaluation.jsp"> SaaS Evaluation </a> > Performance Validation </p>
		
		<h2>Performance Validation</h2>
		
		<h3>Step 1: Performance Measurements </h3>
		<hr>
		<p style="padding-left:25px;">
			View System Metrics, User Defined Metrics, and Model Metrics.
			</br>
			Create customized metrics from system defined metrics or other user defined metrics to use in models.
			</br></br>
			<button dojoType="dijit.form.Button" value="metrics" onClick="document.location.href = '/cbsatesting/Performance/PerformanceMetrics.jsp'"> Performance Measurements >> </button>
		</p>
		
		<h3>Step 2: Performance Models </h3>
		<hr>
		<p style="padding-left:25px;">
			View System defined Modes or create custom Models from system defined metrics or user defined metrics from step 1. 
			</br></br>
			<button dojoType="dijit.form.Button" value="metrics" onClick="document.location.href = '/cbsatesting/Performance/PerformanceModels.jsp'"> Performance Models >> </button>
		</p>
		
		<h3>Step 3: Performance Runner </h3>
		<hr>
		<p style="padding-left:25px;">
			Run models created in step 2 to collect data for your application.  
			</br></br>
			<button dojoType="dijit.form.Button" value="runner" onClick="document.location.href = '/cbsatesting/Performance/PerformanceRunner.jsp'"> Performance Runner >> </button>
		</p>
		
		<h3>Step 4: Performance Monitor </h3>
		<hr>
		<p style="padding-left:25px;">
			Monitor currently running models using a table or a spider chart. 
			</br></br>
			<button dojoType="dijit.form.Button" value="monitor" onClick="document.location.href = '/cbsatesting/Performance/PerformanceMonitor.jsp'"> Performance Monitor >> </button>
		</p>
		
		<h3>Step 5: Performance Reports </h3>
		<hr>
		<p style="padding-left:25px;">
			View performance reports of currently running models. 
			</br></br>
			<button dojoType="dijit.form.Button" value="report" onClick="document.location.href = '/cbsatesting/Performance/PerformanceReports.jsp'"> Performance Reports >> </button>
		</p>
		
	</body>
</html>