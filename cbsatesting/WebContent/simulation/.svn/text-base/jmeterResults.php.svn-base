<?php
if (isset ($_GET['tool']) && $_GET['tool'] == "Selenium")
	$tool = "seleniumresult";
else
	$tool = "jmeterresult";
if (isset ($_GET['testID']) && $_GET['testID'] !== "")
	$query = "select * from " . $tool . " where testResultID=" . $_GET['testID'] . " order by testresultid desc";

else
	$query = "select * from " . $tool . " order by testresultid desc LIMIT 0 , 1000";

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
"<body class='claro'><h2>" . $_GET['tool'] . " Test Results</h2><table class='blueTable'><tr>";
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

		if ($tool == "seleniumresult" && $j == 6) {
			echo "<td><a href='../../src/seleniumResults/".$row[1]."/" . $row[$j] . ".html'>Link to Result</a></td>";
		} else {
			if ($row[$j] == "")
				$printFormat = "N/A";
			else {
				$printFormat = str_replace('%3A', ':', $row[$j]);
				$printFormat = str_replace('%2F', '/', $printFormat);
				$printFormat = str_replace('%5C', '\\', $printFormat);
			}
			echo "<td>$printFormat</td>";
		}
		$j++;
	}
	$i++;
	echo "</tr>";
}
echo "</table><br/>" ."<div class='alignRight'><button value='' dojoType='dijit.form.Button' id='backBtn' onClick='window.history.back()'>Back</button></body></html>";

?>