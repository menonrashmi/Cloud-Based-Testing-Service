<%@page import="java.util.Date"%>
<%@page import="java.lang.*"%> <!-- MNJ added this import stmt -->

<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@page import="com.amazonaws.auth.BasicAWSCredentials"%>
<%@page import="com.amazonaws.services.ec2.model.RunInstancesResult"%>
<%@page import="com.amazonaws.services.ec2.model.RunInstancesRequest"%>

<%@page import="com.amazonaws.services.ec2.model.GetPasswordDataRequest"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="com.amazonaws.services.ec2.AmazonEC2Client"%>
<%@page import="com.amazonaws.auth.PropertiesCredentials"%>
<%@page import="com.amazonaws.auth.AWSCredentials"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page  import=" java.io.*" %>
<%@   page import=" java.util.StringTokenizer"%>

   
     <%@  page import="com.amazonaws.auth.PropertiesCredentials"%>
       <%@page import="com.amazonaws.services.ec2.AmazonEC2"%>
<%@       page import="com.amazonaws.services.ec2.AmazonEC2Client"%>
  <%@     page import="com.amazonaws.services.ec2.model.DescribeInstancesResult"%>
    <%@   page import="com.amazonaws.services.ec2.model.GetPasswordDataRequest"%>
<%@       page import="com.amazonaws.services.ec2.model.GetPasswordDataResult"%>
  <%@     page import="com.amazonaws.services.ec2.model.ImportKeyPairRequest"%>
    <%@   page import="com.amazonaws.services.ec2.model.RunInstancesRequest"%>
      <%@ page import="com.amazonaws.services.ec2.model.RunInstancesResult"%>

<%
	//MNJ - receive error at < % part is ignored- still the appliation works. 
	//String Declaration		
	String myname = (String)session.getAttribute("username"); 
    String memory=(String)request.getParameter("memory");session.setAttribute("memory",memory);
    String architecture=(String)request.getParameter("architecture");session.setAttribute("architecture",architecture);
    String cpu=(String)request.getParameter("cpu");session.setAttribute("cpu",cpu);
    String storage=(String)request.getParameter("storage");session.setAttribute("storage",storage);
    String os=(String)request.getParameter("os");session.setAttribute("os",os);
    String instance_type=(String)request.getParameter("instance_type");session.setAttribute("instance_type",instance_type);
    String signed_by=(String)request.getParameter("signed_by");session.setAttribute("signed_by",signed_by);
    String vendor = (String)request.getParameter("vendor_name");session.setAttribute("vendor_name",vendor);
    String client_name= (String)request.getParameter("client_name");session.setAttribute("client_name",client_name);
    String current_date = (new java.util.Date().getMonth()+1)+"/"+new java.util.Date().getDate()+"/"+(new java.util.Date().getYear()+1900);
    String delivery_date = (new java.util.Date().getMonth()+1)+"/"+(new java.util.Date().getDate() + 1) +"/"+(new java.util.Date().getYear()+1900);
 	session.setAttribute("current_date",current_date);
 	session.setAttribute("delivery_date",delivery_date);
 	String secretkey="wye9KJ3vioi4MP8uDwBKy0Q/J9fNRciW8CM+EU5A"; //mnj-old wye9KJ3vioi4MP8uDwBKy0Q/J9fNRciW8CM+EU5A";
 	String accesskey="AKIAIMEH6LATDIR5P6IA"; // mnj-oldAKIAIMEH6LATDIR5P6IA";
	String ami_id=null;
	
	//DB connection 
	String dburl ="jdbc:mysql://localhost:3306/amazon_instance";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(dburl, "root", "");
	 Statement statement = con.createStatement();
	 int count=0;
	 out.println("os:"+os);
	 //Selecting AMI for instance creationus-west-1c/1a.
    if(os.equals("windows2008r2"))
    {		
	 ami_id="ami-13f9307a";
	 }
    else if(os.equals("windows2008"))
	{		
    ami_id="ami-fbf93092";}
		

    else if(os.equals("amazonLinux"))
	{
		ami_id="ami-31814f58";	
	}
    else if(os.equals("suse"))
	{
		ami_id="ami-3d599754";	
	}
	else if(os.equals("orangehrm"))  //mnj- added if statement
	{
		ami_id = "ami-e6d10a8f";
	}
	else
	{
		ami_id="ami-13f9307a";	
	}
	out.print("printing ami_id mnj =" + ami_id);

	System.out.print( new Date().getTime());
   AWSCredentials credentials = new BasicAWSCredentials(accesskey,secretkey);    
   AmazonEC2Client ec2 = new AmazonEC2Client(credentials);
   ec2.setEndpoint("https://ec2.us-east-1.amazonaws.com"); 
   DescribeInstancesResult desc = ec2.describeInstances();
		String tempStr = desc.toString();
		StringTokenizer stringTokenizer = new StringTokenizer(tempStr);    			
		
		//request.placement = new Placement("eu-west-1a");
		//RunInstancesResult runInstance = ec2.runInstances(reqRunInstance);
		//out.println(runInstance.toString());
    			 RunInstancesRequest reqRunInstance = new RunInstancesRequest();
    			reqRunInstance.setImageId(ami_id);
    			reqRunInstance.setInstanceType( instance_type ); //mnj-instance_type = t1.micro
    			reqRunInstance.setMinCount(1);
    			reqRunInstance.setMaxCount(1);
    			reqRunInstance.setKeyName("sumalatha");  //mnj-key Pair Name as in aws account.
    			reqRunInstance.setMonitoring(true);
    			reqRunInstance.getSecurityGroups().add("default"); //mnj-key Group Name in aws account.
    			//request.placement = new Placement("eu-west-1a");
    			RunInstancesResult runInstance = ec2.runInstances(reqRunInstance);
    			out.println(runInstance.toString());
    			
    			
    			String[] arr1 = runInstance.toString().split("InstanceId: ");
    			String[] instance_id = arr1[1].split(",");
    			out.println("Instance ID: "+instance_id[0]);
				//Adding instance id to session
				session.setAttribute("instance_id",instance_id[0]);
    			// Query for insertion
    			
    			String inst_id_query= "SELECT LAST_INSERT_ID();";
    			ResultSet inst_id= statement.executeQuery(inst_id_query);
    			//insert instance
    			if(inst_id.next()){
    				int fk_contract_id=Integer.parseInt( inst_id.getString(1));
    			String insert_instance="INSERT INTO `amazon_instance`.`instance`"+
    			"(`fk_contract_id`,`os`,`ram`,`storage`,`amazon_instance_id`,`start_date`,`instance_type`)	VALUES	("+
    					"'"+fk_contract_id+"','"+os+"','"+memory+"','"+storage+"','"+instance_id[0]+"','"+Calendar.getInstance().getTime()+"','"+instance_type+"');";//SELECT LAST_INSERT_ID();";
    			System.out.println("query: " + insert_instance); //mnj modified fk_contract_id from date to integer and added sysout stmt
    					int insert_instance_count=statement.executeUpdate(insert_instance);
    					
    			}
    			//Mapping of AMI id 
    			String instance_id_query= "SELECT LAST_INSERT_ID();";
    			ResultSet get_last_instance_id=statement.executeQuery(instance_id_query);
    			if(get_last_instance_id.next()){
    			//int insert_taas_id_count= statement.executeUpdate("UPDATE `amazon_instance.instance` SET 'instance.amazon_instance_id' ='"+instance_id[0].toString()+"';");
    			int insert_taas_id_count= statement.executeUpdate("update amazon_instance.instance set `taas_instance_id`="+get_last_instance_id.getString(1)+" where instance.amazon_instance_id='"+instance_id[0].toString()+"';");
    			
    			}
			
                con.close();
   
    			System.out.print( new Date().getTime());
    			//<FORM><INPUT TYPE="button" VALUE="Back" onClick="history.go(-1);return true;"></FORM>
    			response.sendRedirect("test_env_delete.jsp");
//    			out.print("<script type=\"javascript\"><!-- window.open(\"generate_contract.jsp\"); //--></script>");
    %>