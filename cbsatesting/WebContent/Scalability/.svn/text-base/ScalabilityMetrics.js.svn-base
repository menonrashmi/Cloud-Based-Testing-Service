function checkAllBoxes(checked)
{
	var checks = document.getElementsByName("checks");
	for(var i = 0; i < checks.length; i++)
	{
		checks[i].checked = checked;
	}
}

function selectDefault(event)
{
	var check = confirm("Are you sure you want to change the selected metrics to Default?");
	if(check)
	{
		document.getElementById("scalabilitymetrics").action = "ScalabilityMetrics/SelectDefault.jsp";
		document.getElementById("scalabilitymetrics").submit();
	}
}

function deleteMetric(event)
{
	var check = confirm("Are you sure you want to delete the selected metrics?");
	if(check)
	{
		document.getElementById("scalabilitymetrics").action = "ScalabilityMetrics/DeleteMetrics.jsp";
		document.getElementById("scalabilitymetrics").submit();
	}
}

function createMetric(event)
{
	document.getElementById("scalabilitymetrics").action = "ScalabilityMetrics/CreateMetric.jsp";
	document.getElementById("scalabilitymetrics").submit();
}

function goToModel(event)
{
	document.getElementById("scalabilitymetrics").action = "ScalabilityModels.jsp";
	document.getElementById("scalabilitymetrics").submit();
}

function displayMetric(metric, statistic)
{
	var name = metric.replace(/ /g, '%20');
	document.getElementById("scalabilitymetrics").action = "ScalabilityMetrics/DisplayMetric.jsp?Name=" + name +"&Statistic=" + statistic;
	document.getElementById("scalabilitymetrics").submit();
}