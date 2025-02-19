<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="org.json.JSONObject"%>
<%@page import="alain.core.utils.Cartographer"%>
<%

JSONObject o = new JSONObject();
JSONObject domain = new JSONObject();



JSONObject review_group_name = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "review_group_name");
review_group_name.put("domain", domain);
review_group_name.put("type", "terms");
review_group_name.put("field", "review_group_name");
review_group_name.put("limit", -1);
//type.put("missing", true);
review_group_name.put("sort", "index");

o.put("review_group_name", review_group_name);

JSONObject review = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "review");
review.put("domain", domain);
review.put("type", "terms");
review.put("field", "review");
review.put("limit", -1);
//type.put("missing", true);
review.put("sort", "index");

o.put("review", review);

JSONObject review_status = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "review_status");
review_status.put("domain", domain);
review_status.put("type", "terms");
review_status.put("field", "review_status");
review_status.put("limit", -1);
//type.put("missing", true);
review_status.put("sort", "index");

o.put("review_status", review_status);


JSONObject assigned = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "assigned");
assigned.put("domain", domain);
assigned.put("type", "terms");
assigned.put("field", "assigned");
assigned.put("limit", -1);
//type.put("missing", true);
assigned.put("sort", "index");
o.put("assigned", assigned);



JSONObject activity_type = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "activity_type");
activity_type.put("domain", domain);
activity_type.put("type", "terms");
activity_type.put("field", "activity_type");
activity_type.put("limit", -1);
//type.put("missing", true);
activity_type.put("sort", "index");

o.put("activity_type", activity_type);

JSONObject activity_status = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "activity_status");
activity_status.put("type", "terms");
activity_status.put("field", "activity_status");
activity_status.put("limit", -1);
activity_status.put("domain", domain);
activity_status.put("sort", "index");

o.put("activity_status", activity_status);



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



JSONObject online = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "online");
online.put("domain", domain);
online.put("type", "terms");
online.put("field", "online");
online.put("limit", -1);
//type.put("missing", true);

o.put("online", online);


JSONObject curr_approved = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "curr_approved");
curr_approved.put("domain", domain);
curr_approved.put("type", "terms");
curr_approved.put("field", "curr_approved");
curr_approved.put("limit", -1);
//type.put("missing", true);

o.put("curr_approved", curr_approved);

JSONObject curr_unapproved = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "curr_unapproved");
curr_unapproved.put("domain", domain);
curr_unapproved.put("type", "terms");
curr_unapproved.put("field", "curr_unapproved");
curr_unapproved.put("limit", -1);
//type.put("missing", true);

o.put("curr_unapproved", curr_unapproved);


JSONObject curr_final = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "curr_final");
curr_final.put("domain", domain);
curr_final.put("type", "terms");
curr_final.put("field", "curr_final");
curr_final.put("limit", -1);
//type.put("missing", true);

o.put("curr_final", curr_final);





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

/*  JSONObject lsotype = new JSONObject();
 domain = new JSONObject();
 domain.put("excludeTags", "lso_type");
 lsotype.put("domain", domain);
 lsotype.put("type", "terms");
 lsotype.put("field", "lso_type");
 lsotype.put("limit", -1);
type.put("missing", true);

 o.put("lso_type", lsotype); */

/* JSONObject address = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "address");
address.put("domain", domain);
address.put("type", "terms");
address.put("field", "address");

//type.put("offset ", "21");

o.put("address", address); */

JSONObject review_status_expired = new JSONObject();
domain = new JSONObject();
domain.put("excludeTags", "review_status_expired");
review_status_expired.put("domain", domain);
review_status_expired.put("type", "terms");
review_status_expired.put("field", "review_status_expired");
review_status_expired.put("limit", -1);
//type.put("missing", true);

o.put("review_status_expired", review_status_expired);

String facets = StringEscapeUtils.escapeJava(o.toString());
//System.out.println("aa"+StringEscapeUtils.escapeJava(o.toString()));

%>
