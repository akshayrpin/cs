<%@page import="alain.core.utils.Logger"%>
<%@page import="csshared.vo.RequestVO"%><%@page import="csshared.vo.SubObjVO"%><%@page import="cs.common.ApiHandler"%><%@page import="cs.utils.RequestMapper"%><%@page import="alain.core.utils.Cartographer"%><% 
	Cartographer map = new Cartographer(request,response,true);
	String entity = map.getString(RequestMapper.entity);
	int entityid = map.getInt(RequestMapper.entityid);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	String grptype = map.getString(RequestMapper.grouptype);
	String res = "";
	if (map.hasValue("q")) {
		RequestVO req = new RequestVO();
		req.setEntity(entity);
		req.setEntityid(entityid);
		req.setType(type);
		req.setTypeid(typeid);
		req.setGrouptype(grptype);
		req.setRequest("search");
		req.setSearch(map.getString("q"));
		req.setOption(map.getString("t"));
		res = ApiHandler.post(req);
	}
	out.print(res);
%>