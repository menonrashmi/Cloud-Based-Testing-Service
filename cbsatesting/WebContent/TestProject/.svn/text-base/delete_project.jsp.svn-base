<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
<% String dburl ="jdbc:mysql://localhost:3306/amazon_instance";
Class.forName("com.mysql.jdbc.Driver");
String username = (String)session.getAttribute("username");
String selected_name = (String) session.getAttribute("selected_project_name");
Connection con = DriverManager.getConnection(dburl, "root", "");
	Statement statement = con.createStatement();
	int count=0;
	if(true)
	{
		File f = new File("C:\\Users\\Public\\upload-CBSA\\"+selected_name+"\\Test_Script_Selenium");
		String root="C:\\Users\\Public\\upload-CBSA\\"+selected_name+"\\Test_Script_Selenium\\";
		 java.io.File file;
		 java.io.File dir = new java.io.File(root);
		  
		 String[] list = dir.list();
		 	 for (int i = 0; i < list.length; i++) {
		 	  file = new java.io.File(root + list[i]);
		 	  file.delete();
		 	   }
		f.delete();
		
		File f1 = new File("C:\\Users\\Public\\upload-CBSA\\"+selected_name+"\\Test_Script_Jmeter");
		String root1="C:\\Users\\Public\\upload-CBSA\\"+selected_name+"\\Test_Script_Jmeter\\";
		 java.io.File file1;
		 java.io.File dir1 = new java.io.File(root1);
		  
		 String[] list1 = dir1.list();
		 	 for (int j= 0; j < list1.length; j++) {
		 	  file1 = new java.io.File(root1 + list1[j]);
		 	  file1.delete();
		 	   }
		f1.delete();
		File f2 = new File("C:\\Users\\Public\\upload-CBSA\\"+selected_name+"\\Test_Tool");
		f2.delete();
		File f3 = new File("C:\\Users\\Public\\upload-CBSA\\"+selected_name);
		f3.delete();
		count =1;
	}
	if(count==1)
	{
		statement.executeUpdate("DELETE FROM `amazon_instance`.`project` WHERE project_name='"+selected_name+"';");
		response.sendRedirect("testing_space_new.jsp");	
	}
	
	
%>