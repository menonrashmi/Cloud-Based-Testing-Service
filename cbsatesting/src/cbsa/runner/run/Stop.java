package cbsa.runner.run;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class for Servlet: Performance Stop
 * http://localhost/cbsatesting/Performance/Stop
 * 
 * Implements Stop for a given model.
 */

@WebServlet("/Performance/Stop")
public class Stop extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private String responseText;
	private Connection connection;
	private String connectionURL;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Stop() {
        super();
        
        responseText = "Selected metrics are now stopped.";
        
		connection = null;
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
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			
			/* Create a connection by using getConnection() method that takes parameters of 
			string type connection url, user name and password to connect to database. */
			connection = DriverManager.getConnection(connectionURL, "root", "");

			// check weather connection is established or not by isClosed() method 
			if (connection.isClosed()) {
				throw new Exception();
			}
			
			String[] checks = request.getParameterValues("checks");
			if (checks != null) {
				Boolean first = true;
				for (int i = 0; i < checks.length; i++)
				{
					// set model to stopped
					String setStopped = "UPDATE PerformanceModel SET Status = '(stopped)' WHERE Name = '" + checks[i] + "'";
					PreparedStatement setStoppedStatement = connection.prepareStatement(setStopped);
					setStoppedStatement.executeUpdate();
					if(setStoppedStatement.getUpdateCount() != 1)
					{
						if (first)
							responseText = "A selected model could not be stopped. See message below.";
						responseText += "'" + checks[i] + " could not be updated.";
					}
					else
					{
						String getModelId = "Select * from PerformanceModel where Name='" + checks[i] + "'";
						PreparedStatement getModelIdStatement = connection.prepareStatement(getModelId);
						ResultSet getModelIdResult = getModelIdStatement.executeQuery();
						
						while (getModelIdResult.next()) 
						{
							String key = getModelIdResult.getInt("ModelId") + "-Performance-" + getModelIdResult.getInt("Value");
							// stop collecting
							Thread sendThread = new Thread(new Sender(key));
							sendThread.start();
						}
						
						
					}
					setStoppedStatement.close();
				}
			}
			else {
				responseText = "You did not select any models to stop.";
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
		
		response.sendRedirect("/cbsatesting/Performance/PerformanceRunner.jsp?message=" + responseText);
	}

}
