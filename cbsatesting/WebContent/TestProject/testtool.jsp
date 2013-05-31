<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% String myname = (String)session.getAttribute("username"); 
    	String instance_create_success=(String)	session.getAttribute("instance_create_success");
    	String user_id = (String)session.getAttribute("user_id");    	
    
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>TaaS:- Test Environment Setup</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="../WebContent/TestProject/default.css" rel="stylesheet" type="text/css" />
 <script type="text/javascript" language="javascript">
 <!--
	function temp()
 {
 len=document.contract.checkbox.length;
	//alert(len);
	if(len==undefined)
		{len =1;

	 	if(document.contract.checkbox.checked == true){
		 checkBox = document.contract.checkbox.value;
		 tool_name=document.contract.tool.options[document.contract.tool.options.selectedIndex].value;
		 alert(tool_name);
		 alert(checkBox);
		//window.open('generate_contract.jsp?checkBox='+checkBox)
	 	}
	 }else
		 {
		 for(k=0;k<len;k++)
		 {
	 	if(document.contract.checkbox[k].checked == true){
		 checkBox = document.contract.checkbox[k].value; 
		 tool_name=document.contract.tool.options[document.contract.tool.options.selectedIndex].value;
		 alert(tool_name);
		 alert(checkBox);//window.open('generate_contract.jsp?checkBox='+checkBox)
		  	}}			 
		 }
	
 }
--> 
</script>

</head>
<body>
<!-- start header -->
<div id="wrapper">

<div id="header">
	<div id="menu">
		<ul>
		
			<li ><a href="index.jsp">Home</a></li>
			<li><a href="user_account_details.jsp">Account </a></li>
			<li><a href="test_env_setup.jsp">Environment </a></li>
			<li class="current_page_item"><a href="testtool.jsp">TestTool </a></li>
			<li><a href="testware.jsp">Testware </a></li>
			<li><a href="testing_space_new.jsp">Test Space</a></li>
			
					
				
		</ul>
	</div>
</div>
<!-- end header -->
<!-- start page -->
<div id="page">
	<!-- start content -->
	<div id="content" >
		<div class="post">
			<h1 class="title">Test Tools Management</h1>
	<div class="entry">			<%String dburl ="jdbc:mysql://localhost:3306/amazon_instance";
			Class.forName("com.mysql.jdbc.Driver");
 			Connection con = DriverManager.getConnection(dburl, "root", "");
 			Statement statement = con.createStatement();
 			ResultSet rs = statement.executeQuery("SELECT * FROM amazon_instance.instance;");
 			%>

 			<form name="contract" id="form1" method=""  >
			 <table border="2" cellspacing="1" cellpadding="1" width="500" >
			  	<tr>
				 <td ><div align="center"><strong>Instance Id</strong></div></td>
			     <td><div align="center"><strong>OS</strong></div></td>
		     <td colspan="1"><div align="center"><strong>AntEater</strong></div></td>
		     <td colspan="1"><div align="center"><strong>ITP</strong></div></td>
		        </tr>
		      <%int j=0;
		      String[] instance = new String [10];
		      String not_installed = "Not Installed";
		      String tool1,tool2=null;
 			while(rs.next())
 			{	tool1 = rs.getString("tool1");
 				tool2 = rs.getString("tool2");
 				if(tool1.equalsIgnoreCase("null")){
 					tool1="Not Installed";
 				}else {tool1="Installed";}
 				if(tool2.equalsIgnoreCase("null")){
 					tool2="Not Installed";
 				}else {tool2="Installed";}
 				
 				instance[j]=rs.getString("instance_id");
 				//out.print(instance[j]);
			if(rs.getString("tool1").equalsIgnoreCase("null") || rs.getString("tool2").equalsIgnoreCase("null")){%>
			
				  	<tr>
				     <td><input type="checkbox" name="checkbox" id="checkbox %>" value="<%=rs.getString("contract_id") %>" />
			          <%=rs.getString("taas_instance_id") %></td>
				     <td><div align="center"><%=rs.getString("os") %></div></td>
				      <td><div align="center"><%=tool1 %></div></td>
				       <td><div align="center"><%=tool2 %></div></td>
				  
			     <%}j++;
 			}rs.close();
			      
			       %>
			       
			       
  </tr>
  <tr> <td colspan="2"><label>
    <select name="tool" id="tool">
      <option value="tool1" selected="selected">AntEater</option>
      <option value="tool2">ITP Harness</option>
    </select>
  </label></td>
  <td colspan="3"><label>
    <input type="button" name="deploy" id="deploy" value="Deploy" onclick="temp()" />
  </label></td></tr>
</table>     

<p>&nbsp;</p>

<p>&nbsp;</p>
		  </div>
			
		</div>
		
	</div>
	<!-- end content -->
	<!-- start sidebar -->
				</form>
	<!-- end sidebar -->
	<div style="clear: both;">&nbsp;</div>
</div>
<!-- end page -->
<!-- start footer -->
<div id="footer">
	<p id="legal">( c ) 2011. All Rights Reserved by Ashrut and Romil  <a href="#">About</a>  <a href="#">Contact</a></p>
</div>
</div>
<!-- end footer -->
</body>
</html>
