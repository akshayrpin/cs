<%@page import="alain.core.utils.Operator"%><%@page import="csshared.utils.CsApi"%><%@page import="alain.core.security.Token"%><%@page import="alain.core.utils.Cartographer"%><%

	Cartographer map = new Cartographer(request,response);
	if (!Operator.hasValue(map.token()) || !Operator.hasValue(map.username())) {
		map.logout();
	}
 	String c = CsApi.content("lsosummary", map.token(), map.getRemoteIp());
 	out.print(c);


%>