package cs.agent;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;

import org.json.JSONException;
import org.json.JSONObject;

import alain.core.utils.Cartographer;
import alain.core.utils.Config;
import alain.core.utils.Logger;
import alain.core.utils.Operator;
import cs.common.ApiHandler;
import cs.utils.RequestMapper;
import csshared.vo.BrowserItemVO;
import csshared.vo.BrowserItemsVO;
import csshared.vo.RequestVO;

public class BrowserAgent {

	public static String panel(Cartographer map) {
		return panel(map.getString("id"), map.getString("grouptype"), map.getString("type"), map.getInt("dataid"), map.getString("entity"), map.getString("option"), map.token(), map.getRemoteIp());
	}

	public static String panel(String id, String grouptype, String type, int typeid, String entity, String option, String token, String ip) {
		Logger.info("Browser","Get Panel");
		RequestVO r = new RequestVO();
		r.setType(type);
		r.setId(id);
		r.setTypeid(typeid);
		r.setEntity(entity);
		r.setGrouptype(grouptype);
		r.setOption(option);
		r.setToken(token);
		r.setIp(ip);
		r.setRequest("browse");
		return ApiHandler.post(r);
	}

	public static String search(Cartographer map) {
		return search(map.getString("url"), map.getString("search"), map.getString("grouptype"), map.getString("type"), map.getInt("typeid"), map.getString("entity"), map.getString("option"), map.token());
	}

	public static String search(String url, String search, String grouptype, String type, int typeid, String entity, String option, String token) {
		Logger.info("Browser","Search");
		RequestVO r = new RequestVO();
		r.setUrl(url);
		r.setGrouptype(grouptype);
		r.setType(type);
		r.setTypeid(typeid);
		r.setEntity(entity);
		r.setOption(option);
		r.setSearch(search);
		r.setToken(token);
		r.setRequest("search");
		return ApiHandler.post(r);
	}

	public static String panels(Cartographer map) {
		return panels(map.getString("type"), map.getInt("typeid"), map.getString("reference"), map.getString("entity"), map.token());
	}

	public static String panels(String type, int typeid, String reference, String entity, String token) {
		if (!Operator.hasValue(entity)) { entity = "lso"; }
		Logger.info("Browser","Panels");
		StringBuilder sb = new StringBuilder();

		sb.append(" { ");

		sb.append("    \"menu\": { ");
		sb.append("      \"item\": { ");
		sb.append("        \"url\": \"").append(Config.contexturl()).append("/json/menu.jsp\" ");
		sb.append("        , ");
		sb.append("        \"type\": \"").append(entity).append("\" ");
		sb.append("      }, ");
		sb.append("      \"type\": \"menu\" ");
		sb.append("    } ");

		BrowserItemsVO m = new BrowserItemsVO();
		if (Operator.hasValue(type)) {
			RequestVO r = new RequestVO();
			r.setType(type);
			r.setTypeid(typeid);
			r.setEntity(entity);
			r.setReference(reference);
			r.setToken(token);
			r.setRequest("panels");
			m = ApiHandler.getPanels(r);
			BrowserItemVO e = m.item("entity");
			if (e != null) {
				sb.append("    , ");
				sb.append("   \"main\": { ");
				sb.append("     \"item\": { ");
				sb.append("       \"entity\": \"").append(e.getEntity()).append("\" ");
				sb.append("       , ");
				sb.append("       \"type\": \"").append(e.getType()).append("\" ");
				sb.append("       , ");
				sb.append("       \"dataid\": \"").append(e.getDataid()).append("\" ");
				sb.append("       , ");
				sb.append("       \"id\": \"").append(e.getId()).append("\" ");
				sb.append("      }, ");
				sb.append("     \"type\": \"tree\" ");
				sb.append("    } ");
			}

			BrowserItemVO t = m.item("type");
			if (t != null) {
				sb.append("    , ");
				sb.append("   \"sub\": { ");
				sb.append("     \"item\": { ");
				sb.append("       \"entity\": \"").append(t.getEntity()).append("\" ");
				sb.append("       , ");
				sb.append("       \"type\": \"").append(t.getType()).append("\" ");
				sb.append("       , ");
				sb.append("       \"dataid\": \"").append(t.getDataid()).append("\" ");
				sb.append("       , ");
				sb.append("       \"id\": \"").append(t.getId()).append("\" ");
				sb.append("      }, ");
				sb.append("     \"type\": \"tree\" ");
				sb.append("    } ");
			}

			BrowserItemVO d = m.item("detail");
			if (d != null) {
				sb.append("    , ");
				sb.append("   \"link\": { ");
				sb.append("     \"item\": { ");
				sb.append("       \"entity\": \"").append(d.getEntity()).append("\" ");
				sb.append("       , ");
				sb.append("       \"type\": \"").append(d.getType()).append("\" ");
				sb.append("       , ");
				sb.append("       \"dataid\": \"").append(d.getDataid()).append("\" ");
				sb.append("       , ");
				sb.append("       \"id\": \"").append(d.getId()).append("\" ");
				sb.append("       , ");
				sb.append("       \"link\": \"summary\" ");
				sb.append("      }, ");
				sb.append("     \"type\": \"iframe\", ");
				sb.append("     \"hide\": \"false\" ");
				sb.append("    } ");
			}
		}
		else {
			sb.append("    , ");
			sb.append("   \"main\": { ");
			sb.append("     \"item\": { ");
			sb.append("      }, ");
			sb.append("     \"type\": \"tree\" ");
			sb.append("    } ");
			sb.append("    , ");
			sb.append("   \"sub\": { ");
			sb.append("     \"item\": { ");
			sb.append("      }, ");
			sb.append("     \"type\": \"tree\" ");
			sb.append("    } ");
			sb.append("    , ");
			sb.append("   \"link\": { ");
			sb.append("     \"item\": { ");
			sb.append("       \"link\": \"entry\" ");
			sb.append("      }, ");
			sb.append("     \"type\": \"iframe\", ");
			sb.append("     \"hide\": \"false\" ");
			sb.append("    } ");
		}

		sb.append(" } ");

		Logger.highlight(sb.toString());

		return sb.toString();
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//for(int i=0;i<10000;i++){
		JSONObject a= new JSONObject();
		try {
			a.put("q", "801 Rodeo");
			a.put("start", 0);
			a.put("end", 10);
			a.put("token", "1243dsf214124123123dscds");
			/*String url = Config.rooturl()+"/csapi/rest/lso/search";
			String s = ApiHandler.getResponsePost(url, a.toString());
			System.out.println("input post"+a.toString());
			System.out.println("output json::"+s);
			
			 
			ActivityVO v = new ActivityVO();
			
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
		
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//}
		
	}
	
	
	public static String checkQ(String q,String url,String token,String ip, String option) {
		// TODO Auto-generated method stub
		//for(int i=0;i<10000;i++){
		JSONObject a= new JSONObject();
		String s = "";
		BufferedWriter output = null;
		try {
			a.put("q", q);
			a.put("start", 0);
			a.put("end", 50);
			a.put("token", token);
			a.put("ip", ip);
			a.put("option", option);
			
			//String url = Config.rooturl()+"/csapi/rest/lso/search";
			s = ApiHandler.getResponsePost(url, a.toString());
			
			
			try {
				output = new BufferedWriter(new FileWriter("c:/TEMP/cs.txt", true));
				output.newLine();
				Logger.info("input post 123"+a.toString());
				output.write(a.toString());
				output.newLine();
				Logger.info("output json 323::"+s);
				output.write(s);
				output.close();
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
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
		BufferedWriter output = null;
		try {
			a.put("q", "Rodeo");
			a.put("start", 0);
			a.put("end", 10);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/lso/search";
			String s = ApiHandler.getResponsePost(url, a.toString());
			try {
				output = new BufferedWriter(new FileWriter("c:/TEMP/cs.txt", true));
				output.newLine();
				Logger.info("input post 123"+a.toString());
				output.write(a.toString());
				output.newLine();
				Logger.info("output json 323::"+s);
				output.write(s);
				output.close();
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
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
		BufferedWriter output = null;
		try {
			a.put("q", "801 Rodeo");
			a.put("start", 0);
			a.put("end", 10);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/lso/search";
			s = ApiHandler.getResponsePost(url, a.toString());
			try {
				output = new BufferedWriter(new FileWriter("c:/TEMP/cs.txt", true));
				output.newLine();
				Logger.info("input post 123"+a.toString());
				output.write(a.toString());
				output.newLine();
				Logger.info("output json 323::"+s);
				output.write(s);
				output.close();
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
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
		BufferedWriter output = null;
		try {
			a.put("type", type);
			a.put("id", id);
			a.put("token", "1243dsf214124123123dscds");
			String url = Config.rooturl()+"/csapi/rest/lso/childrens";
			s = ApiHandler.getResponsePost(url, a.toString());
			try {
				output = new BufferedWriter(new FileWriter("c:/TEMP/cs.txt", true));
				output.newLine();
				Logger.info("input post 123"+a.toString());
				output.write(a.toString());
				output.newLine();
				Logger.info("output json 323::"+s);
				output.write(s);
				output.close();
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
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
	
}
