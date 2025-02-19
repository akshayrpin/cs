<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.vo.AppointmentScheduleVO"%>
<%@page import="csshared.vo.AppointmentVO"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="alain.core.utils.Logger"%>
<%@page import="csshared.utils.ObjMapper"%>
<%@page import="csshared.vo.ObjVO"%>
<%@page import="java.util.HashMap"%>
<%@page import="csshared.vo.SubObjVO"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="cs.utils.ObjUi"%>
<%@page import="csshared.vo.ObjGroupVO"%>
<%@page import="cs.common.ApiHandler"%>
<%@page import="csshared.vo.TypeVO"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="alain.core.utils.Cartographer"%>
<%

	Cartographer map = new Cartographer(request,response);
	RequestVO req = RequestMapper.getRequest(map);

	RequestVO nav = req.duplicate();
	nav.setGrouptype("appointment");
	nav.setRequest("details");

	TypeVO o = ApiHandler.getType(nav);
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	int id = map.getInt(RequestMapper.id);
	String groupid = map.getString(RequestMapper.groupid);
	String grouptype = "appointment";

	String alert = o.getAlert();

	AppointmentVO appt = o.getFirstGroup().getFirstAppointment();
	AppointmentScheduleVO schedule = appt.getFirstSchedule();
	

	RequestVO creq = req.duplicate();
	creq.setGrouptype("appointment");
	creq.setRequest("collaborators");
	SubObjVO[] collaborators = ApiHandler.getChoices(creq);

 	RequestVO tmreq = req.duplicate();
 	tmreq.setGrouptype("appointment");
 	tmreq.setRequest("team");
 	SubObjVO[] team = ApiHandler.getChoices(tmreq);

%><html>
<head>
	<%= CsUiTools.getHTMLImports() %>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/ioscheckboxes/assets/css/mobileCheckbox.iOS.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
	
	<style>
		.csui_controls { visibility: hidden }
		table[itype=people] tr:nth-child(even), table[itype=team] tr:nth-child(even) {
			background-color: #f2f2f2;
		}
	</style>
	<script>
	var entity = '<%= entity %>';
	var type = '<%= type %>';
	var typeid = '<%= typeid %>';
	var groupid = '<%= groupid %>';
	var grouptype = '<%=grouptype%>';
	var fullcontexturl = '<%=Config.fullcontexturl()%>';
		
	</script>

	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.appt.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/toggleswitch/tinytools.toggleswitch.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/jquery.tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/inputmask.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/jquery.inputmask.js"></script>
	
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/ioscheckboxes/assets/js/jquery.mobileCheckbox.js"></script>
	
 	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>

</head>
<body>

	<div id="fullpage">
	<div id="loader"></div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
				<table cellpadding="10" cellspacing="0" border="0" width="100%">
					<tr>
						<td align="left" id="title"><%= title %></td>
						<td align="right" id="subtitle"><%= subtitle %></td>
					</tr>
				</table>
				<div id="csform_message"></div>

					<table class="csui_title csuialert" alert="<%=alert%>">
						<tr>
							<td class="csui_title"><a href="<%= Config.fullcontexturl() %>/list.jsp?_id=&_entid=-1&_ent=<%= o.getEntity() %>&_typeid=<%= o.getTypeid() %>&_type=<%= o.getType() %>&_grpid=appointment&_grp=appointment&_grptype=appointment" class="csui_title">appointment</a></td>
							<td class="csui_controls"><a href="<%= Config.fullcontexturl() %>/appointment.jsp?_id=&_entid=-1&_ent=<%= o.getEntity() %>&_typeid=<%= o.getTypeid() %>&_type=<%= o.getType() %>&_grpid=appointment&_grp=appointment&_grptype=appointment" class="csui_controls"><img src="<%= Config.fullcontexturl() %>/images/icons/controls/white/edit.png" width="20" height="20" border="0"/></a></td>
						</tr>
					</table>
					<table class="csui" type="default">
						<tr>
							<td class="csui_label">APPOINTMENT TYPE</td>
							<td class="csui vertical csui_field" type="String" itype="appointment">
								<%= appt.getAppttype() %>
							</td>

							<td class="csui_label">SUBJECT</td>
							<td class="csui vertical csui_field" type="String" itype="text">
								<%= appt.getSubject() %>
							</td>
						</tr>
						<tr>
							<td class="csui_label">DATE</td>
							<td class="csui vertical csui_field" type="datetime" itype="availability_date">
								<%= schedule.asText() %>
							</td>
							<td class="csui_label">STATUS</td>
							<td class="csui vertical csui_field" type="status" itype="status">
								<%= schedule.getStatus() %>
							</td>
						</tr>
						<tr>

							<td class="csui_label">COLLABORATORS</td>
							<td class="csui vertical csui_field" type="people" itype="people">
								<table cellpadding="2" cellspacing="0" border="0" itype="people" width="100%" id="collaborator_table">

									<%
										StringBuilder sb = new StringBuilder();
										for (int i=0; i<collaborators.length; i++) {
											SubObjVO cvo = collaborators[i];
											String selected = "";
											if (cvo.isSelected()) { selected = " checked"; }
											sb.append("<tr>\n");
											sb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"98%\" class=\"csform_checkboxtext\">").append(cvo.getText()).append("</td>");
											sb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csform_checkboxtext\" align=\"right\">").append(cvo.getDescription()).append("</td>");
											sb.append("</tr>");
										}
									%>
									<%= sb.toString() %>

								</table>
							</td>

							<td class="csui_label">TEAM</td>
							<td class="csui vertical csui_field" type="team" itype="team" valign="top">
								<table cellpadding="2" cellspacing="0" border="0" itype="team" width="100%" id="team_table">

									<%
										StringBuilder tsb = new StringBuilder();
										int tml = team.length;
										for (int i = 0; i < tml; i++) {
											SubObjVO st = team[i];
											String selected = "";
											if (st.isSelected()) { selected = " checked"; }
											tsb.append("<tr>\n");
											tsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"98%\" class=\"csform_checkboxtext\">").append(st.getText()).append("</td>");
											tsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csform_checkboxtext\" align=\"right\">").append(st.getDescription()).append("</td>");
											tsb.append("</tr>");
										}
										out.print(tsb.toString());
									%>
								</table>
							</td>
						</tr>
					</table>


			</div>
		</div>
	</div>
	</div>




</body>
</html>

