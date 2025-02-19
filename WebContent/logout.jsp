<%@page import="alain.core.security.OauthUtils"%>
<%@page import="alain.core.utils.Config"%><%@page import="alain.core.utils.Cartographer"%><%

	Cartographer map = new Cartographer(request, response);
	map.logout();
	if(!OauthUtils.isOauth()){
		map.redirect(Config.fullcontexturl());
	}
%>




























