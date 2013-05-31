<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Test Environment Setup</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="project.css" rel="stylesheet" type="text/css" />
<link href="default.css" rel="stylesheet" type="text/css" />
 <script type="text/javascript" language="javascript">
 <!--
		function check() {
	 if(document.forms.form1.os.value=="windows2008r2" && document.forms.form1.architecture.value=="32")
	 {
	 alert("Please select an instance with 64 Bit architecure. Windows 2008 R2 doesnt support x86.");
	 return false;
	 }
	 if(document.forms.form1.instance_type.value=="select_instance" && document.forms.form1.os.value=="select_os")
		 {
		 alert("Please select Instance type and OS");
		 return false;
		 }
}
 function ok() {
	 	
	 	var r =confirm("Are you sure you want to create an instance?");
	 	if(r ==true)
	 		{<%session.setAttribute("ok","ok");%>
	 		window.location="TestProject.html";
	 		return true;}
	 	
	 	else 
	 		return false;
	 }
function Choice()
{
	switch (document.forms.form1.instance_type.value){

case "m1.small":
	document.forms.form1.memory.value="1.7";
	document.forms.form1.architecture.value="32";
	document.forms.form1.cpu.value="1";
	document.forms.form1.storage.value="160";
	break;
case "m1.large":
	document.forms.form1.memory.value="7.5";
	document.forms.form1.architecture.value="64";
	document.forms.form1.cpu.value="4";
	document.forms.form1.storage.value="850";
	break;
case "m1.xlarge":
	document.forms.form1.memory.value="15";
	document.forms.form1.architecture.value="64";
	document.forms.form1.cpu.value="8";
	document.forms.form1.storage.value="1690";
	break;
case "t1.micro":
	document.forms.form1.memory.value="0.613";
	document.forms.form1.architecture.value="32";
	document.forms.form1.cpu.value="2";
	document.forms.form1.storage.value="32";
	break;
case "m2.xlarge":
	document.forms.form1.memory.value="17.1";
	document.forms.form1.architecture.value="64";
	document.forms.form1.cpu.value="6";
	document.forms.form1.storage.value="420";
	break;
case "c1.medium":
	document.forms.form1.memory.value="1.7";
	document.forms.form1.architecture.value="32";
	document.forms.form1.cpu.value="5";
	document.forms.form1.storage.value="320";
	break;
case "c1.xlarge":
	document.forms.form1.memory.value="7";
	document.forms.form1.architecture.value="20";
	document.forms.form1.cpu.value="20";
	document.forms.form1.storage.value="1690";
	break;
default : ;



	}

}

<%
if((String)session.getAttribute("instance_create_success")==("instance_create_success"))
		{%>
		alert("You have successfully created an instance. Please read contract carefully\n\nPassword generation and encryption can sometimes take more than 30 minutes.\n\nPlease wait at least 15 minutes after launching an instance before trying to retrieve the generated password");
		// window.open("generate_contract.jsp"); 
		<%
	session.removeAttribute("instance_create_success");
		} %>
 //-->
</script>

</head>
<body>
<!-- start header -->
<div id="wrapper">

<div id="header">
	<div id="menu">
			<ul>
			<li><a href="test_env_setup.jsp">AWS Environment </a></li>
			
			<li ><a href="testware.jsp">Testware Management</a></li>
			<li class="current_page_item"><a href="testing_space_new.jsp">Test Project</a></li>
		
		</ul>
	</div>
</div>
<!-- end header -->
<!-- start page -->
<div id="page">
	<!-- start content -->
	<div id="content">
		<div class="post">
			<h1 class="title">Create a New Instance</h1>
			<div class="entry">
			
				<form id="form1" method="post"action="create_test_env.jsp">
				  <table width="250" border="0">
				  <tr>
				    <td><label><strong>OS</strong></label></td>
				    <td><label>
				      <select name="os" id="os" onchange="Choice();">
						<option value="select_os">Select OS</option>
				        <option value="orangehrm">Orangehrm</option>
				        <option value="windows2008">Windows 2008</option>
 			            <option value="windows2008r2">Windows 2008 R2</option>
				        <option value="amazonLinux">Amazon Linux</option>
				        <option value="suse">SUSE Linux</option>
                      </select>
				    </label></td>
			      </tr>
				  <tr>
				    <td><strong>Instance Type</strong></td>
				    <td><label>
				      <select name="instance_type" id="instance_type" onchange="Choice();">
				        <option value="select_instance">Select Instance</option>
				         <option value="t1.micro">T1.Micro</option>
				        <option value="m1.small">M1.Small</option>
				        <option value="m1.large">M1.Large</option>
				        <option value="m1.xlarge">M1.Xlarge</option>
				        <option value="m2.xlarge">M2.Xlarge</option>
				        <option value="c1.medium">C1.Medium</option>
				        <option value="c1.xlarge">C1.Xlarge</option>
			          </select>
			        </label></td>
			      </tr>
				  <tr>
				    <td><strong>Memory</strong></td>
				    <td><label>
				      <input readonly="readonly"  name="memory" type="text" id="memory" size="15" />
				    </label></td>
				    </tr>
				  <tr>
				    <td><strong>Architecture (Bit)</strong></td>
				    
				    <td><label>
				      <input readonly="readonly" name="architecture " type="text" id="architecture" size="15" />
				      
				    </label></td>
			      </tr>
				  <tr>
				    <td><strong>Computing (core)</strong></td>
				    <td><label>
				      <input readonly="readonly"  name="cpu" type="text" id="cpu" size="15" />
			        </label></td>
			      </tr>
				  <tr>
				    <td><strong>Storage</strong></td>
				    <td><input readonly="readonly"  name="storage" type="text" id="storage" size="15" />
			        </td>
			      </tr>
				  
				  <tr>
				    <td><strong>Delivery Date</strong></td>
				    <td><input readonly="readonly"  name="current_date" type="text" id="current_date" size="15" /></td>
				    </tr>
				  <tr>
				    <td>&nbsp;</td>
				    <td>
				    	<input type="submit" id="submit" value="submit" />
				    	<INPUT TYPE="button" VALUE="Back" onClick="history.go(-1);" />
				    <!--  <input name="confirm" type="submit" onClick="return ok()"  id="confirm" value="confirm" /> --></td>
				    </tr>
				    
				  </table>
				  	
               
<p>&nbsp;</p>
 
	          </form>
<p>&nbsp;</p>
		
</body>
</html>
