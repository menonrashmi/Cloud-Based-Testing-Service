function checkAllBoxes(checked)
{
	var checks = document.getElementsByName("checks");
	for(var i = 0; i < checks.length; i++)
	{
		checks[i].checked = checked;
	}
}

function goToRunner(event)
{
	document.getElementById("performancemonitor").action = "PerformanceRunner.jsp";
	document.getElementById("performancemonitor").submit();
}

function goToReport(event)
{
	document.getElementById("performancemonitor").action = "PerformanceReports.jsp";
	document.getElementById("performancemonitor").submit();
}

function displayModel(modelName)
{
	var name = modelName.replace(/ /g, '%20');
	document.getElementById("performancemonitor").action = "PerformanceModels/DisplayModel.jsp?Name=" + name;
	document.getElementById("performancemonitor").submit();
}

function viewPolygon(modelName)
{
	
	var name = modelName.replace(/ /g, '%20');
	document.getElementById("performancemonitor").action = "PerformanceMonitor/ViewPolygon.jsp?Name=" + name;
	document.getElementById("performancemonitor").submit();
}

function viewStatistics(modelName)
{
	var name = modelName.replace(/ /g, '%20');
	document.getElementById("performancemonitor").action = "PerformanceMonitor/ViewStatistics.jsp?Name=" + name;
	document.getElementById("performancemonitor").submit();
}

function generateReport(modelName)
{
	var name = modelName.replace(/ /g, '%20');
	document.getElementById("performancemonitor").action = "PerformanceMonitor/DisplayReport.jsp?Name=" + name;
	document.getElementById("performancemonitor").submit();
}

