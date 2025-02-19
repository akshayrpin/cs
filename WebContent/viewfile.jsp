<%@page import="csshared.vo.ResponseVO"%>
<%@page import="java.io.PrintStream"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="cs.utils.PrintPDF"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="csshared.vo.ToolsVO"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="alain.core.utils.Logger"%>
<%@page import="cs.agent.UiAgent"%>
<%@page import="cs.utils.ObjUi"%>
<%@page import="csshared.vo.ObjGroupVO"%>
<%@page import="cs.common.ApiHandler"%>
<%@page import="csshared.vo.TypeVO"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="alain.core.utils.Cartographer"%>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@page trimDirectiveWhitespaces="true" %> 
<!--sunil  -->
<%
try{
	Cartographer map = new Cartographer(request,response);
	
	RequestVO nav = new RequestVO();
	nav.setEntity(map.getString("_ent","lso"));
	String token = map.token();
	String ip = map.getRemoteIp();
	nav.setToken(token);
	nav.setIp(ip);
	nav.setType(map.getString("_type","lso"));
	nav.setTypeid(map.getInt("_typeid"));
	nav.setId(map.getString("_id"));
	nav.setReference(map.getString("_reference"));
	if(Operator.hasValue(map.getString("request"))){
		nav.setRequest(map.getString("request"));
	}else {
		nav.setRequest("fileinfo");	
	}
	nav.setGrouptype("attachments");
	String subreq = map.getString("subrequest");
	nav.setSubrequest(subreq);
	
	
	
	out.clear();
	response.reset();
	
	
	ResponseVO r = ApiHandler.getResponse(nav);
	if(r.getFile().isShowbrowser()==true){
		response.flushBuffer();
	}
	String filename = r.getFile().getFilename()+"."+r.getFile().getExtension();
	Logger.highlight(filename);
	response.setContentType(r.getFile().getContenttype());
	response.setHeader("Content-Disposition", "attachment; filename="+filename);
	
	
	
	ServletOutputStream s =  response.getOutputStream();
	nav.setRequest("view");	
	nav.setSubrequest("");
	nav.setToken(token);
	nav.setIp(ip);
	nav.setReference(r.getFile().getPath());
	ByteArrayOutputStream o =  ApiHandler.postPdf(nav);
	s.write(o.toByteArray());
	o.flush();
	o.close();
	s.flush();
	s.close();
    out = pageContext.pushBody();
} catch(Exception e){
	Logger.error(e);
}
%>
