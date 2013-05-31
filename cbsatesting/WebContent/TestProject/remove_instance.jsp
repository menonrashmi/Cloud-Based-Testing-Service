<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
<% String dburl ="jdbc:mysql://localhost:3306/amazon_instance";
Class.forName("com.mysql.jdbc.Driver");
String username = (String)session.getAttribute("username");
String selected_name = (String) session.getAttribute("selected_project_name");
//String instance_id = (String)request.getParameter("instance_id");
Connection con = DriverManager.getConnection(dburl, "root", "");
	Statement statement = con.createStatement();
	int count = statement.executeUpdate("UPDATE `amazon_instance`.`project` SET `fk_resource_id` = ' ' WHERE project_name='"+selected_name+"';");
	response.sendRedirect("testing_space_new.jsp?project_name="+selected_name);
	%>