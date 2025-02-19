<%@page import="csshared.utils.CsApi"%><%@page import="csshared.vo.ResponseVO"%><%@page import="java.io.PrintStream"%><%@page import="java.nio.charset.Charset"%><%@page import="cs.utils.PrintPDF"%><%@page import="alain.core.utils.Operator"%><%@page import="alain.core.utils.Config"%><%@page import="csshared.vo.ToolsVO"%><%@page import="cs.utils.RequestMapper"%><%@page import="alain.core.utils.Logger"%><%@page import="cs.agent.UiAgent"%><%@page import="cs.utils.ObjUi"%><%@page import="csshared.vo.ObjGroupVO"%><%@page import="cs.common.ApiHandler"%><%@page import="csshared.vo.TypeVO"%><%@page import="csshared.vo.RequestVO"%><%@page import="alain.core.utils.Cartographer"%><%@ page import="java.io.ByteArrayOutputStream" %><%@page trimDirectiveWhitespaces="true" %><%

	Cartographer map = new Cartographer(request,response);
	ServletOutputStream s =  response.getOutputStream();
	try {
		String view = map.getString("view");
		if (Operator.equalsIgnoreCase(view, "thumb")) { view = "thumb"; }
		else if (Operator.equalsIgnoreCase(view, "pic")) { view = "pic"; }
		else if (Operator.equalsIgnoreCase(view, "rotate")) { view = "rotate"; }
		else { view = "slide"; }
		
		RequestVO nav = new RequestVO();
		nav.setEntity(map.getString("_ent","lso"));
		nav.setToken(map.token());
		nav.setIp(map.getRemoteIp());
		nav.setType(map.getString("_type","lso"));
		nav.setTypeid(map.getInt("_typeid"));
		nav.setId(map.getString("_id"));
		nav.setReference(map.getString("_reference"));
		if(Operator.hasValue(map.getString("request"))){
			nav.setRequest(map.getString("request"));
		}
		else {
			nav.setRequest("fileinfo");	
		}
		nav.setGrouptype("attachments");
		String subreq = map.getString("subrequest");
		nav.setSubrequest(subreq);
	
		out.clear();
		response.reset();
	
		ResponseVO r = CsApi.getResponse(nav);
		if(r.getFile().isShowbrowser()==true){
			response.flushBuffer();
		}
		int id = r.getFile().getId();
		response.setContentType(r.getFile().getContenttype());

		nav.setRequest(view);	
		nav.setSubrequest("");
		nav.setReference(r.getFile().getPath());
		nav.setId(Operator.toString(id));
		ByteArrayOutputStream o =  ApiHandler.postPdf(nav);
		if (o.size() < 1) {
			o.flush();
			o.close();
			s.flush();
			s.close();
			Logger.highlight(o.size());
			map.forward("/cs/images/image_placeholder.png");
		}
		else {
			s.write(o.toByteArray());
			o.flush();
			o.close();
			s.flush();
			s.close();
		    out = pageContext.pushBody();
		}
	}
	catch(Exception e){
		s.flush();
		s.close();
		map.forward("/images/image_placeholder.png");
	}



%>