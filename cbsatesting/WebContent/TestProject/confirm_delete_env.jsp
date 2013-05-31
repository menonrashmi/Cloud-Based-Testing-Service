<%@page import="com.amazonaws.services.ec2.model.StopInstancesResult"%>
<%@page import="com.amazonaws.services.ec2.model.StopInstancesRequest"%>
<%@page import="com.amazonaws.services.ec2.model.TerminateInstancesResult"%>
<%@page import="com.amazonaws.services.ec2.model.TerminateInstancesRequest"%>
<%@page import="com.amazonaws.auth.BasicAWSCredentials"%>
<%@page import="com.amazonaws.services.ec2.AmazonEC2Client"%>
<%@page import="com.amazonaws.auth.AWSCredentials"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="com.amazonaws.services.ec2.model.StartInstancesResult"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.amazonaws.services.ec2.model.StartInstancesRequest"%>

<%@page import="java.util.Date"%>

<%@page import="java.io.FileOutputStream"%>

<%@page import="java.sql.*"%>
<%@page import="java.awt.print.PrinterJob"%>

<%@page import="javax.print.attribute.standard.MediaSizeName"%>
<%@page import="javax.print.attribute.standard.MediaTray"%>
<%@page import="javax.print.attribute.standard.Copies"%>
<%@page import="javax.print.PrintException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="javax.print.SimpleDoc"%>
<%@page import="javax.print.Doc"%>
<%@page import="java.net.URL"%>
<%@page import="javax.print.attribute.PrintRequestAttributeSet"%>
<%@page import="javax.print.attribute.HashPrintRequestAttributeSet"%>
<%@page import="javax.print.DocPrintJob"%>
<%@page import="javax.print.*"%>
<%@page import="javax.print.attribute.standard.OrientationRequested"%>
<%@page import="javax.print.attribute.HashDocAttributeSet"%>
<%@page import="javax.print.attribute.DocAttributeSet"%>
<%@page import="com.itextpdf.text.BaseColor"%>

<%@page import="com.itextpdf.text.Element"%>
<%@page import="com.itextpdf.text.Phrase"%>
<%@page import="com.itextpdf.text.pdf.PdfPCell"%>
<%@page import="com.itextpdf.text.pdf.PdfPTable"%>
<%@page import="com.itextpdf.text.Section"%>
<%@page import="com.itextpdf.text.Chapter"%>
<%@page import="com.itextpdf.text.Anchor"%>
<%@page import="com.itextpdf.text.Paragraph"%>
<%@page import="com.itextpdf.text.pdf.PdfWriter"%>
<%@page import="com.itextpdf.text.Document"%>
<%@page import="com.itextpdf.text.Font"%>
<%@page import="com.itextpdf.*"%>


<%@page import="javax.print.DocFlavor"%>
<%@page import="javax.print.PrintServiceLookup"%>
<%@page import="javax.print.PrintService"%>
<%@page import="java.util.Calendar" %>
<%@page import="java.text.SimpleDateFormat" %>
<%! String sports; %>
<% 
 //  sports = request.getParameter("radio");
 
//     out.println ("<b>"+sports.toString()+"<b>");
 String amazon_instance_id=(String)request.getParameter("checkBox");
 String edit_type =request.getParameter("edit_type");
 out.print(edit_type.toString());
String startDate = null;
String stopDate = null;
String sDate = null;
%>
 <%
	String secretkey="wye9KJ3vioi4MP8uDwBKy0Q/J9fNRciW8CM+EU5A"; // MNJ - added new secretkey wye9KJ3vioi4MP8uDwBKy0Q/J9fNRciW8CM+EU5A";
	String accesskey="AKIAIMEH6LATDIR5P6IA";   //MNJ replaced old accesskey to new one
	
String select[] = request.getParameterValues("checkBox"); 
if (select != null && select.length != 0) {
out.println("You have selected: ");
for (int m = 0; m< select.length; m++) {
out.println(select[m]); 
}
}
//out.println ("<b>"+amazon_instance_id.toString()+"<b>");
//ResultSet resultset = statement.executeQuery("select * from instance;");
//Amazon ec2 instnace

   AWSCredentials credentials = new BasicAWSCredentials(accesskey,secretkey);    
   AmazonEC2Client ec2 = new AmazonEC2Client(credentials);
   ec2.setEndpoint("https://ec2.us-east-1.amazonaws.com"); 
   //String edit_type =request.getParameter("edit_type");
   if(edit_type.equalsIgnoreCase("start")){
	   
	 //===create database connection=====
	   String dburl ="jdbc:mysql://localhost:3306/amazon_instance";
	   Class.forName("com.mysql.jdbc.Driver");
	   Connection con = DriverManager.getConnection(dburl, "root", "");
	   Statement statement = con.createStatement();
	
//=========starting instances=====
StartInstancesRequest startRequest = new StartInstancesRequest();
ArrayList<String> startInstances = new ArrayList<String>();
startInstances.add(amazon_instance_id.toString());
startRequest.setInstanceIds(startInstances);

StartInstancesResult startResult = ec2.startInstances(startRequest);
out.println(startResult.getStartingInstances());


String tempStr = startResult.getStartingInstances().toString();
StringTokenizer stringTokenizer = new StringTokenizer(tempStr);
//System.out.println(stringTokenizer.countTokens());
//System.out.println(tempStr);

Calendar cal = Calendar.getInstance();
sDate = cal.getTime().toString();

statement.executeUpdate("update amazon_instance.instance SET start_date='"+sDate+"' where amazon_instance_id='"+amazon_instance_id+"';");


//InstanceId
String[] arr1 = tempStr.split("InstanceId: ");
String[] arr2 = arr1[1].split(",");
out.println("Instance ID: "+arr2[0]);

//Current state
arr1 = tempStr.split(", CurrentState: ");
arr2 = arr1[1].split(", Name: ");
String[] arr3 = arr2[1].split(",");
out.println("Current State: "+arr3[0]);
//System.out.println(arr2[1]);

//Previous state
arr1 = tempStr.split(", PreviousState: ");
arr2 = arr1[1].split(", Name: ");
arr3 = arr2[1].split(",");
out.println("Previous State: "+arr3[0]);
%>


<script type="text/javascript">
<!--

window.close();
//-->
</script> <%
   }
   
   if(edit_type.equalsIgnoreCase("stop")){

//===create database connection=====
String dburl ="jdbc:mysql://localhost:3306/amazon_instance";
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(dburl, "root", "");
Statement statement = con.createStatement();
ResultSet for_start_date = statement.executeQuery("select * from amazon_instance.instance where amazon_instance_id='"+amazon_instance_id+"';");
while( for_start_date.next()){
		startDate = for_start_date.getString("start_date") ; //session.getAttribute("StartDate").toString();
		}
String pattern = "EEE MMM dd HH:mm:ss z yyyy";
SimpleDateFormat format = new SimpleDateFormat(pattern);
Date date2 = format.parse(startDate);

Calendar cal = Calendar.getInstance();
Calendar cal2 = Calendar.getInstance();
cal2.setTime(date2);

long d2 = cal2.getTimeInMillis();
long d1 = cal.getTimeInMillis();

long diff = d1-d2;
long time = diff / 1000;  
int seconds = (int)(time % 60);  
int minutes =(int)((time % 3600) / 60);  
int hours = (int)(time / 3600); 
if(minutes>1)
	hours = hours + 1;
	//System.out.println("hours: "+(hours+1));

stopDate = cal.getTime().toString();
int total_hours = 0;
ResultSet rs1 = statement.executeQuery("select total_hours from amazon_instance.instance where amazon_instance_id='"+amazon_instance_id+"';");
while(rs1.next()){
total_hours = rs1.getInt("total_hours");
total_hours = total_hours+hours;
}
statement.executeUpdate("UPDATE `amazon_instance`.`instance` SET stop_date='"+stopDate+"',total_hours="+total_hours+" where amazon_instance_id='"+amazon_instance_id.toString()+"';");

	  
	   
	   
	//=========stopping instances=====
StopInstancesRequest stopRequest = new StopInstancesRequest();
ArrayList<String> stopInstances = new ArrayList<String>();
stopInstances.add(amazon_instance_id.toString());
stopRequest.setInstanceIds(stopInstances);

StopInstancesResult stopResult = ec2.stopInstances(stopRequest);

String tempStr1 = stopResult.getStoppingInstances().toString();
StringTokenizer stringTokenizer1 = new StringTokenizer(tempStr1);
//System.out.println(stringTokenizer.countTokens());
//System.out.println(tempStr);

//InstanceId
String[] arr11 = tempStr1.split("InstanceId: ");
String[] arr21 = arr11[1].split(",");
out.println("Instance ID: "+arr21[0]);

//Current state
arr11 = tempStr1.split(", CurrentState: ");
arr21 = arr11[1].split(", Name: ");
String[] arr31 = arr21[1].split(",");
out.println("Current State: "+arr31[0]);
//System.out.println(arr2[1]);

//Previous state
arr11 = tempStr1.split(", PreviousState: ");
arr21 = arr11[1].split(", Name: ");
arr31 = arr21[1].split(",");
out.println("Previous State: "+arr31[0]);
%>


<script type="text/javascript">
<!--

window.close();
//-->
</script> <%

   }
if(edit_type.equalsIgnoreCase("terminate")){
//=========terminating instances=====
//Database connection to get contract details.
	String dburl ="jdbc:mysql://localhost:3306/amazon_instance";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(dburl, "root", "");
	Statement statement = con.createStatement();
	ResultSet for_start_date = statement.executeQuery("select * from amazon_instance.instance where amazon_instance_id='"+amazon_instance_id+"';");
	while( for_start_date.next()){
			startDate = for_start_date.getString("start_date") ; //session.getAttribute("StartDate").toString();
			}
	String pattern = "EEE MMM dd HH:mm:ss z yyyy";
	SimpleDateFormat format = new SimpleDateFormat(pattern);
	Date date2 = format.parse(startDate);

	Calendar cal = Calendar.getInstance();
	Calendar cal2 = Calendar.getInstance();
	cal2.setTime(date2);

	long d2 = cal2.getTimeInMillis();
	long d1 = cal.getTimeInMillis();

	long diff = d1-d2;
	long time = diff / 1000;  
	int seconds = (int)(time % 60);  
	int minutes =(int)((time % 3600) / 60);  
	int hours = (int)(time / 3600); 
	if(minutes>1)
		hours = hours + 1;
		//System.out.println("hours: "+(hours+1));

	stopDate = cal.getTime().toString();
	int total_hours = 0;
	ResultSet rs1 = statement.executeQuery("select total_hours from amazon_instance.instance where amazon_instance_id='"+amazon_instance_id+"';");
	while(rs1.next()){
	total_hours = rs1.getInt("total_hours");
	total_hours = total_hours+hours;
	}
	statement.executeUpdate("UPDATE `amazon_instance`.`instance` SET stop_date='"+stopDate+"',total_hours="+total_hours+" where amazon_instance_id='"+amazon_instance_id.toString()+"';");

		  
		   

TerminateInstancesRequest terminateRequest = new TerminateInstancesRequest();
ArrayList<String> terminateInstances = new ArrayList<String>();
terminateInstances.add(amazon_instance_id.toString());
terminateRequest.setInstanceIds(terminateInstances);

TerminateInstancesResult terminateResult = ec2.terminateInstances(terminateRequest);

String tempStr2 = terminateResult.getTerminatingInstances().toString();
StringTokenizer stringTokenizer2 = new StringTokenizer(tempStr2);
//System.out.println(stringTokenizer.countTokens());
//System.out.println(tempStr);

//InstanceId
String[] arr12 = tempStr2.split("InstanceId: ");
String[] arr22 = arr12[1].split(",");
out.println("Instance ID: "+arr22[0]);

//Current state
arr12 = tempStr2.split(", CurrentState: ");
arr22 = arr12[1].split(", Name: ");
String[] arr32 = arr22[1].split(",");
out.println("Current State: "+arr32[0]);
//System.out.println(arr2[1]);

//Previous state
arr12 = tempStr2.split(", PreviousState: ");
arr22 = arr12[1].split(", Name: ");
arr32 = arr22[1].split(",");
out.println("Previous State: "+arr32[0]); 

int count = statement.executeUpdate("Update `amazon_instance`.`instance` set current_state='terminate'	 WHERE amazon_instance_id='"+amazon_instance_id.toString()+"';");

if(count>0)
{
	session.setAttribute("termination_success","termination_success");

	con.close();
	%>


		<script type="text/javascript">
	<!--

	window.close();
	//-->
	</script> <%
}
}

%>