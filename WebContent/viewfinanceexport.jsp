<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.OutputStreamWriter"%>
<%@page import="java.io.Writer"%>
<%@page import="java.io.OutputStream"%>
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
	nav.setEntity(map.getString("_ent","finance"));
	nav.setToken(map.token());
	nav.setType(map.getString("_type","finance"));
	nav.setTypeid(map.getInt("_typeid"));
	nav.setId(map.getString("_id"));
	nav.setIp(map.getRemoteIp());
	nav.setReference(map.getString("department"));
	nav.setStartdate(map.getString("START_DATE"));
	nav.setRequest("extractfinancerecords");	
	
	nav.setGrouptype("finance");
	
	String filename = "export.txt";
	response.setContentType("text/plain");
	response.setHeader("Content-Disposition", "attachment; filename="+filename);
	
	
	
	
	
	ResponseVO r = ApiHandler.getResponse(nav);
	String content = r.getProcessmessage();
	
	
	java.io.PrintWriter op = response.getWriter();
	op.write(content);
	op.close();

		
	
	
} catch(Exception e){}
%>
