<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
String myname = (String) session.getAttribute("username");
String name= request.getParameter("name");
String type = request.getParameter("type");
String selected_project_name= (String)session.getAttribute("temp_name");
String filename=null;

if(type.equalsIgnoreCase("script"))
{   filename="C:\\Users\\Public\\upload-CBSA\\"+selected_project_name+"\\Test_Script_Selenium\\"+name.toString();

}
if (type.equalsIgnoreCase("file"))
{
	   filename="C:\\Users\\Public\\upload-CBSA\\"+selected_project_name+"\\Test_Script_Jmeter\\"+name.toString();
	   
}
if (type.equalsIgnoreCase("tool"))
{
	   filename="C:\\Users\\Public\\upload-CBSA\\Test_Tool\\"+name.toString();
	   
}
File myfile = new File(filename);
myfile.delete();
if(type.equalsIgnoreCase("script"))
{  response.sendRedirect("testware.jsp?project_name="+selected_project_name);
}
if (type.equalsIgnoreCase("file"))
{
	 response.sendRedirect("testware.jsp?project_name="+selected_project_name);	   
}
if (type.equalsIgnoreCase("tool"))
{ response.sendRedirect("testtool.jsp");	   
}%>