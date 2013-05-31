<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String myname = (String) session.getAttribute("username");
	String instance_create_success = (String) session
			.getAttribute("instance_create_success");

	String selected_name = request.getParameter("project_name");
	session.setAttribute("temp_name", selected_name);

	if (selected_name == null) {
		selected_name = "";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>CBSA Testware Management</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript">
 
 function upload(String) {
      if (String == "script") {
         window.location = "uploadfile.jsp?type=" + String;
      }
      if (String == "file") {
         window.location = "uploadfile.jsp?type=" + String;
      }
   }
   function upload_gui_script() {
      var selected_name=document.getElementById("project_name").value;
     
      selected_name = document.form1.project_name.options[document.form1.project_name.selectedIndex].value;

      document.form1.action = "uploadscriptfile.jsp?project_name=" + selected_name;
      document.form1.submit();

   }
   
   function upload_load_script() {
      var selected_name=document.getElementById("project_name").value;
     
      document.form2.action = "uploadfile.jsp?project_name=" + selected_name;
      document.form2.submit();
   }

   function set_drop_down() {
      document.form1.project_name.selectedIndex = 2;
   }
</script>
</head>
<body>
	<!-- start header -->
	<div id="wrapper">
		<div id="header">
			<div id="menu">
				<ul>
            	<li><a href="test_env_setup.jsp">AWS Environment </a>
					</li>

					<li class="current_page_item"><a href="testware.jsp">Testware Management
					</a>
					</li>
					<li><a href="testing_space_new.jsp">Test Projects</a>
					</li>



				</ul>
			</div>
		</div>
		<!-- end header -->
		<!-- start page -->
		<div id="page">
			<!-- start content -->
			<div id="content" style="width: auto">
				<div class="post">
					<h1 class="title">TestWare Management</h1>

					<FORM name="form1" ENCTYPE="multipart/form-data" ACTION=""
						METHOD="POST">
						<table style="width: auto;">
							<tr>
								<td style="width: auto;" colspan="2"><b>Choose a
										Project</b></td>

								<td colspan="2"><select id="project_name"
									name="project_name" >
										<option value="select_project">project name</option>
										<%//enter code for displaying project
			String root_project = "C:\\Users\\Public\\upload-CBSA\\";
			java.io.File file_project;
			java.io.File dir_project = new java.io.File(root_project);

			String[] list_project = dir_project.list();
			for (int m = 0; m < list_project.length; m++) {
				file_project = new java.io.File(root_project + list_project[m]);
				if (file_project.isDirectory()) {%>
										<option value="<%=list_project[m]%>"><%=list_project[m]%></option>
										<%}
			}%>

								</select></td>
								</td>
							</tr>
							<tr>
								<td style="width: auto;" colspan="2"><b>Choose the file</b>
								</td>
								<td align="left"><INPUT NAME="F1" TYPE="file">
								</td>
								<td><INPUT TYPE="button" VALUE="Upload GUI Test Script "
									onclick="upload_gui_script();">
								</td>
							</tr>
							<tr>
								</form>
								<FORM name="form2" ENCTYPE="multipart/form-data" ACTION=""
									METHOD=POST>
									<tr>
										<td style="width: auto;" colspan="2"><b>Choose the
												file</b></td>
										<td><INPUT NAME="F1" TYPE="file">
										</td>
										<td><INPUT TYPE="button" VALUE="Upload Load Test Script"
											onclick="upload_load_script();">
										</td>
									</tr>
							</tr>
							<tr style="border: 2">
								<th scope="col" colspan="2">GUI Test Script in <%=selected_name%></th>
								<th scope="col" colspan="2">Load Test Scripts in <%=selected_name%></th>
							</tr>
							<tr>
								<th scope="col" colspan="2">
								<script type="text/javascript"> 
								function root_directory() {
                              selected_name = document.form1.project_name.options[document.form1.project_name.selectedIndex].value;
                              document.form1.action = "?project_name=" + selected_name;

                              document.form1.submit();		 
		 }
 							
								</script> <%
 	if (selected_name != null && selected_name != "") {
 		String root = "C:\\Users\\Public\\upload-CBSA\\"
 				+ selected_name + "\\Test_Script_Selenium\\";
 		String root2 = "C:\\xampp\\tomcat\\webapps\\cbsatesting\\src\\seleniumTS\\"+selected_name+"\\";
 		java.io.File file;
 		java.io.File dir = new java.io.File(root2);

 		String[] list = dir.list();
 	
 		 for(String s:list){
        	 System.out.println(s);
         }
 		for (int i = 0; i < list.length; i++) {
 			file = new java.io.File(root2 + list[i]);
 %>
									<li><a
										href="downloadfile.jsp?name=<%=list[i]%>&type=script"
										target="_top"><%=list[i]%></a> <a style="color: black;"
										href="deletefiles.jsp?name=<%=list[i]%>&type=script">Delete</a>
										<br> <%
 	}
 	}
 %>
									
								</th>
								<th colspan="2" scope="col">
									<%
										if (selected_name != null && selected_name != "") {

											String root_testfiles = "C:\\Public\\Public\\upload-CBSA\\"
													+ selected_name + "\\Test_Script_Jmeter\\";
											String root_testfiles2 = "C:\\xampp\\tomcat\\webapps\\cbsatesting\\WebContent\\LoadTestScript\\"+ selected_name+"\\";
											java.io.File testfile;
											java.io.File testfile2;
											java.io.File dir_testfile = new java.io.File(root_testfiles);
										
											java.io.File dir_testfile2 = new java.io.File(root_testfiles2);
											String[] testlist = dir_testfile2.list();

											
											for (int i = 0; i < testlist.length; i++) {
												testfile = new java.io.File(root_testfiles2 + testlist[i]);
												//if (testfile.isDirectory()) {
									%>

									<li><a
										href="downloadfile.jsp?name=<%=testlist[i]%>&type=file"
										target="_top"><%=testlist[i]%></a> <a style="color: black;"
										href="deletefiles.jsp?name=<%=testlist[i]%>&type=file">Delete</a>
										<br> <%
 	//  }
 		}
 	}
 %>
									
								</th>
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
		</div>
		<!-- end page -->
		<!-- start footer -->
		<div id="footer"></div>
	</div>
	<!-- end footer -->
</body>
</html>
