<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<% 

String path = "C:\\Users\\Public\\upload-CBSA-TestTool";

String myname = (String)session.getAttribute("username"); 
   String user_id = (String)session.getAttribute("user_id"); 
    	String instance_create_success=(String)	session.getAttribute("instance_create_success");
		
		String selected_name= request.getParameter("project_name");
		session.setAttribute("selected_project_name", selected_name);
		String taas_instance_id=" ",os=" ",instance_type=" ",tool1=" ",tool2=" ";
		//session.setAttribute("temp_name",selected_name);
    
    if(selected_name==null)
    {
    	selected_name="";
    	//selected_name = (String) session.getAttribute("temp_name");
    }
    if(selected_name!=null && selected_name!=""){
    	String dburl ="jdbc:mysql://localhost:3306/amazon_instance";
    	Class.forName("com.mysql.jdbc.Driver");
    	Connection con = DriverManager.getConnection(dburl, "root", "");
    	Statement statement = con.createStatement();
    	ResultSet rs = statement.executeQuery("select * from amazon_instance.project, amazon_instance.instance where "+
    			"project.fk_resource_id=instance.taas_instance_id  and project.project_name='"+selected_name+"';");
    	
    	while(rs.next())
    	{
    		taas_instance_id = rs.getString("fk_resource_id");
    		os=rs.getString("os");
    		instance_type=rs.getString("instance_type");
    		
    		tool1 = rs.getString("tool1");
				tool2 = rs.getString("tool2");
				if(tool1.equalsIgnoreCase("null")){
					tool1="Not Installed";
				}else {tool1="Installed";}
				if(tool2.equalsIgnoreCase("null")){
					tool2="Not Installed";
				}else {tool2="Installed";}
    		
    	}
    }
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>CBSA Testing Space</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="../WebContent/TestProject/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript">
 <!--
 function upload(String) {
		if(String == "script")
			{
			window.location="uploadfile.jsp?type="+String;
			}
		if(String == "file")
		{
		window.location="uploadfile.jsp?type="+String;
		}
 }
 function upload_test_script()
 {	var selected_name
	 selected_name=document.form1.project_name.options[document.form1.project_name.selectedIndex].value;
 
 document.form1.action="uploadscriptfile.jsp?project_name="+selected_name;
 document.form1.submit();
 
 }
function upload_test_file()
{var selected_name
	 selected_name=document.form1.project_name.options[document.form1.project_name.selectedIndex].value;
alert(selected_name);
document.form2.action="uploadfile.jsp?project_name="+selected_name;
document.form2.submit();
	}

function set_drop_down(){
document.form1.project_name.selectedIndex = 2;}

function create_project_folder1()
{
	if(document.form1.folder_name.value!=""){
len=document.form1.checkbox.length;
	//alert(len);
	if(len==undefined)
		{len =1;

	 	if(document.form1.checkbox.checked == true){
		 checkBox = document.form1.checkbox.value; 
	 	//alert(checkBox);
	 	document.form1.action="create_folder.jsp?taas_id="+checkBox;
	 	document.form1.submit();
		}
	 	}
	 else
		 {
		 for(k=0;k<len;k++)
		 {
	 	if(document.form1.checkbox[k].checked == true){
		 checkBox = document.form1.checkbox[k].value; 
			//alert(checkBox); 
	 	document.form1.action="create_folder.jsp?taas_id="+checkBox;
		 document.form1.submit();		
		  	}}			 
		 }
	}
	else
		alert("Please enter folder name")
}

function create_project_folder()
{
	if(document.form1.folder_name.value!=""){
len=document.form1.checkbox.length;
	//alert(len);
	if(len==undefined)
		{len =1;

		 checkBox = document.form1.checkbox.options[document.form1.checkbox.selectedIndex].value;
	 	//alert(checkBox);
	 	project_desc= document.form1.project_description.value;
	 	alert(project_dec);
	 	document.form1.action="create_folder.jsp?taas_id="+checkBox+"&project_desc="+project_desc;
	 	document.form1.submit();
	
	 	}
	 else
		 {
		
	 	 checkBox = document.form1.checkbox.options[document.form1.checkbox.selectedIndex].value;
			//alert(checkBox); 
			
	 	project_desc= document.form1.project_description.value;
	 	document.form1.action="create_folder.jsp?taas_id="+checkBox+"&project_desc="+project_desc;
		 document.form1.submit();		
		  	}		 
		 }
	}
function create_instance()
{
	
create_instance=document.form1.checkbox.options[document.form1.checkbox.selectedIndex].value;
if(create_instance=="create_instance"){
window.location="test_env_setup.jsp";}
}
function delete_pro()
{
var t =confirm("Are you sure you want to delete the project?");
	if(t==true){
window.location="delete_project.jsp";
	return true;}
	else
{
	return false;
}
	}
	function add_instance_id(){
		  instance_id = document.form1.add_instance_select.options[document.form1.add_instance_select.selectedIndex].value;
		window.location="add_instance.jsp?instance_id="+instance_id;
	}
	function remove_instance_id()
	{
		var remove = confirm("Are you sure you want to remove instance?");
		if(remove==true)
			{
			  window.location="remove_instance.jsp";
			  return true;
			}
		else(remove==false)
		{
			return false;
		}
		
	}
//--> 
</script>

</head>
<body>
	<!-- start header -->
	<div id="wrapper">

		<div id="header">
			<div id="menu">
				<ul>
		<li><a href="Testtool.jsp">Test Tool </a>
					</li>
					<li class="current_page_item"><a href="testing_space_new.jsp">Test
							Space</a>
					</li>

				</ul>
			</div>
		</div>
		<!-- end header -->
		<!-- start page -->
		<div id="page">
			<!-- start content -->
			<div id="content" style="width: 600px">
				<div class="post">
					<h1 class="title">Add a Test Project</h1>
					<%String dburl ="jdbc:mysql://localhost:3306/amazon_instance";
			Class.forName("com.mysql.jdbc.Driver");
 			Connection con = DriverManager.getConnection(dburl, "root", "");
 			Statement statement = con.createStatement();
 			ResultSet rs = statement.executeQuery("SELECT instance.os,instance.ram, instance.storage,instance.amazon_instance_id , instance.taas_instance_id FROM amazon_instance.instance;");
 			%>
					<form id="form1" name="form1" method="post" action=""
						onsubmit="create_project_folder()">

						<table style="width: auto;">
							<tr>
								<td>Project Name:</td>
								<td colspan="1"><input name="folder_name" type="text"
									id="folder_name"
									onclick="javascript:document.form1.folder_name.value=''"
									value="Enter Project Name" size="27" />
								</td>

							</tr>
							<tr>
								<td>ToolType:</td>
								<td><select id="checkbox" name="checkbox"
									style="width: inherit"">
										<option value="">GUI Testing</option>
										<option value="">Load Testing</option>
										<%int c=0;
 			while(rs.next())
 			{	
 				 			
			%>
										<option value="<%=rs.getString("taas_instance_id") %>"><%=rs.getString("taas_instance_id") %>
										</option>

										<%c++;}rs.close(); %>
								</select></td>
							</tr>
							<tr>
								<td valign="top">Project Description:</td>
								<td><textarea name="project_description"
										id="project_description" cols="25" rows="3"></textarea></td>
							</tr>




							<tr>
								<td><input type="submit" name="create_folder"
									id="create_folder" value="Submit" />
								</td>
								<td align="center" colspan="">&nbsp;</td>
							</tr>

						</table>
						<p>&nbsp;</p>
						<tr></tr>
						<tr></tr>

						<%//enter code for displaying project
								           if (myname!=null)
								           {	String root_project= path;
								java.io.File file_project;
								java.io.File dir_project = new java.io.File(root_project);
								 
								String[] list_project = dir_project.list();
								for (int m = 0; m < list_project.length; m++) {
								  file_project = new java.io.File(root_project + list_project[m]);
								 if (file_project.isDirectory()) {
									 %>
						<option value="<%=list_project[m] %>"><%=list_project[m] %></option>
						<%}} 
									 }	%>

						</select>
						</td>
						<td>
							<%int d=0;
							ResultSet rs1 = statement.executeQuery("SELECT instance.os,instance.ram, instance.storage,instance.amazon_instance_id , instance.taas_instance_id FROM amazon_instance.instance;");
				 			
 			while(rs1.next())
 			{	
 				 			
			%>
							<option value="<%=rs1.getString("taas_instance_id") %>"><%=rs1.getString("taas_instance_id") %>
							</option> <%d++;}rs1.close(); %> </select></td>
						<td style="width: auto;" colspan="2">&nbsp;</td>
						</tr>

						<script type="text/javascript" language="javascript">
 								<!--
 									function root_directory()
										{
		 selected_name=document.form1.project_name.options[document.form1.project_name.selectedIndex].value;
		 document.form1.action="?project_name="+selected_name;
		 
		 document.form1.submit();		 
		 }
 								
 								 //-->
								</script>
					</form>





					<%

	if(selected_name!=null && selected_name!=""){
		 String root="path\\"+selected_name+"\\GUI_Testing\\";
		 java.io.File file;
		 java.io.File dir = new java.io.File(root);
		  
		 String[] list = dir.list();


		 	 for (int i = 0; i < list.length; i++) {
		 	   file = new java.io.File(root + list[i]);
		 	   %>
					<li><a href="downloadfile.jsp?name=<%=list[i]%>&type=script"
						target="_top"><%=list[i]%></a> <a
						href="deletefiles.jsp?name=<%=list[i]%>&type=script">Delete</a> <br>
						<%
		 	 
		 	   }
		 	 }%> <%if(selected_name!=null  && selected_name!=""){
String root_testfiles="path\\"+selected_name+"\\Load_Testing\\";
java.io.File testfile;
java.io.File dir_testfile = new java.io.File(root_testfiles);
 
String[] testlist = dir_testfile.list();
 
for (int i = 0; i < testlist.length; i++) {
  testfile = new java.io.File(root_testfiles+ testlist[i]);
  //if (testfile.isDirectory()) {
  %>

						<li><a
							href="downloadfile.jsp?name=<%=testlist[i]%>&type=file"
							target="_top"><%=testlist[i]%></a> <a
							href="deletefiles.jsp?name=<%=testlist[i]%>&type=file">Delete</a>
							<br> <%
   //  }
  }}
%>

							</th>
							<td><%=taas_instance_id%></td>
							<td><%=instance_type%></td>
							<td><%= os %></td>
							<td><%= tool1 %></td>
							<td><%= tool2 %></td>
							</tr>

							</table>
							<table>
								<tr>

								</tr>
							</table>

							</form>
							<div class="entry">

								<p>&nbsp;</p>

								<p>&nbsp;</p>
							</div>
				</div>

			</div>
			<!-- end content -->
			<!-- start sidebar -->

			<!-- end sidebar -->
			<div style="clear: both;">&nbsp;</div>
		</div></div>
</body>
</html>
