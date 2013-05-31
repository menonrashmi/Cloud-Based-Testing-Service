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
		document.getElementById("scalabilitymodels").action = "ScalabilityModels/SelectDefault.jsp";
		document.getElementById("scalabilitymodels").submit();
	}
}

function deleteModel(event)
{
	var check = confirm("Are you sure you want to delete the selected model?");
	if(check)
	{
		document.getElementById("scalabilitymodels").action = "ScalabilityModels/DeleteModels.jsp";
		document.getElementById("scalabilitymodels").submit();
	}
}

function createModel(event)
{
	document.getElementById("scalabilitymodels").action = "ScalabilityModels/CreateModel.jsp";
	document.getElementById("scalabilitymodels").submit();
}

function goToMetric(event)
{
	document.getElementById("scalabilitymodels").action = "ScalabilityMetrics.jsp";
	document.getElementById("scalabilitymodels").submit();
}

function goToRunner(event)
{
	document.getElementById("scalabilitymodels").action = "ScalabilityRunner.jsp";
	document.getElementById("scalabilitymodels").submit();
}

function displayModel(model)
{
	var name = model.replace(/ /g, '%20');
	document.getElementById("scalabilitymodels").action = "ScalabilityModels/DisplayModel.jsp?Name=" + name;
	document.getElementById("scalabilitymodels").submit();
}