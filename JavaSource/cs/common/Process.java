package cs.common;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.util.ArrayList;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;

import alain.core.utils.Logger;

public class Process {
	
	
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

	
}
