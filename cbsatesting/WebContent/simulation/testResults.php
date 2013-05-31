<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>JMeter Simulation Configuration</title>
<link rel="stylesheet" type="text/css" href="../script/dijit/themes/claro/claro.css" />
<link rel="stylesheet" type="text/css" href="../style/main.css" />

<script src="../script/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
<script src="simulation.js"></script>

<body class="claro">

	<form method="GET" id="searchResultForm" action="jmeterResults.php">
		<h2>Simulation Test Result</h2>
		
		<label for="tool">Select test tool:</label> <select
				id="tool" name="tool" dojoType="dijit.form.ComboBox">
				<option value="jmeterresult" selected>JMeter</option>
				<option value="seleniumresult">Selenium</option>
			</select><br/><br/>
			<label for="tool">Test ID:</label> 
			<input type="text"
				dojotype="dijit.form.TextBox" id="testID" name="testID"></input><br/><br/>
				<div class="alignRight">
					<button type="submit" dojoType="dijit.form.Button" value="" id="startbtn" >Search</button></div>
</form>
</body>
</html>