package saaswatch.collector;

/**
 * 
 * @author Shone Liu
 *
 */
public class TaaSConstants {
	public static final String UTF_8 = "UTF-8";
	public static final String CONTENT_TYPE = "Content-Type";
	public static final String FORM_URLENCODED = "application/x-www-form-urlencoded";
	public static final String TEXT_HTML = "text/html";
	public static final String TEXT_JAVASCRIPT = "text/javscript";
	public static final String STATISTICS_SUM = "Sum";
	public static final String STATISTICS_AVG = "Average";
	public static final String CRAM_TITLE = "Compute Resource Allocation Meter";	
	public static final String CRAM_axisLabel[] = {"CPU(GHz)","Disk/Storage(Gb)","Memory(Gb)","Cache(mb)","Network BandWidth(Mbps)"};
	
	public static final String CRUM_TITLE = "Compute Resource Utilization Meter";	
	public static final String CRUM_axisLabel[] = {"CPU(%)","NetworkIn(mb)","NetworkOut(mb)","Volume Read(mb)","Volume write(mb)"};
	public static final String CRUM_metricNames[] = {"CPUUtilization","NetworkIn","NetworkOut","DiskReadBytes","DiskWriteBytes","VolumeWriteBytes"};
	
	public static final String SPM_TITLE = "System Performance Meter";	
	public static final String SPM_axisLabel[] = {"Throughtput","CRUM","Process Speed"};
	public static final String SPM_metricNames[] = {"CPUUtilization","NetworkIn","NetworkOut","DiskReadBytes","DiskWriteBytes","RequestCount","HealthyHostCount"};
	
	public static final String SLM_TITLE = "System Load Meter";	
	public static final String SLM_axisLabel[] = {"UAL(count)","CTL(count)","SDL(mb)"};
	public static final String SLM_metricNames[] = {"RequestCount","HealthyHostCount","DiskWriteOps","DiskReadOps"};
			
	public static final String SECM_TITLE = "System Effective Capacity Meter";	
	public static final String SECM_axisLabel[] = {"SLM","SPM","CRUM"};
	public static final String SECM_metricNames[] = {"CPUUtilization","NetworkIn","NetworkOut","DiskReadBytes","DiskWriteBytes","RequestCount","HealthyHostCount","DiskWriteOps","DiskReadOps"};
	
}
