package cs.search;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import alain.core.db.Sage;
import alain.core.security.RequestToken;
import alain.core.utils.Cartographer;
import alain.core.utils.Logger;
import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;
import cs.common.ApiHandler;
import csshared.utils.CsConfig;

/**
 * @author svijay
 *
 */
public class GlobalSearch {

	public static String search(Cartographer map){
		return search(map, false,false);
	}
	
	public static String search(Cartographer map,boolean trends,boolean stats){
		
		String resp ="";
		try{
			
			URIBuilder  o = new URIBuilder(map.getString("_url"));
			ArrayList<NameValuePair> oparams = new ArrayList<NameValuePair>();
			String q = map.getString("q");
			if(!Operator.hasValue(q)){
				q = "*";
			}
			
			oparams.add(new BasicNameValuePair("start",map.getString("start")));
			oparams.add(new BasicNameValuePair("rows",map.getString("rows","25")));
			if(stats){
				oparams.add(new BasicNameValuePair("stats","true"));
				oparams.add(new BasicNameValuePair("stats.field",map.getString("statsfield")));
			}else {
				oparams.add(new BasicNameValuePair("json.facet", map.getString("_facet")));
			}
			
			q = lsoId(q);
			/*Logger.info(q);
			Logger.info(q.indexOf(":"));
			Logger.info(q.indexOf("lso_id"));
			if(q.indexOf("lso_id:")>=0){
				//if(q.indexOf(":")){
					String ra[] = Operator.split(q," ");
					for(int i=0;i<ra.length;i++){
					String r[] = Operator.split(ra[i],":");
					if(r.length>0){
						if(ra[i].startsWith("lso_id")){
						Logger.info("******FFFFFF***"+ra[i]);
						String aq = " parent_id:"+r[1];
						aq += " grandparent_id:"+r[1];
						aq += " "+ra[i];
						q = Operator.replace(q, ra[i], aq);
						oparams.add(new BasicNameValuePair("q",Operator.replace(q, " ", "%20")));
						oparams.add(new BasicNameValuePair("defType","edismax"));
						oparams.add(new BasicNameValuePair("mm","100"));
						}
					}
					}
					
				
			}else {*/
				oparams.add(new BasicNameValuePair("q",URLEncoder.encode(q, "UTF-8")));
				oparams.add(new BasicNameValuePair("defType","edismax"));
				oparams.add(new BasicNameValuePair("mm","100"));
			//}
			Logger.info("##########FINAL######"+q);
			oparams.add(new BasicNameValuePair("indent","on"));
			oparams.add(new BasicNameValuePair("wt",map.getString("wt")));
			oparams.add(new BasicNameValuePair("_fq",map.getString("_fq")));
			oparams.add(new BasicNameValuePair("sort",Operator.replace(map.getString("_sort"), " ", "%20")));
			oparams.add(new BasicNameValuePair("_filters",map.getString("_filters")));
			oparams.add(new BasicNameValuePair("_dt",map.getString("_dt")));
			oparams.add(new BasicNameValuePair("_customdt",map.getString("_customdt")));
			//oparams.add(new BasicNameValuePair("_userId",map.getString("_userId")));
			oparams.add(new BasicNameValuePair("TZ","America/Los_Angeles"));

			oparams.add(new BasicNameValuePair("_price",map.getString("_price")));
			oparams.add(new BasicNameValuePair("fl",Operator.replace(map.getString("fl")," ","%20")));
			oparams.add(new BasicNameValuePair("specific",map.getString("specific")));
			//oparams.add(new BasicNameValuePair("_bookmarktitle",map.getString("_bookmarktitle")));
			if(map.getString("_view").equalsIgnoreCase("viewrow")){
				oparams.add(new BasicNameValuePair("hl.fl","_text_"));
				oparams.add(new BasicNameValuePair("hl","on"));
				oparams.add(new BasicNameValuePair("hl.simple.pre",URLEncoder.encode("<mark>", "UTF-8")));
				oparams.add(new BasicNameValuePair("hl.simple.post",URLEncoder.encode("</mark>", "UTF-8")));
			}
			
			String u = o.toString();
			
			if(!trends){
				if(Operator.equalsIgnoreCase(map.getString("_bookmark"),"Y")){
						saveBookmark(map.getInt("_userId"),map.getString("_bookmarktitle"),map);
				}
				resp = searchSolr(u, oparams,map.getString("method"));
			}else{
				resp = trends(u, oparams,map.getString("method"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
			Logger.error(e.getMessage());
		}
		return resp;
	}
	
	
	public static String spell(Cartographer map){
		
		String resp ="";
		try{
			String url = map.getString("_url");
			url = Operator.replace(url, "/query", "/spell");
			URIBuilder  o = new URIBuilder(url);
			ArrayList<NameValuePair> oparams = new ArrayList<NameValuePair>();
			oparams.add(new BasicNameValuePair("spellcheck.q",URLEncoder.encode(map.getString("q"), "UTF-8")));
			oparams.add(new BasicNameValuePair("indent","on"));
			oparams.add(new BasicNameValuePair("wt",map.getString("wt")));
			oparams.add(new BasicNameValuePair("spellcheck.maxCollations","1"));
			oparams.add(new BasicNameValuePair("spellcheck.collateParam.q.op","AND"));
			String u = o.toString();
			resp = searchSolr(u, oparams,map.getString("method"));
		}catch(Exception e){
			Logger.error(e.getMessage());
		}
		return resp;
	}
	
	
	 public static String searchSolr(String url,String format)  {
		 StringBuilder out = new StringBuilder();
		  try {
		  HttpClient httpclient = new DefaultHttpClient();
		  HttpGet httpget = new HttpGet();
		
		  String encoding =  CsConfig.getString("search.credentials.login_username")+":"+ CsConfig.getString("search.credentials.login_pass"); 
		  byte[] encodedBytes = Base64.encodeBase64(encoding.getBytes());
		  httpget.setHeader("Authorization", "Basic " + new String(encodedBytes));
		  
		
	      String s = url;
	    
	      Logger.info(s);
	      URI website = new URI(s);
	   
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
		    	  out.append("Error while getting response "+ex.getMessage());  
		      } 
			  return out.toString();
	 }
	
	 public static String searchSolr(String url,ArrayList<NameValuePair> params,String format)  {
		  StringBuilder out = new StringBuilder();
		  try {
		  HttpClient httpclient = new DefaultHttpClient();
		  HttpGet httpget = new HttpGet();
		
		  String encoding =  CsConfig.getString("search.credentials.login_username")+":"+ CsConfig.getString("search.credentials.login_pass"); 
		  byte[] encodedBytes = Base64.encodeBase64(encoding.getBytes());
		  httpget.setHeader("Authorization", "Basic " + new String(encodedBytes));
		  
		 // httpget.setParams(arg0);
		  StringBuilder sb = new StringBuilder();
		  sb.append(url);
	      if(params.size()>0){
	    	  sb.append("?");
	      }
	      String pr = "";
	      String dt = "";
	      String fq = "";
	      String filters="";
	      String customdt = "";
	      String specific = "";
	      for(int i=0;i<params.size();i++){
	    	 Logger.info(params.get(i)+"");
	    	 if(params.get(i).getName().equals("_fq")){
	    		 fq = params.get(i).getValue();
	    	 }else  if(params.get(i).getName().equals("_filters")){
	    		 filters = params.get(i).getValue();
	    	 }else  if(params.get(i).getName().equals("_dt")){
	    		 dt = params.get(i).getValue();
	    	 }else  if(params.get(i).getName().equals("_customdt")){
	    		 customdt = params.get(i).getValue();
	    	 }else  if(params.get(i).getName().equals("_price")){
	    		 pr = params.get(i).getValue();
	    	 }else  if(params.get(i).getName().equals("specific")){
	    		 specific = params.get(i).getValue();
	    	 }else  if(params.get(i).getName().equals("q")){
	    		 
	    		 String q = params.get(i).getValue();
	    		
	    		 if(Operator.hasValue(q) && q.indexOf("@")==-1){
	    			 q = Operator.replace(q,"@","&#64;");
	    		 }else {
	    			 q = URLEncoder.encode(q, "UTF-8");
	    		 }
	    		 
	    		 sb.append(params.get(i).getName()).append("=").append(q);
	    		 sb.append("&");
	    	 }
	    	 else
	    		 if(params.get(i).getName().equals("json.facet")){
	    		// sb.append(params.get(i).getName()).append("=").append(URLEncoder.encode(params.get(i).getValue(), "UTF-8"));
	    		 
	    		 //211{"type" :{ "type":"terms","field":"type","domain": {"excludeTags": "type" } },"status" :{ "type":"terms","field":"status","domain": {"excludeTags": "status" } }}
	    		// %7B%22type%22+%3A%7B+%22type%22%3A%22terms%22%2C%22field%22%3A%22type%22%2C%22domain%22%3A+%7B%22excludeTags%22%3A+%22type%22+%7D+%7D%2C%22status%22+%3A%7B+%22type%22%3A%22terms%22%2C%22field%22%3A%22status%22%2C%22domain%22%3A+%7B%22excludeTags%22%3A+%22status%22+%7D+%7D%7D
	    		 String j = params.get(i).getValue();
	    		 j = Operator.replace(j, "{", "%7b");
	    		 j = Operator.replace(j, "}", "%7d");
	    		 j = Operator.replace(j,"\"","%22");
	    		
	    		// j = Operator.replace(j,":","%20:");
	    		
	    		 sb.append(params.get(i).getName()).append("=").append(j);
	    		 sb.append("&");
	    		
	    		
	    	 }  	 
	    	 else {
	    	  sb.append(params.get(i));
	    	  sb.append("&");
	    	 }
	      }
	      
	   
	      
	  	ArrayList<String> a = solrescapeFilter(fq, filters);
	    for(String qfp : a){
	    	
	    	String k = qfp;
	    	Logger.info("k*************************************"+k);
	    	if(k.indexOf("display_type")<0){
	    		sb.append("&fq").append("=").append(k).append("&");
	    	}
	    }
	    
	    String []dts = Operator.split(dt,"&");
	    for(String qfp : dts){
	    	sb.append("&fq").append("=").append(Operator.replace(qfp, " ", "%20")).append("&");
	    }
	    String []prs = Operator.split(pr,"&");
	    for(String qfp : prs){
	    	sb.append("&fq").append("=").append(Operator.replace(qfp, " ", "%20")).append("&");
	    }
	    String []sprs = Operator.split(specific,",");
	    for(String qfp : sprs){
	    	sb.append("&fq").append("=").append(Operator.replace(qfp, " ", "%20")).append("&");
	    }
	   
	    sb.append(doCustomDates(customdt));
	    
	      
	   
	      String s = sb.toString();
	    
	      Logger.info(s);
	      URI website = new URI(s);
	   
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
			  return out.toString().replaceAll("_SPACE_"," ");
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
				    Logger.info("g*******************"+g);
				    String s = Operator.replace(g," ","%5C%20");
				    s = Operator.replace(s, "(", "%5C%28");
					
					s = Operator.replace(s, ")", "%5C%29");
					s = Operator.replace(s, "," ,"%20");
					s = Operator.replace(s,"&","%26");
				    
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
	 
	 public static int userId(String token,String ip) throws JSONException{
		 RequestToken r = new RequestToken();
		 r.setToken(token);
		 r.setIp(ip);
		 String s  = ApiHandler.post("lso", r);
		 JSONObject t  = new JSONObject(s);
		 System.out.println(t.getInt("id"));
		 return t.getInt("id");
		 
		
		 
	 }
	 
	 
	 public static String doCustomDates(String customdt){
		
		 StringBuilder sb =new StringBuilder();
		 String []cdts = Operator.split(customdt,",");
		 	for(String qfp : cdts){
		    	Logger.info(qfp);
		    	String qf[] = Operator.split(qfp, "-");
		    	sb.append("&fq").append("=").append(qf[0]).append(":").append(getDates(qf[1])).append("&");
		    }
		return sb.toString();   
	 }
	 
	 public static String getDates(String pattern){
		 StringBuilder sb = new StringBuilder();
		 Timekeeper P24 = new Timekeeper();
		 P24.addDay(-1);
		 
		 Timekeeper C1M = new Timekeeper();
		 C1M.setDay(1);
		 
		 Timekeeper C1Y = new Timekeeper();
		 C1Y.setDay(1);
		 C1Y.setMonth(1);
		 
		 Timekeeper F1Y = new Timekeeper();
		 if(F1Y.MONTH()>6){
			 F1Y.setDay(1);
			 F1Y.setMonth(7);
		 }else {
			 F1Y.addYear(-1);
			 F1Y.setDay(1);
			 F1Y.setMonth(7);
		 }
		 
		
		 
		 if(pattern.equalsIgnoreCase("P24")){
			 sb.append("[").append(P24.getString("YYYY-MM-DD")).append("T00:00:00Z%20TO%20*]");
		 }
		 
		 if(pattern.equalsIgnoreCase("C1M")){
			 sb.append("[").append(C1M.getString("YYYY-MM-DD")).append("T00:00:00Z%20TO%20*]");
		 }
		 if(pattern.equalsIgnoreCase("C1Y")){
			 sb.append("[").append(C1Y.getString("YYYY-MM-DD")).append("T00:00:00Z%20TO%20*]");
		 }
		 
		 if(pattern.equalsIgnoreCase("F1Y")){
			 sb.append("[").append(F1Y.getString("YYYY-MM-DD")).append("T00:00:00Z%20TO%20*]");
		 }
		 
		 return sb.toString();
		 
	 }
	 
	 
	 public static boolean addBookmark(int userId,String title,String location,JSONObject o){
		 boolean r = false;
		 Sage db = new Sage();
		 
		 StringBuilder sb = new StringBuilder();
		 sb.append("insert into BOOKMARK (USERS_ID, TITLE, LOCATION,BOOKMARK,CREATED_BY,UPDATED_BY) VALUES (");
		 sb.append(userId);
		 sb.append(",");
		 sb.append("'").append(Operator.sqlEscape(title)).append("'");
		 sb.append(",");
		 sb.append("'").append(Operator.sqlEscape(location)).append("'");
		 sb.append(",");
		 sb.append("'").append(Operator.sqlEscape(o.toString())).append("'");
		 sb.append(",");
		 sb.append(userId);
		 sb.append(",");
		 sb.append(userId);
		 sb.append(")");
		
		 r =db.update(sb.toString());
			 
		 
		 
		 db.clear();
		 
		 return r;
	 }
	 
	 public static boolean saveBookmark(int userId,String title,Cartographer map){
		boolean r = false;
		 JSONObject o = new JSONObject();
		 try{
		 
		 
		  
		   	o.put("q",map.getString("q"));
			o.put("start",map.getString("start"));
			o.put("rows",map.getString("rows","50"));
		
			o.put("_fq",map.getString("_fq"));
			o.put("sort",Operator.replace(map.getString("_sort"), " ", "%20"));
			o.put("_filters",map.getString("_filters"));
			o.put("_dt",map.getString("_dt"));
			o.put("_customdt",map.getString("_customdt"));
			o.put("_facetvalues",map.getString("_facetvalues"));
			o.put("_price",map.getString("_price"));
			o.put("fl",map.getString("fl"));
			
				 
		  
		 }catch(Exception e){
			 Logger.error(e.getMessage());
		 }
		 if(Operator.hasValue(o.toString())){
			 	r =addBookmark(userId, title,map.getString("_location"), o);
		 }
		 return r;
	 } 
	 
	 
	 public static JSONArray getBookmarks(int userId) throws JSONException{
		 JSONArray a = new JSONArray();
		 Sage db = new Sage();
		 
		 //String command = "select * from bookmark left outer join  where users_id="+userId;
		 StringBuilder sb = new StringBuilder();
		 sb.append("  select   ");
		 sb.append(" A.* ");
		 sb.append(",");	
		 sb.append(" CONVERT(VARCHAR(10),A.CREATED_DATE,101) as C_CREATED_DATE ");
		 sb.append(",");
		 sb.append(" CONVERT(VARCHAR(10),A.UPDATED_DATE,101) as C_UPDATED_DATE ");
		 sb.append(",");
		 sb.append("   CU.USERNAME AS CREATED ");
		 sb.append(",");
		 sb.append("   UP.USERNAME as UPDATED from BOOKMARK A "); 
		 sb.append(" LEFT OUTER JOIN USERS CU on A.CREATED_BY = CU.ID ");
		 sb.append(" LEFT OUTER JOIN USERS UP on A.UPDATED_BY = UP.ID "); 
		 sb.append(" WHERE A.ACTIVE ='Y' AND A.USERS_ID = ").append(userId).append(" ORDER BY A.TITLE "); 
		 db.query(sb.toString());
		 while(db.next()){
			 JSONObject t  = new JSONObject();
			 t.put("ID", db.getInt("ID"));
			 t.put("TITLE", db.getString("TITLE"));
			 t.put("DESCRIPTION", db.getString("DESCRIPTION"));
			 t.put("LOCATION", db.getString("LOCATION"));
			 t.put("SHARE_ID", db.getInt("SHARE_ID"));
			 t.put("C_CREATED_DATE", db.getString("C_CREATED_DATE"));
			 t.put("C_UPDATED_DATE", db.getString("C_UPDATED_DATE"));
			 t.put("EMAIL_ON", db.getString("EMAIL_ON"));
			 t.put("CREATED", db.getString("CREATED"));
			 t.put("UPDATED", db.getString("UPDATED"));
			 a.put(t);
		 }
		 db.clear();
		 
		 return a;
		 
		
		 
	 }
	 
	 public static JSONObject viewBookmark(int bookmarkId) throws JSONException{
		 JSONObject t  = new JSONObject();
		 Sage db = new Sage();
		 
		 String command = "select * from bookmark where ID="+bookmarkId;
		 db.query(command);
		 while(db.next()){
			t = new JSONObject(db.getString("BOOKMARK"));
			t.put("_BTITLE", db.getString("TITLE"));
			t.put("_BDESCRIPTION", db.getString("DESCRIPTION"));
		 }
		 db.clear();
		 
		 return t;
		 
		
		 
	 }
	 
	 
	 public static JSONObject getBookmark(int bookmarkId) throws JSONException{
		 JSONObject t  = new JSONObject();
		 Sage db = new Sage();
		 
		 //String command = "select * from bookmark left outer join  where users_id="+userId;
		 StringBuilder sb = new StringBuilder();
		 sb.append("  select   ");
		 sb.append(" A.* ");
		 sb.append(",");	
		 sb.append(" CONVERT(VARCHAR(10),A.CREATED_DATE,101) as C_CREATED_DATE ");
		 sb.append(",");
		 sb.append(" CONVERT(VARCHAR(10),A.UPDATED_DATE,101) as C_UPDATED_DATE ");
		 sb.append(",");
		 sb.append("   CU.USERNAME AS CREATED ");
		 sb.append(",");
		 sb.append("   UP.USERNAME as UPDATED from BOOKMARK A "); 
		 sb.append(" LEFT OUTER JOIN USERS CU on A.CREATED_BY = CU.ID ");
		 sb.append(" LEFT OUTER JOIN USERS UP on A.UPDATED_BY = UP.ID "); 
		 sb.append(" WHERE A.ACTIVE ='Y' AND A.ID = ").append(bookmarkId).append("  "); 
		 db.query(sb.toString());
		 while(db.next()){
			 t.put("ID", db.getInt("ID"));
			 t.put("TITLE", db.getString("TITLE"));
			 t.put("DESCRIPTION", db.getString("DESCRIPTION"));
			 t.put("LOCATION", db.getString("LOCATION"));
			 t.put("SHARE_ID", db.getInt("SHARE_ID"));
			 t.put("RECURRENCE_PATTERN", db.getString("RECURRENCE_PATTERN"));
			 t.put("C_CREATED_DATE", db.getString("C_CREATED_DATE"));
			 t.put("C_UPDATED_DATE", db.getString("C_UPDATED_DATE"));
			 t.put("EMAIL_TO", db.getString("EMAIL_TO"));
			 t.put("EMAIL_ON", db.getString("EMAIL_ON"));
			 t.put("CREATED", db.getString("CREATED"));
			 t.put("UPDATED", db.getString("UPDATED"));
			
		 }
		 db.clear();
		 
		 return t;
		 
		
		 
	 }
	 
	 public static JSONArray getStaff() throws JSONException{
		 JSONArray a = new JSONArray();
		 Sage db = new Sage();
		 //String command = "select * from bookmark left outer join  where users_id="+userId;
		 StringBuilder sb = new StringBuilder();
		 sb.append("  select   ");
		 sb.append(" U.ID,A.TITLE,U.FIRST_NAME,U.LAST_NAME,U.USERNAME,U.EMAIL ");
		 sb.append("    from STAFF A "); 
		 sb.append(" LEFT OUTER JOIN USERS U on A.USERS_ID = U.ID ");

		 sb.append(" WHERE A.ACTIVE ='Y' AND U.ID >0 ORDER BY FIRST_NAME "); 
		 db.query(sb.toString());
		 while(db.next()){
			 JSONObject t  = new JSONObject();
			 t.put("ID", db.getInt("ID"));
			 t.put("TITLE", db.getString("TITLE"));
			 t.put("FIRST_NAME", db.getString("FIRST_NAME"));
			 t.put("LAST_NAME", db.getString("LAST_NAME"));
			 t.put("USERNAME", db.getString("USERNAME"));
			 t.put("EMAIL", db.getString("EMAIL"));
			 a.put(t);
		 }
		 db.clear();
		 
		 return a;
	 }
	 public static JSONArray getStaff(int bookmarkId,int shareId) throws JSONException{
		 JSONArray a = new JSONArray();
		 Sage db = new Sage();
		 
		
		 if(shareId<0){
			 shareId = bookmarkId;
		 }
		 
		 //String command = "select * from bookmark left outer join  where users_id="+userId;
		 StringBuilder sb = new StringBuilder();
		 sb.append("  select   ");
		 sb.append(" U.ID,A.TITLE,U.FIRST_NAME,U.LAST_NAME,U.USERNAME,U.EMAIL,B.ID as BOOKMARK_ID ");
		 sb.append("    from STAFF A "); 
		 sb.append(" LEFT OUTER JOIN USERS U on A.USERS_ID = U.ID ");
		 sb.append(" LEFT OUTER JOIN BOOKMARK B on A.USERS_ID = B.USERS_ID and (B.ID =").append(bookmarkId).append(" OR B.SHARE_ID= ").append(shareId).append(") ");

		 sb.append(" WHERE A.ACTIVE ='Y' AND U.ID >0 ORDER BY FIRST_NAME "); 
		 db.query(sb.toString());
		 while(db.next()){
			 JSONObject t  = new JSONObject();
			 t.put("ID", db.getInt("ID"));
			 t.put("TITLE", db.getString("TITLE"));
			 t.put("FIRST_NAME", db.getString("FIRST_NAME"));
			 t.put("LAST_NAME", db.getString("LAST_NAME"));
			 t.put("USERNAME", db.getString("USERNAME"));
			 t.put("EMAIL", db.getString("EMAIL"));
			 t.put("BOOKMARK_ID", db.getInt("BOOKMARK_ID"));
			 a.put(t);
		 }
		 db.clear();
		 
		 return a;
		 
		
		 
	 }
	 
	 public static boolean shareControl(Cartographer map){
		 boolean result = false;
		 	
		 
		 int bookmarkId = map.getInt("bookmarkId",0);
		 int shareId = map.getInt("shareId",-1);
		 if(bookmarkId>0){
			 if(shareId<0){
				 shareId = bookmarkId;
			 }
			 Sage db = new Sage();
			 String share = map.getString("share","");
			 String recurrence = map.getString("recurrence_pattern","");
			
			 if(Operator.hasValue(share)){
				 String a[] = Operator.split(share,"|");
				 for(String s: a){
					 String ids[] = Operator.split(s,"$"); 
					 StringBuilder sb = new StringBuilder();
					 
					 sb.append(" insert into bookmark (USERS_ID,TITLE,DESCRIPTION,LOCATION,BOOKMARK");
					 if(Operator.hasValue(recurrence)){
						 sb.append(" ,SCHEDULE,RECURRENCE_PATTERN,EMAIL_TO,EMAIL_ON");
					 }
					 sb.append(" ,SHARE_ID,CREATED_BY,UPDATED_BY) ");
					
					 
					 sb.append(" select ").append(ids[0]).append(",B.TITLE,B.DESCRIPTION,B.LOCATION,B.BOOKMARK");
					 if(Operator.hasValue(recurrence)){
						 sb.append(",getdate(),'").append(Operator.sqlEscape(recurrence)).append("'");	
						 sb.append(",'").append(Operator.sqlEscape(ids[1].trim())).append("@beverlyhills.org','Y'");	 
					 }
					 sb.append(",").append(shareId).append(",B.CREATED_BY,B.UPDATED_BY from bookmark B");
					 sb.append(" left outer join BOOKMARK D on B.ID=D.SHARE_ID AND  D.USERS_ID= ").append(ids[0]).append("  AND D.ACTIVE='Y' ");
					 sb.append(" where B.id =").append(bookmarkId).append(" and D.ID is null ");
					 //sb.append(" select ").append(ids[0]).append(",TITLE,DESCRIPTION,LOCATION,BOOKMARK,getdate(),'monthly',8,'re','Y',CREATED_BY,UPDATED_BY from bookmark where id =").append(bookmarkId);
					 Logger.info(sb.toString());
					 
					/* StringBuilder sb2 = new StringBuilder();
					 sb2.append(" UPDATE BOOKMARK SET ACTIVE='N' , UPDATED_DATE = getdate(),UPDATED_BY=").append(map.getInt("userId",0)).append(" WHERE USERS_ID= ").append(ids[0]).append(" AND  SHARE_ID=").append(shareId);
					 result= db.update(sb2.toString());*/
					 result= db.update(sb.toString());
				 }
			 }
			 
			 db.clear();
		 }
		 
		 return result;
	 }
	 
	 public static boolean deleteBookmark(int bookmarkId){
		 boolean result = false;
		 StringBuilder sb = new StringBuilder();
		 sb.append(" UPDATE BOOKMARK SET ACTIVE='N'  , UPDATED_DATE = getdate() WHERE ID  = ").append(bookmarkId);
		 Sage db = new Sage();
		 result = db.update(sb.toString());
		 db.clear();
		 return result;
	 }
	 
	 public static boolean emailControl(Cartographer map){
		 boolean result = false;
		 	
		 
		 int bookmarkId = map.getInt("bookmarkId",0);
		 int shareId = map.getInt("shareId",-1);
		 int userId = map.getInt("userId",-1);
		 String emailon = map.getString("EMAIL_ON","N");
		 if(Operator.equalsIgnoreCase(emailon, "on")){	emailon = "Y";}
		 
		 String emailstaff = map.getString("emailstaff","");
		 emailstaff = Operator.replace(emailstaff, "|", ",");
		 
		 String recurrence = map.getString("recurrence_pattern","");
		 String emailselected = map.getString("emailselected","");
		 String email ="";
		 if(Operator.hasValue(emailselected)){
			 email = emailselected+","+emailstaff;
		 }else {
			 email = emailstaff;
		 }
		 
		 email = Operator.replace(email, ",,", ",");
		 if(email.endsWith(",")){
			 email = email.substring(0,email.length()-1);
		 }
		 
		 StringBuilder sb = new StringBuilder();
		 sb.append(" UPDATE BOOKMARK SET EMAIL_ON= '").append(Operator.sqlEscape(emailon)).append("'");
		 sb.append(",");
		 sb.append(" EMAIL_TO = '").append(Operator.sqlEscape(email)).append("'");
		 if(Operator.hasValue(recurrence)){
			 sb.append(",");
			 sb.append(" SCHEDULE = getdate() ");
			 sb.append(",");
			 sb.append(" RECURRENCE_PATTERN = '").append(Operator.sqlEscape(recurrence)).append("'");
		 }else {
			 sb.append(",");
			 sb.append(" SCHEDULE = null ");
			 sb.append(",");
			 sb.append(" RECURRENCE_PATTERN = null");
		 }
		 sb.append(",");
		 sb.append(" UPDATED_DATE = getdate() ");
		 sb.append(",");
		 sb.append(" UPDATED_BY =").append(userId);
		 sb.append(" WHERE ID  =").append(bookmarkId);
		 
		 Sage db = new Sage();
		 result = db.update(sb.toString());
		 db.clear();
		 
		 return result;
	 }
	 
	 public static boolean bookmarkEdit(Cartographer map){
		 boolean result = false;
		 	
		 
		 int bookmarkId = map.getInt("bookmarkId",0);
		 int shareId = map.getInt("shareId",-1);
		 int userId = map.getInt("userId",-1);
		 String title = map.getString("TITLE");
		 String desc = map.getString("DESCRIPTION");
		 
		 StringBuilder sb = new StringBuilder();
		 sb.append(" UPDATE BOOKMARK SET TITLE= '").append(Operator.sqlEscape(title)).append("'");
		 sb.append(",");
		 sb.append(" DESCRIPTION = '").append(Operator.sqlEscape(desc)).append("'");
		 sb.append(",");
		 sb.append(" UPDATED_DATE = getdate() ");
		 sb.append(",");
		 sb.append(" UPDATED_BY =").append(userId);
		 sb.append(" WHERE ID  =").append(bookmarkId);
		 
		 Sage db = new Sage();
		 result = db.update(sb.toString());
		 db.clear();
		 
		 return result;
	 }
	 
	public static String lsoId(String q){
		
		String s = q;
		if(s.indexOf("lso_id:")>=0){
			Sage db = new Sage();
			String command = "select * from LSO where ID=";
			Pattern p = Pattern.compile("lso_id:"+"([\\w&&[^b]])*");
			Matcher m = p.matcher(s);
			
			int md =0;
			while (m.find()) {
				int lsoId =  Operator.toInt(Operator.replace(m.group(), "lso_id:", ""));
				if(lsoId>0){
					command = "select LT.DESCRIPTION from LSO L JOIN LKUP_LSO_TYPE LT on L.LKUP_LSO_TYPE_ID= LT.ID where L.ID="+lsoId;
					if(db.query(command) && db.next()){
						String desc = db.getString("DESCRIPTION").toLowerCase();
						desc +="_id:"+lsoId;
						
						q = Operator.replace(q, m.group(), desc);
					}
				}
			}
			db.clear();
		}
		
		return q;
	}
	
	public static void main1(String args[]){
		String s = "lso_id:3816 electrical building lso_id:3456";
		if(s.indexOf("lso_id:")>=0){
			
			Pattern p = Pattern.compile("lso_id:"+"([\\w&&[^b]])*");
			Matcher m = p.matcher(s);
		
			int md =0;
			while (m.find()) {
				String noofmonths =  Operator.replace(m.group(), "lso_id:", "");
				System.out.println(noofmonths);
			}
			
		}
	}
	
	public static void main(String args[]){
		String s = "2018-01-14T01:20:33.916Z";
		Timekeeper k = new Timekeeper();
		k.setDate(s);
		System.out.println(k.getString("MM/DD/YYYY")); 
		
	}
	
	 public static String trends(String url,ArrayList<NameValuePair> params,String format)  {
		  StringBuilder out = new StringBuilder();
		  try {
		 
		
		
		  StringBuilder sb = new StringBuilder();
		  sb.append(url);
	      if(params.size()>0){
	    	  sb.append("?");
	      }
	      String pr = "";
	      String dt = "";
	      String fq = "";
	      String filters="";
	      String customdt = "";
	      String specific = "";
	      for(int i=0;i<params.size();i++){
	    	 Logger.info(params.get(i)+"");
	    	 if(params.get(i).getName().equals("_fq")){
	    		 fq = params.get(i).getValue();
	    	 }else  if(params.get(i).getName().equals("_filters")){
	    		 filters = params.get(i).getValue();
	    	 }else  if(params.get(i).getName().equals("_dt")){
	    		 dt = params.get(i).getValue();
	    	 }else  if(params.get(i).getName().equals("_customdt")){
	    		 customdt = params.get(i).getValue();
	    	 }else  if(params.get(i).getName().equals("_price")){
	    		 pr = params.get(i).getValue();
	    	 }else  if(params.get(i).getName().equals("specific")){
	    		 specific = params.get(i).getValue();
	    	 }else  if(params.get(i).getName().equals("q")){
	    		 
	    		 String q = params.get(i).getValue();
	    		
	    		 if(Operator.hasValue(q) && q.indexOf("@")==-1){
	    			 q = Operator.replace(q,"@","&#64;");
	    		 }else {
	    			 q = URLEncoder.encode(q, "UTF-8");
	    		 }
	    		 
	    		 sb.append(params.get(i).getName()).append("=").append(q);
	    		 sb.append("&");
	    	 }
	    	 else
	    		 if(params.get(i).getName().equals("json.facet")){
	    		// sb.append(params.get(i).getName()).append("=").append(URLEncoder.encode(params.get(i).getValue(), "UTF-8"));
	    		 
	    		 //211{"type" :{ "type":"terms","field":"type","domain": {"excludeTags": "type" } },"status" :{ "type":"terms","field":"status","domain": {"excludeTags": "status" } }}
	    		// %7B%22type%22+%3A%7B+%22type%22%3A%22terms%22%2C%22field%22%3A%22type%22%2C%22domain%22%3A+%7B%22excludeTags%22%3A+%22type%22+%7D+%7D%2C%22status%22+%3A%7B+%22type%22%3A%22terms%22%2C%22field%22%3A%22status%22%2C%22domain%22%3A+%7B%22excludeTags%22%3A+%22status%22+%7D+%7D%7D
	    		 String j = params.get(i).getValue();
	    		 j = Operator.replace(j, "{", "%7b");
	    		 j = Operator.replace(j, "}", "%7d");
	    		 j = Operator.replace(j,"\"","%22");
	    		
	    		// j = Operator.replace(j,":","%20:");
	    		
	    		 sb.append(params.get(i).getName()).append("=").append(j);
	    		 sb.append("&");
	    		
	    		
	    	 }  	 
	    	 else {
	    	  sb.append(params.get(i));
	    	  sb.append("&");
	    	 }
	      }
	      
	   
	      
	  	ArrayList<String> a = solrescapeFilter(fq, filters);
	    for(String qfp : a){
	    	
	    	String k = qfp;
	    	
	    	if(k.indexOf("display_type")<0){
	    		sb.append("&fq").append("=").append(k).append("&");
	    	}
	    }
	    
	    String []dts = Operator.split(dt,"&");
	    for(String qfp : dts){
	    	sb.append("&fq").append("=").append(Operator.replace(qfp, " ", "%20")).append("&");
	    }
	    String []prs = Operator.split(pr,"&");
	    for(String qfp : prs){
	    	sb.append("&fq").append("=").append(Operator.replace(qfp, " ", "%20")).append("&");
	    }
	    String []sprs = Operator.split(specific,",");
	    for(String qfp : sprs){
	    	sb.append("&fq").append("=").append(Operator.replace(qfp, " ", "%20")).append("&");
	    }
	   
	    sb.append(doCustomDates(customdt));
	    
	    
	    
	      
	   
	      String s = sb.toString();
	    
	      Logger.info(s);
	      out.append(trends(url).toString());
		  } catch(Exception ex){
		    	  out.append("Error while getting response "+ex.getMessage());  
		      } 
			  return out.toString();
		  }
	
	 
	 public static JSONArray trends(String url){
		 JSONArray t = new JSONArray();
		 String trend1 = url+"?q=*&start=0&rows=0&facet.range=created_date&facet=true&facet.range.start=NOW-1YEAR&facet.range.end=NOW&facet.range.gap=%2B1DAY";
		 try{
			 Logger.info(trend1);
			 JSONObject o = new JSONObject(urlResponse(trend1));
			
			 return trendsParser(o);
			 
			 //Logger.info("t*********"+t.toString());
		 }catch(Exception e){
			 Logger.error(e.getMessage());
		 }
		 return t;
	 }
	 
	 public static JSONArray trendsParser(JSONObject o){
		 JSONArray t = new JSONArray();
		 try{
			 JSONObject fc = o.getJSONObject("facet_counts");
			 JSONObject fr = fc.getJSONObject("facet_ranges");
			 JSONObject t1 = fr.getJSONObject("created_date");
			 
			 String c = t1.getString("counts");
			 c = Operator.replace(c, "[", "");
			 c = Operator.replace(c, "]", "");
			 c = Operator.replace(c, "Z\",", "|");
			
			 String r[] = Operator.split(c,",");
			 
			 JSONObject d = new JSONObject();
			 JSONArray ta = new JSONArray();	 
			 Timekeeper k = new Timekeeper();
			 for(String a: r){
				 JSONObject trend1 = new JSONObject();
				 String j[] = Operator.split(a,"|");
				 k.setDate(j[0]);
				 trend1.put("date", k.getString("YYYY-MM-DD"));
				 trend1.put("value", Operator.toInt(j[1]));
				 ta.put(trend1);
			 }
			 d.put("trend1", ta);
			 t.put(d);
			
			 
		 }catch(Exception e){
			 Logger.error(e.getMessage());
		 }
		 return t;
	 }
	 
	 
	 public static String urlResponse(String url){
		 StringBuilder out = new StringBuilder();
		  try {
		  HttpClient httpclient = new DefaultHttpClient();
		  HttpGet httpget = new HttpGet();
		
		  String encoding =  CsConfig.getString("search.credentials.login_username")+":"+ CsConfig.getString("search.credentials.login_pass"); 
		  byte[] encodedBytes = Base64.encodeBase64(encoding.getBytes());
		  httpget.setHeader("Authorization", "Basic " + new String(encodedBytes));
		 
		 URI website = new URI(url);
		   
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
		    	  out.append("Error while getting response "+ex.getMessage());  
		      } 
			  return out.toString();
	 }
	 
	 public static JSONArray getFields(String source)  {
			StringBuilder sql = new StringBuilder("select * from LKUP_FIELDS where ACTIVE = 'Y' AND SOURCE = ");
			sql.append(Operator.checkString(source));
			sql.append(" order by DISPLAYORDER asc");
			
			JSONArray facets = new JSONArray();
			JSONObject obj = new JSONObject();
			try {
				Sage db = new Sage();
				db.query(sql.toString());
				while (db.next()) {
					obj = new JSONObject();
					obj.put("id", db.getString("ID"));
					obj.put("field", db.getString("FIELD"));
					obj.put("text", db.getString("LABEL"));
					obj.put("display", db.getString("DISPLAY"));
					obj.put("export", db.getString("EXPORT"));
					obj.put("link", db.getString("link"));
					obj.put("type", db.getString("type"));
					obj.put("pkey", db.getString("pkey"));
					obj.put("stats", db.getString("STATS"));
					obj.put("target", db.getString("target"));
					
					facets.put(obj);
				}
				db.clear();
			} catch (Exception e) {
				Logger.error(" Exception while getting Fields : "+e.getMessage());
			}

			return facets;
	 }
	 
	 public static void saveExportFields(Cartographer map) {
		 Sage db = new Sage();
		 try{
			 int bookmarkId = map.getInt("bookmarkid");
			 String[] csvFields = map.getString("fl").split(",");
			 
			 db.update("DELETE FROM REF_LKUP_FIELDS_BOOKMARK WHERE BOOKMARK_ID = "+bookmarkId);
			 
			 for(int i=0; i<csvFields.length; i++) {
				 String sql ="SELECT * FROM LKUP_FIELDS WHERE SOURCE = '"+ map.getString("source")+"' AND ACTIVE ='Y' and FIELD IN  ('"+csvFields[i].substring(csvFields[i].indexOf(":")+1)+"')";
				 db.query(sql);
				 int fieldId =0;
				 if(db.next()){
					 fieldId= db.getInt("ID");
				 }
				 String insertSQL ="INSERT INTO REF_LKUP_FIELDS_BOOKMARK (LKUP_FIELDS_ID, BOOKMARK_ID, ACTIVE, CREATED_DATE, CREATED_BY, UPDATED_DATE, UPDATED_BY) VALUES ("+fieldId+", "+bookmarkId+", 'Y', CURRENT_TIMESTAMP, "+map.getInt("_userId")+", CURRENT_TIMESTAMP, "+map.getInt("_userId")+")";
				 db.update(insertSQL);
			 }
			 db.clear();
		 }catch (Exception e) {
			 Logger.error(" Exception while getting Fields : "+e.getMessage());
		 }

	 }
	 
		public static List<String> getExportFieldsForBookmark(String bookmarkId) throws Exception {
			List<String> fieldsList = new ArrayList();
			
			try {
				String sql = "select ID,LKUP_FIELDS_ID,BOOKMARK_ID from REF_LKUP_FIELDS_BOOKMARK WHERE ACTIVE='Y' AND BOOKMARK_ID = "+bookmarkId;

				Sage db = new Sage();
				db.query(sql);

				while (db.next()) {
					String fieldId = db.getString("LKUP_FIELDS_ID");
					fieldsList.add(fieldId);
				}
				db.clear();
				return fieldsList;
			} catch (Exception e) {
				Logger.error(e.getMessage());
				throw e;
			}
		}
}
