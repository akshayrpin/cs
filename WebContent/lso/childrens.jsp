<%@page import="alain.core.utils.Cartographer"%>
<%@page import="cs.address.*"%>
<% 
Cartographer map = new Cartographer(request,response,true);
out.write(Address.children(map.getInt("id")));
%>
