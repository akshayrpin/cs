<%@page import="alain.core.utils.Cartographer"%>
<%@page import="cs.address.*"%>
<% 
Cartographer map = new Cartographer(request,response,true);
out.write(AddressTest.checkQ(map.getString("q")));
%>
