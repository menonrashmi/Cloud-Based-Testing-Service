package saaswatch.collector;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.jms.Connection;
import javax.jms.DeliveryMode;
import javax.jms.Destination;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnectionFactory;

import cbsa.runner.run.SendMessage;
import com.amazonaws.util.json.JSONObject;

public class Collector implements Runnable{
	public int InstanceID= 0;
	public SendMessage recvObj;
	int loopCounter = 0;
	public boolean stop = false;
	@Override
	public void run() {
		try 
		{
			while (!stop)
			{
				System.out.println("ModelId=" + recvObj.ModelID + ": recieving counter=" + loopCounter++);
				// Wait for a message
				List data = new ArrayList();
				JSONObject response = new JSONObject();
				BufferedReader cgiOutput = null;
				String line = null;
				String xmlOutput = null;
				// TODO
				List alldatas = new ArrayList();
				//	                Message message = consumer.receive();
				//	            	if (message != null) {
				//	            	ObjectMessage obj = (ObjectMessage) message;	
				//	            	recvObj = (SendMessage) obj.getObject();
				//	            	stop = recvObj.Stop;
				//	            	}

					ArrayList<String> AvaliableMetrics =  recvObj.MetricNames;
					//System.out.println("Message Type is: "+ recvObj.Type);
//					Date now = new Date();
//					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");       
//					recvObj.TimeStamp  = sdf.format( new Date(now.getTime() + 3600000*8 ));
//					recvObj.EndTime = new Date(now.getTime());
					for(int cnt = 0 ; cnt < AvaliableMetrics.size() ; cnt++){
						//reads the CGI response and print it inside the servlet content
						xmlOutput = "";
						line = null;
						cgiOutput =  new BufferedReader(new InputStreamReader(ConstructURL.getConstructedURLByMsgV2(recvObj,cnt).getInputStream()));
						//System.out.println(cgiOutput);
						while (null != (line = cgiOutput.readLine())){
							xmlOutput += line.trim();
						}	
						//System.out.println("Counter: " + loopCounter + " Data " + xmlOutput);
						response = XMLToJsonConverter.getStatsJSON(response, xmlOutput, recvObj.Statistics.get(cnt),recvObj.MetricNames.get(cnt));
						//alldatas.add(XMLToJsonConverter.getStatsJSON(xmlOutput, "Sum",AvaliableMetrics[cnt]).toString());
						//System.out.println("Max" + XMLToJsonConverter.getStatsData(xmlOutput, "Sum"));
					}
					//response.putOpt("dataCollected", alldatas);
					response.put("ModelID", recvObj.ModelID);
					response.put("Type", recvObj.Type);
					response.put("SampleCount", "1.0");//temporary solution
					//System.out.println(response.toString());
					response(response.toString());
					//JSONObject responseJSON = Misc.getJSONData(alldatas, "Sum", AvaliableMetrics);
					//data = Misc.getCRUMDatas(alldatas);
					//Thread.sleep(60000);
					Thread.sleep(300000);
				
			} 
		}catch (Exception e) {
			System.out.println("Caught: " + e);
			e.printStackTrace();
		}

	}
	public void response(String sendMessage) {
		try {
			// Create a ConnectionFactory
			ActiveMQConnectionFactory connectionFactory = new ActiveMQConnectionFactory("vm://localhost");

			// Create a Connection
			Connection connection = connectionFactory.createConnection();
			connection.start();

			// Create a Session
			Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

			// Create the destination (Topic or Queue)
			Destination destination = session.createQueue("RECIEVER.CBSA");

			// Create a MessageProducer from the Session to the Topic or Queue
			MessageProducer producer = session.createProducer(destination);
			producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);

			// Create a messages
			// String text = "Hello world! From: " + Thread.currentThread().getName() + " : " + this.hashCode();
			// TextMessage message = session.createTextMessage("test");

			TextMessage objMessage = session.createTextMessage(sendMessage);


			// Tell the producer to send the message
			// System.out.println("Sent message: "+ message.hashCode() + " : " + Thread.currentThread().getName());
			//System.out.println("Sent message: " + sendMessage);
			producer.send(objMessage);

			// Clean up
			session.close();
			connection.close();
		}
		catch (Exception e) {
			System.out.println("Caught: " + e);
			e.printStackTrace();
		}
	}
	
	public void SetInstanceID (int id)
	{
		this.InstanceID = id;
	}

}

