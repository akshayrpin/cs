<%@page import="java.io.InputStream"%>
<%@page import="org.apache.http.HttpEntity"%>
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="com.fasterxml.jackson.databind.ObjectWriter"%>
<%@page import="org.apache.http.impl.client.DefaultHttpClient"%>
<%@page import="org.apache.http.entity.StringEntity"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="org.apache.catalina.WebResource"%>
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
	nav.setToken(map.token());
	nav.setType(map.getString("_type","lso"));
	nav.setTypeid(map.getInt("_typeid"));
	nav.setId(map.getString("_id"));
	nav.setReference(map.getString("_reference"));
	if(Operator.hasValue(map.getString("request"))){
		nav.setRequest(map.getString("request"));
	}else {
		nav.setRequest("viewer");	
	}
	nav.setGrouptype("attachments");
	byte[] b = new byte[500];
	ByteArrayOutputStream o = new ByteArrayOutputStream();
	try {
		HttpClient c = new DefaultHttpClient();
		HttpPost p = new HttpPost(nav.getUrl());
		ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
		String json = ow.writeValueAsString(nav);
		
		StringEntity input = new StringEntity(json);
		input.setContentType("application/json");
		p.setEntity(input);

		HttpResponse r = c.execute(p);
		HttpEntity entity = r.getEntity();
		String contentType = "";

		if (entity != null) {
			InputStream is = entity.getContent();
			
			for(int lengthread = 0; (lengthread = is.read(b)) != -1;){
				o.write(b, 0, lengthread);
			
			}
		
			is.close();
		}
		
		out.clear();
		response.reset();
		System.out.println(r.getFirstHeader("Content-Type").getValue());
		System.out.println(r.getFirstHeader("Content-Disposition").getValue());
		response.setContentType(r.getFirstHeader("Content-Type").getValue());
		response.setHeader("Content-Disposition", r.getFirstHeader("Content-Disposition").getValue());
		
		ServletOutputStream s =  response.getOutputStream();
	

		s.write(o.toByteArray());
		
		s.close();
		
	}
	
	catch (Exception e) { }


} catch(Exception e){}
%>
