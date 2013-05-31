<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.amazonaws.services.ec2.model.DescribeInstancesResult"%>
<%@page import="com.amazonaws.services.ec2.model.DescribeInstancesRequest"%>
<%@page import="com.amazonaws.auth.BasicAWSCredentials"%>
<%@page import="com.amazonaws.services.ec2.AmazonEC2Client"%>
<%@page import="com.amazonaws.auth.AWSCredentials"%>
<%@ page import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String myname =  (String)session.getAttribute("username");
	//String addresses = (String)session.getAttribute("addresses");
	//String email = (String)session.getAttribute("email");
	//String phone = (String)session.getAttribute("phone");
	String user_id = (String)session.getAttribute("user_id");
	String termination_success=(String)session.getAttribute("termination_success");
	String secretkey="wye9KJ3vioi4MP8uDwBKy0Q/J9fNRciW8CM+EU5A"; //MNJ - replaced old with new secret key.
 	String accesskey="AKIAIMEH6LATDIR5P6IA";   //MNJ - replaced old with new access key.
 	String startdate=null;
	
	   AWSCredentials credentials = new BasicAWSCredentials(accesskey,secretkey);    
	   AmazonEC2Client ec2 = new AmazonEC2Client(credentials);
	   ec2.setEndpoint("https://ec2.us-east-1.amazonaws.com"); 
	   DescribeInstancesResult desc_result = new DescribeInstancesResult();
	   DescribeInstancesRequest desc_request = new DescribeInstancesRequest();
	
	
	if(termination_success=="termination_success")
	{
		Thread.sleep(3000);
		response.sendRedirect("test_env_delete.jsp");
		session.removeAttribute("termination_success");
	}
	
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>CBSA Account update</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="project.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript">
 
		function temp(String)
	 {
	 len=document.contract.checkbox.length;
	//alert(len);
	 //alert(String);
	if(len==undefined)
		{len=1;
	 	 	if(document.contract.checkbox.checked == true){
			
		 		checkBox = document.contract.checkbox.value; 
			//alert(checkBox);
		 		window.open('confirm_delete_env.jsp?checkBox='+checkBox+"&edit_type="+String);  
		
		 	
		 }}else
			 {
			 for(k=0;k<len;k++)
			 {
			
		 	if(document.contract.checkbox[k].checked == true){
			
		 		checkBox = document.contract.checkbox[k].value; 
		//	alert(checkBox);
		 		window.open('confirm_delete_env.jsp?checkBox='+checkBox+"&edit_type="+String);    
		 		
		 	}
		 	
		 } 
			 }
	 }
 function delete_env(String)
 {
if(String=="start"){var r= confirm('Are you sure you want to start instance?');}
if(String=="stop"){var r= confirm('Are you sure you want to stop instance?');}
if(String=="terminate"){
var r= confirm('Are you sure you want to terminate instance?');}
	 if(r == true)
		 {
		 //alert('you selected yes');
		temp(String);
		alert('Please refresh to get latest status');
		return true;}
			
	 else(r==false)
	 {return false;
		}
 }

 
</script>
</head>
<body>
<!-- start header -->
<div id="wrapper">
<div id="logo">
	
	<h2>
	</h2>
</div>
<div id="header">
	<div id="menu">
		<ul>
			
			<font size="5" face="arial" color="blue" >
<label1>Virtual Test Environment </label1> 

</font>
<font size="5" face="arial" color="blue">
<label2 > >Test Projects</label>
</font>
</font>
<font size="5" face="arial" color="black">
<label2 >>Manage Instance:</label><br/><br/>
</font>
			
				<%
				%>	
				</ul>
	</div>
</div>
<!-- end header -->
<!-- start page -->
<div id="page">
	<!-- start content -->
	<div id="content" style="width: auto;">
		<div class="post">
			<h1 class="title">Environment Details</h1>
			<div class="entry">
			<%String dburl ="jdbc:mysql://localhost:3306/amazon_instance";
			Class.forName("com.mysql.jdbc.Driver");
 			Connection con = DriverManager.getConnection(dburl, "root", "");
 			Statement statement = con.createStatement();
 			ResultSet rs = statement.executeQuery("SELECT * FROM instance;");
 			%>

		<form name="contract" id="form1" method="post"  >
			 <table border="1" cellspacing="1" cellpadding="1">
			  	<tr>
                
				 <td  ><strong>   Instance  Id  </strong></td>
				 <td ><strong>Public DNS Name</strong></td>
			     <td><strong>OS</strong></td>
			     <td><strong>Memory</strong></td>
			     <td><strong>Storage</strong></td>
			     <td><strong>Signed By</strong></td>
			     <td><strong>Date Created</strong></td>
			     <td><strong>Client </strong></td>
			     <td><strong>Current Status</strong></td>
		       </tr>
		      <%int i=0;
 			while(rs.next())
 			{
 			ArrayList<String> instancesId = new ArrayList<String>();
 		
 				String current_state = rs.getString("current_state");
 				System.out.print("current_state: " +current_state);
 				if(current_state != null && current_state.equalsIgnoreCase("terminate")){     //MNJ - added:  current_state!=null && 
 					System.out.println("In terminated state");
 				}
 				else
 				{ 					
 					System.out.println("Not in terminated state");
 					instancesId.add(rs.getString("amazon_instance_id"));
 		 			desc_request.setInstanceIds(instancesId);
 		 			System.out.print(instancesId);
 		 			//error
 		 				desc_result= ec2.describeInstances(desc_request);	
 		 				String tempStr = desc_result.toString();			
 			  //StringTokenizer stringTokenizer = new StringTokenizer(tempStr);    			
	          //System.out.print(stringTokenizer.toString());
 			  System.out.print("Temp Str: " + tempStr);
				String[] arr1 = tempStr.split("State: ");
				String[] arr2 = arr1[1].split(",");
				String[]  arr3 = arr2[1].split(":");
			//	out.println(desc_result.toString());
			String[] arr4 = desc_result.toString().split("PublicDnsName: ");
			String[] arr5 = arr4[1].split(",");
			
				//ut.println("PubcliDnsName:"+ arr5[0]);
				startdate = rs.getString("date_signed");				
				session.setAttribute("startdate", startdate);
			%>
			
				  	<tr>
                    <td > <input type="checkbox" name="checkbox" id="checkbox"<%=i%> value="<%=rs.getString("amazon_instance_id") %>" />
                    <%=rs.getString("amazon_instance_id") %></td>
				     <td><%=arr5[0]%></td>
				     <td><%=rs.getString("os") %></td>
				     <td><%=rs.getString("ram") %></td>
				     <td><%=rs.getString("storage") %></td>
				     <td><%=rs.getString("signed_by") %></td>
				     <td><%=rs.getString("Start_date") %></td>
				     <td><%=rs.getString("client_name") %></td>
				     <td><%=arr3[1]%></td>				     			 
			       </tr><%}i++;
			       }rs.close(); %>
			       <tr>
				
		       </tr>
			      </table>
			      <table>
			      <tr>
			      <td ></td>
			      <td></td>
			      <td><input name="stop" id="stop_instance" type="button" value="Stop" onclick="delete_env('stop')"/></td>
			      <td><input name="start" id="start_instance" type="button" value="Start" onclick="delete_env('start')"/></td>
			      <td><input name="terminate" id="terminate_instance" type="button" value="Terminate" onclick="delete_env('terminate')"/></td>
			      <td><input name="refresh" id="refresh_instance" type="button" value="Refresh" onclick="javascript:window.location='test_env_delete.jsp'"/></td>
			      </tr></table>
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

</div>
<!-- end footer -->
</body>
</html>
