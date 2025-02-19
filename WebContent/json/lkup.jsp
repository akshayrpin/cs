<%@page import="alain.core.utils.Logger"%>
<%@page import="cs.utils.RequestMapper"%><%@page import="cs.common.ApiHandler"%><%@page import="alain.core.utils.Cartographer"%><%

	Cartographer map = new Cartographer(request, response);
	String json = ApiHandler.getLkup(map.getString("lkup"), map.getString(RequestMapper.entity), map.getString(RequestMapper.type), map.getInt(RequestMapper.typeid), map.getString(RequestMapper.group), map.getString(RequestMapper.groupid), map.getString(RequestMapper.grouptype), map.getInt(RequestMapper.id));

%><%= json %>