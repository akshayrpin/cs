<%@page import="cs.utils.RequestMapper"%><%@page import="alain.core.utils.Cartographer"%><%@page import="csshared.utils.CsApi"%><%

	Cartographer map = new Cartographer(request, response);
	String entity = map.getString(RequestMapper.entity);
	String json = CsApi.token(map.token(), map.getRemoteIp());

%><%= json %>