package cs.projects;

import org.json.JSONException;
import org.json.JSONObject;

import alain.core.utils.Cartographer;
import alain.core.utils.Config;
import cs.common.ApiHandler;

public class Projects {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//for(int i=0;i<10000;i++){
		JSONObject a= new JSONObject();
		try {
			a.put("q", "801 Rodeo");
			a.put("start", 0);
			a.put("end", 10);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/address/search";
			String s = ApiHandler.getResponsePost(url, a.toString());
			System.out.println("input post"+a.toString());
			System.out.println("output json::"+s);
			
			
			
			
		
		} catch (JSONException e) {
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
			a.put("end", 50);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/address/search";
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
			String url = Config.rooturl()+"/csapi/rest/address/search";
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
			String url = Config.rooturl()+"/csapi/rest/address/search";
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
	
	
	public static String subs(int id) {
		JSONObject a= new JSONObject();
		String s = "";
		try {
		
			a.put("id", id);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/project/addressProjects";
			s = ApiHandler.getResponsePost(url, a.toString());
			System.out.println("input post"+a.toString());
			System.out.println("output json::"+s);
		
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return s;
		
	}
	
	public static String childrens(int id) {
		JSONObject a= new JSONObject();
		String s = "";
		try {
		
			a.put("id", id);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/project/childrens";
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
			String url = Config.rooturl()+"/csapi/rest/project/details";
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
			String url = Config.rooturl()+"/csapi/rest/project/formdetails";
			s = ApiHandler.getResponsePost(url, a.toString());
			System.out.println("input post"+a.toString());
			System.out.println("output json::"+s);
		
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return s;
		
	}
	
}
