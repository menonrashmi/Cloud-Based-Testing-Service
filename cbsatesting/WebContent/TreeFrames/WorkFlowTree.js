function TreeOnClick(item, node, event)
{ 
	var label = ItemFileReadStore_1.getLabel(item);
	
	if(label == "Create Workflow")
		label = "/cbsatesting/WorkFlowManagement/Create_Workflow.html";
	else if(label == "View Workflow")
		label = "/cbsatesting/WorkFlowManagement/ViewWorkflow.jsp";
	
	parent.document.getElementById("ContentFrame").src = label;
}