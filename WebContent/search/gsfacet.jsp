<%@page import="alain.core.utils.Config"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="org.json.JSONObject"%>
<%@page import="alain.core.utils.Cartographer"%>
<%

JSONObject o = new JSONObject();
JSONObject domain = new JSONObject();


JSONObject type = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "type");
type.put("domain", domain);
type.put("type", "terms");
type.put("field", "type");
type.put("limit", -1);
type.put("sort", "index");
//type.put("missing", true);

o.put("type", type);

JSONObject status = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "status");
status.put("type", "terms");
status.put("field", "status");
status.put("limit", -1);
status.put("domain", domain);
status.put("sort", "index");
o.put("status", status);



JSONObject divisions = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "divisions");
divisions.put("domain", domain);
divisions.put("type", "terms");
divisions.put("field", "divisions");
divisions.put("limit", -1);
//type.put("missing", true);
divisions.put("sort", "index");

o.put("divisions", divisions);

JSONObject department = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "department");
department.put("domain", domain);
department.put("type", "terms");
department.put("field", "department");
department.put("limit", -1);
//type.put("missing", true);
department.put("sort", "index");
o.put("department", department);


JSONObject online = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "online");
online.put("domain", domain);
online.put("type", "terms");
online.put("field", "online");
online.put("limit", -1);
//type.put("missing", true);

o.put("online", online);


JSONObject lsotype = new JSONObject();
 domain = new JSONObject();
 domain.put("excludeTags", "lso_type");
 lsotype.put("domain", domain);
 lsotype.put("type", "terms");
 lsotype.put("field", "lso_type");
 lsotype.put("limit", -1);
//type.put("missing", true);

 o.put("lso_type", lsotype);

/* JSONObject address = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "address");
address.put("domain", domain);
address.put("type", "terms");
address.put("field", "address");

//type.put("offset ", "21");

o.put("address", address); */

String facets = StringEscapeUtils.escapeJava(o.toString());
String hyperlinktable = Config.fullcontexturl()+"/?entity=lso&type=activity&reference=";
String hyperlinktablevalue = "act_nbr";
String tdefaults = "id,title,type,status,address,apn,description,updated";


%>
