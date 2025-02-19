<%@page import="alain.core.security.Token"%>
<%@page import="csshared.utils.CsApi"%>
<%@page import="alain.core.utils.Cartographer"%><%@page import="alain.core.utils.Config"%><%@page import="cs.agent.UiAgent"%><%

	Cartographer map = new Cartographer(request, response);
Token u = CsApi.getToken(map.token(),map.getRemoteIp());

%>{

	"panels": {
		"menu": {
			"url": "<%=Config.fullcontexturl() %>/json/menu.jsp"
		},
		"main": {
		},
		"sub": {
		},
		"link": {
		}
	},
	"root": [
	<%= UiAgent.menu(map.token(), map.getRemoteIp()) %>
	]


}
