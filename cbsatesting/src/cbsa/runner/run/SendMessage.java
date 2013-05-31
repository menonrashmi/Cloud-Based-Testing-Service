package cbsa.runner.run;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

public class SendMessage implements Serializable
{ 
	// activeMQ
	public int ModelID; 
	public String Type;
	
	public String AWS_ID=""; // amazon id
	public String AWS_Key=""; // amazon secret key
	public String InstanceId; // instance to get it from
	
	public String EndPoint; // region, locational, ex: us-east-1

	public Integer Period; // min 60 seconds, intervals of 60 
	
	public ArrayList<String> MetricNames; 
	public ArrayList<String> Statistics; 
	
	// default
	public String Unit;
	public String NameSpace; 
	public String TimeStamp; // default ex: 2009-05-15
	
	public Date StartTime; // Collect data starting from 
	public Date EndTime; // Collect data ending at
	
	public String ConvetStartTime; // Default to current time - collect period
	public String ConvetEndTime; // Default to current time
	
	public int CollectPeriod; // Start time and End time difference
	
	public String toString()
	{
		String temp = "ModelId=" + ModelID + " type=" + Type + " InstanceId=" + InstanceId;
		return temp;
	}
}