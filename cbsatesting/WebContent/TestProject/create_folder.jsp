<%@page import="java.sql.*"%>
<%@page import="java.io.File"%>
<%@page import="com.sun.xml.internal.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%

String tool_type = request.getParameter("tool_type");
String project_desc = request.getParameter("project_desc");
String myname = (String)session.getAttribute("username");
String user_id = (String)session.getAttribute("user_id");
String folder_name=request.getParameter("folder_name");
String TestProjectID = request.getParameter("TestProjectID");
String taas_id = request.getParameter("taas_id");
String TesterID = request.getParameter("TesterID");
String ProjectDate = request.getParameter("ProjectDate");
String ProductName = request.getParameter("ProductName");
String ProductVersion = request.getParameter("ProductVersion");
System.out.println(user_id);
out.print("C:\\Users\\Public\\upload-CBSA\\"+folder_name);

File f = new File("C:\\Users\\Public\\upload-CBSA\\"+folder_name);
File fs = new File("D:\\cbsaworkspace\\cbsatesting\\webcontent\\results\\seleniumTS\\"+folder_name);
f.mkdir();


File f2 = new File("C:\\Users\\Public\\upload-CBSA\\"+folder_name+"\\Test_Script_Selenium");
File f2s = new File("D:\\cbsaworkspace\\cbsatesting\\webcontent\\results\\seleniumTS\\"+folder_name);
File f2r = new File("D:\\cbsaworkspace\\cbsatesting\\webcontent\\results\\seleniumResults\\"+folder_name);
File f2t = new File("C:\\Users\\Public\\upload-CBSA-TestTool\\"+folder_name+"\\GUI_Testing");
File f2t2 = new File("C:\\Users\\Public\\upload-CBSA-TestTool\\"+folder_name+"\\Load_Testing");
f2.mkdir();
f2s.mkdir();
f2t.mkdir();
f2t2.mkdir();
f2r.mkdir();
File f3 = new File("C:\\Users\\Public\\upload-CBSA\\"+folder_name+"\\Test_Script_Jmeter");
File f3s = new File("D:\\cbsaworkspace\\cbsatesting\\WebContent\\LoadTestScript\\"+folder_name);
f3.mkdir();
f3s.mkdir();
response.sendRedirect("testing_space_new.jsp");
  
  
String dburl ="jdbc:mysql://localhost:3306/amazon_instance";
	Class.forName("com.mysql.jdbc.Driver").newInstance(); // mnj added new instance()
	Connection con = DriverManager.getConnection(dburl, "root", "");
	Statement statement = con.createStatement();
	System.out.println("MNJ Foldername = "+ folder_name);
	System.out.println("MNJ Project description = "+ project_desc);
	String sql = "INSERT INTO `amazon_instance`.`project` (`project_name`, `project_description` ) VALUES ('"+folder_name+"','"+project_desc+"')";
	
	System.out.println(" MNJ SQL query = "+ sql); 
	int count = statement.executeUpdate("INSERT INTO `amazon_instance`.`project`"+
			"(`project_name`, `project_description` ) VALUES ('"+folder_name+"','"+project_desc+"');");
	con.close();

	%>
