<%@page import="cs.common.ApiHandler"%>
<%@page import="csshared.vo.SubObjVO"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="org.json.JSONArray"%>
<%@page import="cs.address.AddressTest"%>
<%@page import="org.json.JSONObject"%>
<%@page import="alain.core.utils.Cartographer"%>
<%@include file="search/gspeoplefacet.jsp"%>
<% 

Cartographer map = new Cartographer(request,response,true);
RequestVO req = RequestMapper.getRequest(map);
req.setRequest("notification");

SubObjVO[] choices = ApiHandler.getChoices(req);
if (choices.length > 0) {
	SubObjVO choice = choices[0];
	String content = choice.getAddldata().get("CONTENT");
	out.print(content);
}

%>















