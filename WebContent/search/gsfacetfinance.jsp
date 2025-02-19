<%@page import="alain.core.utils.Config"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="org.json.JSONObject"%>
<%@page import="alain.core.utils.Cartographer"%>
<%

JSONObject o = new JSONObject();
JSONObject domain = new JSONObject();


JSONObject paymentcounter = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "paymentcounter");
paymentcounter.put("domain", domain);
paymentcounter.put("type", "terms");
paymentcounter.put("field", "paymentcounter");
paymentcounter.put("limit", -1);
paymentcounter.put("sort", "index");
//type.put("missing", true);

o.put("paymentcounter", paymentcounter);

JSONObject method = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "method");
method.put("type", "terms");
method.put("field", "method");
method.put("limit", -1);
method.put("domain", domain);
method.put("sort", "index");
o.put("method", method);



JSONObject transactiontype = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "transactiontype");
transactiontype.put("domain", domain);
transactiontype.put("type", "terms");
transactiontype.put("field", "transactiontype");
transactiontype.put("limit", -1);
//type.put("missing", true);
transactiontype.put("sort", "index");

o.put("transactiontype", transactiontype);

JSONObject cashier = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "cashier");
cashier.put("domain", domain);
cashier.put("type", "terms");
cashier.put("field", "cashier");
cashier.put("limit", -1);
//type.put("missing", true);
cashier.put("sort", "index");
o.put("cashier", cashier);


JSONObject online = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "online");
online.put("domain", domain);
online.put("type", "terms");
online.put("field", "online");
online.put("limit", -1);
//type.put("missing", true);

o.put("online", online);





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
