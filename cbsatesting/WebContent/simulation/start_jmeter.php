<?php

if (isset($_REQUEST['noofthreads'])) {
    $noofthreads = $_REQUEST['noofthreads'];
	$rampupperiod = $_REQUEST['rampupperiod'];
	$loopcount = $_REQUEST['loopcount'];
	$servername = $_REQUEST['servername'];
	$protocol = $_REQUEST['protocol'];
	$path = $_REQUEST['path'];
	$portno = $_REQUEST['port'];
    $project = $_REQUEST['testProject'];
    $num=$noofthreads*$loopcount;

	$request = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
	<jmeterTestPlan version=\"1.2\" properties=\"2.1\">
	  <hashTree>
	    <TestPlan guiclass=\"TestPlanGui\" testclass=\"TestPlan\" testname=\"Test Plan\" enabled=\"true\">
	      <stringProp name=\"TestPlan.comments\"></stringProp>
	      <boolProp name=\"TestPlan.functional_mode\">false</boolProp>
	      <boolProp name=\"TestPlan.serialize_threadgroups\">false</boolProp>
	      <elementProp name=\"TestPlan.user_defined_variables\" elementType=\"Arguments\" guiclass=\"ArgumentsPanel\" testclass=\"Arguments\" testname=\"User Defined Variables\" enabled=\"true\">
	        <collectionProp name=\"Arguments.arguments\"/>
	      </elementProp>
	      <stringProp name=\"TestPlan.user_define_classpath\"></stringProp>
	    </TestPlan>
	    <hashTree>
	      <ThreadGroup guiclass=\"ThreadGroupGui\" testclass=\"ThreadGroup\" testname=\"Thread Group\" enabled=\"true\">
	        <stringProp name=\"ThreadGroup.on_sample_error\">continue</stringProp>
	        <elementProp name=\"ThreadGroup.main_controller\" elementType=\"LoopController\" guiclass=\"LoopControlPanel\" testclass=\"LoopController\" testname=\"Loop Controller\" enabled=\"true\">
	          <boolProp name=\"LoopController.continue_forever\">false</boolProp>
	          <stringProp name=\"LoopController.loops\">$loopcount</stringProp>
	        </elementProp>
	        <stringProp name=\"ThreadGroup.num_threads\">$noofthreads</stringProp>
	        <stringProp name=\"ThreadGroup.ramp_time\">$rampupperiod</stringProp>
	        <longProp name=\"ThreadGroup.start_time\">1300124363000</longProp>
	        <longProp name=\"ThreadGroup.end_time\">1300124363000</longProp>
	        <boolProp name=\"ThreadGroup.scheduler\">false</boolProp>
	        <stringProp name=\"ThreadGroup.duration\"></stringProp>
	        <stringProp name=\"ThreadGroup.delay\"></stringProp>
	      </ThreadGroup>
	      <hashTree>
	        <HTTPSampler guiclass=\"HttpTestSampleGui\" testclass=\"HTTPSampler\" testname=\"HTTP Request\" enabled=\"true\">
	          <elementProp name=\"HTTPsampler.Arguments\" elementType=\"Arguments\" guiclass=\"HTTPArgumentsPanel\" testclass=\"Arguments\" testname=\"User Defined Variables\" enabled=\"true\">
	            <collectionProp name=\"Arguments.arguments\"/>
	          </elementProp>
	          <stringProp name=\"HTTPSampler.domain\">$servername</stringProp>
	          <stringProp name=\"HTTPSampler.port\">$portno</stringProp>
	          <stringProp name=\"HTTPSampler.connect_timeout\"></stringProp>
	          <stringProp name=\"HTTPSampler.response_timeout\"></stringProp>
	          <stringProp name=\"HTTPSampler.protocol\">$protocol</stringProp>
	          <stringProp name=\"HTTPSampler.contentEncoding\"></stringProp>
	          <stringProp name=\"HTTPSampler.path\">$path</stringProp>
	          <stringProp name=\"HTTPSampler.method\">GET</stringProp>
	          <boolProp name=\"HTTPSampler.follow_redirects\">true</boolProp>
	          <boolProp name=\"HTTPSampler.auto_redirects\">false</boolProp>
	          <boolProp name=\"HTTPSampler.use_keepalive\">true</boolProp>
	          <boolProp name=\"HTTPSampler.DO_MULTIPART_REQUEST\">false</boolProp>
	          <boolProp name=\"HTTPSampler.monitor\">false</boolProp>
	          <stringProp name=\"HTTPSampler.embedded_url_re\"></stringProp>
	        </HTTPSampler>
	        <hashTree>
	          <ResultCollector guiclass=\"GraphVisualizer\" testclass=\"ResultCollector\" testname=\"Graph Results\" enabled=\"true\">
	            <boolProp name=\"ResultCollector.error_logging\">false</boolProp>
	            <objProp>
	              <name>saveConfig</name>
	              <value class=\"SampleSaveConfiguration\">
	                <time>true</time>
	                <latency>true</latency>
	                <timestamp>true</timestamp>
	                <success>true</success>
	                <label>true</label>
	                <code>true</code>
	                <message>true</message>
	                <threadName>true</threadName>
	                <dataType>true</dataType>
	                <encoding>false</encoding>
	                <assertions>true</assertions>
	                <subresults>true</subresults>
	                <responseData>false</responseData>
	                <samplerData>false</samplerData>
	                <xml>true</xml>
	                <fieldNames>false</fieldNames>
	                <responseHeaders>false</responseHeaders>
	                <requestHeaders>false</requestHeaders>
	                <responseDataOnError>false</responseDataOnError>
	                <saveAssertionResultsFailureMessage>false</saveAssertionResultsFailureMessage>
	                <assertionsResultsToSave>0</assertionsResultsToSave>
	                <bytes>true</bytes>
	              </value>
	            </objProp>
	            <stringProp name=\"filename\"></stringProp>
	          </ResultCollector>
	          <hashTree/>
	        </hashTree>
	      </hashTree>
	    </hashTree>
	  </hashTree>
	</jmeterTestPlan>";

	
	$fp = fopen("request.jmx", 'w+');
	fputs($fp, $request);
	fclose($fp);

	$fp = fopen("result.xml", 'w+');
	fputs($fp, "");
	fclose($fp);

	exec("C:\JMeter\apache-jmeter-2.6\bin\jmeter.bat -n -r -t request.jmx -l result.xml");
	$content = simplexml_load_file("result.xml");

	saveToDB($project,$content,$num);
	   echo "<br/>";
	foreach ($content->children() as $child) {

		foreach ($content->httpSample[0]->attributes() as $a => $b) {
			echo $a, "=", $b, "&nbsp;&nbsp;&nbsp;";
		}
        echo "<br/>";
	}
	echo "<br/><h3>Test has completed.</h3><h3>You may reveiw the results <a href='jmeterResults.php?tool=JMeter'>here</a></h3>";
	   

}

//there is a test case file
else {

    $fp = fopen("result.xml", 'w+');
	fputs($fp, "");
	fclose($fp);
	$path=$_REQUEST['testProject']."\\".$_REQUEST['testcase'];
	print("C:\\JMeter\\apache-jmeter-2.6\\bin\\jmeter.bat -r -n -t C:\\xampp\\tomcat\\webapps\\cbsatesting\\WebContent\\LoadTestScript\\".$path." -l result.xml");
	shell_exec("C:\\JMeter\\apache-jmeter-2.6 -n -r -t C:\\xampp\\tomcat\\webapps\\cbsatesting\\WebContent\\LoadTestScript\\".$path." -l result.xml");
	$content = simplexml_load_file("result.xml");
	
	saveToDB($project,$content,$num);
/*
	foreach ($content->children() as $child) {		
		foreach ($child->attributes() as $a => $b) {
			echo $a, "=", $b, "&nbsp;&nbsp;&nbsp;";
		}
		 echo "\n";
	}*/
		echo "<br/><br/><h3>Test has completed.</h3><h3>You may review the results <a href='jmeterResults.php?tool=JMeter'>here</a></h3>";
	
}

function saveToDB($project,$cont,$num){
	$first=true;
	$sec=true;
	$content="";
	$content2="";
	$mid=$num/2;
	$q=1;
	
	foreach($cont->children() as $tag){
	 
		$t=$tag['t'];
		$tn=substr($tag['tn'],15);
		$byte=$tag['by'];
		
		if($q<=$mid){
		if(!$first)
			$content.=",";
		
		$first=false;
		$content.="('".$project."',".$t.", '".$tn."',".$byte.")";	
		}
		else{
		if(!$sec)
			$content2.=",";
		
		$sec=false;
		$content2.="('".$project."',".$t.", '".$tn."',".$byte.")";	
		}
		$q=$q+1;	
	
	}
	
	$user = "root";
	$password = "";
	$database = "CBSA";
	mysql_connect("localhost:3306", $user, $password);
	mysql_select_db($database) or die("Unable to select database");
	$query = "INSERT INTO `cbsa`.`jmeterresult` (  `TestProject`, `RequestTime`, `ThreadName`, `Byte`) VALUES ".$content."; ";
	$result = mysql_query($query);
	 mysql_close();
	 mysql_connect("localhost:3306", $user, $password);
	mysql_select_db($database) or die("Unable to select database");
	 
	$query = "INSERT INTO `cbsa`.`jmeterresult` (  `TestProject`, `RequestTime`, `ThreadName`, `Byte`) VALUES ".$content2."; ";
	$result = mysql_query($query);
   	 mysql_close();
    
    
}
?>


