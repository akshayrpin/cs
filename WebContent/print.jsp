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
	nav.setEntity(map.getString("_ent"));
//	nav.setToken(map.filetoken());
	nav.setType(map.getString("_type"));
	nav.setTypeid(map.getInt("_typeid"));
	nav.setGroup(map.getString("_grp"));
	nav.setGroupid(map.getString("_grpid"));
	nav.setId(map.getString("_id"));
	nav.setReference(map.getString("_reference"));
	nav.setRef(map.getString("_ref"));
	nav.setSubrequest(map.getString("subrequest"));
	if(Operator.hasValue(map.getString("request"))){
		nav.setRequest(map.getString("request"));
	}else {
		nav.setRequest("details");	
	}
	nav.setGrouptype("print");
	
	String filename = map.getInt("_typeid")+"_SUNIl";
	
	out.clear();
	response.reset();
	response.flushBuffer();
	response.setContentType("application/pdf");
	response.setHeader("Content-Disposition", "attachment;filename="+filename+".pdf");
	
	ServletOutputStream s =  response.getOutputStream();
	ByteArrayOutputStream o = ApiHandler.postPdf(nav);
	s.write(o.toByteArray());
	o.flush();
	o.close();
	s.flush();
	s.close();

} catch(Exception e){}
%>
