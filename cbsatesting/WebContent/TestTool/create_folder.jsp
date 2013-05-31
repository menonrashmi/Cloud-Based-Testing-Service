<%@page import="java.sql.*"%>
<%@page import="java.io.File"%>
<%@page import="com.sun.xml.internal.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Calendar"%>
<%@page import=" java.text.SimpleDateFormat"%>
<%

String myname = (String)session.getAttribute("username");
String user_id = (String)session.getAttribute("user_id");
String folder_name=request.getParameter("folder_name");
String TestProjectID = request.getParameter("TestProjectID");
String taas_id = request.getParameter("taas_id");
String project_desc = request.getParameter("project_desc");
String TesterID = request.getParameter("TesterID");
String ProjectDate = request.getParameter("ProjectDate");
String ProductName = request.getParameter("ProductName");
String ProductVersion = request.getParameter("ProductVersion");
System.out.println(user_id);
out.print("C:\\Users\\Public\\upload-CBSA-TestTool\\"+folder_name);
if(TestProjectID == null){
	TestProjectID = "123";
}
if(TesterID == null){
	TesterID = "123";
}
if(ProductVersion == null){
	ProductVersion = "1.0";
}
if( ProjectDate == null){
	Calendar currentDate = Calendar.getInstance();
	SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
	ProjectDate = formatter.format(currentDate.getTime());
}
File f = new File("C:\\Users\\Public\\upload-CBSA-TestTool\\"+folder_name);
f.mkdir();

File f2 = new File("C:\\Users\\Public\\upload-CBSA-TestTool\\"+folder_name+"\\GUI_Testing");
f2.mkdir();

File f3 = new File("C:\\Users\\Public\\upload-CBSA-TestTool\\"+folder_name+"\\Load_Testing");
f3.mkdir();
response.sendRedirect("testing_space_new.jsp");
  
  
  String dburl ="jdbc:mysql://localhost:3306/amazon_instance";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(dburl, "root", "");
	Statement statement = con.createStatement();
	int count = statement.executeUpdate("INSERT INTO `amazon_instance`.`project`"+
			"(`project_name`, `fk_resource_id`,`project_description`, `TestProjectID`,`TesterID`, `ProjectDate`, `ProductName`, `ProductVersion` ) VALUES ('"+folder_name+"','"+taas_id+"','"+project_desc+"','"+TestProjectID+"', '"+TesterID+"', '"+ProjectDate+"', '"+ProductName+"', '"+ProductVersion+"');");
%>