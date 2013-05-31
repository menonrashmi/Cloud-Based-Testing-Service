<%@page import="org.eclipse.jdt.internal.compiler.ast.TryStatement"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<% String type = (String)request.getParameter("type");
	String myname = (String)session.getAttribute("username");
	String selected_project_name= (String)request.getParameter("project_name");
out.print(type);
	//to get the content type information from JSP Request Header
	String contentType = request.getContentType();
	//here we are checking the content type is not equal to Null and
// as well as the passed data from mulitpart/form-data is greater than or
// equal to 0
	if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
 		DataInputStream in = new DataInputStream(request.getInputStream());
		//we are taking the length of Content type data
		int formDataLength = request.getContentLength();
		byte dataBytes[] = new byte[formDataLength];
		int byteRead = 0;
		int totalBytesRead = 0;
		//this loop converting the uploaded file into byte code
		while (totalBytesRead < formDataLength) {
			byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
			totalBytesRead += byteRead;
			}

		String file = new String(dataBytes);
		//for saving the file name
		String saveFile = file.substring(file.indexOf("filename=\"") + 10);
		saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
		saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,saveFile.indexOf("\""));
		int lastIndex = contentType.lastIndexOf("=");
		String boundary = contentType.substring(lastIndex + 1,contentType.length());
		int pos;
		//extracting the index of file 
		pos = file.indexOf("filename=\"");
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		int boundaryLocation = file.indexOf(boundary, pos) - 4;
		int startPos = ((file.substring(0, pos)).getBytes()).length;
		int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

		
			FileOutputStream	 fileOut = new FileOutputStream("C:\\Users\\Public\\upload-CBSA\\"+selected_project_name+"\\Test_Script_Jmeter\\"+saveFile);
			fileOut.write(dataBytes, startPos, (endPos - startPos));
			fileOut.flush();
			fileOut.close();
			
			FileOutputStream fileOut2 = new FileOutputStream("C:\\xampp\\tomcat\\webapps\\cbsatesting\\WebContent\\LoadTestScript\\"+selected_project_name+"\\"+saveFile);
			fileOut2.write(dataBytes, startPos, (endPos - startPos));
			fileOut2.flush();
			fileOut2.close();

		%> <%
		  response.sendRedirect("testware.jsp?project_name="+selected_project_name);
		
		Connection connection = null; 
		try {
			/* Create string of connection url within specified format with machine name, 
			port number and database name. Here machine name id localhost and 
			database name is usermaster. */ 
			String connectionURL = "jdbc:mysql://localhost:3306/cbsa"; 
			
			// declare a connection by using Connection interface 
			
			Statement statement = null;
			ResultSet resultset = null;
			
			// Load JBBC driver "com.mysql.jdbc.Driver" 
			Class.forName("com.mysql.jdbc.Driver").newInstance(); 
			
			/* Create a connection by using getConnection() method that takes parameters of 
			string type connection url, user name and password to connect to database. */ 
			connection = DriverManager.getConnection(connectionURL, "root", "");
			
			 
			// check weather connection is established or not by isClosed() method 
			if(connection.isClosed())
			{
				throw new Exception();
			}
			
			statement = connection.createStatement();
			String cont="('"+saveFile+"','load','"+selected_project_name+"')";
			statement.executeUpdate("INSERT INTO `cbsa`.`testscript`(`fileName`,`type`,`projectName`) VALUES " +cont);
		} catch (Exception ex) {
			System.out.println("Unable to connect to database. "
					+ ex.getMessage());
		} finally {
			if (connection != null) {
				try {
					connection.close();
					System.out.println("Database connection terminated");
				} catch (Exception e) { /* ignore close errors */
				}
			}
		}
		
		
		
		
		}
	
%>