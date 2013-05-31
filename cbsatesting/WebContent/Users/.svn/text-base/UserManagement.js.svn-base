function checkAllBoxes(checked)
{
	var checks = document.getElementsByName("checks");
	for(var i = 0; i < checks.length; i++)
	{
		checks[i].checked = checked;
	}
}

function createAccount(event)
{
	document.location.href = "createAccount.jsp";
}

function deleteUsers(event)
{
	var check = confirm("Are you sure you want to delete the selected users?");
	if(check)
	{
		document.getElementById("users").action = "action/deleteUsers.jsp";
		document.getElementById("users").submit();
	}
}

function displayUser(username)
{
	document.getElementById("users").action = "MyProfile.jsp?username=" + username;
	document.getElementById("users").submit();
}

