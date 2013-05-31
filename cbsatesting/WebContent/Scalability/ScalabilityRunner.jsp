<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>Scalability Runner</title>
		
		<link rel="stylesheet" type="text/css" href="/cbsatesting/style/main.css" />
		<link rel="stylesheet" type="text/css" href="/cbsatesting/script/dijit/themes/claro/claro.css" />
        
        <script type="text/javascript" src="ScalabilityRunner.js"></script>
        <script src="/cbsatesting/script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
        <script type="text/javascript">
	        dojo.require("dijit.form.TextBox");
	        dojo.require("dijit.form.DateTextBox");
	        dojo.require("dijit.form.Select");
		   	dojo.require("dojox.charting.widget.SelectableLegend");
		   
		   dojo.addOnLoad(function() {
			   var startDate = new dijit.form.DateTextBox({
		            name: "startDate",
		            value: new Date(),
		            constraints: {
		                selector: 'date',
		                datePattern: 'MM-dd-yyyy',
		                locale: 'en-us'
		            }
		        },
		        "startDate");
			   
			   var endDate = new dijit.form.DateTextBox({
		            name: "endDate",
		            value: new Date(),
		            constraints: {
		                selector: 'date',
		                datePattern: 'MM-dd-yyyy',
		                locale: 'en-us'
		            }
		        },
		        "endDate");
		   });
		</script>
	</head>
	
	<body class="claro">
		<p> <a href="/cbsatesting/Performance/SaaSEvaluation.jsp"> SaaS Evaluation </a> > <a href="ScalabilityValidation.jsp"> Scalability Validation </a> > Scalability Runner</p>
		
		<h2>Scalability Runner</h2>
		
		<%
		   if (request.getParameter("message") != null) 
		   {
				out.print("<p id='message'> > Message: " + request.getParameter("message") + "</p>");
		   }
		%>
		
		<form name="scalabilityrunner" id="scalabilityrunner" method="post">
			<span id="scalabilitybuttons">
				<button dojoType="dijit.form.Button" name="run" onClick="Run(event)">Run</button>
				<button dojoType="dijit.form.Button" name="stop" onClick="Stop(event)">Stop</button>
			</span>
			<button dojoType="dijit.form.Button" value="model" onClick="goToModel(event)"> << Model </button>
			<button dojoType="dijit.form.Button" value="monitor" onClick="goToMonitor(event)"> Monitor >> </button>

			<br />
			<br />
			
			
			<table class="runnerSettings">
				<tbody>
					<tr>
						<td style="font-weight: bold;"> Time Settings: </td>
						<td> </td>
					</tr>
					<tr>
						<td> AWS Access Key ID: </td>
						<td> 
							<input value="AKIAIMEH6LATDIR5P6IA"  dojoType="dijit.form.TextBox" id="AWSAccessKeyId" name="AWSAccessKeyId">
						</td>
					</tr>
					<tr>
						<td> AWS Secret Access Key: </td>
						<td>
							<input value="wye9KJ3vioi4MP8uDwBKy0Q/J9fNRciW8CM+EU5A" dojoType="dijit.form.TextBox" id="AWSSecretAccessKey" name="AWSSecretAccessKey">
						</td>
					</tr>
					<tr>
						<td> Instance ID: </td>
						<td>
							<input value="i-0a185c6d" dojoType="dijit.form.TextBox" id="InstanceID" name="InstanceID">
						</td>
					</tr>
					<tr>
						<td> Collect Period: </td>
						<td>
							<select name="period" id="period" dojoType="dijit.form.Select">
								<option value="60">1 Minute</option>
								<option value="120">2 Minute</option>
								<option value="180">3 Minute</option>
								<option value="240">4 Minute</option>
								<option value="300">5 Minute</option>
							</select>
						</td>
					</tr>
<!-- 					<tr> -->
<!-- 						<td> Start Date: </td> -->
<!-- 						<td> -->
<!-- 							<input type="text" id="startDate" name="startDate"></input> -->
<!-- 						</td> -->
<!-- 					</tr> -->
				</tbody>
			</table>
			
			<br />
			<br />
	
			<table class="graytable">
				<tbody>
					<tr>
						<th>Select <br/> <input type="checkbox" name="selectAll" onChange="checkAllBoxes(this.checked)" value=""> </th>
						<th>Model Name</th>
						<th>Status</th>
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
					resultset = statement.executeQuery("Select * from ScalabilityModel");
					while (resultset.next())
					{
			%>
			
	
					<tr>
						<td>
							<%
								if(resultset.getInt("isDefault") == 1)
									out.println("<input type='checkBox' name='checks' checked='checked' value='" + resultset.getString("Name") + "' />");
								else
									out.println("<input type='checkBox' name='checks' value='" + resultset.getString("Name") + "' />");
							%> 
							
						</td>
						<td> <a href="#" onClick="displayModel('<%=resultset.getString("Name")%>')"> <%= resultset.getString("Name") %> </a> </td>
						<td> 
							<% 
								if(resultset.getString("Status").equals("(running)"))
								{
									out.println("<div style='color:green'> (running) </div>");
								}
								else if(resultset.getString("Status").equals("(stopped)"))
								{
									out.println("<div style='color:red'> (stopped) </div>");
								}
							%>
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
					out.println("Unable to connect to database. <br/>" + ex.getMessage());
				}
			%>	
			
				</tbody>
			</table>
		</form>
	</body>
</html>