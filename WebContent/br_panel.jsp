<%@page import="cs.agent.BrowserAgent"%><%@page import="alain.core.utils.Cartographer"%><%@page import="cs.address.*"%><% 
	Cartographer map = new Cartographer(request,response);
	if (map.hasValue("type")) {
		String r = BrowserAgent.panel(map);
		out.write(r);
	}
%>
