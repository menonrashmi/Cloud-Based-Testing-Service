//importClass(java.net.URLEncoder);

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
		document.getElementById("performancemetrics").action = "PerformanceMetrics/SelectDefault.jsp";
		document.getElementById("performancemetrics").submit();
	}
}

function deleteMetric(event)
{
	var check = confirm("Are you sure you want to delete the selected metrics?");
	if(check)
	{
		document.getElementById("performancemetrics").action = "PerformanceMetrics/DeleteMetrics.jsp";
		document.getElementById("performancemetrics").submit();
	}
}

function createMetric(event)
{
	document.getElementById("performancemetrics").action = "PerformanceMetrics/CreateMetric.jsp";
	document.getElementById("performancemetrics").submit();
}

function goToModel(event)
{
	document.getElementById("performancemetrics").action = "PerformanceModels.jsp";
	document.getElementById("performancemetrics").submit();
}

function displayMetric(metric, statistic)
{
	//var name = metric.replace(/ /g, '%20');
	//var name = URLEncoder.encode(metric, "UTF-8");
	var name = encodeURIComponent(metric); // this is to parse input like ThroughputRatio(%) - having special characters ( % and )
	document.getElementById("performancemetrics").action = "PerformanceMetrics/DisplayMetric.jsp?Name=" + name +"&Statistic=" + statistic;
	document.getElementById("performancemetrics").submit();
}