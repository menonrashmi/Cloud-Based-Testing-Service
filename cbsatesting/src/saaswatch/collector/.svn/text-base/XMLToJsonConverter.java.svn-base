package saaswatch.collector;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;


import org.w3c.dom.CharacterData;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.amazonaws.util.json.JSONException;
import com.amazonaws.util.json.JSONObject;


import java.io.IOException;
import java.io.StringReader;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.Vector;

public class XMLToJsonConverter {


	public static ArrayList<HashMap<String, String>> getDataPoints(String reponseStr){
		//	System.out.println("response Str : " + reponseStr);

		ArrayList<HashMap<String, String>> datapointVal = new ArrayList<HashMap<String,String>>();
		HashMap<String, String> stats = null;
		try {
			DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			InputSource is = new InputSource();
			is.setCharacterStream(new StringReader(reponseStr));

			Document doc = db.parse(is);

			NodeList nodes = doc.getElementsByTagName("member");
			//   System.out.println("hasChildNodes:"+doc.hasChildNodes() + "\n Node length:" + nodes.getLength());

			for (int i = 0; i < nodes.getLength(); i++) {
				stats = new HashMap<String, String>();
				Element element = (Element) nodes.item(i);

				NodeList name = element.getElementsByTagName("Timestamp");
				Element line = (Element) name.item(0);

				NodeList avgNode = element.getElementsByTagName("Average");
				Element avgEle = (Element) avgNode.item(0);

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
				Date date = sdf.parse(getCharacterDataFromElement(line));

				stats.put("Timestamp", date.toString());
				stats.put("Average", getCharacterDataFromElement(avgEle));

				datapointVal.add(stats);
				System.out.println("row "+i+" :"+stats);
			}


		} catch (ParserConfigurationException e) {
			System.out.println("ParseConfiguration Exception :" + e.getMessage());
		} catch (SAXException e) {
			System.out.println("SAXException :" + e.getMessage());
		} catch (IOException e) {
			System.out.println("IO Exception :" + e.getMessage());
		} catch (ParseException e) {
			System.out.println("Parse Exception :" + e.getMessage());
		}
		return datapointVal;
	}

	public static String getCharacterDataFromElement(Element e) {
		Node child = e.getFirstChild();
		if (child instanceof CharacterData) {
			CharacterData cd = (CharacterData) child;
			return cd.getData();
		}
		return "";
	}

	public static ArrayList<BigDecimal> getAverageData(String reponseStr){
		//System.out.println("response Str : " + reponseStr);

		int count = 0;
		ArrayList<BigDecimal> avgLS = new ArrayList<BigDecimal>();
		try {
			DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			InputSource is = new InputSource();
			is.setCharacterStream(new StringReader(reponseStr));

			Document doc = db.parse(is);

			NodeList nodes = doc.getElementsByTagName("member");
			count = nodes.getLength();
			for (int i = 0; i < count; i++) {

				Element element = (Element) nodes.item(i);

				NodeList avgNode = element.getElementsByTagName("Average");
				Element avgEle = (Element) avgNode.item(0);		    	


				avgLS.add(new BigDecimal(getCharacterDataFromElement(avgEle)).setScale(2, BigDecimal.ROUND_UP));			    

			}	


		} catch (ParserConfigurationException e) {
			System.out.println("ParseConfiguration Exception :" + e.getMessage());
		} catch (SAXException e) {
			System.out.println("SAXException :" + e.getMessage());
		} catch (IOException e) {
			System.out.println("IO Exception :" + e.getMessage());
		} catch (NumberFormatException nfe){
			System.out.println("Number format exception :" + nfe.getMessage());
		}
		return avgLS;
	}

	public static Object getStatsData(String reponseStr,String stats){
		//System.out.println("response Str : " + reponseStr);
		Object obj = new Object();
		int count = 0;
		ArrayList<BigDecimal> avgLS = new ArrayList<BigDecimal>();
		try {
			DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			InputSource is = new InputSource();
			is.setCharacterStream(new StringReader(reponseStr));

			Document doc = db.parse(is);

			NodeList nodes = doc.getElementsByTagName("member");
			count = nodes.getLength();
			for (int i = 0; i < count; i++) {

				Element element = (Element) nodes.item(i);

				NodeList avgNode = element.getElementsByTagName(stats);
				Element avgEle = (Element) avgNode.item(0);		    	


				avgLS.add(new BigDecimal(getCharacterDataFromElement(avgEle)).setScale(2, BigDecimal.ROUND_UP));			    
				
			}
			if(avgLS.size() > 0){
			obj = Collections.max(avgLS);
			}
			else {
				obj = 0;
			}

		} catch (ParserConfigurationException e) {
			System.out.println("ParseConfiguration Exception :" + e.getMessage());
		} catch (SAXException e) {
			System.out.println("SAXException :" + e.getMessage());
		} catch (IOException e) {
			System.out.println("IO Exception :" + e.getMessage());
		} catch (NumberFormatException nfe){
			System.out.println("Number format exception :" + nfe.getMessage());
		}
		System.out.println(stats + " value is " + obj);
		return obj;
	}

	public static JSONObject getStatsJSON(JSONObject obj,String reponseStr,String stats, String  AvaliableMetric){
		int count = 0;
		String responseName = AvaliableMetric + "-" + stats;
		ArrayList<BigDecimal> avgLS = new ArrayList<BigDecimal>();
		try {
			DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			InputSource is = new InputSource();
			is.setCharacterStream(new StringReader(reponseStr));

			Document doc = db.parse(is);

			NodeList nodes = doc.getElementsByTagName("member");
			count = nodes.getLength();
			for (int i = 0; i < count; i++) {

				Element element = (Element) nodes.item(i);

				NodeList avgNode = element.getElementsByTagName(stats);
				Element avgEle = (Element) avgNode.item(0);		    	


				avgLS.add(new BigDecimal(getCharacterDataFromElement(avgEle)).setScale(2, BigDecimal.ROUND_UP));			    
				
			}
			if(avgLS.size() > 0){
				try {
					obj.put(responseName,Collections.max(avgLS).toString());
					//System.out.println(AvaliableMetric + " " + stats + " value is " + obj.get(responseName));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			else {
				try {
					obj.put(responseName,"0");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}

		} catch (ParserConfigurationException e) {
			System.out.println("ParseConfiguration Exception :" + e.getMessage());
		} catch (SAXException e) {
			System.out.println("SAXException :" + e.getMessage());
		} catch (IOException e) {
			System.out.println("IO Exception :" + e.getMessage());
		} catch (NumberFormatException nfe){
			System.out.println("Number format exception :" + nfe.getMessage());
		}
		return obj;
	}

	public static HashMap<Date, BigDecimal> getDatapoints(String reponseStr,String statName){

		int count = 0;
		//System.out.println(reponseStr);
		HashMap<Date, BigDecimal> ts = new HashMap<Date, BigDecimal>();

		try {
			DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			InputSource is = new InputSource();
			is.setCharacterStream(new StringReader(reponseStr));

			Document doc = db.parse(is);

			NodeList nodes = doc.getElementsByTagName("member");
			count = nodes.getLength();
			for (int i = 0; i < count; i++) {

				Element element = (Element) nodes.item(i);

				NodeList avgNode = element.getElementsByTagName(statName);
				Element avgEle = (Element) avgNode.item(0);		    	

				NodeList name = element.getElementsByTagName("Timestamp");
				Element line = (Element) name.item(0);

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
				Date date = sdf.parse(getCharacterDataFromElement(line));

				ts.put(date, new BigDecimal(getCharacterDataFromElement(avgEle)).setScale(2, BigDecimal.ROUND_UP));

			}	


		} catch (ParserConfigurationException e) {
			System.out.println("ParseConfiguration Exception :" + e.getMessage());
		} catch (SAXException e) {
			System.out.println("SAXException :" + e.getMessage());
		} catch (IOException e) {
			System.out.println("IO Exception :" + e.getMessage());
		} catch (NumberFormatException nfe){
			System.out.println("Number format exception :" + nfe.getMessage());
		}catch (ParseException e) {
			System.out.println("Parse exception :" + e.getMessage());		
		}
		return ts;
	}

	public static ArrayList<HashMap<String, Vector>> groupTimeStamp(String responseStr){		
		int count = 0;
		ArrayList resultTS = new ArrayList<HashMap>();
		HashMap<String, Vector> ts = new HashMap<String, Vector>();
		try {
			DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			InputSource is = new InputSource();
			is.setCharacterStream(new StringReader(responseStr));

			Document doc = db.parse(is);

			NodeList nodes = doc.getElementsByTagName("member");
			count = nodes.getLength();
			for (int i = 0; i < count; i++) {

				Element element = (Element) nodes.item(i);

				NodeList name = element.getElementsByTagName("Timestamp");
				Element line = (Element) name.item(0);

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
				Date date = sdf.parse(getCharacterDataFromElement(line));
				String dd = String.valueOf(date.getDate());

				if(ts.containsKey(dd)){
					Vector tmp = ts.get(dd);
					tmp.add(date);
					ts.put(dd, tmp);
				}else{
					Vector tmp = new Vector<Date>();
					tmp.add(date);
					ts.put(dd, tmp);
				}

			}	
			Set keys = ts.keySet();

			Iterator keyIter = keys.iterator();
			HashMap<String, Vector> hrmap = null;

			while(keyIter.hasNext()){			    	
				Vector al = ts.get(keyIter.next());

				if(al != null){
					Iterator<Date> iter = al.iterator();
					hrmap = new HashMap<String, Vector>();
					while(iter.hasNext()){

						Date d = iter.next();
						String hr = String.valueOf(d.getHours());

						if(hrmap.containsKey(hr)){
							Vector tmp = hrmap.get(hr) == null ? new Vector<Date>() : hrmap.get(hr);
							tmp.add(d);
							hrmap.put(hr, tmp);
						}else{
							Vector tmp = new Vector<Date>();
							tmp.add(d);
							hrmap.put(hr, tmp);
						}
					}
				}
				resultTS.add(hrmap);
			}

			System.out.println("resultTS	:" + resultTS);

		} catch (ParserConfigurationException e) {
			System.out.println("ParseConfiguration Exception :" + e.getMessage());
		} catch (SAXException e) {
			System.out.println("SAXException :" + e.getMessage());
		} catch (IOException e) {
			System.out.println("IO Exception :" + e.getMessage());
		} catch (NumberFormatException nfe){
			System.out.println("Number format exception :" + nfe.getMessage());
		} catch (ParseException e) {
			System.out.println("Parse exception :" + e.getMessage());

		}
		return resultTS;
	}

	public static List<String> getTimeStampData(String responseStr){
		List<String> timestampdata = new ArrayList<String>();
		try {
			DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			InputSource is = new InputSource();
			is.setCharacterStream(new StringReader(responseStr));

			Document doc = db.parse(is);

			NodeList nodes = doc.getElementsByTagName("member");
			for (int i = 0; i < nodes.getLength(); i++) {

				Element element = (Element) nodes.item(i);

				NodeList name = element.getElementsByTagName("Timestamp");
				Element line = (Element) name.item(0);


				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
				Date date = sdf.parse(getCharacterDataFromElement(line));			      

				timestampdata.add(date.toString());

			}			   

		} catch (ParserConfigurationException e) {
			System.out.println("ParseConfiguration Exception :" + e.getMessage());
		} catch (SAXException e) {
			System.out.println("SAXException :" + e.getMessage());
		} catch (IOException e) {
			System.out.println("IO Exception :" + e.getMessage());
		} catch (ParseException e) {
			System.out.println("Parse Exception :" + e.getMessage());
		}

		return timestampdata;
	}

}

