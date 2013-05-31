<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
String path = "C:\\Users\\Public\\upload-CBSA-TestTool";
String myname = (String) session.getAttribute("username");
String name= request.getParameter("name");
String type = request.getParameter("type");
String selected_project_name= (String)session.getAttribute("temp_name");
String filename=null;

if(type.equalsIgnoreCase("script"))

{   filename= "C:\\Users\\Public\\upload-CBSA-TestTool\\"+selected_project_name+"\\GUI_Testing\\"+name.toString();

}
if (type.equalsIgnoreCase("file"))
{
	   filename=  "C:\\Users\\Public\\upload-CBSA-TestTool\\"+selected_project_name+"\\Load_Testing\\"+name.toString();
	   
}

File myfile = new File(filename);
myfile.delete();
if(type.equalsIgnoreCase("script"))
{  response.sendRedirect("Testtool.jsp?project_name="+selected_project_name);
}
if (type.equalsIgnoreCase("file"))
{
	 response.sendRedirect("Testtool.jsp?project_name="+selected_project_name);	   

	   
}%>