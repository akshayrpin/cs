<%@page import="cs.common.ApiHandler"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="alain.core.utils.Cartographer"%>
<%

Cartographer map = new Cartographer(request,response,true);
System.out.println("####"+map.getString("search"));


if (map.equalsIgnoreCase("_action", "parkingsearch")) {
	RequestVO vo = RequestMapper.getParkingRequest(map,"search");
	System.out.println(vo.getUrl());
	String resp = ApiHandler.post(vo);
	System.out.println("parking response "+resp);
	out.print(resp);
}



%>

