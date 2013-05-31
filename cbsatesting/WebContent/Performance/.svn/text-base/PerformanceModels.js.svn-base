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
	var check = confirm("Are you sure you want to change the selected model to Default?");
	if(check)
	{
		document.getElementById("performancemodels").action = "PerformanceModels/SelectDefault.jsp";
		document.getElementById("performancemodels").submit();
	}
}

function deleteModel(event)
{
	var check = confirm("Are you sure you want to delete the selected model?");
	if(check)
	{
		document.getElementById("performancemodels").action = "PerformanceModels/DeleteModels.jsp";
		document.getElementById("performancemodels").submit();
	}
}

function createModel(event)
{
	document.getElementById("performancemodels").action = "PerformanceModels/CreateModel.jsp";
	document.getElementById("performancemodels").submit();
}

function goToMetric(event)
{
	document.getElementById("performancemodels").action = "PerformanceMetrics.jsp";
	document.getElementById("performancemodels").submit();
}

function goToRunner(event)
{
	document.getElementById("performancemodels").action = "PerformanceRunner.jsp";
	document.getElementById("performancemodels").submit();
}

function displayModel(model)
{
	var name = model.replace(/ /g, '%20');
	document.getElementById("performancemodels").action = "PerformanceModels/DisplayModel.jsp?Name=" + name;
	document.getElementById("performancemodels").submit();
}