<%@page import="alain.core.utils.Logger"%><%@page import="cs.utils.RequestMapper"%><%@page import="csshared.utils.CsConfig"%><%@page import="cs.common.ApiHandler"%><%@page import="alain.core.utils.Operator"%><%@page import="alain.core.utils.Cartographer"%><%

	Cartographer map = new Cartographer(request, response);

	StringBuilder sb = new StringBuilder();
	sb.append(Operator.removeTrailingSlash(CsConfig.getDomain(map.getString(RequestMapper.entity))));
	sb.append("/");
	sb.append(Operator.removeOpeningAndTrailingSlash(CsConfig.getApiPath()));
	sb.append("/log/get");
	String url = sb.toString();

	sb = new StringBuilder();
	sb.append(" { ");
	sb.append(" \"id\": \"").append(map.getString("_id")).append("\" ");
	sb.append(" } ");

	String json = ApiHandler.post(url, sb.toString());

%><%= json %>