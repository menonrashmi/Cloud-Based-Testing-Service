<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SaaS Evaluation</title>
<link rel="stylesheet" type="text/css"
	href="/cbsatesting/script/dijit/themes/claro/claro.css" />
<link rel="stylesheet" type="text/css" href="/cbsatesting/style/main.css" />

<script src="/cbsatesting/script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
<script type="text/javascript">
	dojo.require("dojox.charting.widget.SelectableLegend");
	
	function goToPerformanceValidation(event)
	{
		document.location.href = "/cbsatesting/Performance/PerformanceValidation.jsp";
	}
	
	function goToScalabiltyValidation(event)
	{
		document.location.href = "/cbsatesting/Scalability/ScalabilityValidation.jsp";
	}
   	
   	function startReceivers(event)
   	{
   		document.location.href = "/cbsatesting/Performance/StartRecievers";
   	}
   	
</script>
</head>
<body class="claro">
	<p> SaaS Evaluation </p>
		
	<h2> SaaS Evaluation </h2>
	
	<h3> Performance Validation </h3>
	<hr>
	<p style="padding-left:25px;">
		 
		Monitor your application's performance in the cloud.
		</br></br>
		<button dojoType="dijit.form.Button" value="perf" onClick="goToPerformanceValidation(event)"> Performance Validation >> </button>
		
	</p>
	
	<h3> Scalability Validation</h3>
	<hr>
	<p style="padding-left:25px;">
		Test the scalability of your application in the cloud.
		</br></br>
		<button dojoType="dijit.form.Button" value="scal" onClick="goToScalabiltyValidation(event)"> Scalability Validation >> </button>		
	</p>
	
	<h3> Start Receivers</h3>
	<hr>
	
		<%
		   if (request.getParameter("message") != null) 
		   {
				out.print("<p id='message'> > Message: " + request.getParameter("message") + "</p>");
		   }
		%>
		
	<p style="padding-left:25px;">
		<b>
			NOTE: You must start the receivers once before running models or they will not work.
		</b> 
		</br></br>
		<button dojoType="dijit.form.Button" value="receive" onClick="startReceivers(event)"> Start Receivers </button>		
	</p>
	
</body>

</html>