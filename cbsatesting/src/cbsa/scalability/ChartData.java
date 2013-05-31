package cbsa.scalability;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cbsa.monitor.chart.JSONArray;
import cbsa.monitor.chart.JSONException;
import cbsa.monitor.chart.JSONObject;

/**
 * Servlet implementation class for Servlet: ChartData
 * http://localhost/cbsatesting/Scalability/ChartData?modelName=<modelName>
 * 
 * Returns JSONString of polygon data.
 */
@WebServlet("/Scalability/ChartData")
public class ChartData extends javax.servlet.http.HttpServlet implements
		javax.servlet.Servlet {

	private String modelName;
	private JSONArray jsarray;
	
	private java.sql.Connection connection;
	private java.sql.Statement statement;
	private String connectionURL;

	public ChartData() {
		super();
		
		// default model
		modelName = "CRUM";
		jsarray = new JSONArray();
		connection = null;
		statement = null;

		connectionURL = "jdbc:mysql://localhost:3306/CBSA";
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		jsarray = new JSONArray();
		if (request.getParameter("modelName") != null
				&& request.getParameter("modelName").length() > 0)
			modelName = request.getParameter("modelName");
		getChartData(modelName);

		response.setContentType("text/javascript");
		PrintWriter out = response.getWriter();
		out.print(jsarray);
		out.flush();
		
		System.out.println("sent back data" + jsarray.toString());

	}

	private void getChartData(String modelName) throws IOException {

		try {

			Class.forName("com.mysql.jdbc.Driver").newInstance();

			connection = DriverManager.getConnection(connectionURL, "root", "");
			statement = connection.createStatement();
			String cont = "SELECT pm.name, pm.statistic, pmd.data, pmd.CollectedTime FROM `scalabilitymetric` pm, `scalabilitymodeldata` pmd";
			cont += " WHERE pm.metricid = pmd.metricid AND pm.type <> 'Model Defined' AND pmd.modelid in (Select modelid from scalabilitymodel where name='";
			cont += modelName;
			cont += "') and pmd.CollectedTime = (select max(CollectedTime) from scalabilitymodeldata where modelId=pmd.modelId)";
			getJSONObj(cont);

			// get time 2
			cont = "SELECT pm.name, pm.statistic, pmd.data, pmd.CollectedTime FROM scalabilitymetric pm, scalabilitymodeldata pmd WHERE pm.metricid = pmd.metricid";
			cont += " AND pm.type <> 'Model Defined' AND pmd.modelid=(select modelid from scalabilitymodel where name='"
					+ modelName
					+ "') AND pmd.`CollectedTime` = ( SELECT distinct `CollectedTime` FROM scalabilitymodeldata pmd1 WHERE pmd1.modelId = pmd.modelId AND ( 2 -1 ) = ( ";
			cont += " SELECT COUNT( DISTINCT (pmd2.`CollectedTime`) ) FROM scalabilitymodeldata pmd2 WHERE pmd2.`CollectedTime` > pmd1.`CollectedTime` AND pmd2.modelId = pmd1.modelId ) )  ";
			getJSONObj(cont);

			// get time 3
			cont = "SELECT pm.name, pm.statistic, pmd.data, pmd.CollectedTime FROM scalabilitymetric pm, scalabilitymodeldata pmd WHERE pm.metricid = pmd.metricid ";
			cont += "AND pm.type <> 'Model Defined' AND pmd.modelid=(select modelid from scalabilitymodel where name='"
					+ modelName
					+ "') AND pmd.`CollectedTime` = ( SELECT distinct `CollectedTime` FROM scalabilitymodeldata pmd1 ";
			cont += "WHERE pmd1.modelId = pmd.modelId AND ( 3 -1 ) = ( SELECT COUNT( DISTINCT (pmd2.`CollectedTime`) ) FROM scalabilitymodeldata pmd2 WHERE pmd2.`CollectedTime` > pmd1.`CollectedTime` AND pmd2.modelId = pmd1.modelId))";
			getJSONObj(cont);

		} catch (Exception ex) {
			System.out.println("Unable to connect to database. "
					+ ex.getMessage());
		} finally {
			if (connection != null) {
				try {
					connection.close();
					System.out.println("Database connection terminated");
				} catch (Exception e) {
				}
			}
		}
	}

	private void getJSONObj(String cont) throws JSONException, SQLException {

		String time = "";
		JSONObject jsobj1 = new JSONObject();
		JSONObject jsobj2 = new JSONObject();

		//System.out.println(cont);
		ResultSet resultset = statement.executeQuery(cont);

		while (resultset.next()) {
			    time = resultset.getString("CollectedTime").substring(11, 19) + "(time)";
			    String name = resultset.getString("name") + " (" + resultset.getString("statistic") + ")";
				jsobj1.put(name,
						resultset.getDouble("data"));
		}
		jsobj2.put("time", time);
		jsarray.put(jsobj2);
		jsarray.put(jsobj1);
		resultset.close();
	}

}

/*
 * 2 5 0 CPUUtilization (%) 30,54,73 2 10 0 DiskReadOps + 2 15 0 DiskWriteOps
 * (count) 125,150,175 2 25 0 DiskWriteBytes (storage) (10E-1 GB) 119,153,235
 * 
 * 2 30 0 NetworkIn (memory) (10E-2 GB) 63,77,106 2 35 0 NetworkOut (10E-2 MB)
 * 128,166,225
 */

/*
 * SELECT pm.name, pm.statistic, pmd.data, pmd.CollectedTime FROM
 * `scalabilitymetric` pm, `scalabilitymodeldata` pmd WHERE pm.metricid =
 * pmd.metricid AND pmd.modelid IN (
 * 
 * SELECT modelid FROM scalabilitymodel pm1 WHERE pm1.`name` = "CRUM" AND
 * pmd.CollectedTime = ( SELECT MAX( CollectedTime ) FROM scalabilitymodeldata )
 * )
 */