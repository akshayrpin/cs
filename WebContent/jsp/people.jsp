<%@page import="alain.core.utils.Cartographer"%><%
	Cartographer map = new Cartographer(request,response, true);
	out.print(map.getString("_cartsession"));
%>