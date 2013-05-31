function TreeOnClick(item, node, event)
{ 
	var label = ItemFileReadStore_1.getLabel(item);
	label = label.replace(/ /g, "");
	if(label=="GUITestResults")
	 {
	   parent.document.getElementById("ContentFrame").src = "simulation/jmeterResults.php?tool=Selenium";
	 }
	else if(label=="LoadTestResults")
   {
     parent.document.getElementById("ContentFrame").src = "simulation/jmeterResults.php?tool=JMeter";
   }
	else if(label=="GUITestScripts")
	{
	   parent.document.getElementById("ContentFrame").src = "simulation/Testscript.php?type=gui";
	}
	else if(label=="LoadTestScripts")
	  {
      parent.document.getElementById("ContentFrame").src = "simulation/Testscript.php?type=load";
   }
	else if(label=="TestResults")
   {
    parent.document.getElementById("ContentFrame").src = "simulation/testResults.php?type=load";
 }
	else{
	
	label = "/cbsatesting/TreeFrames/" + label + ".jsp";

	parent.document.getElementById("ContentFrame").src = label;
	}
}
