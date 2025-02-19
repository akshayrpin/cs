<%@page import="java.util.Map"%><%@page import="java.util.Enumeration"%><%@page import="alain.core.utils.Cartographer"%><%@page import="cs.agent.*"%><% 

	Cartographer map = new Cartographer(request, response);
	out.write(BrowserAgent.panels(map));


%>
