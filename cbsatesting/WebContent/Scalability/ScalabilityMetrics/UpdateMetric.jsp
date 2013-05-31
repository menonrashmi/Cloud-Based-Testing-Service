<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>Scalability Metrics</title>
		
		<link rel="stylesheet" type="text/css" href="/cbsatesting/style/main.css" />
		<link rel="stylesheet" type="text/css" href="/cbsatesting/script/dijit/themes/claro/claro.css" />
        
        <script type="text/javascript" src="CreateMetric.js"></script>
        <script src="../script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
        <script type="text/javascript">
		   dojo.require("dojox.charting.widget.SelectableLegend");
		</script>
	</head>

	<body class="claro">
		<p> <a href="/cbsatesting/Performance/SaaSEvaluation.jsp"> SaaS Evaluation </a> > <a href="../ScalabilityValidation.jsp"> Scalability Validation </a> > <a href="../ScalabilityMetrics.jsp"> Scalability Measurements </a> > Update Metric </p>
		
		<h2>Update A Metric</h2>
		
		<%
		   if (request.getParameter("message") != null) 
		   {
				out.print("<p id='message'> > Message: " + request.getParameter("message") + "</p>");
		   }
		%>
		
		<form name="createmetric" id="createmetric" method="post">
			<table class="createmetric">
				<tr>
					<td> Metric's Name: </td>
					<td> <input type="text" name="name" id="name" size="65" disabled="disabled" value="<% if(request.getParameter("name") != null) out.print(request.getParameter("name")); %>" />
					</td>
				</tr>
				<tr>
					<td> Description: </td>
					<td> <textarea name="description" id="description" rows="5" cols="50"><% if(request.getParameter("description") != null) out.print(request.getParameter("description")); %></textarea> </td>
				</tr>
				<tr>
					<td> Equation: </td> 
					<td> 
						
						<%
							String[] equation = null;
							if(request.getParameter("equation") != null)
							{
								equation = request.getParameter("equation").split(" ");
							}
							
						%>
						
					
						Coefficient 1: <input type="text" name="coefficient1" id="coefficient1" size="5" maxlength="5" value="<% 
								if(request.getParameter("coefficient1") != null) 
									out.print(request.getParameter("coefficient1"));
								else if (equation != null)
									out.println(equation[0]);
							%>" />
						
						<br />
						
						Metric 1: 
						<select name="metric1" id="metric1">
							<%	try {
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
								resultset = statement.executeQuery("Select distinct name from ScalabilityMetric where type = 'System Defined' or type = 'User Defined'");
								while (resultset.next())
								{ 
									if(equation[2].equals(resultset.getString("Name")))
									{
							%>
										<option selected='selected'><%=resultset.getString("Name")%></option>
							<%
									}
									else
									{
							%>
											<option><%=resultset.getString("Name")%></option>
							<%
									}
								}
							%>
						</select>
						
						<br />
						
						Statistic 1:
						<select name="statistic1" id="statistic1"> 
							<option> Minimum </option>
							<option> Maximum </option>
							<option> Sum </option>
							<option> Average </option>
							<option> SampleCount </option>
						</select>
						
						<br />
						<br />
						
						Operation: 
						<select name="operation" id="operation"> 
						<%
							if(equation[5].equals("+"))
								out.println("<option selected='selected'> + </option>");
							else
								out.println("<option> + </option>");
						
							if(equation[5].equals("-"))
								out.println("<option selected='selected'> - </option>");
							else
								out.println("<option> - </option>");
							
							if(equation[5].equals("*"))
								out.println("<option selected='selected'> * </option>");
							else
								out.println("<option> * </option>");
							
							if(equation[5].equals("/"))
								out.println("<option selected='selected'> / </option>");
							else
								out.println("<option> / </option>");
						%>
						</select>
						
						<br />
						<br />
						
						Coefficient 2: <input type="text" name="coefficient2" id="coefficient2" size="5" maxlength="5" value="<% 
								if(request.getParameter("coefficient1") != null) 
									out.print(request.getParameter("coefficient1"));
								else if (equation != null)
									out.println(equation[0]);
							%>" />
						
						<br />
						
						Metric 2:
							<select name="metric2" id="metric2">
								<%	resultset.beforeFirst();
									while (resultset.next())
									{ 
										if(equation[2].equals(resultset.getString("Name")))
										{
								%>
											<option selected='selected'><%=resultset.getString("Name")%></option>
								<%
										}
										else
										{
								%>
												<option><%=resultset.getString("Name")%></option>
								<%
										}
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
							</select>
							
						<br />
						
						Statistic 2: 
						<select name="statistic2" id="statistic2"> 
							<option> Minimum </option>
							<option> Maximum </option>
							<option> Sum </option>
							<option> Average </option>
							<option> SampleCount </option>
						</select>
					</td>
				</tr>
				<tr>
					<td> </td>
					<td> <button dojoType='dijit.form.Button' name="submit" onClick="create(event)" style="float:left"> Create </button> </td>
				</tr>
			</table>
		</form>		
	</body>
</html>