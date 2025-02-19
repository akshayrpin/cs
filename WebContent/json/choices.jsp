<%@page import="alain.core.utils.Logger"%><%@page import="cs.utils.RequestMapper"%><%@page import="csshared.utils.CsConfig"%><%@page import="cs.common.ApiHandler"%><%@page import="alain.core.utils.Operator"%><%@page import="alain.core.utils.Cartographer"%><%

	Cartographer map = new Cartographer(request, response);

	StringBuilder sb = new StringBuilder();
	sb.append(Operator.removeTrailingSlash(CsConfig.getDomain(map.getString(RequestMapper.entity))));
	sb.append("/");
	sb.append(Operator.removeOpeningAndTrailingSlash(CsConfig.getApiPath()));
	sb.append("/");
	if (map.hasValue(RequestMapper.grouptype)) {
		sb.append(Operator.urlFriendly(map.getString(RequestMapper.grouptype)));
	}
	else {
		sb.append(Operator.urlFriendly(map.getString("_type")));
	}
	sb.append("/");
	sb.append(Operator.urlFriendly(map.getString("_request")));
	String url = sb.toString();

	sb = new StringBuilder();
	sb.append(" { ");
	sb.append(" \"id\": \"").append(map.getString("_id")).append("\" ");
	sb.append(" , ");
	sb.append(" \"type\": \"").append(map.getString(RequestMapper.type)).append("\" ");
	sb.append(" , ");
	sb.append(" \"typeid\": \"").append(map.getInt(RequestMapper.typeid)).append("\" ");
	sb.append(" , ");
	sb.append(" \"appttypeid\": \"").append(map.getInt(RequestMapper.appttypeid, 0)).append("\" ");
	sb.append(" , ");
	sb.append(" \"reviewrefid\": \"").append(map.getInt(RequestMapper.reviewrefid, 0)).append("\" ");
	sb.append(" } ");

	String json = ApiHandler.post(url, sb.toString());

%><%= json %>