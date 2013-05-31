<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<!DOCTYPE html">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>Create Account</title>
		
		<link rel="stylesheet" type="text/css" href="/cbsatesting/WebContent/style/main.css" />
		<link rel="stylesheet" type="text/css" href="/cbsatesting/WebContent/script/dijit/themes/claro/claro.css" />
        
		<script src="/cbsatesting/WebContent/script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
        <script type="text/javascript">
		   dojo.require("dojox.charting.widget.SelectableLegend");
		</script>
	</head>
	<body class="claro">
	
		<p> <a href="UserProfile.jsp"> User Profile</a> > <a href="UserManagement.jsp"> User Management </a> > Create Account</p>
				
		<h2>Create Account</h2>
		
		<form name="createAccount" id="createAccount" action="action/createAccount.jsp" method="post">
			<table class="personalinfo">
				<tbody>
					<tr>
						<td> UserName:  </td>
						<td> <input type="text" name="username" id="username"/> </td>
					</tr>
					<tr>
						<td> First Name:  </td>
						<td> <input type="text" name="firstname" id="firstname"/> </td>
					</tr>
					<tr>
						<td> Last Name:  </td>
						<td> <input type="text" name="lastname" id="lastname"/> </td>
					</tr>
					<tr>
						<td> Primary Email: </td>
						<td> <input type="email" name="primaryemail" id="primaryemail"/> </td>
					</tr>
					<tr>
						<td> Account Type:  </td>
						<td>
							<select name="type" id="type">
								<option> Admin </option>
								<option> user </option>
							</select>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td>
							<button dojoType="dijit.form.Button" type="submit" name="createAccount" id="createAccount" value="createAccount"> Create Account </button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</body>
</html>