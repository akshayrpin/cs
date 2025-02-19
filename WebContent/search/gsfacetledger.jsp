<%@page import="alain.core.utils.Config"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="org.json.JSONObject"%>
<%@page import="alain.core.utils.Cartographer"%>
<%

JSONObject o = new JSONObject();
JSONObject domain = new JSONObject();


/* JSONObject paymentcounter = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "paymentcounter");
paymentcounter.put("domain", domain);
paymentcounter.put("type", "terms");
paymentcounter.put("field", "paymentcounter");
paymentcounter.put("limit", -1);
paymentcounter.put("sort", "index");
//type.put("missing", true);

o.put("paymentcounter", paymentcounter); */

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


JSONObject fee_group = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "fee_group");
fee_group.put("domain", domain);
fee_group.put("type", "terms");
fee_group.put("field", "fee_group");
fee_group.put("limit", -1);
//type.put("missing", true);
fee_group.put("sort", "index");

o.put("fee_group", fee_group); 

JSONObject fee_name = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "fee_name");
fee_name.put("domain", domain);
fee_name.put("type", "terms");
fee_name.put("field", "fee_name");
fee_name.put("limit", -1);
//type.put("missing", true);
fee_name.put("sort", "index");

o.put("fee_name", fee_name); 


JSONObject key_code = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "key_code");
key_code.put("domain", domain);
key_code.put("type", "terms");
key_code.put("field", "key_code");
key_code.put("limit", -1);
//type.put("missing", true);
key_code.put("sort", "index");

//o.put("facet",fac);
o.put("key_code", key_code);

JSONObject fund = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "fund");
fund.put("domain", domain);
fund.put("type", "terms");
fund.put("field", "fund");
fund.put("limit", -1);
//type.put("missing", true);
fund.put("sort", "index");

o.put("fund", fund);

JSONObject budget_unit = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "budget_unit");
budget_unit.put("domain", domain);
budget_unit.put("type", "terms");
budget_unit.put("field", "budget_unit");
budget_unit.put("limit", -1);
//type.put("missing", true);
budget_unit.put("sort", "index");

o.put("budget_unit", budget_unit);


JSONObject account_number = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "account_number");
account_number.put("domain", domain);
account_number.put("type", "terms");
account_number.put("field", "account_number");
account_number.put("limit", -1);
//type.put("missing", true);
account_number.put("sort", "index");

o.put("account_number", account_number);


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

/* JSONObject fac = new JSONObject();
fac.put("x", "'sum(payment_amount)'");
fac.put("y", "'sum(fee_amount)'");
fac.put("z", "'sum(fee_paid)'");
o.append("x", fac.get("x")); */

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
