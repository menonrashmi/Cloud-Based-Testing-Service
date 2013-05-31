<%@page import="com.sun.xml.internal.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% //String myname =  (String)session.getAttribute("username");
	String addresses = (String)session.getAttribute("addresses");
	String email = (String)session.getAttribute("email");
	String phone = (String)session.getAttribute("phone");
	
	 
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>CBSA: Account update</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="project.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript">
 <!--

		//-->
</script>
</head>
<body>
<!-- start header -->
<div id="wrapper">

<div id="header">
	<div id="menu">
		<ul>
			<li>
			<font size="5" face="arial" color="blue" >
<label1>Virtual Test Environment </label1> 

</font>
<font size="5" face="arial" color="blue">
<label2 >Test Tool Management:</label>
</font>

<font size="5" face="arial" color="black">
<label2 >Create Projects:</label><br/><br/>
</font>
		</ul>
	</div>
</div>
<!-- end header -->
<!-- start page -->
<div id="page">
	<!-- start content -->
	<div id="content" style="width: auto;">
		<div class="post">
		  <div class="entry">
		
			<form id="form1" method="post" action="create_folder.jsp" onsubmit="">
				  <label>
				    <input type="text" name="folder_name" id="folder_name" />
				
			      </label>
			  <label>
				    <input type="submit" name="create_folder" id="create_folder" value="Create Project" />
			  </label>
              <table border="2" >
	  <tr>
	    <th style="font-size: 24" align="center" colspan="6" scope="col">Test Tools</th>
	    </tr>
  <tr></tr>
</table>
   <table border="1" cellspacing="1" cellpadding="1">
                <tr>
                  <th scope="col">Project Name</th>
                  <th scope="col">Files</th>

                </tr>
              
                <%
String root="C:\\Users\\Public\\upload-CBSA-TestTool";
java.io.File file;
java.io.File dir = new java.io.File(root);
 
String[] list = dir.list();
for (int i = 0; i < list.length; i++) {
  file = new java.io.File(root + list[i]);
 if (file.isDirectory()) {
	 %>  <tr ><td colspan="1"><%=list[i] %></td></tr>
             
									
										<%
	 String root1="C:\\Users\\Public\\upload-CBSA-TestTool\\"+list[i]+"\\";
	 java.io.File file1;
	 
	 java.io.File dir1 = new java.io.File(root1);
	  
	 String[] list1 = dir1.list();
	
	 for (int j = 0; j < list1.length; j++) {
	   file1 = new java.io.File(root1 + list1[j]);
	if(file1.isDirectory())
  {
	%><tr><td colspan="1" align="right"><%=list1[j] %> </td> 
		
									
									<%  String root2="C:\\Users\\Public\\upload-CBSA-TestTool\\"+list[i]+"\\"+list1[j]+"\\";
 java.io.File file2;
 
 java.io.File dir2 = new java.io.File(root2);
  %><td><%
 String[] list2 = dir2.list();
 for (int k = 0; k < list2.length; k++) {
	   file2 = new java.io.File(root2 + list2[k]);
	   if(file2.isFile()){%>
	   <%= list2[k]%>
		   	
<%	   }
 }%></td>
   <%}}}}
%></tr>

              </table>
								
			  </form>        		  
				</div>
			
		</div>
		
	</div>
	<!-- end content -->
	<!-- start sidebar -->
	<!-- end sidebar -->
	<div style="clear: both;">&nbsp;</div>
</div>
<!-- end page -->

</body>
</html>
