package cbsa.scalability;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cbsa.monitor.chart.JSONArray;

/**
 * Servlet implementation class for Servlet: StatsData
 * http://localhost/cbsatesting/Scalability/StatsData?modelName=<modelName>
 * 
 * Returns table of a model's data.
 */
@WebServlet("/Scalability/StatsData")
public class StatsData extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String modelName;
	private String responseText;
	
	private Connection connection;
	private Statement statement;
	private String connectionURL;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StatsData() {
        super();
		// default model
		responseText = "<table> Unable to get Data. </table>";
		connection = null;
		statement = null;
		connectionURL = "jdbc:mysql://localhost:3306/CBSA";
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
		if (request.getParameter("modelName") != null)
		{
			modelName = request.getParameter("modelName");
		}
		
		getStatsData(modelName);
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.print(responseText);
		out.flush();
		out.close();
		System.out.println("Sent back table data: " + responseText);
	}

	private void getStatsData(String modelName) {
		if(modelName == null)
		{
			responseText = "<table> Model Name was not found. </table>";
			return;
		}
		
		responseText = "<table class='graytable'>" +
				"<tr><th>Collected Time</th>" +
				"<th>Metric Name</th>" +
				"<th>Statistic</th>" +
				"<th>Metric Data</th></tr>";
		
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();

			connection = DriverManager.getConnection(connectionURL, "root", "");
			statement = connection.createStatement();
			
			// get time 1
			String statsQuery = "SELECT pm.name, pm.statistic, pmd.data, pmd.CollectedTime FROM `scalabilitymetric` pm, `scalabilitymodeldata` pmd";
			statsQuery += " WHERE pm.metricid = pmd.metricid AND pmd.modelid in (Select modelid from scalabilitymodel where name='" + modelName;
			statsQuery += "' and pmd.CollectedTime = (select max(CollectedTime) from scalabilitymodeldata)) ";
			getTR(statsQuery);

			// get time 2 to 10 
			for (int i = 2; i <= 10; i++) {
				statsQuery = "SELECT pm.name, pm.statistic, pmd.data, pmd.CollectedTime FROM scalabilitymetric pm, scalabilitymodeldata pmd WHERE pm.metricid = pmd.metricid";
				statsQuery += " AND pmd.modelid=(select modelid from scalabilitymodel where name='" + modelName
						+ "') AND pmd.`CollectedTime` = ( SELECT distinct `CollectedTime` FROM scalabilitymodeldata pmd1 WHERE ( " + i + " - 1 ) = ( ";
				statsQuery += " SELECT COUNT( DISTINCT (pmd2.`CollectedTime`) ) FROM scalabilitymodeldata pmd2 WHERE pmd2.`CollectedTime` > pmd1.`CollectedTime` ) )  ";
				getTR(statsQuery);
			}

		} catch (Exception ex) {
			System.out.println("Unable to connect to database. " + ex.getMessage());
		} finally {
			if (connection != null) {
				try {
					connection.close();
					System.out.println("Database connection terminated");
				} catch (Exception e) {
				}
			}
		}
		
		//get footer value
		responseText += "</table>";
	}

	private void getTR(String statsQuery) throws SQLException {
		ResultSet resultset = statement.executeQuery(statsQuery);
		boolean first = true;
		while (resultset.next()) {
			if(first)
			{
				responseText += "<tr><td>" + resultset.getString("CollectedTime") + "</td>";
				first = false;
			}
			else
				responseText += "<tr><td></td>";
			
			responseText += "<td>" + resultset.getString("Name") + "</td><td>";
			responseText += resultset.getString("Statistic") + "</td><td>";
			responseText += resultset.getString("Data") + "</td></tr>";
		}
	}

}
