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
	document.getElementById("scalabilitymonitor").action = "ScalabilityRunner.jsp";
	document.getElementById("scalabilitymonitor").submit();
}

function goToReport(event)
{
	document.getElementById("scalabilitymonitor").action = "ScalabilityReports.jsp";
	document.getElementById("scalabilitymonitor").submit();
}

function displayModel(modelName)
{
	var name = modelName.replace(/ /g, '%20');
	document.getElementById("scalabilitymonitor").action = "ScalabilityModels/DisplayModel.jsp?Name=" + name;
	document.getElementById("scalabilitymonitor").submit();
}

function viewPolygon(modelName)
{
	var name = modelName.replace(/ /g, '%20');
	document.getElementById("scalabilitymonitor").action = "ScalabilityMonitor/ViewPolygon.jsp?Name=" + name;
	document.getElementById("scalabilitymonitor").submit();
}

function viewStatistics(modelName)
{
	var name = modelName.replace(/ /g, '%20');
	document.getElementById("scalabilitymonitor").action = "ScalabilityMonitor/ViewStatistics.jsp?Name=" + name;
	document.getElementById("scalabilitymonitor").submit();
}

function generateReport(modelName)
{
	var name = modelName.replace(/ /g, '%20');
	document.getElementById("scalabilitymonitor").action = "ScalabilityMonitor/DisplayReport.jsp?Name=" + name;
	document.getElementById("scalabilitymonitor").submit();
}

