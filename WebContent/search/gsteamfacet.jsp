<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="org.json.JSONObject"%>
<%

JSONObject o = new JSONObject();
JSONObject domain = new JSONObject();


JSONObject ptype = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "type");
ptype.put("domain", domain);
ptype.put("type", "terms");
ptype.put("field", "type");
ptype.put("limit", -1);
//type.put("missing", true);

o.put("type", ptype);

JSONObject department = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "department");
department.put("type", "terms");
department.put("field", "department");
department.put("limit", -1);
department.put("domain", domain);

o.put("department", department);





String facets = StringEscapeUtils.escapeJava(o.toString());
//System.out.println("aa"+StringEscapeUtils.escapeJava(o.toString()));

%>
