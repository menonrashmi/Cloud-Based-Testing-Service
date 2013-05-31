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
	document.getElementById("performancerunner").action = "PerformanceModels.jsp";
	document.getElementById("performancerunner").submit();
}

function goToMonitor(event)
{
	document.getElementById("performancerunner").action = "PerformanceMonitor.jsp";
	document.getElementById("performancerunner").submit();
}

function displayModel(model)
{
	var name = model.replace(/ /g, '%20');
	document.getElementById("performancerunner").action = "PerformanceModels/DisplayModel.jsp?Name=" + name;
	document.getElementById("performancerunner").submit();
}

function Run(event)
{
	if (validateSettings())
	{
		document.getElementById("performancerunner").action = "Run";
		document.getElementById("performancerunner").submit();
	}
}

function Stop(event)
{
	document.getElementById("performancerunner").action = "Stop";
	document.getElementById("performancerunner").submit();
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

















