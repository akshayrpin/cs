<%@page import="cs.ui.CsUiTools"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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

Cartographer map = new Cartographer(request,response);
boolean multiple = true;
ResponseVO r = new ResponseVO();
String type = map.getString("_type");
String typeIds = map.getString("_typeid");
String ids = map.getString("_id");
String subrequest = map.getString("subrequest");
String grp = map.getString("_grp");
String grpid = map.getString("_grpid");
try {
		
	RequestVO nav = new RequestVO();
	nav.setEntity(map.getString("_ent"));
	nav.setToken(map.token());
	nav.setType(map.getString("_type"));
	nav.setTypeid(map.getInt("_typeid"));
	nav.setId(map.getString("_id"));
	nav.setReference(map.getString("_reference"));
	
	nav.setGrouptype("print");
	nav.setGroup(map.getString("_grp"));
	nav.setGroupid(map.getString("_grpid"));
	nav.setRequest("gettemplates");
	nav.setSubrequest(subrequest);	
	r = ApiHandler.getResponse(nav);
	
	if(type.equalsIgnoreCase("templatetype")){
		if(nav.getGroup().equalsIgnoreCase("batch")){
			type = "project";
		}else
			type = nav.getGroup();
	
		ids = map.getString("chk");
	}
	
	
} catch(Exception e){}



%>
<html>
	<head>
	
		<%= CsUiTools.getHTMLImports() %>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
		<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/ioscheckboxes/assets/css/mobileCheckbox.iOS.css">
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css">
		
	
		<style>
			.csui_controls { visibility: hidden }
		</style>
	
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/toggleswitch/tinytools.toggleswitch.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/tinymce/js/tinymce/jquery.tinymce.min.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/tinymce/js/tinymce/tinymce.min.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/inputmask.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/jquery.inputmask.js"></script>
		
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/ioscheckboxes/assets/js/jquery.mobileCheckbox.js"></script>
		
	 	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
	    <script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
		<script type="text/javascript">
		
		
		function viewprint(){
			<%if(!multiple){ %>
				window.open("print.jsp?_ent=<%=map.getString("_ent") %>&_entid=-1&_type=<%=type %>&_typeid=<%=typeIds %>&_grptype=print&_act=print","_blank");
				parent.$.fancybox.close();
			
			<%} %>
		}
		
		
		
		function openexport(){
			parent.openexport();
		}
		</script>
	</head>
<body >

<%if(multiple){ %>



	<div class="csui_divider"></div>
						<!-- List TEMPLATES-->
					 <table class="csui_title" alert="warning">
							<tr>
								<td class="csui_title">PRINT</td>
								
							</tr>
						</table>
					
					<table class="csui" type="horizontal">
							
							
							 <thead>
								<tr>
									<td class="csui_header">TEMPLATE</td>
									<td class="csui_header">EMAIL</td>
									<td class="csui_header">PRINT</td>
								</tr>
							</thead>
							 <tbody>
							 	
								<%
									for (Map.Entry<String, String> entry : r.getInfo().entrySet()) {
										String t = type;
										String tid = typeIds;
										String n = entry.getValue();
										if (Operator.hasValue(r.map(entry.getKey(), "TYPE"))) {
											t = r.map(entry.getKey(), "TYPE");
											tid = r.map(entry.getKey(), "TYPE_ID");
											n = r.map(entry.getKey(), "TEMPLATE");
										}
								%>
								<tr id="tr_">
									<td class="csui"><%=entry.getValue() %></td>
									
									<td class="csui" width="1%">
										<a  href="email.jsp?_ent=<%=map.getString("_ent") %>&_entid=-1&_type=<%=t %>&_typeid=<%=tid %>&_id=<%=ids %>&_grptype=email&_act=email&_reference=<%=entry.getKey() %>" title="E-mail" border="0"  target="lightbox-iframe"  ><img src="/cs/images/icons/controls/black/email.png" border="0"></a>
									</td>
									<td class="csui" width="1%">
										<a  href="print.jsp?_ent=<%=map.getString("_ent") %>&_entid=-1&_type=<%=t %>&_typeid=<%=tid %>&_grp=<%=grp %>&_grpid=<%=grpid %>&_id=<%=ids %>&_grptype=print&_act=print&_reference=<%=entry.getKey() %>&subrequest=<%=subrequest%>" title="Print" border="0"  target="_blank" onclick="close();" ><img src="/cs/images/icons/controls/black/print.png" border="0"></a>
									</td>
									
								</tr>
								<% } %>
							</tbody>
						</table>
						
						
						
							 	


<%}%>
</body>


