package cbsa.runner.run;

import javax.jms.Connection;
import javax.jms.DeliveryMode;
import javax.jms.Destination;
import javax.jms.MessageProducer;
import javax.jms.ObjectMessage;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnectionFactory;

/**
 * Sends given message to SaaS Watch.
 *
 */
public class Sender implements Runnable {
	
	public SendMessage sendMessage;
	public String stopMessage;
	
	public Sender(SendMessage sendMessage)
	{
		this.sendMessage = sendMessage;
		stopMessage = null;
	}
	
	public Sender(String stopMessage)
	{
		this.stopMessage = stopMessage;
		sendMessage = null;
	}
	
    public void run() {
        try {
        	
            // Create a ConnectionFactory
            ActiveMQConnectionFactory connectionFactory = new ActiveMQConnectionFactory("vm://localhost");

            // Create a Connection
            Connection connection = connectionFactory.createConnection();
            connection.start();

            // Create a Session
            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

            // Create the destination (Topic or Queue)
            Destination destination = session.createQueue("REQUESTOR.CBSA");

            // Create a MessageProducer from the Session to the Topic or Queue
            MessageProducer producer = session.createProducer(destination);
            producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);

            // Create a messages
            // String text = "Hello world! From: " + Thread.currentThread().getName() + " : " + this.hashCode();
            // TextMessage message = session.createTextMessage("test");

            if(sendMessage != null)
            {
            	 //System.out.println("sending type " + sendMessage.Type);
            	 producer.send(session.createObjectMessage(sendMessage));
            }
            else if (stopMessage != null)
            {
            	producer.send(session.createTextMessage(stopMessage));
            }
            
            // Clean up
            session.close();
            connection.close();
        }
        catch (Exception e) {
            System.out.println("Caught: " + e);
            e.printStackTrace();
        }
    }
}