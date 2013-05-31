<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

   

<%@ page  import="java.io.FileInputStream" %>
<%@ page  import="java.io.BufferedInputStream"  %>
<%@ page  import="java.io.File"  %>
<%@ page import="java.io.IOException" %>


<%String myname = (String)session.getAttribute("username"); 
String selected_project_name= (String)session.getAttribute("temp_name");
String name = request.getParameter("name");
String type = request.getParameter("type");
   // you  can get your base and parent from the database
  //String parent="C:\\Studies\\Semester\\Fall 2010\\CMPE 295 A\\eclipse-jee-helios-SR2-win32-x86_64\\Workspace\\taas_aws\\WebContent\\Test_Script\\"; 
   String filename=null;
   if(type.equalsIgnoreCase("script"))
   {   //filename="C:\\Users\\Public\\upload-CBSA\\"+selected_project_name+"\\Test_Script_Selenium\\"+name.toString();
	   filename="C:\\xampp\\tomcat\\webapps\\cbsatesting\\src\\seleniumTS\\"+selected_project_name+"\\"+name.toString();
   }
   if (type.equalsIgnoreCase("file"))
   {
	   //filename="C:\\Users\\Public\\upload-CBSA\\"+selected_project_name+"\\Test_Script_Jmeter\\"+name.toString();
	   filename=" C:\\xampp\\tomcat\\webapps\\cbsatesting\\WebContent\\LoadTestScript\\"+selected_project_name+"\\"+name.toString();
	  
	   
   }
   if (type.equalsIgnoreCase("tool"))
   {
	   filename="C:\\Users\\Public\\upload-CBSA\\Test_Tool\\"+name.toString();
	   
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
 