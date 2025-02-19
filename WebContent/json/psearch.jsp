<%@page import="org.json.JSONObject"%><%@page import="alain.core.utils.Cartographer"%><%@page import="cs.utils.ObjTables"%><%

	Cartographer map = new Cartographer(request, response);
	JSONObject o = ObjTables.psearch(map.getString("s"), map.getString("q"), map.getInt("PAGE", 1), map.getInt("MAX", 25), map.token(), map.getRemoteIp());
	//JSONObject o = new JSONObject();
	//o.append("table", t);
	String json = o.toString();

%><%= json %>