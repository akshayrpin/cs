<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.vo.InspectionStatisticsVO"%>
<%@page import="csshared.vo.InspectionStatisticsList"%>
<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="java.util.ArrayList"%>
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
InspectionStatisticsList r = new InspectionStatisticsList();
Timekeeper k = new Timekeeper();
String d = k.getString("YYYY/MM/DD");
RequestVO nav = RequestMapper.getRequest(map);

if(map.equalsIgnoreCase("EXECUTE", "STATLIST")){
	d = map.getString("START_DATE");
}

nav.setStartdate(d);

r = ApiHandler.getInspectionStatistics(nav);
ArrayList<InspectionStatisticsVO> ins = r.getList();

	


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
		
		
		
		</script>
	</head>
<body >

<div id="csuibody">
		<div id="csuimain">

<div class="csuicontent">
				<form id="appointmentstatistics" action="appointmentstatistics.jsp" method="get">
				<input type="hidden" name="_grpid" value="<%=nav.getGroupid()%>">
				<input type="hidden" name="_grp" value="<%=nav.getGroup()%>">
				<input type="hidden" name="_grptype" value="<%=nav.getGroup()%>">
				<input type="hidden" name="_type" value="<%=nav.getType()%>">
				<input type="hidden" name="_typeid" value="<%=nav.getTypeid()%>">
				<input type="hidden" name="_id" value="<%=nav.getId()%>">
				<input type="hidden" name="_ent" value="<%=nav.getEntity()%>">
				<input type="hidden" name="EXECUTE" value="STATLIST">
				 <table class="csui_title" alert="warning">
					<tr>
						<td class="csui_title">DATE</td>
						
					</tr>
				</table>
				<table class="csui" colnum="2" type="default">
					<tr>
						<td class="csui_label" style="width: 1%" nowrap>FROM DATE</td>
						<td class="csui">
							<input name="START_DATE" type="text" itype="date" id="START_DATE" value="<%=d%>" >
							&nbsp; <input type="submit" name="action" value="Refresh" class="csui_button">
						</td>
					</tr>
				</table>
				</form>
			

	<div class="csui_divider"></div>
						
					 <table class="csui_title" alert="warning">
							<tr>
								<td class="csui_title">STATISTICS</td>
								
							</tr>
						</table>
					
					<table class="csui" type="horizontal">
							
							
							 <thead>
								<tr>
									
									<td class="csui_header" style="width: 100px; text-align: left">TYPE</td>
									<td class="csui_header">AVAILABILITY</td>
									<td class="csui_header" style="width: 100px; text-align: left">DATE</td>
									<td class="csui_header" style="width: 50px; text-align: center">SEATS AVAILABLE</td>
									<td class="csui_header" style="width: 50px; text-align: center">TOTAL RESERVATIONS</td>
									<td class="csui_header" style="width: 50px; text-align: center">MANUAL</td>
									<td class="csui_header" style="width: 50px; text-align: center">ONLINE</td>
									<td class="csui_header" style="width: 50px; text-align: center">IVR</td>
								</tr>
							</thead>
							 <tbody>
							 	
								<%
								for (int i=0; i<ins.size(); i++) {
									InspectionStatisticsVO vo = ins.get(i);
								%>
								<tr id="tr_">
									<td class="csui" style="width: 100px; text-align: left" nowrap><%= vo.getType() %></td>
									<td class="csui"><%= vo.getAvailability() %></td>
									<td class="csui" style="width: 100px; text-align: left" nowrap><%= vo.getDate() %></td>
									<td class="csui" style="width: 50px; text-align: right" nowrap><%= vo.getTotalSeats() %></td>
									<td class="csui" style="width: 50px; text-align: right" nowrap><%= vo.getTotal() %></td>
									<td class="csui" style="width: 50px; text-align: right" nowrap><%= vo.getSource("MANUAL") %></td>
									<td class="csui" style="width: 50px; text-align: right" nowrap><%= vo.getSource("ONLINE") %></td>
									<td class="csui" style="width: 50px; text-align: right" nowrap><%= vo.getSource("IVR") %></td>
									
								</tr>
							<%} %>
							</tbody>
						</table>
						
	</div>
	</div>
	</div>					
						
							 	



</body>


