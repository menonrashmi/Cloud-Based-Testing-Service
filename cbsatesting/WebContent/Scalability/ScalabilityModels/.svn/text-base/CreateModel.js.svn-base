
function addMetrics(event)
{
	var numMetrics = document.getElementById("numMetrics");
	var num = numMetrics.options[numMetrics.selectedIndex].text;
	
	i = 1;
	while (i < 6)
	{
		if(i <= num)
			document.getElementById("metric" + i).style.visibility = "visible";
		else
			document.getElementById("metric" + i).style.visibility = "hidden";
		i++;
	}
}

function createModel(event)
{
	document.getElementById("createmodel").action = "AddModel.jsp";
	document.getElementById("createmodel").submit();
}

window.onload = function()
{
	var numMetrics = document.getElementById("numMetrics");
	var num = numMetrics.options[numMetrics.selectedIndex].text;
	
	i = 1;
	while (i < 6)
	{
		if(i <= num)
			document.getElementById("metric" + i).style.visibility = "visible";
		else
			document.getElementById("metric" + i).style.visibility = "hidden";
		i++;
	}
}
