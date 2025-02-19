package cs.common;
import org.apache.http.HttpEntity;
import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import alain.core.utils.Logger;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class Http {

	
	public static String GET_TOKEN_CUSTOMER_URL= "http://localhost:8080/csapi/rest/AuthTest/user1";
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		for (int i =0;i<10;i++){
			System.out.println(i+"--"+getToken("username000", "password"));
		}
		

	}

	
	/**
	 * @param args
	 */
	 public static JSONArray getJsonArray(String url,ArrayList<NameValuePair> params) {
		 JSONArray o = new JSONArray();
		 try{
			 o = new JSONArray(getResponsePost(url, params));
			 
		 }catch(Exception e){
			 System.err.println("Error while retrieving Json array"+e.getMessage());
		 }
		 return o;
	 }
	 
	 public static JSONObject getJson(String url,ArrayList<NameValuePair> params) {
		 JSONObject o = new JSONObject();
		 try{
			 o = new JSONObject(getResponsePost(url, params));
			 
		 }catch(Exception e){
			 System.err.println("Error while retrieving Json"+e.getMessage());
		 }
		 return o;
	 }
	
	public static String getResponsePost(String url,ArrayList<NameValuePair> params)  {
		  StringBuilder out = new StringBuilder();
		  try {
		  
		  HttpClient httpclient = new DefaultHttpClient();
		  HttpPost httppost = new HttpPost(url);
		  
	   	 /* UrlEncodedFormEntity e = new UrlEncodedFormEntity(params);
		  httppost.setEntity(e);*/
		  
		 
		  //post json
		   StringEntity params1 =new StringEntity("details={\"name\":\"City Smart\",\"age\":\"20\"} ");
		   httppost.addHeader("content-type", "application/x-www-form-urlencoded");
		   httppost.setEntity(params1);
		  
		//  params.add(new BasicName(11,"password"));
		  
		  
		  HttpResponse response = httpclient.execute(httppost);
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
	 
	 public static String getResponseGet(String url,ArrayList<NameValuePair> params)  {
		  StringBuilder out = new StringBuilder();
		  try {
		  HttpClient httpclient = new DefaultHttpClient();
		  HttpGet httpget = new HttpGet();
	   	  
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
	    	  out.append("Error while getting response "+ex.getMessage());  
	      } 
		  return out.toString();
	  }

	
	 
	 public static String getToken(String username,String password) {
		  String token = "";
		  ArrayList<NameValuePair> params = new ArrayList<NameValuePair>();
		  params.add(new BasicNameValuePair("username",username));
		  params.add(new BasicNameValuePair("passwd",password));
		  try {
				  //JSONObject o = getJson(GET_TOKEN_CUSTOMER_URL, params);
				 // token = o.getString("token");
			  token = getResponsePost(GET_TOKEN_CUSTOMER_URL, params);
			
		} catch (Exception e) {
			System.err.println("Error while retrieving token"+e.getMessage());
			
			
		}
		  return token;
	  }
	 
}
