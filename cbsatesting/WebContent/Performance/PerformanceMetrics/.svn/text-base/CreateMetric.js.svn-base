function create(event)
{
	if (document.getElementById("name").value == "")
	{
		alert("Enter a value for the 'Name' field.");
		return;
	}
	if (document.getElementById("coefficient1").value == "")
	{
		alert("Enter a value for the 'Coefficient 1' field.");
		return;
	}
	if (document.getElementById("coefficient1").value != "")
	{
		var strString = document.getElementById("coefficient1").value;
		var strValidChars = "0123456789.-";
		var strChar;
		var result = true;

		for (i = 0; i < strString.length && result == true; i++)
		{
			strChar = strString.charAt(i);
			if (strValidChars.indexOf(strChar) == -1)
			{
				result = false;
			}
		}
		if(!result)
		{
			alert("Coefficient 1 must be a numeric value.");
			return;
		}
		
	}
	if (document.getElementById("coefficient2").value == "")
	{
		alert("Enter a value for the 'Coefficient 2' field.");
		return;
	}
	if (document.getElementById("coefficient2").value != "")
	{
		var strString = document.getElementById("coefficient2").value;
		var strValidChars = "0123456789.-";
		var strChar;
		var result = true;

		for (i = 0; i < strString.length && result == true; i++)
		{
			strChar = strString.charAt(i);
			if (strValidChars.indexOf(strChar) == -1)
			{
				result = false;
			}
		}
		if(!result)
		{
			alert("Coefficeint 2 must be a numeric value.");
			return;
		}
	}

	document.getElementById("name").disabled = false;
	document.getElementById("createmetric").action = "AddMetric.jsp";
	document.getElementById("createmetric").submit();
}