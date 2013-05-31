package Recievers;

import java.sql.*;
import java.util.ArrayList;
import javax.jms.Connection;
import javax.jms.Destination;
import javax.jms.ExceptionListener;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.ObjectMessage;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnectionFactory;

import cbsa.runner.run.SendMessage;
import saaswatch.collector.Collector;

public class RecieverSaaSWatch implements Runnable,MessageListener, ExceptionListener
{
	public SendMessage test;
	public SendMessage recvObj;
	int loopCounter = 0;
	int tmpInstanceID= 1000; // start from 1000
	ArrayList<Collector> performanceInstanceList = new ArrayList<Collector>();
	ArrayList<Collector> scalabilityInstanceList = new ArrayList<Collector>();

	private java.sql.Connection sqlconnection;
	private String connectionURL;

	public void run() {
		try {
			// Create a ConnectionFactory
			ActiveMQConnectionFactory connectionFactory = new ActiveMQConnectionFactory("vm://localhost");

			// Create a Connection
			Connection connection = connectionFactory.createConnection();
			connection.start();

			connection.setExceptionListener(this);

			// Create a Session
			Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

			// Create the destination (Topic or Queue)
			Destination destination = session.createQueue("REQUESTOR.CBSA");
			System.out.println("Listen to: REQUESTOR.CBSA" );
			// Create a MessageConsumer from the Session to the Topic or Queue
			MessageConsumer consumer = session.createConsumer(destination);
			consumer.setMessageListener(this);

			//        consumer.close();
			//        session.close();
			//        connection.close();
		} catch (Exception e) {
			System.out.println("Caught: " + e);
			e.printStackTrace();
		}
	}

	public void onException(JMSException arg0) {
		System.out.println("JMS Exception occured.  Shutting down client.");
	}



	@Override
	public void onMessage(Message message) {
		// ThreadGroup threadGroup = new ThreadGroup("RECV");
		String stopper = null;
		TextMessage msg = null;

		//System.out.println("ReceiverSaasWatch Received Message: " + message);

		if (message instanceof TextMessage) {
			msg = (TextMessage) message;
			try {
				stopper = msg.getText();
				String[] keys = stopper.split("-");
				int a = Integer.parseInt(keys[0]);
				String type = keys[1];
				int instid = Integer.parseInt(keys[2]);
				boolean foundCollector = false;
				Collector collector = null;

				System.out.println
				("MESSAGE BEAN: Stop Message received: " 
						+ stopper + " to stop instance: " + type + " " + a + " " + instid);
				if (type.contains("Performance")){
					for (int i=0; i<performanceInstanceList.size(); i++)
					{
						collector = performanceInstanceList.get(i);

						if (collector.InstanceID == instid) {
							foundCollector = true;
							break;
						}
					}

					if (foundCollector ){
						System.out.println("Found performance instance " + instid);
						collector.stop = true;
						performanceInstanceList.remove(collector);						
					}
				}
				else if (type.contains("Scalability")){
					for (int i=0; i<scalabilityInstanceList.size(); i++)
					{
						collector = scalabilityInstanceList.get(i);

						if (collector.InstanceID == instid) {
							foundCollector = true;
							break;
						}
					}

					if (foundCollector){
						System.out.println("Found scalability instance " + instid);
						collector.stop = true;
						scalabilityInstanceList.remove(collector);						
					}
				}
			} catch (JMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} else {
			Collector collectInstance = new Collector();

			ObjectMessage obj = (ObjectMessage) message;
			//System.out.println(obj.toString());
			//TextMessage stoper = (TextMessage)message;
			try {
				//if(obj.toString() != "stop"){
				collectInstance.recvObj = (SendMessage) obj.getObject();
				System.out.println(collectInstance.recvObj);

			} catch (JMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			if(collectInstance.recvObj.Type.contains("Performance")) {
				performanceInstanceList.add(collectInstance);
				System.out.println("performanceInstanceList size is " + performanceInstanceList.size());
				Thread recieveThread = new Thread(collectInstance);
				synchronized (this) {
					collectInstance.InstanceID = ++tmpInstanceID ;					
				}
				recieveThread.start();
				System.out.println("created performance receiver " + collectInstance.InstanceID);	
				updateInstanceId("Performance", collectInstance.recvObj.ModelID, collectInstance.InstanceID);
			}
			else if(collectInstance.recvObj.Type.contains("Scalability")) {
				scalabilityInstanceList.add(collectInstance);
				System.out.println("scalabilityInstanceList size is " + scalabilityInstanceList.size());
				Thread recieveThread = new Thread(collectInstance);
				synchronized (this) {
					collectInstance.InstanceID = ++tmpInstanceID ;					
				}
				recieveThread.start();
				System.out.println("created scalability receiver " + collectInstance.InstanceID);
				updateInstanceId("Scalability", collectInstance.recvObj.ModelID, collectInstance.InstanceID);
			}
		}
	}

	private void updateInstanceId(String type, int modelId, int instId)
	{
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();			
			connectionURL = "jdbc:mysql://localhost:3306/CBSA";
			sqlconnection = DriverManager.getConnection(connectionURL, "root", "");

			String setRunning = " SET Value = " + instId + " WHERE ModelID = " + modelId;

			if (type.equals("Performance"))
				setRunning = "UPDATE PerformanceModel " + setRunning;
			else if (type.equals("Scalability"))
				setRunning = "UPDATE ScalabilityModel " + setRunning;

			//System.out.println(setRunning);
			PreparedStatement setRunningStatement = sqlconnection.prepareStatement(setRunning);
			setRunningStatement.executeUpdate();


		} catch (Exception e) {
			e.printStackTrace();
		} 

		try {
			sqlconnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}



