<%@page import="alain.core.utils.Operator"%>
<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="csshared.vo.AvailabilityVO"%>
<%@page import="alain.core.utils.Logger"%>
<%@page import="cs.common.ApiHandler"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="alain.core.utils.Cartographer"%>
<% 
	Cartographer map = new Cartographer(request,response,true);
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);

	int appttypeid = map.getInt(RequestMapper.appttypeid);
	int apptsubtypeid = map.getInt(RequestMapper.apptsubtypeid);
	String ref = map.getString(RequestMapper.reference);

	String start = map.getString(RequestMapper.startdate);
	String end = map.getString(RequestMapper.enddate);
	int days = map.getInt(RequestMapper.end);

	Timekeeper s = new Timekeeper();
	if (Operator.hasValue(start)) {
		s.setDate(start);
	}
	Timekeeper e = s.copy();
	if (Operator.hasValue(end)) {
		e.setDate(end);
	}
	else if (days > 0) {
		e.addDay(days);
	}


	RequestVO vo = new RequestVO();
	vo.setEntity(entity);
	vo.setType(type);
	vo.setTypeid(typeid);
	vo.setGrouptype("appointment");
	vo.setRequest("availability");
	vo.setStartdate(s.getString("DATECODE"));
	vo.setEnddate(e.getString("DATECODE"));
	vo.setAppttypeid(appttypeid);
	vo.setApptsubtypeid(apptsubtypeid);
	vo.setReference(ref);

	Logger.highlight(vo.getUrl());
	AvailabilityVO a = ApiHandler.getAvailability(vo);

	out.print(a.toString());

%>
