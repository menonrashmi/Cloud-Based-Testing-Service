package saaswatch.collector;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import com.amazonaws.util.json.JSONException;
import com.amazonaws.util.json.JSONObject;

/**
 * 
 * @author Shone Liu
 *
 */
public class Misc {
	public static int getMaxVal(List<Integer> ls){
		//System.out.println("Inside Max Val:" + ls);
		int result = 0;
		if(ls != null && ls.size() > 0){
			if(ls.size() == 1){
				result = ls.get(0);				
			}else{	
				int a = 0;
				for(int i = 0 ; i < ls.size(); i++){
					if(a < ls.get(i)){
						a = ls.get(i);
					}
				}
				result = a;
			}
		}
		System.out.println("Inside Max Val:" + result);
		return result;
	}

	public static List<Integer> getAxisData(int maxValue,int maxNum){
		int maxAxis = Math.round((maxValue / 10) + 1)*10; 
		int pointVal = Math.round(maxAxis / maxNum );

		List<Integer> ls = new ArrayList<Integer>();
		for(int i = 0 ; i <= maxNum; i ++){
			ls.add(i*pointVal);
		}
		System.out.println("Axis Data:" + ls);
		return ls;
	}

	public static List<Integer> getCRUMDatas(List allDatapoints){
		List<Integer> result = new ArrayList<Integer>();
		if(allDatapoints != null && allDatapoints.size() == 6){
			List<BigDecimal> a = (ArrayList<BigDecimal>)allDatapoints.get(0);
			List<BigDecimal> b = (ArrayList<BigDecimal>)allDatapoints.get(1);
			List<BigDecimal> c = (ArrayList<BigDecimal>)allDatapoints.get(2);
			List<BigDecimal> d = (ArrayList<BigDecimal>)allDatapoints.get(3);
			List<BigDecimal> e = (ArrayList<BigDecimal>)allDatapoints.get(4);
			List<BigDecimal> f = (ArrayList<BigDecimal>)allDatapoints.get(4);
			System.out.println(a);
			int length = a.size() > 6 ? 6 : a.size();
			for(int i = 0 ; i < length ; i ++){	
				BigDecimal cpuPer = a.get(i).floatValue() > 0.00 ? a.get(i).multiply(new BigDecimal(10)) : a.get(i).multiply(new BigDecimal(100));
				BigDecimal nwbdPer = b.get(i).add(c.get(i)).divide(new BigDecimal(1024*1024),2,BigDecimal.ROUND_UP).multiply(new BigDecimal(100));
				BigDecimal discPer = d.get(i).add(e.get(i)).divide(new BigDecimal(30),2,BigDecimal.ROUND_UP).multiply(new BigDecimal(100));
				BigDecimal memPer = f.get(i).divide(new BigDecimal(1.66),2,BigDecimal.ROUND_UP).multiply(new BigDecimal(100));

				//System.out.println(cpuPer + "\t" + nwbdPer + "\t" + discPer +"\t" + memPer );
				int tmp = new BigDecimal(0.48).multiply(((cpuPer.multiply(nwbdPer).add((nwbdPer.multiply(discPer))).add(discPer.multiply(memPer)).add(memPer.multiply(cpuPer))))).intValue();
				tmp = trimDigits(tmp);
				result.add(tmp);
			}
		}
		//System.out.println("CRUM Data:" + result);
		return result;		
	}

	public static List<Integer> getSLMDatas(List allDatapoints){
		List<Integer> result = new ArrayList<Integer>();
		if(allDatapoints != null && allDatapoints.size() == 4){
			List<BigDecimal> a = (ArrayList<BigDecimal>)allDatapoints.get(0);
			List<BigDecimal> b = (ArrayList<BigDecimal>)allDatapoints.get(1);
			List<BigDecimal> c = (ArrayList<BigDecimal>)allDatapoints.get(2);
			List<BigDecimal> d = (ArrayList<BigDecimal>)allDatapoints.get(3);

			int length = a.size() > 4 ? 4 : a.size();
			for(int i = 0 ; i < length ; i ++){	
				BigDecimal aVal = a.get(i);
				BigDecimal bVal = b.get(i);
				bVal = aVal.add(bVal);
				BigDecimal cVal = c.get(i);
				BigDecimal dVal = d.get(i);
				cVal = cVal.add(dVal);

				int tmp = new BigDecimal(0.58).multiply((aVal.multiply(bVal).add((bVal.multiply(cVal))).add(cVal.multiply(aVal)))).multiply(new BigDecimal(82)).intValue();
				tmp = trimDigits(tmp);
				result.add(tmp);
			}
		}
		System.out.println("SLM Data:" + result);
		return result;	
	}

	public static List<Integer> getSCMDatas(List allDatapoints){

		List<Integer> result = new ArrayList<Integer>();
		if(allDatapoints != null && allDatapoints.size() == 9){
			List<BigDecimal> a = (ArrayList<BigDecimal>)allDatapoints.get(0);
			List<BigDecimal> b = (ArrayList<BigDecimal>)allDatapoints.get(1);
			List<BigDecimal> c = (ArrayList<BigDecimal>)allDatapoints.get(2);
			List<BigDecimal> d = (ArrayList<BigDecimal>)allDatapoints.get(3);
			List<BigDecimal> e = (ArrayList<BigDecimal>)allDatapoints.get(4);

			List<BigDecimal> f = (ArrayList<BigDecimal>)allDatapoints.get(5);
			List<BigDecimal> g = (ArrayList<BigDecimal>)allDatapoints.get(6);

			List<BigDecimal> aa = (ArrayList<BigDecimal>)allDatapoints.get(5);
			List<BigDecimal> bb = (ArrayList<BigDecimal>)allDatapoints.get(6);

			int length = a.size() > 4 ? 4 : a.size();
			for(int i = 0 ; i < length ; i ++){	
				BigDecimal cpuPer = a.get(i);//.floatValue() > 0.00 ? a.get(i).multiply(new BigDecimal(10)) : a.get(i).multiply(new BigDecimal(100));
				BigDecimal nwbdPer = b.get(i).add(c.get(i)).divide(new BigDecimal(1024*1024),2,BigDecimal.ROUND_UP);//.multiply(new BigDecimal(100));
				BigDecimal discPer = d.get(i).add(e.get(i)).divide(new BigDecimal(30),2,BigDecimal.ROUND_UP);//.multiply(new BigDecimal(100));
				BigDecimal memPer = f.get(i).divide(new BigDecimal(1.66),2,BigDecimal.ROUND_UP);//.multiply(new BigDecimal(100));

				System.out.println(cpuPer + "\t" + nwbdPer + "\t" + discPer +"\t" + memPer );
				BigDecimal crum = new BigDecimal(0.48).multiply(((cpuPer.multiply(nwbdPer).add((nwbdPer.multiply(discPer))).add(discPer.multiply(memPer)).add(memPer.multiply(cpuPer)))));

				BigDecimal aVal = a.get(i);
				BigDecimal bVal = b.get(i);
				bVal = aVal.add(bVal);
				BigDecimal cVal = c.get(i);
				BigDecimal dVal = d.get(i);
				cVal = cVal.add(dVal);

				BigDecimal r1 = new BigDecimal(0.58).multiply((aVal.multiply(bVal).add((bVal.multiply(cVal))).add(cVal.multiply(aVal))));//.multiply(new BigDecimal(82)).intValue();

				BigDecimal fVal = f.get(i);
				BigDecimal gVal = g.get(i);				
				BigDecimal r3 = new BigDecimal(0.48).multiply(fVal.multiply(crum).multiply(gVal));

				int tmp = new BigDecimal(0.58).multiply((r1.multiply(crum).add((crum.multiply(r3))).add(r3.multiply(r1)))).intValue();
				tmp = trimDigits(tmp);
				result.add(tmp);
			}
		}
		System.out.println("SCM Data:" + result);
		return result;	
	}

	public static List<Integer> getSECMDatas(List allDatapoints){

		List<Integer> result = new ArrayList<Integer>();
		if(allDatapoints != null && allDatapoints.size() == 9){
			List<BigDecimal> a = (ArrayList<BigDecimal>)allDatapoints.get(0);
			List<BigDecimal> b = (ArrayList<BigDecimal>)allDatapoints.get(1);
			List<BigDecimal> c = (ArrayList<BigDecimal>)allDatapoints.get(2);
			List<BigDecimal> d = (ArrayList<BigDecimal>)allDatapoints.get(3);
			List<BigDecimal> e = (ArrayList<BigDecimal>)allDatapoints.get(4);

			List<BigDecimal> f = (ArrayList<BigDecimal>)allDatapoints.get(5);
			List<BigDecimal> g = (ArrayList<BigDecimal>)allDatapoints.get(6);

			List<BigDecimal> aa = (ArrayList<BigDecimal>)allDatapoints.get(5);
			List<BigDecimal> bb = (ArrayList<BigDecimal>)allDatapoints.get(6);

			int length = a.size() > 4 ? 4 : a.size();
			for(int i = 0 ; i < length ; i ++){	
				BigDecimal cpuPer = a.get(i);//.floatValue() > 0.00 ? a.get(i).multiply(new BigDecimal(10)) : a.get(i).multiply(new BigDecimal(100));
				BigDecimal nwbdPer = b.get(i).add(c.get(i)).divide(new BigDecimal(1024*1024),2,BigDecimal.ROUND_UP);//.multiply(new BigDecimal(100));
				BigDecimal discPer = d.get(i).add(e.get(i)).divide(new BigDecimal(30),2,BigDecimal.ROUND_UP);//.multiply(new BigDecimal(100));
				BigDecimal memPer = f.get(i).divide(new BigDecimal(1.66),2,BigDecimal.ROUND_UP);//.multiply(new BigDecimal(100));

				System.out.println(cpuPer + "\t" + nwbdPer + "\t" + discPer +"\t" + memPer );
				BigDecimal crum = new BigDecimal(0.48).multiply(((cpuPer.multiply(nwbdPer).add((nwbdPer.multiply(discPer))).add(discPer.multiply(memPer)).add(memPer.multiply(cpuPer)))));

				BigDecimal aVal = a.get(i);
				BigDecimal bVal = b.get(i);
				bVal = aVal.add(bVal);
				BigDecimal cVal = c.get(i);
				BigDecimal dVal = d.get(i);
				cVal = cVal.add(dVal);

				BigDecimal r1 = new BigDecimal(0.58).multiply((aVal.multiply(bVal).add((bVal.multiply(cVal))).add(cVal.multiply(aVal))));//.multiply(new BigDecimal(82)).intValue();

				BigDecimal fVal = f.get(i);
				BigDecimal gVal = g.get(i);				
				BigDecimal r3 = new BigDecimal(0.48).multiply(fVal.multiply(crum).multiply(gVal));

				BigDecimal scm = new BigDecimal(0.58).multiply((r1.multiply(crum).add((crum.multiply(r3))).add(r3.multiply(r1))));

				BigDecimal spm = new BigDecimal(0.48).multiply(fVal.multiply(crum).multiply(gVal));
				int tmp = new BigDecimal(0.58).multiply((scm.multiply(spm).add((spm.multiply(crum))).add(crum.multiply(scm)))).intValue();


				tmp = trimDigits(tmp);
				result.add(tmp);
			}
		}
		System.out.println("SCM Data:" + result);
		return result;	
	}

	public static List<Integer> getSPMDatas(List allDatapoints){
		List<Integer> result = new ArrayList<Integer>();
		if(allDatapoints != null && allDatapoints.size() == 7){
			List<BigDecimal> a = (ArrayList<BigDecimal>)allDatapoints.get(0);
			List<BigDecimal> b = (ArrayList<BigDecimal>)allDatapoints.get(1);
			List<BigDecimal> c = (ArrayList<BigDecimal>)allDatapoints.get(2);
			List<BigDecimal> d = (ArrayList<BigDecimal>)allDatapoints.get(3);
			List<BigDecimal> e = (ArrayList<BigDecimal>)allDatapoints.get(4);

			List<BigDecimal> f = (ArrayList<BigDecimal>)allDatapoints.get(5);
			List<BigDecimal> g = (ArrayList<BigDecimal>)allDatapoints.get(6);

			int length = a.size() > 4 ? 4 : a.size();
			for(int i = 0 ; i < length ; i ++){	
				BigDecimal cpuPer = a.get(i).floatValue() > 0.00 ? a.get(i).multiply(new BigDecimal(5)) : a.get(i);

				BigDecimal nwbdPer = b.get(i).add(c.get(i)).divide(new BigDecimal(1024*1024),2,BigDecimal.ROUND_UP).multiply(new BigDecimal(100));
				BigDecimal discPer = d.get(i).add(e.get(i)).divide(new BigDecimal(30),2,BigDecimal.ROUND_UP).multiply(new BigDecimal(100));
				BigDecimal memPer = f.get(i).divide(new BigDecimal(1.66),2,BigDecimal.ROUND_UP).multiply(new BigDecimal(100));

				//System.out.println(cpuPer + "\t" + nwbdPer + "\t" + discPer +"\t" + memPer );
				BigDecimal crum = new BigDecimal(0.48).multiply(((cpuPer.multiply(nwbdPer).add((nwbdPer.multiply(discPer))).add(discPer.multiply(memPer)).add(memPer.multiply(cpuPer)))));


				BigDecimal fVal = f.get(i);

				BigDecimal gVal = g.get(i).add(new BigDecimal(20));
				fVal = fVal.divide(gVal,2,BigDecimal.ROUND_UP);
				System.out.println(fVal + "\t" + gVal);
				int tmp = new BigDecimal(0.48).multiply(fVal.multiply(crum).multiply(gVal)).intValue();
				tmp = tmp > 100 ? (tmp / 10 ) : tmp;
				result.add(tmp);
			}
		}
		System.out.println("SPM Data:" + result);
		return result;	
	}

	public static List<BigDecimal> getDatasByTimeStamp(List<HashMap<Date, BigDecimal>> datas,Vector daterange){
		List result = new ArrayList();
		List<BigDecimal> resources = null;
		HashMap<Date, BigDecimal> datapoints = null;
		if(datas != null & datas.size() > 0){
			Iterator<HashMap<Date, BigDecimal>> datasIter = datas.iterator();
			while(datasIter.hasNext()){
				resources = new ArrayList<BigDecimal>();
				datapoints = datasIter.next();
				if(daterange != null){
					Iterator datesIter = daterange.iterator();
					while(datesIter.hasNext()){
						Date dd = (Date)datesIter.next();
						//System.out.println(dd);
						resources.add(datapoints.get(dd) == null ? new BigDecimal("0.00") : datapoints.get(dd) );
					}
				}
				result.add((resources == null && resources.size() == 0) ? new BigDecimal("0.00") : resources);
			}
		}


		System.out.println("getDatasByTimeStamp :" + result);
		return result;
	}

	public static int trimDigits(int no){
		System.out.println("Inside trimDigit:" + no);
		int res = 0;
		BigDecimal bgint = new BigDecimal(no);
		String nostr = String.valueOf(no);
		int divident = nostr.length() - 2;
		res = bgint.divide(new BigDecimal(Math.pow(10D,divident )),2,BigDecimal.ROUND_UP).intValue();
		System.out.println("Before return trimDigit:" + res);
		return res;
	}

	public static JSONObject getJSONData(List allDatapoints, String statistics, String[] AvaliableMetrics){
		JSONObject responseJSON = new JSONObject();
		for(int valueCount = 0; valueCount < allDatapoints.size();valueCount++ ){
			List<BigDecimal> valueList = (ArrayList<BigDecimal>)allDatapoints.get(valueCount);
			String recordName = AvaliableMetrics[valueCount] + "-" + statistics;
			String[] valueArray = null;
			for (int valueCnt = 0 ; valueCnt < valueList.size(); valueCnt++){
				
			}
			try {
				responseJSON.put(recordName, valueList);
				System.out.println("JSON" + responseJSON.toString());
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return responseJSON;		
	}
}
