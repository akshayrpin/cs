<%@page import="alain.core.utils.Logger"%><%@page import="alain.core.utils.Operator"%><%@page import="cs.agent.BrowserAgent"%><%@page import="alain.core.utils.Cartographer"%><%@page import="cs.address.*"%><% 
	Cartographer map = new Cartographer(request,response);
	String type = map.getString("child");
	if (!Operator.hasValue(type)) { type = map.getString("type"); }
	map.set("type", type);
	String r = BrowserAgent.panel(map);
	out.write(r);
%>
