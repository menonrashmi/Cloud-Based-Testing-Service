function TreeOnClick(item, node, event)
{ 
	var label = ItemFileReadStore_1.getLabel(item);
	
	if(label == "Personal Information")
		label = "/cbsatesting/Users/PersonalInformation.jsp";

	if(label == "Account Settings")
		label = "/cbsatesting/Users/AccountSettings.jsp";
	
	if(label == "Privacy")
		label = "/cbsatesting/Users/Privacy.jsp";
	
	if(label == "Users (Administration only)")
		label = "/cbsatesting/Users/UserManagement.jsp";

	parent.document.getElementById("ContentFrame").src = label;
}
