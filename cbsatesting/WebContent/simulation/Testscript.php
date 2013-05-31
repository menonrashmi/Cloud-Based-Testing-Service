<?php
if (isset ($_GET['type']) && $_GET['type'] == "gui")
	$type = "gui";
else
	$type = "load";

$query = "select * from testscript where type='".$type."' order by testscriptid";

$user = "root";
$password = "";
$database = "CBSA";
mysql_connect("localhost:3306", $user, $password);
mysql_select_db($database) or die("Unable to select database");
$result = mysql_query($query);

$cols = mysql_num_fields($result);
mysql_close();

$x = 0;
echo "<html><head><link rel='stylesheet' type='text/css' href='../style/main.css'  />" .
"<link rel='stylesheet' type='text/css' href='../script/dijit/themes/claro/claro.css' />" .
"<script src='../script/dojo/dojo.js' djConfig='parseOnLoad: true'></script>" .
"<script type='text/javascript'>dojo.require('dijit.form.Button');dojo.require('dojo.parser'); </script><head>" .
"<body class='claro'><h2>" . $_GET['type'] . " Test Scripts</h2><table class='blueTable'><tr>";
while ($x < $cols) {

	echo "<td>";
	echo mysql_field_name($result, $x);
	
	echo "</td>";
	$x++;
}

echo "</tr>";
$i = 0;
   
while ($row = mysql_fetch_array($result)) {

	echo "<tr>";
	$j = 0;
	while ($j < $cols) {
   
			if ($row[$j] == "")
				$printFormat = "N/A";
	
			echo "<td>$row[$j]</td>";
		//}
		$j++;
	}
	$i++;
	echo "</tr>";
}
echo "</table><br/>" .
"<div class='alignRight'><button value='' dojoType='dijit.form.Button' id='backBtn' onClick='window.history.back()'>Back</button></body></html>";
?>