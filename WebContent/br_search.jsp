<%@page import="csshared.utils.CsConfig"%>
<%@page import="cs.search.GlobalSearch"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.Map"%><%@page import="java.util.Enumeration"%><%@page import="alain.core.utils.Cartographer"%><%@page import="cs.agent.*"%><% 

	Cartographer map = new Cartographer(request, response);
	System.out.println(map.getString("search"));
	System.out.println(map.getString("grouptype"));
	System.out.println(map.getString("type"));
	System.out.println(map.getInt("typeid"));
	System.out.println(map.getString("entity"));
	
	/* JSONObject s = new JSONObject(); 
	s.remove("root");
	map.setString("q", map.getString("search"));
	map.setString("_url", CsConfig.getString("search.address_lso"));
	map.setString("start", "0");
	map.setString("rows", "1000");
	String resp = GlobalSearch.search(map); */
	
	out.write(BrowserAgent.search(map));


%>
