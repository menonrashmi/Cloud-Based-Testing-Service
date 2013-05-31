<%@ page import="java.util.*" %>
<html>
<body>
<%! String[] sports; %>
<center>You have selected: 
<% 
   sports = request.getParameterValues("sports");
   if (sports != null) 
   {
      for (int i = 0; i < sports.length; i++) 
      {
         out.println ("something is selected");
      }
   }
   else out.println ("<b>none<b>");
   
 //UPDATE  `scalabilitymetric` SET  `isDefault` =  '0' WHERE  `scalabilitymetric`.`MetricID` =9;
 
%>

		
		<% 
            if(request.getParameter("selectdefault") != null) 
            {
            	String name = request.getParameter("default");
            	out.println(name);

            	String ParameterNames = "";
            	Enumeration<String> e = request.getParameterNames();
            	while(e.hasMoreElements()){
            		ParameterNames = (String) e.nextElement();
            		out.println("<br/>" + ParameterNames + "<br/>");
            	}
            }
        %>
        
</center>
</body>
</html>