package cs.address;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLConnection;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;





















import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.impl.NoOpResponseParser;
import org.apache.solr.client.solrj.request.QueryRequest;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.client.solrj.util.ClientUtils;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.util.NamedList;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import alain.core.db.Sage;
import alain.core.utils.Cartographer;
import alain.core.utils.Config;
import alain.core.utils.FileUtil;
import alain.core.utils.Logger;
import alain.core.utils.MapSet;
import alain.core.utils.Numeral;
import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;
//import alain.core.utils.Timekeeper;
import cs.common.ApiHandler;
import csshared.utils.CsConfig;

public class AddressTest {

	public static void main1(String[] args) {
		// TODO Auto-generated method stub
		//for(int i=0;i<10000;i++){
		JSONObject a= new JSONObject();
		try {
			/*a.put("q", "801 Rodeo");
			a.put("start", 0);
			a.put("end", 10);
			a.put("token", "1243dsf214124123123dscds");*/
			String url = CsConfig.getString("dropdownlist.streetlist");
			String s = ApiHandler.getResponsePost(url, a.toString());
			System.out.println("input post"+a.toString());
			System.out.println("output json::"+s);
			
			 
		/*	ActivityVO v = new ActivityVO();
			
			v.setCONTACT("Sunil");
			v.setDEPATMENT("BS");
			System.out.println(v.getCONTACT());
			System.out.println(v.getDEPATMENT());*/
			
			 /*Map<net.sourceforge.jgeocoder.AddressComponent, String> parsedAddr  = AddressParser.parseAddress("Google Inc, 1600 Amphitheatre Parkway, Mountain View, CA 94043");
			    System.out.println(parsedAddr);
			    
			    Map<net.sourceforge.jgeocoder.AddressComponent, String> normalizedAddr  = AddressStandardizer.normalizeParsedAddress(parsedAddr); 
			    System.out.println(normalizedAddr);*/
			
		/*	String s = "801  rodeo drive";
			int k = s.indexOf(" N ");
			System.out.println(k);*/
			
			String abc = "12.77";
			System.out.println(Operator.toString(abc));
			System.out.println(Operator.isNumber(abc));
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//}
		
	}
	
	
	public static String checkQ(String q) {
		// TODO Auto-generated method stub
		//for(int i=0;i<10000;i++){
		JSONObject a= new JSONObject();
		String s = "";
		try {
			a.put("q", q);
			a.put("start", 0);
			a.put("end", 500);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/lso/search";
			s = ApiHandler.getResponsePost(url, a.toString());
			System.out.println("input post"+a.toString());
			System.out.println("output json::"+s);
			
			
			
			
		
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
return s;
		
	}
	
	public static void doUrl(Cartographer map) {
		// TODO Auto-generated method stub
		//for(int i=0;i<10000;i++){
		JSONObject a= new JSONObject();
		try {
			a.put("q", "Rodeo");
			a.put("start", 0);
			a.put("end", 10);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/lso/search";
			String s = ApiHandler.getResponsePost(url, a.toString());
			System.out.println("input post"+a.toString());
			System.out.println("output json::"+s);
		
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//}
		
	}

	
	
	public static String test() {
		// TODO Auto-generated method stub
		//for(int i=0;i<10000;i++){
		String s ="";
		JSONObject a= new JSONObject();
		try {
			a.put("q", "801 Rodeo");
			a.put("start", 0);
			a.put("end", 10);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/lso/search";
			s = ApiHandler.getResponsePost(url, a.toString());
			System.out.println("input post"+a.toString());
			System.out.println("output json::"+s);
		
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return s;
		//}
		
	}
	
	
	public static String childrens(String type,int id) {
		JSONObject a= new JSONObject();
		String s = "";
		try {
			a.put("type", type);
			a.put("id", id);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/lso/childrens";
			s = ApiHandler.getResponsePost(url, a.toString());
			System.out.println("input post"+a.toString());
			System.out.println("output json::"+s);
		
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return s;
		
	}
	
	
	public static JSONObject searchQ(String q) {
		// TODO Auto-generated method stub
		//for(int i=0;i<10000;i++){
		JSONObject a= new JSONObject();
		String s = "";
		try {
			a.put("q", q);
			a.put("start", 0);
			a.put("end", 50);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/lso/searchAll";
			s = ApiHandler.getResponsePost(url, a.toString());
			System.out.println("input post"+a.toString());
			System.out.println("output json::"+s);
			a= new JSONObject(s);
			
			
			
		
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
return a;
		
	}
	
	public static void main7(String[] args) {
		int total = 8;
		int max = 8;
		
		int pct = Numeral.percent(1710, total);
		int bar = Numeral.percent(1710, max);
		
		System.out.println(pct+":::"+bar);
		
		
	}
	
		
		public static void main6(String[] args) {
		// TODO Auto-generated method stub
		//for(int i=0;i<10000;i++){
		JSONObject a= new JSONObject();
		try {
			/*a.put("q", "801 Rodeo");
			a.put("start", 0);
			a.put("end", 10);
			a.put("TOKEN", "1243dsf214124123123dscds");*/
			ArrayList<NameValuePair> params = new ArrayList<NameValuePair>();
			  params.add(new BasicNameValuePair("TOKEN","SVxIkYXSODIqKQRSGv"));
			  params.add(new BasicNameValuePair("USERNAME","csims@beverlyhills.org"));
			  params.add(new BasicNameValuePair("CUSTNO","201941"));
			String url = "https://www.beverlyhills.org/ws/api/rest/water/addCustomer/json";
			String s = ApiHandler.getResponsePost(url, params);
			System.out.println("input post"+params.toString());
			System.out.println("output json::"+s);
			
			/*try{
				Timekeeper k = new Timekeeper();
				output = new BufferedWriter(new FileWriter(LOG_FILE, true));
				output.newLine();
				String token = 	formParams.getFirst("TOKEN");
				if(AuthorizeUser.validateToken(token)){	
					if(AuthorizeUser.validateTokenRole(token, API_ROLE)){
						if(Operator.hasValue(formParams.getFirst("USERNAME")) && Operator.hasValue(formParams.getFirst("CUSTNO"))){
							String username = formParams.getFirst("USERNAME");
							String custNo = formParams.getFirst("CUSTNO");
							custNo = Operator.toString(Operator.toInt(custNo));
							output.write(k.sqlTimestamp()+" custNO Only_ "+custNo+" username_ "+username);
							Logger.info(account+"--"+address+"--"+username);
							Logger.info(isValidAccount(account, address)+"--");
							
							
						}else {
							sb.append(getMessage("All fields are required in order to process the request ",json));
							output.write(sb.toString());
						}
						
					}else {
						sb.append(getMessage("Access Denied",json));
						output.write(sb.toString());
					}
				}else {
					sb.append(getMessage("Invalid Token",json));
					output.write(sb.toString());
				}
				output.close();
			}catch(Exception e){
				e.printStackTrace();
				Logger.error(e.getMessage());
				sb.append(getMessage(e.getMessage(),json));
			}*/
		
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//}
		
	}
	
	public static void main2(String[] args) {
		// TODO Auto-generated method stub
		//for(int i=0;i<10000;i++){
		JSONObject a= new JSONObject();
		try {
			
			String str = null;
			System.out.println("###$"+Operator.sqlEscape(str)+"####");
			
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//}
		
	}
	
	
	public static void main5(String[] args) {
		// TODO Auto-generated method stub
		//for(int i=0;i<10000;i++){
		
		try {
			LocalDate st = LocalDate.now();
			st = st.plus(18,ChronoUnit.DAYS);
		/*	st.addHour(1);
			st.setSecond(45);*/
			System.out.println("###$"+st+"####");
			System.out.println("###$"+st.getEra()+"####");
			
			ZoneId id = ZoneId.systemDefault();
		      System.out.println("ZoneId: " + id);
		      
		     //MathOperation addition = (int a, int b) -> a + b;
			/*Timekeeper  k = new Timekeeper();
			k.setDate(st);
			//System.out.println("###$"+k.DATECODE()+"####");
			
			k.setDayOfWeek(1);
			
			System.out.println("###$"+k.DATECODE()+"####"+k.getString("MM/DD/YYYY @ HH:MM:SS"));
			for(int i=0;i<25;i++){
				System.out.println(i+"###$"+i%7+"####");
			}
			LocalDate date1 = currentTime.toLocalDate();*/
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//}
		
	}
	
	
	
	public static JSONObject globalSearch(String q) {
		// TODO Auto-generated method stub
		//for(int i=0;i<10000;i++){
		JSONObject a= new JSONObject();
		String s = "";
		try {
			a.put("q", q);
			a.put("start", 0);
			a.put("end", 50);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/general/globalSearch";
			s = ApiHandler.getResponsePost(url, a.toString());
			System.out.println("input post"+a.toString());
			System.out.println("output json::"+s);
			a= new JSONObject(s);
			
			
			
		
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
return a;
		
	}
	
	
	public static String globalSearch(String url,String q,int start,int rows,String jsonfacet, String fq) throws Exception {
		String r = "";
		
		try{
			//SystemDefaultHttpClient httpClient = new SystemDefaultHttpClient();
			//HttpSolrClient solr = new HttpSolrClient(solrurl, httpClient);
			
			SolrClient solr = new HttpSolrClient.Builder(url).build();
			Logger.info(solr.ping()+"");
			//server.setParser(new JSONParser());
			SolrQuery query = new SolrQuery();
			query.setQuery(q);
			query.setStart(start);
			query.setRows(rows);
		
			query.setParam("defType", "edismax");
			query.setParam("mm", "100");
			
			query.setParam("wt", "json");
			query.setParam("indent", "true");
			
			query.setParam("json.facet", jsonfacet);
			//query.setFilterQueries(fq);
			
			query.setParam("fq", fq);
			Logger.info(fq);
		   
			QueryRequest req = new QueryRequest(query);
			//req.
			QueryResponse response = solr.query(query);
			Logger.info("***********"+response);
			NoOpResponseParser rawJsonResponseParser = new NoOpResponseParser();
			rawJsonResponseParser.setWriterType("json");
			req.setResponseParser(rawJsonResponseParser);

			NamedList<Object> resp = solr.request(req);
			Logger.info(""+query.getParameterNames());
			String jsonResponse = (String) resp.get("response");

			//System.out.println(jsonResponse );
			
			r = jsonResponse;
			
			
			}catch(Exception e){
				e.printStackTrace();
				System.err.println("content error = " + e.getMessage());
	
			}
		 
		
		
		return r;
	}
	
	public static String replaceLast(String text, String regex, String replacement) {
        return text.replaceFirst("(?s)"+regex+"(?!.*?"+regex+")", replacement);
    }

	
	public static ArrayList<String> solrescapeFilter(String fq, String filter){
		ArrayList<String> a = new ArrayList<String>();
		try{
			String t = filter;
			String type[] = Operator.split(t,",");
			StringBuilder sb = new StringBuilder();
			Matcher m = Pattern.compile("\\[(.*?)\\]").matcher(fq);
			int i =0; 
			while(m.find()) {
			    sb = new StringBuilder();
			    String g = m.group(1);
			    String s = Operator.replace(g," ","%5C%20");
			    Logger.info("s=="+s);
			    
				s = Operator.replace(s, "(", "%5C%28");
				Logger.info("s=="+s);
				s = Operator.replace(s, ")", "%5C%29");
				Logger.info("s=="+s);
				s = Operator.replace(s, "," ,"%20");
				Logger.info("s=="+s);
			    
			    sb.append("%7B!tag=").append(type[i]).append("%7D").append(type[i]).append(":(").append(s).append(")");
			    Logger.info(sb.toString());
			    a.add(sb.toString());
			    i = i+1;
			}
		}catch(Exception e){
			Logger.error(e.getMessage());
		}
		return a;
	}
	
	
	public static void main3(String args[]){
		String t = "type,status";
		ArrayList<String> a = new ArrayList<String>();
		String type[] = Operator.split(t,",");
		String fq = "[Public Right-of-Way Use (BS)],[Pending],";
		StringBuilder sb = new StringBuilder();
		Matcher m = Pattern.compile("\\[(.*?)\\]").matcher(fq);
		for(String j: type){
			System.out.println(j);
		}
		int i =0;
		while(m.find()) {
		    System.out.println(m.group(1));
		    sb = new StringBuilder();
		    String g = m.group(1);
		    String s = Operator.replace(g," ","\\%20");
			s = Operator.replace(s, "(", "\\%28");
			s = Operator.replace(s, ")", "\\%29");
		    s = Operator.replace(s, "," ," ");
		    
		    sb.append("{!tag = ").append(type[i]).append("}").append(type[i]).append(":(").append(s).append(")");
		    a.add(sb.toString());
		    i = i+1;
		}
		
		for(String c: a){
			System.out.println(c);
		}
		
	}
	
	
	public static void main12(String args[]){
		// TODO Auto-generated method stub
				//for(int i=0;i<10000;i++){
				JSONObject a= new JSONObject();
				JSONArray ga = new JSONArray();
				String s = "";
				try {
					
					JSONObject g= new JSONObject();
					
					g.put("Name", "PERMIT NUMBER");
					g.put("Value", "C9300398");
					ga.put(g);
					
					a.put("Indexes", ga);
					
					
					JSONObject f= new JSONObject();
					f.put("QueryOperator", 0);
					f.put("SearchType", 0);
					f.put("Thesaurus", true);
					f.put("Value", "");
					
					a.put("fullText", f);
					
					a.put("IsIncludingPreviousRevisions", false);
				/*	a.put("Name", "MyNewQuerySunil");
					a.put("IsPublic", true);
					a.put("IsIncludingPreviousRevisions", true);*/
					
					/*a.put("FTQueryOperator", 0);
					a.put("FTQueryExpression", 0);
					a.put("FTQueryValue", "C93004000");
					a.put("FTQueryOptions", ga);
					
					
					JSONObject g= new JSONObject();
					
					g.put("Name", "PERMIT NUMBER");
					g.put("Value", "C9300398");
					ga.put(g);
					
					//a.put("Indexes", ga);
					JSONObject f= new JSONObject();
					f.put("QueryOperator", 0);
					f.put("SearchType", 0);
					f.put("Thesaurus", true);
					f.put("Value", "C9300398");
					
					a.put("fullText", f);
					a.put("IsIncludingPreviousRevisions", true);*/
					/*a.put("Name", "C9300398");
					a.put("IsPublic", true);
					a.put("IsIncludingPreviousRevisions", true);*/
					
					//String url = "https://ax_public:IseeD0cument$@edocs.beverlyhills.org/api/axdatasources/AX_COBH_CITY/axfulltextquery/30";  
					//String url = "https://ax_public:IseeD0cument$@172.17.41.24/api/axdatasources/AX_COBH_CITY/axfulltextquery/30";  
				
					
					//String url = "http://docweb3/AppXtenderReST/api/axdatasources/AX_COBH_CITY/axqueryfields/";
					String url = "http://edocs.beverlyhills.org/AppXtenderReST/api/AXDataSources/AX-COBH_City/axadhocqueryresults/94";
					
					//String url = "http://docweb3/AppXtenderReST/api/AXDataSources/AX-COBH_City/axfulltextquery/suni12";
					/*a.put("FTQueryOperator", 0);
					a.put("FTQueryExpression", 0);
					a.put("FTQueryValue", "C9300400");
					a.put("FTQueryOptions", ga);*/
					//String url = "http://docweb3/AppXtenderReST/api/AXDataSources/AX-COBH_City/axfulltextquery/suni13";
					

					
					ArrayList<NameValuePair> params = new ArrayList<NameValuePair>();
					s = getResponsePost(url, a.toString());
					//s = getResponseGet(url, params, "");
					System.out.println("input post"+a.toString());
					System.out.println("output json::"+s);
					//a= new JSONObject(s);
					
					
					
				
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	
		
	}
	
	 public static String getResponseGet(String url,ArrayList<NameValuePair> params,String json)  {
		  StringBuilder out = new StringBuilder();
		  try {
			  //TODO Base64.encode(ax_public:IseeD0cument$)axdeveloper:D3v3loper
		//	String encoding = "YXhfcHVibGljOklzZWVEMGN1bWVudCQ="; //ax_public:IseeD0cument$
			  String encoding = "YXhkZXZlbG9wZXI6RDN2M2xvcGVy"; // axdeveloper:D3v3loper
		  HttpClient httpclient = new DefaultHttpClient();
		  HttpGet httpget = new HttpGet();
		  
		  httpget.addHeader("content-type", "application/vnd.emc.ax+json");
		 // httpget.addHeader("content-type", "application/json+home");
		  httpget.setHeader("Authorization", "Basic " + encoding);
		 
		  StringEntity content =new StringEntity(json);
		  //httpget.setEntity(content);
		  //httpget.setParams(json);
		  
		  StringBuilder sb = new StringBuilder();
		  sb.append(url);
	      if(params.size()>0){
	    	  sb.append("?");
	      }
	      for(int i=0;i<params.size();i++){
	    	  sb.append(params.get(i));
	    	  sb.append("&");
	      }
	      
	      Logger.info(sb.toString());
	      URI website = new URI(sb.toString());
	      httpget.setURI(website);
			  HttpResponse response = httpclient.execute(httpget);
			  HttpEntity entity = response.getEntity();
	
			  if (entity != null) {
				  	InputStream instream = entity.getContent();
			          	BufferedReader reader = new BufferedReader(new InputStreamReader(instream));
			    	    String newLine = System.getProperty("line.separator");
			    	    String line;
			    	    while ((line = reader.readLine()) != null) {
			    	        out.append(line);
			    	        out.append(newLine);
			    	    }
			    	instream.close();    
			      }
			      
			  }
			  catch(Exception ex){
				  ex.printStackTrace();
		    	  out.append("Error while getting response "+ex.getMessage());  
		      } 
			  return out.toString();
		  }
	
	
	 public static String getResponsePost(String url,String json)  {
		  StringBuilder out = new StringBuilder();
		  try {
			  
			  
	
		  String encoding = "YXhkZXZlbG9wZXI6RDN2M2xvcGVy"; // axdeveloper:D3v3loper
		  HttpClient httpclient = new DefaultHttpClient();
		  HttpPost httppost = new HttpPost(url);
		  
		  httppost.addHeader("content-type", "application/vnd.emc.ax+json");
			 // httpget.addHeader("content-type", "application/json+home");
		  httppost.setHeader("Authorization", "Basic " + encoding);
		  //post json
		  StringEntity content =new StringEntity(json);
		 // httppost.addHeader("content-type", "application/json");
		  httppost.setEntity(content);
		  Logger.info("+++"+url);
		  Logger.info("+++"+json);
		  
		 /* Cartographer map = new Cartographer(request,response);connRequest
		  */
		 // httppost.setConnectionRequest(map.REQUEST);
		  
		  
		  HttpResponse response = httpclient.execute(httppost);
		  HttpEntity entity = response.getEntity();

		  if (entity != null) {
		      InputStream instream = entity.getContent();
		    
		          	BufferedReader reader = new BufferedReader(new InputStreamReader(instream));
		    	    String newLine = System.getProperty("line.separator");
		    	    String line;
		    	   // Logger.info("--"+reader.readLine()+"");
		    	    out.append(reader.readLine());
		    	    Logger.info("--"+out.toString());
		    	    /*while ((line = reader.readLine()) != null) {
		    	        out.append(line);
		    	        out.append(newLine);
		    	    }*/
		    	instream.close();    
		      }
		     
		  }
		  catch(Exception ex){
			  ex.printStackTrace();
	    	  out.append("Error while getting response "+ex.getMessage());  
	      } 
		  return out.toString();
	  }
	 
	 
		public static void main20(String args[]){
			 Logger.info(runCashier("")+"dd");
			// Logger.info(getUrlContent("")+"dd");
		}
	 
		public static boolean runCashier(String ip) {
			boolean result = false;
		    
		      
		      try {
		    	 
	    		    URL myURL = new URL("http://localhost:8080/cs/index.jsp");
	    		    HttpURLConnection http = (HttpURLConnection)myURL.openConnection();
	    		   
	    		    http.setRequestProperty("User-Agent", "Mozilla/5.0");
	    		    int statusCode = http.getResponseCode();
	    		    if(statusCode==200){
	    			  result = true;
	    		    }
	    		    if(!result){
	    		    	String u = "http://"+ip+":8080/cs/index.jsp";
	    		    	 myURL = new URL(u);
	    	    		 http = (HttpURLConnection)myURL.openConnection();
	    	    		 statusCode = http.getResponseCode();
	    	    		 if(statusCode==200){
	    	    			 result = true;
	    	    		 }
	    		    }
	    		    Logger.info("Logging cash drawer"+myURL.getHost()+myURL.getPort()+myURL.getPath()+"--"+statusCode+"--"+result);
	    		 
		        //  System.out.println(sb.toString());
		                    
		      }  catch (Exception e) {
		    	  Logger.error(e.getMessage());
		      }
		      return result;
		  }
	 
	 public static boolean getUrlContent(String ip){
	    	StringBuilder sb = new StringBuilder();
	    	boolean result = false;
	    	try {
	    		
	    		
				java.net.URL u = new java.net.URL("http://localhost:8080/cs/index.jsp");
				URLConnection conn = u.openConnection();
	 			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				String inputLine;
				while ((inputLine = br.readLine()) != null) {
					sb.append(inputLine);
				}
	 			br.close();
	 		//	int statusCode = http.getResponseCode();
    		    Logger.info(sb.toString());
	    		   
    		    
	    		  //  int code = myURLConnection.get
		    	  
	    		 // if(statusCode==200){
	    			  result = true;
	    		//  }
	 			
			}catch(Exception e){
				Logger.error(e);
			
			}
			return result;
	    }
	 
	 
	 public static ArrayList<MapSet> getColumns(String query){
			ArrayList<MapSet> a = new ArrayList<MapSet>();
			if(Operator.hasValue(query)){
				Sage db = new Sage();
				db.query(query);
				String[] cols = db.COLUMNS;
				while(db.next()){
					
					MapSet h = new MapSet();
					for (int i=0; i<cols.length; i++) {
						String c = cols[i];
						h.add(c, db.getString(c));
					}
					
					a.add(h);
				}
				
				db.clear();
			
			}
			return a;
				
		}	
	 
	 public static String getCustomFields(int groupid){
			StringBuilder sb = new StringBuilder();
			String table = "FIELD";
			sb.append("select  F.FIELD_GROUPS_ID,F.NAME,F.ID,F.REQUIRED,F.MAX_CHAR,F.IDX,T.TYPE, IT.TYPE as ITYPE, COUNT(C.ID) as CHOICE_COUNT  ");
			sb.append(",");	
			sb.append(" CONVERT(VARCHAR(10),F.CREATED_DATE,101) as C_CREATED_DATE ");
			sb.append(",");
			sb.append(" CONVERT(VARCHAR(10),F.UPDATED_DATE,101) as C_UPDATED_DATE ");
			
			sb.append(" from " ).append(table).append(" F ");
			sb.append(" LEFT OUTER JOIN LKUP_FIELD_TYPE T on F.LKUP_FIELD_TYPE_ID = T.ID   ");
			sb.append(" LEFT OUTER JOIN LKUP_FIELD_ITYPE IT on F.LKUP_FIELD_ITYPE_ID = IT.ID  "); 
			sb.append(" LEFT OUTER JOIN FIELD_CHOICES C on F.ID = C.FIELD_ID AND C.ACTIVE='Y' "); 
			 
			sb.append("	WHERE FIELD_GROUPS_ID=").append(groupid).append(" group by F.FIELD_GROUPS_ID,F.NAME,F.ID,T.TYPE,IT.TYPE,F.REQUIRED,F.MAX_CHAR,F.IDX,F.CREATED_DATE,F.UPDATED_DATE,F.ordr order by F.ordr ");
			return sb.toString();
		}
	 
	 
	 public static JSONArray getJsonList(String command){
			JSONArray a = new JSONArray();
			
			try{
			Sage db = new Sage();
			
			db.query(command);
			String[] cols = db.COLUMNS;
			
			while(db.next()){
			
				JSONObject h = new JSONObject();
				for (int i=0; i<cols.length; i++) {
					String c = cols[i];
					h.put(c, db.getString(c));
				}
				
				a.put(h);
			}
			
			db.clear();
			}catch(Exception e){
				Logger.info(e.getMessage());
			}
			
			return a;
				
		}		
	
	 public static void main201(String args[]){
		 Logger.info(runCashier("")+"dd");
		// Logger.info(getUrlContent("")+"dd");
	}
	 public static void main(String args[]){
			Timekeeper k = new Timekeeper();
			Logger.info(k.getString("YYYYMMDD"));
			Logger.info(k.getString("DT"));
			String random = k.getString("DT")+"u"+Operator.randomString(8);
			Logger.info(random);
			
		}
}
