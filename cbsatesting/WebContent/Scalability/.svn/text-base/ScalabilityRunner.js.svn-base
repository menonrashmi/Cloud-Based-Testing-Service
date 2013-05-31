function checkAllBoxes(checked)
{
	var checks = document.getElementsByName("checks");
	for(var i = 0; i < checks.length; i++)
	{
		checks[i].checked = checked;
	}
}

function goToModel(event)
{
	document.getElementById("scalabilityrunner").action = "ScalabilityModels.jsp";
	document.getElementById("scalabilityrunner").submit();
}

function goToMonitor(event)
{
	document.getElementById("scalabilityrunner").action = "ScalabilityMonitor.jsp";
	document.getElementById("scalabilityrunner").submit();
}

function displayModel(model)
{
	var name = model.replace(/ /g, '%20');
	document.getElementById("scalabilityrunner").action = "ScalabilityModels/DisplayModel.jsp?Name=" + name;
	document.getElementById("scalabilityrunner").submit();
}

function Run(event)
{
	if (validateSettings())
	{
		document.getElementById("scalabilityrunner").action = "Run";
		document.getElementById("scalabilityrunner").submit();
	}
}

function Stop(event)
{
	document.getElementById("scalabilityrunner").action = "Stop";
	document.getElementById("scalabilityrunner").submit();
}

function validateSettings()
{
	if(document.getElementById("AWSAccessKeyId").value == "")
	{
		alert("AWS Access Key ID cannot be left blank.");
		return false;
	}
	
	if(document.getElementById("AWSSecretAccessKey").value == "")
	{
		alert("AWS Secret Access Key cannot be left blank.");
		return false;
	}
	
//	var today = new Date();
//	var todayFormatted = (today.getMonth() + 1) + "-" + (today.getDate()) + "-" + today.getFullYear();
//	if(document.getElementById("startDate").value > (todayFormatted))
//	{
//		alert("Start date must be before today's Date." + todayFormatted);
//		return false;
//	}
	return true;
}

















