package cbsa.test.simulation;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.GregorianCalendar;
import java.util.SimpleTimeZone;
import java.util.TimeZone;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.openqa.selenium.*;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.remote.RemoteWebDriver;

import com.thoughtworks.selenium.Selenium;

/**
 * Servlet implementation class for Servlet: RunGUITest
 * 
 */
public class RunGUITest extends javax.servlet.http.HttpServlet implements
		javax.servlet.Servlet {
	public RunGUITest() {
		super();

	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		/*
		Enumeration<String> temp = request.getParameterNames();
		while (temp.hasMoreElements())
		{
			String x = temp.nextElement();
			String res[] = request.getParameterValues(x);
			System.out.println(x + "=" + res[0]);
		}
		*/
		int startHour = Integer.parseInt(request.getParameter("startTime")
				.substring(0, 2));
		int startMin = Integer.parseInt(request.getParameter("startTime")
				.substring(3, 5));
		int startMonth = Integer.parseInt(request.getParameter("startDate")
				.substring(0, 2));
		int startDate = Integer.parseInt(request.getParameter("startDate")
				.substring(2, 4));
		int startYear = Integer.parseInt(request.getParameter("startDate")
				.substring(4, 7));
		String testSuite = request.getParameter("testSuite");
		String testProject = request.getParameter("testProject");
		String url = request.getParameter("testURL");
		int delay = Integer.parseInt(request.getParameter("delay"))*60000;
		TimeZone tz = TimeZone.getTimeZone("America/Los_Angeles");
		
		// Date today = new Date();
		Calendar calendar = new GregorianCalendar(tz);
		calendar.set(startYear, startMonth - 1, startDate - 1, startHour - 1,
				startMin, 0);

		Timestamp ts = new Timestamp(calendar.getTimeInMillis());

		long startTime = ts.getTime();

		Calendar calendarNow = new GregorianCalendar(tz);
		Timestamp tsNow = new Timestamp(calendarNow.getTimeInMillis());
		long now = tsNow.getTime();
		System.out.println("start:" + startHour + ":" + startMin +" "+ startMonth
				+"-"+ startYear +"-"+ startDate);
		System.out.println("now:" + now);

		response.setContentType("text/html");
		
		System.out.println("Starting GUI testing ...");

		try {
			long sleepTime = startTime + delay - now + 90000000;
			System.out.println("sleep:" + sleepTime);

			if (sleepTime > 0)
				Thread.sleep(sleepTime);

			SeleniumTest selenium = new SeleniumTest(url, testProject,testSuite);
			int loop=Integer.parseInt(request.getParameter("loopcount"));
			int interval=Integer.parseInt(request.getParameter("rampupperiod"))*1000;
			for(int i=0;i<loop;i++){
				   if(i>0)
					   Thread.sleep(interval);
			       selenium.setUp();
			       System.out.println("next selenium starts in "+interval+" ms.");
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}