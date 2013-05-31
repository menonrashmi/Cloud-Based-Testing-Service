<%@ page import="java.sql.*"%>
<%@ page import="com.sun.xml.internal.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String myname =  (String)session.getAttribute("username");
	//String addresses = (String)session.getAttribute("addresses");
	//String email = (String)session.getAttribute("email");
	//String phone = (String)session.getAttribute("phone");
	String user_id = (String)session.getAttribute("user_id");
	if (myname==null)
    {
    	response.sendRedirect("index.jsp");
    }
	
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
		alert(len);
		if(len==undefined)
			{len =1;
	
		 	if(document.contract.checkbox.checked == true){
			 checkBox = document.contract.checkbox.value; 
			alert(checkBox);
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
			alert(checkBox); 
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
			<li class="current_page_item"><a href="reporting.jsp">Report</a></li>
			<li><a href="billing.jsp">Bill</a></li>
			<li ><a href="contract.jsp">Contract</a></li>
				<%if (myname!=null && myname!="error")
				out.print("<b><li style=\"text-align: right;\"><a \" href=\"logout.jsp\" >Logout</a></li></b>");
				else
				out.print("<b><li style=\"text-align: right;\"><a \" href=\"login.jsp\" >Login/Signup</a></li></b>");
				%>
		</ul>
	</div>
</div>
<!-- end header -->
<!-- start page -->
<div id="page">
	<!-- start content -->
	<div id="content" style="width:auto">
		<div class="post">
			<h1 class="title">Contract Report</h1>
			<div class="entry">
			<%String dburl ="jdbc:mysql://localhost:3306/taas_schema";
			Class.forName("com.mysql.jdbc.Driver");
 			Connection con = DriverManager.getConnection(dburl, "root", "root");
 			Statement statement = con.createStatement();
 			ResultSet rs = statement.executeQuery("SELECT * FROM taas_schema.contract,taas_schema.instance WHERE contract.contract_id=instance.fk_contract_id and contract.fk_user_id='"+user_id+"';");
 			%>

 			<form name="contract" id="form1" method="post"  >
			 <table border="2" align="center" cellpadding="1" cellspacing="1">
			  	<tr>
				<td></td>
			     <td ><strong>Instance Id</strong></td>
			     <td><strong>OS</strong></td>
			     <td><strong>Memory</strong></td>
			     <td><strong>Storage</strong></td>
			     <td><strong>Signed By</strong></td>
			     <td><strong>Date of Contract</strong></td>
			     <td><strong>Client</strong></td>
			     <td><strong>Vendor</strong></td>
			     <td><strong>Instance Type</strong></td>
		       </tr>
		      <%int i=0;
 			while(rs.next())
 			{	
 				 			
			%>
			
				  	<tr>
				     <td> <label>
				       <input type="checkbox" name="checkbox" id="checkbox %>" value="<%=rs.getString("contract_id") %>" />
			          </label></td>
				     <td style="text-align: center;"><%=rs.getString("taas_instance_id") %></td>
				     <td style="text-align: center;"><%=rs.getString("os") %></td>
				     <td style="text-align: center;"><%=rs.getString("ram") %></td>
				     <td style="text-align: center;"><%=rs.getString("storage") %></td>
				     <td style="text-align: center;"><%=rs.getString("signed_by") %></td>
				     <td style="text-align: center;"><%=rs.getString("date_signed") %></td>
				     <td style="text-align: center;"><%=rs.getString("client_name") %></td>
				     <td style="text-align: center;"><%=rs.getString("vendor") %></td>
				     <td style="text-align: center;"><%=rs.getString("instance_type") %></td>
				     			     
			       </tr><%i++;}rs.close(); %>
			       <tr>
				<td colspan="10"><div align="center">
				  <input name="submit" id="generate_contract" type="submit" value="Generate" onclick="temp('generate_contract')" />				  
				            <input name="print_contract" id="print_contract" type="button" value="Print" onclick="temp('print')"/>
				  </div></td>
		       </tr>
			      </table>
				 <p>&nbsp;</p>
	          </form>
	          <%

String select[] = request.getParameterValues("radio"); 
if (select != null && select.length != 0) {
out.println("You have selected: ");
for (int m = 0; m< select.length; m++) {
out.println(select[i]); 
}
}
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
<!-- end page -->
<!-- start footer -->
<div id="footer">
	<p id="legal">( c ) 2008. All Rights Reserved by Ashrut and Romil  <a href="about.jsp">About</a>  <a href="contact.jsp">Contact</a>
			</p>
</div>
</div>
<!-- end footer -->
</body>
</html>
