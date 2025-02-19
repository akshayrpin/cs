<%@page import="cs.common.ApiHandler"%>
<%@page import="alain.core.security.OauthUtils"%>
<%@page import="alain.core.utils.FileUtil"%>
<%@page import="alain.core.security.source.OauthLogin"%>
<%@page import="org.json.JSONObject"%>
<%@page import="alain.core.utils.Logger"%>
<%@page import="java.util.Enumeration"%>
<%@page import="csshared.utils.CsApi"%>
<%@page import="alain.core.security.Token"%>
<%@page import="alain.core.utils.Config"%><%@page import="alain.core.utils.Cartographer"%><%


	Cartographer map = new Cartographer(request, response,true);


	 if (map.isLoggedIn()) {
		map.redirect(Config.fullcontexturl());
	} 
	

%>

Welcome 























