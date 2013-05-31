<%@ page import="java.sql.*"%>
<%@ page import="com.sun.xml.internal.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String myname =  (String)session.getAttribute("username");
	//String addresses = (String)session.getAttribute("addresses");
	//String email = (String)session.getAttribute("email");
	//String phone = (String)session.getAttribute("phone");
	String user_id = (String)session.getAttribute("user_id");
	
	
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>TaaS: Account update</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript">
 <!--
		function temp(String)
	 {
	 len=document.contract.checkbox.length;
		//alert(len);
		if(len==undefined)
			{len =1;
	
		 	if(document.contract.checkbox.checked == true){
			 checkBox = document.contract.checkbox.value; 
		//	alert(checkBox);
			if(String == 'print'){
			window.location='pricing_gui.jsp?checkBox='+checkBox;}
			else
				{window.open('generate_contract.jsp?checkBox='+checkBox)}
		 	}
		 }else
			 {
			 for(k=0;k<len;k++)
			 {
		 	if(document.contract.checkbox[k].checked == true){
			 checkBox = document.contract.checkbox[k].value; 
			//alert(checkBox); 
			if(String == 'print'){
				window.location='pricing_gui.jsp?checkBox='+checkBox;}
				else
					{window.open('generate_contract.jsp?checkBox='+checkBox)}
			  	}}			 
			 }
		
	 }
 //-->
</script>
</head>
<body>
<!-- start header -->
<div id="wrapper">
<div id="logo">
	<h1><a href="index.jsp">Cloudtaas-Testing as a service on Cloud</a></h1>
	<h2>
	</h2>
</div>
<div id="header">
	<div id="menu">
		<ul>
			<li >
			<a href="index.jsp">Home</a></li>
			<li  ><a href="user_account_details.jsp">Account</a></li>
			<li><a href="pricing.jsp">Price</a></li>
			<li><a href="reporting.jsp">Report</a></li>
			<li><a href="billing.jsp">Bill</a></li>
			<li class="current_page_item"><a href="contract.jsp">Contract</a></li>
					</ul>
	</div>
</div>
<!-- end header -->
<!-- start page -->
<div id="page">
	<!-- start content -->
	<div id="content" style="width:auto">
		<div class="post">
			<h1 class="title">Contract Details</h1>
			<div class="entry">
			<%String dburl ="jdbc:mysql://localhost:3306/amazon_instance";
			Class.forName("com.mysql.jdbc.Driver");
 			Connection con = DriverManager.getConnection(dburl, "root", "");
 			Statement statement = con.createStatement();
 			//ResultSet rs = statement.executeQuery("SELECT contract.contract_id,contract.fk_user_id,contract.vendor,contract.client_name,contract.date_signed,contract.signed_by,"+
 					//"instance.os,instance.ram, instance.storage,instance.amazon_instance_id , instance.taas_instance_id FROM taas_schema.contract,taas_schema.instance WHERE contract.contract_id=instance.fk_contract_id and contract.fk_user_id='"+user_id+"';");
 			ResultSet rs = statement.executeQuery("SELECT * from virtual_instance");
 			%>

 			<form name="contract" id="form1" method="post"  >
			 <table border="2" cellspacing="1" cellpadding="1">
			  	<tr>
			
			     <td ><div align="left"><strong>Instance Id</strong></div></td>
			     <td><div align="center"><strong>OS</strong></div></td>
			     <td><div align="center"><strong>Memory</strong></div></td>
			     <td><div align="center"><strong>Storage</strong></div></td>
			     <td><div align="center"><strong>Signed By</strong></div></td>
			     <td><div align="center"><strong>Date of contract</strong></div></td>
			     <td><div align="center"><strong>Client Name</strong></div></td>
		       </tr>
		      
			       
				<td colspan="8"><div align="center">
				  <input name="submit" id="generate_contract" type="submit" value="Generate" onclick="temp('generate_contract')" />				  
				  <input name="print_contract" id="print_contract" type="button" value="Print" onclick="temp('print')"/>
				  </div></td>
		       </tr>
			      </table>
				 <p>&nbsp;</p>
	          </form>
	          <%


con.close();
%>
	         
<p>&nbsp;</p>
		  </div>
			
		</div>
		
	</div>
	<!-- end content -->
	<!-- start sidebar -->
	<!-- end sidebar -->
	<div style="clear: both;">&nbsp;</div>
</div>

</body>
</html>
