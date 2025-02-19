<%@page import="cs.ui.CsUiTools"%>
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

	boolean add = true;
	Cartographer map = new Cartographer(request,response);
	RequestVO req = RequestMapper.getRequest(map);
	RequestVO nav = req.duplicate();
	nav.setAction(map.getString(RequestMapper.action));
//	nav.setRequest("details");
	if (map.equalsIgnoreCase(RequestMapper.action, "add")) {
		nav.setRequest("fields");
	}
	else {
		add = false;
		nav.setRequest("details");
	}

	TypeVO o = ApiHandler.getType(nav);
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	String grouptype = map.getString(RequestMapper.grouptype);
	if (!Operator.hasValue(grouptype)) {
		grouptype = type;
	}

	ObjGroupVO[] ga = o.getGroups();
	ObjGroupVO g = new ObjGroupVO();
	if (ga.length > 0) {
		g = ga[0];
	}

	if (map.equalsIgnoreCase(RequestMapper.action, "add") && !g.isCreate()) {
		o = new TypeVO();
		map.forward("403.jsp");
	}
	else if (!g.isUpdate()) {
		o = new TypeVO();
		map.forward("403.jsp");
	}

	HashMap<String, String> v = ObjMapper.getFieldValues(o);
	HashMap<String, String> f = ObjMapper.getFieldText(o);
	String groupid = ObjMapper.getGroupId(o);
	boolean finaled = ObjMapper.isFinaled(o);
	String alert = o.getAlert();

	RequestVO treq = req.duplicate();
	treq.setGrouptype("appointment");
	treq.setRequest("types");
	SubObjVO[] types = ApiHandler.getChoices(treq);

	RequestVO creq = req.duplicate();
	creq.setGrouptype("appointment");
	creq.setRequest("collaborators");
	SubObjVO[] collaborators = ApiHandler.getChoices(creq);

 	RequestVO tmreq = req.duplicate();
 	tmreq.setGrouptype("appointment");
 	tmreq.setRequest("team");
 	SubObjVO[] team = ApiHandler.getChoices(tmreq);

 	RequestVO nreq = req.duplicate();
 	nreq.setType("appointment");
 	nreq.setTypeid(Operator.toInt(groupid));
 	nreq.setGrouptype("notes");
 	nreq.setRequest("list");
 	nreq.setViewonly(true);
 	TypeVO notes = ApiHandler.getType(nreq);



	Timekeeper startdate = new Timekeeper();
	String sd = v.get("DATE");
	if (sd != null) { 
		startdate.setDate(sd);
	}

	String atype = v.get("LKUP_APPOINTMENT_TYPE_ID") != null ? v.get("LKUP_APPOINTMENT_TYPE_ID") : "";
	String atypetext = f.get("LKUP_APPOINTMENT_TYPE_ID") != null ? f.get("LKUP_APPOINTMENT_TYPE_ID") : "";
	String asubtype = v.get("REVIEW_ID") != null ? v.get("REVIEW_ID") : "";
	String asubtypetext = f.get("REVIEW_ID") != null ? f.get("REVIEW_ID") : "";
	String atime = v.get("TIME") != null ? v.get("TIME") : "";
	String atimetext = f.get("TIME") != null ? f.get("TIME") : "";
	String stype = v.get("STATUS_ID") != null ? v.get("STATUS_ID") : "";
	String asubject = v.get("SUBJECT") != null ? v.get("SUBJECT") : "";

	String astatus = v.get("STATUS_ID") != null ? v.get("STATUS_ID") : "";
	String astatustext = f.get("STATUS_ID") != null ? f.get("STATUS_ID") : "";

	RequestVO sreq = req.duplicate();
	sreq.setGrouptype("appointment");
	sreq.setRequest("schedulestatus");
	sreq.setAppttypeid(Operator.toInt(atype, 0));
	sreq.setApptsubtypeid(Operator.toInt(asubtype, 0));
//	SubObjVO[] status = ApiHandler.getChoices(sreq);


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
		table[itype=people] tr:nth-child(even), table[itype=team] tr:nth-child(odd) {
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
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.appt.js?v1"></script>
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

	<script>

		$(document).ready(function() {
			$('#csform').apptform({
				<% if (!add) { out.print("add: false"); } %>
			});
		});


	</script>

</head>
<body>

	<div id="fullpage">
	<div id="loader"></div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontrol csuialert" alert="<%= alert %>">
				<div id="csuicontrol" class="csuicontrol csuialert" alert="<%= alert %>">
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<td align="left">
								<table class="csui_tools">
									<tr>
										<td class="csui_tools">
											<a href="<%= Config.fullcontexturl() %>/summary.jsp?_ent=<%= entity %>&_type=<%= type %>&_typeid=<%= typeid %>&_id=<%= typeid %>"><img src="<%= CsConfig.getImage("back") %>" height="25" width="25" border="0"/></a>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>

			</div>
			<div class="csuicontent">
				<table cellpadding="10" cellspacing="0" border="0" width="100%">
					<tr>
						<td align="left" id="title"><%= title %></td>
						<td align="right" id="subtitle"><%= subtitle %></td>
					</tr>
				</table>
				<div id="csform_message"></div>
				<form id="csform" class="form" action="action.jsp" method="post" success="<%= req.summaryUrl() %>">
					<input type="hidden" name="_ent" value="<%= o.getEntity() %>">
					<input type="hidden" name="_type" value="<%= o.getType() %>">
					<input type="hidden" name="_typeid" value="<%= o.getTypeid() %>">

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
								<%
									if (add) {
								%>
								<select id="LKUP_APPOINTMENT_TYPE_ID" title="Appointment type" name="LKUP_APPOINTMENT_TYPE_ID" data-placeholder="Choose appointment type..." itype="appointment" val="" _ent="<%= o.getEntity() %>" valrequired="true">
									<option value=""></option>
									<%
										int tl = types.length;
										for (int i = 0; i < tl; i++) {
											SubObjVO st = types[i];
											out.print("<option value=\"");
											out.print(st.getValue());
											out.print("\"");
											out.print(" availability_id=\"");
											out.print(st.getAddldata().get("AVAILABILITY_ID"));
											out.print("\"");
											if (Operator.equalsIgnoreCase(st.getValue(), atype)) {
												out.print(" selected");
											}
											out.print(">");
											out.print(st.getText());
											out.print("</option>\n");
										}
									%>
								</select>
								<%
									}
									else {
								%>
								<%= atypetext %><input type="hidden" name="LKUP_APPOINTMENT_TYPE_ID" value="<%= atype %>" id="LKUP_APPOINTMENT_TYPE_ID" itype="appointment" val="" _ent="<%= o.getEntity() %>" valrequired="true"/>
								<%
									}
								%>
							</td>
							<td class="csui_label">APPOINTMENT SUB TYPE</td>
							<td class="csui vertical csui_field" type="String" itype="apptreview">

								<%
									if (add) {
								%>
								<select id="REVIEW_ID" name="REVIEW_ID" title="Appointment subtype" data-placeholder="Choose appointment subtype..." itype="apptreview" val="<%= asubtype %>" _ent="<%= o.getEntity() %>">
									<option value=""></option>
								</select>
								<%
									}
									else {
								%>
								<%= asubtypetext %><input type="hidden" name="REVIEW_ID" value="<%= asubtype %>" id="REVIEW_ID" itype="apptreview" val="<%= asubtype %>" _ent="<%= o.getEntity() %>"/>
								<%
									}
								%>

							</td>
						</tr>
						<tr>
							<td class="csui_label">SUBJECT</td>
							<td class="csui vertical csui_field" type="String" itype="text">
								<% if (finaled) { out.print(asubject); } else { %>
								<input name="SUBJECT" type="text" itype="text" value="<%= asubject %>" maxchar="10000">
								<% } %>
							</td>
							<td class="csui_label">STATUS</td>
							<td class="csui vertical csui_field" type="status" itype="status">
								<%
									if (finaled) { out.print(astatustext); } else {
								%>
								<select id="STATUS_ID" title="Status" name="STATUS_ID" data-placeholder="Choose status..." itype="status" val="" _ent="<%= o.getEntity() %>" valrequired="true">
									<option value=""></option>
									<%
// 										int sl = status.length;
// 										for (int i = 0; i < sl; i++) {
// 											SubObjVO st = status[i];
// 											out.print("<option value=\"");
// 											out.print(st.getValue());
// 											out.print("\"");
// 											if (add && st.isSelected() || (!add && Operator.equalsIgnoreCase(st.getValue(), stype))) {
// 												out.print(" selected");
// 											}
// 											out.print(">");
// 											out.print(st.getText());
// 											out.print("</option>\n");
//										}
									%>
								</select>
								<%
									}
								%>
							</td>
						</tr>
						<tr>
							<td class="csui_label">DATE</td>
							<td class="csui vertical csui_field" type="datetime" itype="availability_date">
								<%
									if (finaled) { out.print(startdate.getString("YYYY/MM/DD")); } else {
								%>
									<input name="DATE" title="Date" type="text" itype="availability_date" value="<%= startdate.getString("YYYY/MM/DD") %>" valrequired="true" maxchar="10000">
								<%
									}
								%>
							</td>

							<td class="csui_label">TIME</td>
							<td class="csui vertical csui_field" type="time" itype="availability_time">
								<%
									if (finaled) { out.print(atimetext); } else {
								%>
								<select id="TIME" name="TIME" title="Time" data-placeholder="Choose time..." type="text" val="<%= atime %>" valrequired="true" itype="availability_time">
								</select>
								<%
									}
								%>
							</td>

						</tr>
						<tr>
							<td class="csui_label" rowspan="2">NOTES</td>
							<td class="csui vertical csui_field" rowspan="2" type="String" itype="textarea"><textarea name="NOTES" itype="textarea"></textarea></td>
							<td class="csui_label">TEAM</td>
							<td class="csui vertical csui_field" type="team" itype="team">
								<table cellpadding="2" cellspacing="0" border="0" width="100%">
									<tr>
										<td align="right"><a target="lightbox-iframe" href="<%= Config.fullcontexturl() %>/selectteam.jsp?_ent=<%= o.getEntity() %>&_type=users&fieldid=TEAM"><img src="/cs/images/icons/controls/black/add.png"/></a></td>
									</tr>
								</table>
								<table cellpadding="2" cellspacing="0" border="0" itype="team" width="100%" id="team_table">

								<%
									if (finaled) {
										int tml = team.length;
										boolean empty = true;
										for (int i = 0; i < tml; i++) {
											SubObjVO st = team[i];
											if (st.isSelected()) {
												if (!empty) { out.print(", "); }
												out.print(st.getText());
												empty = false;
											}
										}
									}
									else {
										int tml = team.length;
										StringBuilder tsb = new StringBuilder();
										for (int i = 0; i < tml; i++) {
											SubObjVO st = team[i];
											String selected = "";
											if (st.isSelected()) { selected = " checked"; }
											tsb.append("<tr>\n");
											tsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csform_checkbox\"><input type=\"checkbox\" name=\"TEAM\" value=\"").append(st.getValue()).append("\" class=\"csform_checkbox\"").append(selected).append("/></td>");
											tsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"98%\" class=\"csform_checkboxtext\">").append(st.getText()).append("</td>");
											tsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csform_checkboxtext\" align=\"right\">").append(st.getDescription()).append("</td>");
											tsb.append("</tr>");
										}
										out.print(tsb.toString());
									}
								%>
								</table>
							</td>
						</tr>
						<tr>
							<td class="csui_label">COLLABORATORS</td>
							<td class="csui vertical csui_field" type="people" itype="people">
								<table cellpadding="2" cellspacing="0" border="0" width="100%">
									<tr>
										<td align="right"><a target="lightbox-iframe" href="<%= Config.fullcontexturl() %>/selectcollaborators.jsp?_ent=<%= o.getEntity() %>&_type=users&fieldid=COLLABORATORS"><img src="/cs/images/icons/controls/black/add.png"/></a></td>
									</tr>
								</table>
								<table cellpadding="2" cellspacing="0" border="0" itype="people" width="100%" id="collaborator_table">

									<%
										StringBuilder sb = new StringBuilder();
										for (int i=0; i<collaborators.length; i++) {
											SubObjVO cvo = collaborators[i];
											String selected = "";
											if (cvo.isSelected()) { selected = " checked"; }
											sb.append("<tr>\n");
											sb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csform_checkbox\"><input type=\"checkbox\" name=\"COLLABORATORS\" value=\"").append(cvo.getValue()).append("\" class=\"csform_checkbox\"").append(selected).append("/></td>");
											sb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"98%\" class=\"csform_checkboxtext\">").append(cvo.getText()).append("</td>");
											sb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csform_checkboxtext\" align=\"right\">").append(cvo.getDescription()).append("</td>");
											sb.append("</tr>");
										}
									%>
									<%= sb.toString() %>

								</table>
							</td>
						</tr>
					</table>

					<input type="hidden" name="_grpid" value="appointment">
					<input type="hidden" name="_grp" value="appointment">
					<input type="hidden" name="_grptype" value="appointment">
					<input type="hidden" name="_id" value="<%=groupid%>">
					<div class="csui_divider"></div>
					<div class="csui_buttons"><input type="submit" name="action" value="save" class="csui_button"></div>

				</form>

				<%= ObjUi.table(nreq, notes, "csuisub") %>

			</div>
		</div>
	</div>
	</div>




</body>
</html>

