<%@page import="alain.core.utils.Cartographer"%>
<%@page import="cs.projects.*"%>
<% 
Cartographer map = new Cartographer(request,response,true);
out.write(Projects.childrens(map.getInt("id")));
%>
