package cs.address;

import org.json.JSONException;
import org.json.JSONObject;

import alain.core.utils.Cartographer;
import alain.core.utils.Config;
import alain.core.utils.Operator;
import cs.common.ApiHandler;

public class Address {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//for(int i=0;i<10000;i++){
		JSONObject a= new JSONObject();
		try {
			/*a.put("q", "801 Rodeo");
			a.put("start", 0);
			a.put("end", 10);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/lso/search";
			String s = ApiHandler.getResponsePost(url, a.toString());
			System.out.println("input post"+a.toString());
			System.out.println("output json::"+s);*/
			String str = "9E02532-";
			System.out.println(Operator.toDouble(str));
			System.out.println(Double.valueOf(str.trim()).doubleValue());
			
		
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
			a.put("end", 1000);
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
	
	
	public static String children(int id) {
		JSONObject a= new JSONObject();
		String s = "";
		try {
			
			a.put("id", id);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/lso/children";
			s = ApiHandler.getResponsePost(url, a.toString());
			System.out.println("input post"+a.toString());
			System.out.println("output json::"+s);
		
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return s;
		
	}
	
	
	public static String getDetails(String type,int id) {
		JSONObject a= new JSONObject();
		String s = "";
		try {
			a.put("type", type);
			a.put("id", id);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/lso/details";
			s = ApiHandler.getResponsePost(url, a.toString());
			System.out.println("input post"+a.toString());
			System.out.println("output json::"+s);
		
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return s;
		
	}
	
	
	public static String getDetails(String type,int id,String formgrp) {
		JSONObject a= new JSONObject();
		String s = "";
		try {
			a.put("formgrp", formgrp);
			a.put("type", type);
			a.put("id", id);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/lso/formdetails";
			s = ApiHandler.getResponsePost(url, a.toString());
			System.out.println("input post"+a.toString());
			System.out.println("output json::"+s);
		
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return s;
		
	}
}
