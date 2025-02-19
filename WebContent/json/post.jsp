<%@page import="alain.core.utils.Operator"%>
<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="csshared.vo.AvailabilityVO"%>
<%@page import="alain.core.utils.Logger"%>
<%@page import="cs.common.ApiHandler"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="alain.core.utils.Cartographer"%>
<% 
	Cartographer map = new Cartographer(request,response);
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	String group = map.getString(RequestMapper.group);
	String grouptype = map.getString(RequestMapper.grouptype);
	String id = map.getString(RequestMapper.id);
	String grpid = map.getString(RequestMapper.groupid);
	String reference = map.getString(RequestMapper.reference);

	String req = map.getString(RequestMapper.request);

	if (Operator.hasValue(req)) {
		RequestVO vo = new RequestVO();
		vo.setEntity(entity);
		vo.setType(type);
		vo.setTypeid(typeid);
		vo.setGroup(group);
		vo.setGrouptype(grouptype);
		vo.setId(id);
		vo.setGroupid(grpid);
		vo.setRequest(req);
		vo.setReference(reference);
		vo.setIp(map.getRemoteIp());
		vo.setToken(map.token());

		while (map.next()) {
			vo.addExtra(map.FIELD, map.VALUE);
		}

		String output = ApiHandler.post(vo);
		out.print(output);
	}

%>
