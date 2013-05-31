package Recievers;

import java.util.Date;

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

import saaswatch.collector.Collector;

import cbsa.runner.run.SendMessage;

public class RecieverCBSA implements Runnable, ExceptionListener, MessageListener
{
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
            Destination destination = session.createQueue("RECIEVER.CBSA");
            System.out.println("Listen to: RECIEVER.CBSA" );
            System.out.println("MNJ: RECEIVER.CBSA is our queue name sent to amazon instance");

            // Create a MessageConsumer from the Session to the Topic or Queue
            MessageConsumer consumer = session.createConsumer(destination);
            consumer.setMessageListener(this);
            
            
//            consumer.close();
//            session.close();
//            connection.close();
            
        } catch (Exception e) {
            System.out.println("Caught: " + e);
            e.printStackTrace();
        }
	}

	public void onException(JMSException arg0) {
		System.out.println("JMS Exception occured. Shutting down client.");
	} 	

	
	public void onMessage(Message message) {
    	//System.out.println("Receiver CBSA Received Message: " + message);

		System.out.println("MNJ: in onMessage: received message from amazon instance: MNJ");
    	// Received text message.
    	if (message instanceof TextMessage) {
            TextMessage textMessage = (TextMessage) message;
            String text = "";
            
			try {
				text = textMessage.getText();
			} catch (JMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			Date now = new Date();
            System.out.println(now.toString() + ": collected JSON: " + text);
            
            if(text.contains("Performance"))
            	new cbsa.runner.run.Collect(text);            
            else if(text.contains("Scalability"))
            	new cbsa.scalability.Collect(text);
        } 
        else if (message instanceof ObjectMessage)
        {
        	ObjectMessage obj = (ObjectMessage) message;
        	SendMessage objMessage = null;
        	
			try {
				objMessage = (SendMessage) obj.getObject();
			} catch (JMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
        	System.out.println("Received Obj: " + objMessage);
        	
        }
	}
}