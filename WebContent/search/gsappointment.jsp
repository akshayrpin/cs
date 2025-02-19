<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="org.json.JSONObject"%>
<%@page import="alain.core.utils.Cartographer"%>
<%

JSONObject o = new JSONObject();
JSONObject domain = new JSONObject();



JSONObject activitytype = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "activitytype");
activitytype.put("domain", domain);
activitytype.put("type", "terms");
activitytype.put("field", "activitytype");
activitytype.put("limit", -1);
//type.put("missing", true);
activitytype.put("sort", "index");

o.put("activitytype", activitytype);

JSONObject status = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "review_status");
status.put("type", "terms");
status.put("field", "review_status");
status.put("limit", -1);
status.put("domain", domain);
status.put("sort", "index");

o.put("review_status", status);




JSONObject inspector = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "inspector");
inspector.put("domain", domain);
inspector.put("type", "terms");
inspector.put("field", "inspector");
inspector.put("limit", -1);
inspector.put("sort", "index");
o.put("inspector", inspector);



JSONObject review = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "review");
review.put("domain", domain);
review.put("type", "terms");
review.put("field", "review");
review.put("limit", -1);
review.put("sort", "index");
o.put("review", review);


JSONObject complete = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "complete");
complete.put("domain", domain);
complete.put("type", "terms");
complete.put("field", "complete");
complete.put("limit", -1);
complete.put("sort", "index");
o.put("complete", complete);


/* JSONObject dt = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "start_date");
dt.put("domain", domain);
dt.put("type", "range");
dt.put("field", "start_date");
dt.put("limit", -1);
dt.put("sort", "index");
dt.put("start", "*");
dt.put("end", "*");
dt.put("gap", "1000");
o.put("start_date", dt); */




String facets = StringEscapeUtils.escapeJava(o.toString());
//System.out.println("aa"+StringEscapeUtils.escapeJava(o.toString()));

%>
