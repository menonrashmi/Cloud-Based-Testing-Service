<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%  String myname =  (String)session.getAttribute("username");
 if (myname==null)
    {session.setAttribute("please_login","please_login");
	
    	response.sendRedirect("index.jsp");
    }%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>TaaS:- Reporting</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript">
 <!--
 function report() {
	 	if(document.forms.form1.reportCheckboxGroup_0.checked == true){
		 window.location="billreport.jsp";
 }
	 	if(document.forms.form1.reportCheckboxGroup_1.checked == true){
			window.location="contractreport.jsp";
	 	 }
	 	}
 
--> 
</script>

</head>
<body>
<!-- start header -->
<div id="wrapper">
<div id="logo">
	<h1><a href="#">Cloudtaas-Testing as a service on Cloud</a></h1>
	<h2>&nbsp;</h2>
</div>
<div id="header">
	<div id="menu">
		<ul>	
			<li ><a href="index.jsp">Home</a></li>
				<li ><a href="user_account_details.jsp">Account</a></li>
			<li><a href="pricing.jsp">Price</a></li>
			<li class="current_page_item" ><a href="reporting.jsp">Report</a></li>
			<li><a href="billing.jsp">Bill</a></li>
			<li><a href="contract.jsp">Contract</a></li>
				<%if (myname!=null && myname!="error")
				out.print("<b><li style=\"text-align: right;\"><a \" href=\"logout.jsp\" >Logout</a></li></b>");
				else
				out.print("<b><li style=\"text-align: right;\"><a \" href=\"login.jsp\" >Login/Signup</a></li></b>");
				%>

		</ul>
	</div>
</div>
<!-- end header -->
<!-- start page -->
<div id="page">
	<!-- start content -->
	<div id="content">
		<div class="post">
			<h1 class="title">reporting</h1>
			<div class="entry">
			<form id="form1" method="post" onsubmit="report()">
			  <table  border="0">
                  <tr>
                    <td><label>Please select to generate report:-<br />
                    </label>
                      <table width="200">
                        <tr>
                          <td><label>
                            <input type="checkbox" name="reportCheckboxGroup" value="billing" id="reportCheckboxGroup_0" />
                            Billing</label></td>
                        </tr>
                        <tr>
                          <td><label>
                            <input type="checkbox" name="reportCheckboxGroup" value="contract" id="reportCheckboxGroup_1" />
                            Contract</label></td>
                        </tr>
                        </table>
                    <label>                      </label></td>
                    <td>
                      <p></p>
                    </td>
                  </tr>
                  <tr>
                    <td><input type="button" name="Generate Report" id="Generate Report" value="Generate Report" onclick="report()"/></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
              </table>
              </form>
			  <p>&nbsp;</p>
		  </div>
			
		</div>
		
	</div>
	<!-- end content -->
	<!-- start sidebar -->
	<div id="sidebar">
		<ul>
			<li id="search">
				<h2>Search</h2>
				<form method="get" action="">
					<fieldset>
					<input type="text" id="s" name="s" value="" />
					<input type="submit" id="x" value="Search" />
					</fieldset>
				</form>
			</li>
			<li></li>
		</ul>
	</div>
	<!-- end sidebar -->
	<div style="clear: both;">&nbsp;</div>
</div>
<!-- end page -->
<!-- start footer -->
<div id="footer">
	<p id="legal">( c ) 2008. All Rights Reserved by Ashrut and Romil </p>
</div>
</div>
<!-- end footer -->
</body>
</html>
