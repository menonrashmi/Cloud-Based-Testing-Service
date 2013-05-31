package cbsa.test.simulation;

import java.io.*;
import java.net.URLEncoder;
import java.sql.DriverManager;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;



public class SeleniumTest {
	private String testURL;
	private String testSuite;
	private long timeStamp;
	private String resultPath;
	private String testProject;
	
	public SeleniumTest(String url, String tp, String suite) {
		testURL = url;
		testProject=tp;
		testSuite = "C:\\xampp\\tomcat\\webapps\\cbsatesting\\src\\seleniumTS\\"+tp+"\\"+suite;
		timeStamp = System.currentTimeMillis();
		resultPath = "C:\\xampp\\tomcat\\webapps\\cbsatesting\\src\\SeleniumResults\\"+tp+"\\"
			+ timeStamp + ".html";

	}

	public void setUp() {
		try {
			Runtime rt = Runtime.getRuntime();

			String cmd = "java -jar C:/selenium/selenium-server-standalone-2.21.0.jar -htmlSuite \"*firefox\"  \""
					+ testURL
					+ "\" \""
					+ testSuite
					+ "\" \""
					+ resultPath
					+ "\" ";
			System.out.println("cmd is:"+cmd);
			Process pr = rt.exec(cmd);

		
			BufferedReader input = new BufferedReader(new InputStreamReader(
					pr.getInputStream()));

			String line = null;

			while ((line = input.readLine()) != null) {
				System.out.println(line);
			}

			int exitVal = pr.waitFor();
			System.out.println("Saving results to database... ");
			saveToDB();
			System.out.println("Exited with error code " + exitVal);
			
			

		} catch (Exception e) {
			System.out.println(e.toString());
			e.printStackTrace();
		}
	}

	private void saveToDB() throws IOException {
		java.sql.Connection connection = null;
		String resultFile="http://localhost/src/seleniumResults/"+testProject+"/"+timeStamp+".html";
	
		try {
			java.sql.Statement statement = null;
			Document doc = Jsoup.connect(resultFile).get();
			//System.out.println(doc);
			Elements lines = doc.select("td");
			//System.out.println(lines);
	        int pass=Integer.parseInt(lines.get(7).text());
	        System.out.println(pass);
	        int fail=Integer.parseInt(lines.get(9).text());	        
	        System.out.println(fail);
	        
			String connectionURL = "jdbc:mysql://localhost:3306/CBSA";

			Class.forName("com.mysql.jdbc.Driver").newInstance();

			connection = DriverManager.getConnection(connectionURL, "root", "");
			statement = connection.createStatement();
			String testSuiteName=testSuite.replace("C:\\xampp\\tomcat\\webapps\\cbsatesting\\src\\seleniumTS\\"+testProject+"\\","");
            String cont= "(NULL,"+"'"+testProject+"',2, NULL,'"+ URLEncoder.encode(testURL)+ "', '"+ URLEncoder.encode(testSuiteName)+ "', '"+ timeStamp+ "', "+pass+", "+fail+", NULL)";
            System.out.println(cont);
            statement.executeUpdate("INSERT INTO `cbsa`.`seleniumresult` VALUES " +cont);
		} catch (Exception ex) {
			System.out.println("Unable to connect to database. "
					+ ex.getMessage());
		} finally {
			if (connection != null) {
				try {
					connection.close();
					System.out.println("Database connection terminated");
				} catch (Exception e) { /* ignore close errors */
				}
			}
		}

	}
}