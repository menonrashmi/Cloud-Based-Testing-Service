function selectDefault(event)
{
	var check = confirm("Are you sure you want to change the selected metrics to Default?");
	if(check)
	{
		var name = document.getElementById("name").innerHTML;
		var statistic = document.getElementById("statistic").innerHTML;
		document.getElementById("displaymetric").action = "SelectDefault.jsp?Name=" + name +"&Statistic=" + statistic;
		document.getElementById("displaymetric").submit();
	}
}

function deleteMetric(event)
{
	var check = confirm("Are you sure you want to delete the selected metrics?");
	if(check)
	{
		var name = document.getElementById("name").innerHTML;
		var statistic = document.getElementById("statistic").innerHTML;
		document.getElementById("displaymetric").action = "DeleteMetrics.jsp?Name=" + name +"&Statistic=" + statistic;
		document.getElementById("displaymetric").submit();
	}
}

function updateMetric(event)
{
	var name = document.getElementById("name").innerHTML;
	var description = document.getElementById("description").innerHTML;
	var equation = document.getElementById("equation").innerHTML;
	document.getElementById("displaymetric").action = "UpdateMetric.jsp?name=" + name + "&description=" + description + "&equation=" + equation;
	document.getElementById("displaymetric").submit();
}