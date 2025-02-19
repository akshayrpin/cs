<%@page import="alain.core.utils.Operator"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="cs.utils.Cart"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="cs.common.ApiHandler"%><%@page import="csshared.vo.RequestVO"%><%@page import="cs.utils.RequestMapper"%><%@page import="alain.core.utils.Cartographer"%><%

	String resp = "";
	Cartographer map = new Cartographer(request, response, true);

	if (!map.hasValue(RequestMapper.grouptype)) {
		resp = "API is a required field.";
	}
	else if (!map.hasValue("u")) {
		resp = "Username is a required field";
	}
	else if (!map.hasValue("request")) {
		resp = "Request is a required field";
	}
	else if (!map.hasValue("action")) {
		resp = "Unknown action";
	}
	else {
		RequestVO vo = RequestMapper.getRequest(map);
		if (!Operator.hasValue(vo.getType())) {
			vo.setType(vo.getGrouptype());
		}
		vo.setUsername(map.getString("u"));
		vo.setRequest(map.getString("request"));
		if (map.equalsIgnoreCase("action", "request")) {
//			resp = vo.simpleJson();
		}
		else if (map.equalsIgnoreCase("action", "url")) {
			resp = vo.getUrl();
		}
		else if (map.equalsIgnoreCase("action", "response")) {
			resp = ApiHandler.post(vo);
		}
	}
	out.print(resp);


%>
