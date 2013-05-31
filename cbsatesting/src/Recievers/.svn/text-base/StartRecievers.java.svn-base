package Recievers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class for Servlet: Start Recievers
 * http://localhost/cbsatesting/Performance/StartRecievers
 * 
 * Starts running receivers for CBSA and SaaS Watch.
 */
@WebServlet("/Performance/StartRecievers")
public class StartRecievers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StartRecievers() {
        super();
        // TODO Auto-generated constructor stub
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
		
		Thread receiveCBSA = new Thread(new RecieverCBSA());
		receiveCBSA.start();
		
		Thread receiveSaaS = new Thread(new RecieverSaaSWatch());
		receiveSaaS.start();
		
		System.out.println("Recievers started at " + receiveSaaS.getName() + "status: " + receiveSaaS.isAlive());
		
		response.sendRedirect("/cbsatesting/Performance/SaaSEvaluation.jsp?message=Receivers started.");
	}

}
