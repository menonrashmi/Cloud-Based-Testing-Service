function selectDefault(event)
{
	var check = confirm("Are you sure you want to change the selected metrics to Default?");
	if(check)
	{
		var name = document.getElementById("name").innerHTML;
		document.getElementById("displaymodel").action = "SelectDefault.jsp?Name=" + name;
		document.getElementById("displaymodel").submit();
	}
}

function deleteModel(event)
{
	var check = confirm("Are you sure you want to delete the selected metrics?");
	if(check)
	{
		var name = document.getElementById("name").innerHTML;
		document.getElementById("displaymodel").action = "DeleteModels.jsp?Name=" + name;
		document.getElementById("displaymodel").submit();
	}
}

function updateModel(event)
{
	var name = document.getElementById("name").innerHTML;
	var description = document.getElementById("description").innerHTML;
	var numMetrics = document.getElementById("numMetrics").innerHTML;
	document.getElementById("displaymodel").action = "UpdateModel.jsp?Name=" + name + "&Description=" + description + "&NumMetrics=" + numMetrics;
	document.getElementById("displaymodel").submit();
}

function displayMetric(metric, statistic)
{
	var name = metric.replace(/ /g, '%20');
	document.getElementById("displaymodel").action = "../ScalabilityMetrics/DisplayMetric.jsp?Name=" + name + "&Statistic=" + statistic;
	document.getElementById("displaymodel").submit();
}