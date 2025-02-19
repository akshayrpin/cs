<%@page import="cs.address.MergeDocs"%>
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
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>

<!--sunil  -->
<%
try{
	Cartographer map = new Cartographer(request,response);
		
	
	out.clear();
	response.reset();
	
	
	//ResponseVO r = ApiHandler.getResponse(nav);
	//if(r.getFile().isShowbrowser()==true){
		response.flushBuffer();
	//}
	String random = Operator.randomString(5);
	String filename = "fileszipped_"+random+".zip";
	Logger.highlight(filename);
	response.setContentType("application/pdf");
	response.setHeader("Content-Disposition", "attachment; filename="+filename);
	
	
	
	ServletOutputStream s =  response.getOutputStream();
	
	ByteArrayOutputStream o =  MergeDocs.zipDocuments(map.getString("chk",""));
			
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
