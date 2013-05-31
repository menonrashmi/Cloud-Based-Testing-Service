dojo.require("dijit.form.ComboBox");
dojo.require("dijit.form.Button");
dojo.require("dijit.form.TextBox");
dojo.require("dijit.form.TimeTextBox");
dojo.require("dijit.form.DateTextBox");
dojo.require("dojox.form.Uploader");
dojo.require("dijit.ProgressBar");
dojo.require("dijit.layout.TabContainer");
dojo.require("dijit.layout.ContentPane");
dojo.require("dojo.parser");

function submitTool() {
	var tool = dijit.byId("toolSel").value;

	if (tool == "JMeter") {
		// manual configure test
		if (dijit.byId("tcaseName").attr("value") == "") {
			// this.frameElement.src = "simulation/manualTest.html";
			dijit.byId("jmeterContainer").selectChild("configTab2");
		}
		// with test case
		else {

			startDynamic();
			startTest();
		}
	}
	// selenium testing
	else {
		// manual configure test
		if (dijit.byId("testSuite").attr("value") == "") {

		}
		// with test case
		else {
			this.frameElement.src = "simulation/GUITesting.html";
		}
	}
}

var updateBar;
var updateContent;

function startDynamic() {
	var dataReturn;
	var i = 0;
	var con = true;

	dijit.byId("jmeterContainer").selectChild(dijit.byId("statusTab"));

	if (dijit.byId("tcaseName") == undefined) {

		var url = "/cbsatesting/test/simulation/RunTestPlan?noofthreads="
				+ dijit.byId("noofthreads").value + "&loopcount="
				+ dijit.byId("loopcount").value + "&servername="
				+ dijit.byId("servername").value + "&testProject="
				+ dijit.byId("tprojectName").value + "&rampupperiod="
				+ dijit.byId("rampupperiod").attr('value').split(' ')[0] * 500
				+ "&protocol=" + dijit.byId("protocol").value + "&path="
				+ dijit.byId("path").value + "&port="
				+ dijit.byId("port").value;

		console.log(url);
		if (dijit.byId("rampupperiod").attr('value') !== undefined) {
			var interval = (dijit.byId("rampupperiod").attr('value').split(' ')[0] + dijit
					.byId("noofthreads").value)
					* 1000 * dijit.byId("loopcount").value;
		} else {
			var interval = dijit.byId("noofthreads").value * 1000
					* dijit.byId("loopcount").value;
		}
	} else {
		var testCaseO = dijit.byId("tcaseName").attr("value");

		if (testCaseO.indexOf("C:") == 0)
			var testCase = testCaseO.substr(testCaseO.lastIndexOf("\\") + 1);
		else
			var testCase = testCaseO;
		//testCase= "C:\xampp\tomcat\webapps\cbsatesting\WebContent\simulation\request.jmx";

		var url = "/cbsajmtr/index.php?testcase=request.jmx&testProject="+dijit.byId("tprojectName").value;

		if (dijit.byId("rampupperiod").attr('value') !== undefined) {
			var interval = (dijit.byId("rampupperiod").attr('value').split(' ')[0] + dijit
					.byId("noofthreads").value)
					* 1000 * dijit.byId("loopcount").value;
		} else {
			var interval = dijit.byId("noofthreads").value * 1000
					* dijit.byId("loopcount").value;
		}

	}

	var area = dojo.byId("barDiv");

	area.style.display = "block";

	dojo.xhrGet({
		url : url,
		handleAs : "text",
		load : function(data) {
			dataReturn = data;
		}
	});

	updateBar = setInterval(function() {

		if (i == 101 && dataReturn !== undefined) {

			var result = dojo.create("div", {
				innerHTML : dataReturn,
				id : "jmeterTestResult"
			});
			area.appendChild(result);

			i++;
		} else if (i <= 100) {
			dijit.byId("testProgress").update({

				progress : i++,
				maximum : 100
			});
		}
	}, interval / 100);

}

function startTest() {
	var schedule = dojo.byId("option").style.display;
	
	var dataReturn;
	var i = 0;
	var con = true;
	if (dijit.byId("tcaseName").value == "") {
		var date = dijit.byId("startDate").value;
		var url = "/cbsatesting/Users/RunTestPlan";
		var parms = "noofthreads=" + dijit.byId("noofthreads").value
				+ "&loopcount=" + dijit.byId("loopcount").value
				+ "&servername=" + dijit.byId("servername").value
				+ "&rampupperiod="
				+ dijit.byId("rampupperiod").attr('value').split(' ')[0]
				+ "&protocol=" + dijit.byId("protocol").value + "&path="
				+ dijit.byId("path").value + "&port="
				+ dijit.byId("port").value + "&delay="
				+ dijit.byId("delay").value.split(' ')[0] + "&testProject="
				+ dijit.byId("tprojectName").value + "&startTime="
				+ dijit.byId("startTime").value.toString().split(' ')[4]
				+ "&startDate=" + (date.getMonth() + 1)
				+ date.toString().split(' ')[2] + date.toString().split(' ')[3];
		if (dijit.byId("rampupperiod").attr('value') !== undefined) {
			var interval = dijit.byId("rampupperiod").attr('value').split(' ')[0]
					* 800
					+ dijit.byId("noofthreads").value
					* 10
					* dijit.byId("loopcount").value;
		} else {
			var interval = dijit.byId("noofthreads").value
					* dijit.byId("loopcount").value * 1.5;
		}

	} else {
		var url = "/cbsajmtr/index.php?testcase=request.jmx&testProjecttestcase=" + dijit.byId("tcaseName").value;
		interval = 50000;
	}
	var area = dojo.byId("barDiv");

	dijit.byId("jmeterContainer").selectChild("statusTab");
	area.style.display = "block";
	// it's scheduled
	if (schedule == "block") {
		dojo.xhrPost({
			url : url,
			postData : parms,
			handleAs : "text",
			load : function(data) {
				dataReturn = data;
			}
		});

		var te = dojo
				.create(
						"div",
						{
							innerHTML : "<h3>Your test has been scheduled.</h3><h3>You may reveiw the results <a href='http://localhost/test/jmeterResults.php?tool=JMeter'>here</a> after the scheduled time.</h3>",
							id : "te"
						});
		area.innerHTML = "";
		area.appendChild(te);
	}
	// if it's run now test
	else {
		var delayMin = dijit.byId("delay").value.split(' ')[0] * 60000;

		/*
		 * var w=new Date(dijit.byId("startTime").value); w.setYear(2011);
		 * w.setMonth(10);
		 * 
		 * var hold=Math.round(new Date())-Math.round(new
		 * Date(2011,dijit.byId("startTime").value));
		 * 
		 * if(hold>0){ delayMin+=hold; }
		 * 
		 */

		setTimeout(
				function() {
					dojo.xhrPost({
						url : url,
						postData : parms,
						handleAs : "text",
						load : function(data) {
							dataReturn = data;
							//alert(dataReturn);
						},
						 error: function(error){
						        // We'll 404 in the demo, but that's okay.  We don't have a 'postIt' service on the
						        // docs server.
						       //alert(error);
						      }
					});
					
					updateBar = setInterval(
							function() {								
								if (i == 101 && dataReturn !== undefined) {

									var result = dojo
											.create(
													"div",
													{
														innerHTML : "<br/><h3>Test has completed.</h3><h3>You may reveiw the results <a href='http://localhost/test/jmeterResults.php?tool=JMeter'>here</a></h3>",
														id : "jmeterTestResult"
													});
									area.appendChild(result);
									//alert("HI87");
									i++;
								} else if (i <= 100) {
									dijit.byId("testProgress").update({

										progress : i++,
										maximum : 100
									});
								}
							}, interval / 200);
				}, delayMin);
	}
}

/*function startGUITest() {
	var button = dijit.byId("submittest");
	alert(button);
	dojo.connect(button, "onClick", function(event) {
		var xhrArgs = {
			url : "../../Users/RunGUITest",
			postData : "Hi",
			handleAs : "text",
			load : function(responseFromServlet) {
				alert(responseFromServlet);
				// Do with the response content what you want 
				//  dojo.byId('targetForTheResponse').innerHTML = responseFromServlet; 
			},
			error : function(error) {
				// Something went wrong.. and error contains the 
				alert(error);
				// maybe show the response in a popup 
				// dojo.byId('popup').innerHTML = error; 
			 }
		};
	    // Call the asynchronous xhrPost
	    var deferred = dojo.xhrPost(xhrArgs);
	  });
	}
	dojo.ready(startGUITest);*/

function startGUITest1() {
	//alert("old51");
	var area = dojo.byId("barDiv");
	var schedule = dojo.byId("option").style.display;
	var dataReturn;
	var i = 0;
	var interval = dijit.byId("rampupperiod").attr('value').split(' ')[0];
	var con = true;
	var date = dijit.byId("startDate").value;

	//alert(date);
	var url = "http://localhost/cbsatesting/Users/RunGUITest";//../../Users/RunGUITest";
	var testSuiteO = dijit.byId("testSuite").value;

	if (testSuiteO.indexOf("C:") == 0)
		var testSuite = testSuiteO.substr(testSuiteO.lastIndexOf("\\") + 1);
	else
		var testSuite = testSuiteO;

	var parms = "&testProject=" + dijit.byId("tprojectName").value
			+ "&loopcount=" + dijit.byId("loopcount").value + "&testURL="
			+ dijit.byId("testURL").value + "&rampupperiod=" + interval
			+ "&testSuite=" + testSuite + "&delay="
			+ dijit.byId("delay").value.split(' ')[0] + "&startTime="
			+ dijit.byId("startTime").value.toString().split(' ')[4]
			+ "&startDate=" + (date.getMonth() + 1)
			+ date.toString().split(' ')[2] + date.toString().split(' ')[3];

	dijit.byId("seleniumContainer").selectChild(dijit.byId("statusTab"));
	area.innerHTML = "<h3>GUI testing has started ...</h3><br/>";

	//alert("hi there params:" + parms);

	area.style.display = "block";
	// it's scheduled
	if (schedule == "block") {
		dojo.xhrPost({
			url : url,
			postData : parms,
			handleAs : "text",
			load : function(data) {
				dataReturn = data;
			}
		});
		var te = dojo
				.create(
						"div",
						{
							innerHTML : "<h3>Your test has been scheduled. BLOCKED </h3><h3>You may reveiw the results <a href='http://localhost/test/jmeterResults.php?tool=Selenium'>here</a> after the scheduled time.</h3>",
							id : "te"
						});
		area.innerHTML = "";
		area.appendChild(te);
	}
	// if it's run now test
	else {
		//alert("in else");
		dojo
				.xhrPost({
					url : url,
					postData : parms,
					handleAs : "text",
					load : function(data) {
						dataReturn = data;
						area.style.display = "block";
						area.innerHTML += "<h3>Testing has completed. ELSE </h3><h3>You may review the results <a href='http://localhost/test/jmeterResults.php?tool=Selenium'>here</a>.</h3>";

					},
					error : function(error) {
						// We'll 404 in the demo, but that's okay.  We don't have a 'postIt' service on the
						// docs server.
						alert(error);
					}
				});

	}
}

function stopTest() {
	clearInterval(updateBar);
	clearInterval(updateContent);
	var dataReturn;

	var area = dojo.byId("barDiv");
	dojo.xhrGet({
		url : "stop_jmeter.php",
		handleAs : "text",
		handle : function(data) {
			dataReturn = data;

		}
	});

	var label = dojo.create("h2", {
		innerHTML : "<h3>Testing has been stopped.</h3>"
	});
	area.appendChild(label);

}

function changeURL(url) {
	this.parent.dojo.byId("ContentFrame").src = url;
}
