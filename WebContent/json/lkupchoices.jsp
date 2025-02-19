<%@page import="cs.utils.RequestMapper"%><%@page import="alain.core.utils.Config"%><%@page import="org.json.JSONObject"%><%@page import="csshared.utils.CsConfig"%><%@page import="cs.common.ApiHandler"%><%@page import="alain.core.utils.Operator"%><%@page import="alain.core.utils.Cartographer"%><%

	Cartographer map = new Cartographer(request, response);
	JSONObject o = new JSONObject();
	o.put("command",map.getString("command"));
	o.put("table",map.getString("table"));
	o.put("column",map.getString("column"));
	o.put("orderField",map.getString("orderField"));
	o.put("orderType",map.getString("orderType"));
	o.put("filterColumn",map.getString("filterColumn"));
	o.put("filterValue",map.getString("filterValue"));
	o.put("filterValues",map.getString("filterValues"));
	o.put("selected",map.getString("selected"));
	
	String entity = map.getString(RequestMapper.entity);
	String domain = CsConfig.getDomain(entity);

	StringBuilder sb = new StringBuilder();
	sb.append(Config.rooturl()).append("/csapi/rest/general/choices");
	String url = sb.toString();

	String json = ApiHandler.post(url, o.toString());

%><%= json %>