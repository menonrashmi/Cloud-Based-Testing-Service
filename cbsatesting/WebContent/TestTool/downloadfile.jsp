<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

   

<%@ page  import="java.io.FileInputStream" %>
<%@ page  import="java.io.BufferedInputStream"  %>
<%@ page  import="java.io.File"  %>
<%@ page import="java.io.IOException" %>


<%

String path = "C:\\Users\\Public\\upload-CBSA-TestTool";

String myname = (String)session.getAttribute("username"); 
String selected_project_name= (String)session.getAttribute("temp_name");
String name = request.getParameter("name");
String type = request.getParameter("type");
   // you  can get your base and parent from the database
  
   String filename=null;
   if(type.equalsIgnoreCase("script"))
   {   filename="C:\\Users\\Public\\upload-CBSA-TestTool\\"+selected_project_name+"\\GUI_Testing\\"+name.toString();
   
   }
   if (type.equalsIgnoreCase("file"))
   {
	   filename="C:\\Users\\Public\\upload-CBSA-TestTool\\"+selected_project_name+"\\Load_Testing\\"+name.toString();
	   
   }
  
// you can  write http://localhost
 //  String filepath="http://localhost/"+base+"/";

BufferedInputStream buf=null;
   ServletOutputStream myOut=null;

try{

myOut = response.getOutputStream( );
     File myfile = new File(filename);
     
     //set response headers
     response.getContentType();
     
     response.addHeader(  "Content-Disposition","attachment; filename="+filename );

     response.setContentLength( (int) myfile.length( ) );
 FileInputStream input = new FileInputStream(myfile);
     buf = new BufferedInputStream(input);
     int readBytes = 0;

     //read from the file; write to the ServletOutputStream
     while((readBytes = buf.read( )) != -1)
       myOut.write(readBytes);

} catch (IOException ioe){
     
        throw new ServletException(ioe.getMessage( ));
         
     } finally {
         
     //close the input/output streams
         if (myOut != null)
             myOut.close( );
          if (buf != null)
          buf.close( );
         
     }

   
   
%>
 