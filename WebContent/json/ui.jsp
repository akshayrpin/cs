<%@page import="csshared.utils.CsApi"%><%@page import="alain.core.utils.Logger"%><%@page import="org.json.JSONObject"%><%@page import="cs.ui.CsUi"%><%@page import="csshared.vo.ObjGroupVO"%><%@page import="cs.utils.RequestMapper"%><%@page import="csshared.vo.RequestVO"%><%@page import="alain.core.utils.Cartographer"%><%

	Cartographer map = new Cartographer(request, response);
	RequestVO r = RequestMapper.getRequest(map);
	String style = map.getString("style");
	String option = map.getString("option");
	String alert = map.getString("alert");
	r.setOption(option);
	
	
	RequestVO req = r.duplicate();
	req.setGroup("");
	req.setRequest("");
	ObjGroupVO[] groups = new ObjGroupVO[0];
	String table = "";
	String error = "";
	try {
		groups = CsApi.getGroupsOrErrorTwice(r);
		if (r.getRequest().equalsIgnoreCase("info")) {
			table = CsUi.info(req, groups, style, alert);
		}
		else if (r.getRequest().equalsIgnoreCase("id")) {
			table = CsUi.id(req, groups, style, alert);
		}
		else {
			table = CsUi.summary(req, groups, style, alert);
		}
	}
	catch (Exception e) {
		table = "";
		error = "Unable to access";
	}
	JSONObject o = new JSONObject();
	o.put("table", table);
	o.put("module", r.getGroup());
	o.put("error", error);
	String json = o.toString();

%><%= json %>