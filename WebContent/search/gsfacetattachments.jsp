<%@page import="alain.core.utils.Config"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="org.json.JSONObject"%>
<%@page import="alain.core.utils.Cartographer"%>
<%

JSONObject o = new JSONObject();
JSONObject domain = new JSONObject();


JSONObject attachmenttype = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "attachmenttype");
attachmenttype.put("domain", domain);
attachmenttype.put("type", "terms");
attachmenttype.put("field", "attachmenttype");
attachmenttype.put("limit", -1);
attachmenttype.put("sort", "index");
//type.put("missing", true);

o.put("attachmenttype", attachmenttype);

JSONObject level = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "level");
level.put("type", "terms");
level.put("field", "level");
level.put("limit", -1);
level.put("domain", domain);
level.put("sort", "index");
o.put("level", level);






JSONObject online = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "online");
online.put("domain", domain);
online.put("type", "terms");
online.put("field", "online");
online.put("limit", -1);
//type.put("missing", true);

o.put("online", online);


JSONObject ext = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "ext");
ext.put("domain", domain);
ext.put("type", "terms");
ext.put("field", "ext");
ext.put("limit", -1);
//type.put("missing", true);

o.put("ext", ext);



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
