package cbsa.scalability;

import java.awt.print.Printable;
import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cbsa.runner.run.SendMessage;
import cbsa.runner.run.Sender;

/**
 * Servlet implementation class for Servlet: Scalability Run
 * http://localhost/cbsatesting/Scalability/Run
 * 
 * Implements Run for a given model
 */
@WebServlet("/Scalability/Run")
public class Run extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	private String responseText;
	private Connection connection;
	private String connectionURL;
	
	private SendMessage sendMessage;
	private ArrayList<String> metricList;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Run() {
        super();
        
        // default return message
        responseText = "Selected metrics are now running.";
        
		connection = null;
		connectionURL = "jdbc:mysql://localhost:3306/CBSA";
		
		sendMessage = new SendMessage();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			
			/* Create a connection by using getConnection() method that takes parameters of 
			string type connection url, user name and password to connect to database. */
			connection = DriverManager.getConnection(connectionURL, "root", "");

			// check weather connection is established or not by isClosed() method 
			if (connection.isClosed()) {
				throw new Exception();
			}
			
			System.out.println("AWSAccessKeyId=" + request.getParameter("AWSAccessKeyId"));
			System.out.println("AWSSecretAccessKey=" + request.getParameter("AWSSecretAccessKey"));
			System.out.println("InstanceID=" + request.getParameter("InstanceID"));
			System.out.println("period=" + request.getParameter("period"));
			System.out.println("checks=" + request.getParameter("checks"));

			if(request.getParameter("AWSAccessKeyId") == null
					|| request.getParameter("AWSSecretAccessKey") == null
					|| request.getParameter("InstanceID") == null
					|| request.getParameter("period") == null)
			{
				responseText = "Some required values were left blank.";
			}
			else
			{
				
				sendMessage.AWS_ID = request.getParameter("AWSAccessKeyId");
				sendMessage.AWS_Key = request.getParameter("AWSSecretAccessKey");
				sendMessage.InstanceId = request.getParameter("InstanceID");

				sendMessage.Period = 60;
				
				sendMessage.CollectPeriod = Integer.parseInt(request.getParameter("period"));
				
				String[] checks = request.getParameterValues("checks");
				if (checks != null) {
					sendRequest(checks);
				}
				else {
					responseText = "You did not select any models to run.";
				}
			}
		} catch (Exception ex) {
			responseText = "Unable to connect to database.";
			System.out.println("Unable to connect to database." + ex.getMessage());
		} finally {
			if (connection != null) {
				try {
					connection.close();
					System.out.println("Database connection terminated");
				} catch (Exception e) {
				}
			}
		}
		response.sendRedirect("/cbsatesting/Scalability/ScalabilityRunner.jsp?message=" + responseText);
	}

	private void sendRequest(String[] checks) throws SQLException {
		Boolean first = true;
		for (int i = 0; i < checks.length; i++)
		{
			String getModel = "SELECT * FROM scalabilitymodel WHERE Name='" + checks[i] + "'";
			PreparedStatement getModelStatement = connection.prepareStatement(getModel);
			ResultSet getModelResult = getModelStatement.executeQuery();
			if (getModelResult.next() && getModelResult.getString("Status").equals("(stopped)")) 
			{
				sendMessage.ModelID = getModelResult.getInt("ModelID");
				sendMessage.Type = "Scalability";
				String getMetrics = "Select ScalabilityMetric.Name, ScalabilityMetric.Statistic from ScalabilityMetric where ScalabilityMetric.MetricID in "
						+ "(Select ScalabilityModelMetric.MetricID from ScalabilityModelMetric where ScalabilityModelMetric.ModelMetric = 0 and ScalabilityModelMetric.ModelID in "
						+ "(Select ScalabilityModel.ModelID from ScalabilityModel where ScalabilityModel.Name = '"
						+ checks[i] + "'))";
				PreparedStatement getMetricsStatement = connection.prepareStatement(getMetrics);
				ResultSet getMetricsResult = getMetricsStatement.executeQuery();
				
				metricList = new ArrayList<String>();
				while (getMetricsResult.next()) 
				{
					getSystemMetrics(getMetricsResult.getString("Name"), getMetricsResult.getString("Statistic"));
				}
				
				sendMessage.MetricNames = new ArrayList<String>();
				sendMessage.Statistics = new ArrayList<String>();
				
				for(int j = 0; j < metricList.size(); j++)
				{
					String[] metrics = metricList.get(j).split(":");
					sendMessage.MetricNames.add(j, metrics[0]);
					sendMessage.Statistics.add(j, metrics[1]);
				}
				
				// send message
				Thread sendThread = new Thread(new Sender(sendMessage));
				System.out.println("Sending Message to SaaS Watch.");
				sendThread.start();
				
				// set model to running
				String setRunning = "UPDATE ScalabilityModel SET Status = '(running)' WHERE ModelID = " + getModelResult.getInt("ModelID");
				
				PreparedStatement setRunningStatement = connection.prepareStatement(setRunning);
				setRunningStatement.executeUpdate();
				if(setRunningStatement.getUpdateCount() != 1)
				{
					if (first)
						responseText = "A selected model could not run. See message below.";
					responseText += " </br> '" + checks[i] + " could not be updated.";
				}
			}
			else
			{
				if (first)
					responseText = "A selected model could not run. See message below.";
				responseText += "</br> '" + checks[i] + "' is already running.";
			}
			getModelResult.close();
			getModelStatement.close();
		}
	}

	public void getSystemMetrics(String metric, String statistic)
	{
		if (statistic.equals("None")) {
			try {
				String getEquation = "SELECT Equation FROM ScalabilityMetric WHERE Name='" + metric + "' AND Statistic='None' AND Type='User Defined'";
				PreparedStatement getEquationStatement = connection.prepareStatement(getEquation);
				ResultSet getEquationResult = getEquationStatement.executeQuery();
				if(getEquationResult.next())
				{
					String[] equation = getEquationResult.getString("Equation").split(" ");
					getSystemMetrics(equation[2], equation[4]);
					getSystemMetrics(equation[8], equation[10]);
				}
			}
			catch (Exception ex) {
				// Exception Occurred. 
				ex.printStackTrace();
			}
		}
		else {
			if(!metricList.contains(metric + ":" + statistic))
				metricList.add(metric + ":" + statistic);
		}
	}
}
