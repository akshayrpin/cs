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
	String alert = o.getAlert();
	String entity = o.getEntity();
	String type = o.getType();
	int typeid = o.getTypeid();

	HashMap<String, String> v = ObjMapper.getFieldValues(o);
	HashMap<String, String> f = ObjMapper.getFieldText(o);
	String groupid = ObjMapper.getGroupId(o);
	boolean finaled = ObjMapper.isFinaled(o);

	req.setType(type);
	req.setTypeid(typeid);
	req.setEntity(entity);

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
	SubObjVO[] status = ApiHandler.getChoices(sreq);


%><html>
<head>
	<%= CsUiTools.getHTMLImports() %>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
		
	<style>
		.csui_controls { visibility: hidden }
		table[itype=people] tr:nth-child(even) {
			background-color: #f2f2f2;
		}
	</style>
	<script>
	var entity = '<%= entity %>';
	var type = '<%= type %>';
	var typeid = '<%= typeid %>';
	var groupid = '<%= groupid %>';
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
	
	
 	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>

	<script>

		$(document).ready(function() {
			$('#csform').csform({
				callback: {
					submit: {
						success: function() {
							parent.$.fancybox.close();
							parent.location.reload();
						}
					}
				}
			});
			$('#csform').apptform({
				<% if (!add) { out.print("add: false"); } %>
			});
			$('input[itype=datetime]').datetimepicker({
				formatTime:'g:i A',
				step: 1
			});
			$('input[itype=availability]').datetimepicker({
				timepicker:false,
				format:'Y/m/d'
			});
			$('input[itype=date]').datetimepicker({
				timepicker:false,
				format:'Y/m/d'
			});
			$('select:not([itype=boolean]):not([valrequired=true])').chosen({
				width:'100%',
				disable_search_threshold: 10,
				allow_single_deselect: true
			});
			$('select:not([itype=boolean])[valrequired=true]').chosen({
				width:'100%',
				disable_search_threshold: 10
			});
			$('input[itype=boolean]').toggleSwitch({
				onLabel: 'YES',
				offLabel: 'NO',
				height: '30px'
			});
			$('input[itype=active]').toggleSwitch({
				onLabel: 'ACTIVE',
				offLabel: 'INACTIVE',
				height: '30px',
				width: '140px'
			});
			$('input[itype=enable]').toggleSwitch({
				onLabel: 'ENABLED',
				offLabel: 'DISABLED',
				height: '30px',
				width: '140px'
			});
			
			
			
			$('textarea[itype!=richtext]').autoGrow();
			tinymce.init({
            	selector: "textarea[itype=richtext]"
	        });
			$('input[itype=phone]').inputmask({
				"mask":"(999) 999-9999"
			});
//			$('textarea').tinymce();
		});

	</script>

</head>
<body>

	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontrol <%= alert %>">
				<div id="csuicontrol" class="csuicontrol">
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
				<form id="csform" action="action.jsp" method="post">
					<input type="hidden" name="_ent" value="<%= o.getEntity() %>">
					<input type="hidden" name="_type" value="<%= o.getType() %>">
					<input type="hidden" name="_typeid" value="<%= o.getTypeid() %>">

					<table class="csui_title" alert="pc approved">
						<tr>
							<td class="csui_title"><a href="<%= Config.fullcontexturl() %>/list.jsp?_id=&_entid=-1&_ent=<%= o.getEntity() %>&_typeid=<%= o.getTypeid() %>&_type=<%= o.getType() %>&_grpid=appointment&_grp=appointment&_grptype=appointment" class="csui_title">appointment</a></td>
							<td class="csui_controls"><a href="<%= Config.fullcontexturl() %>/appointment.jsp?_id=&_entid=-1&_ent=<%= o.getEntity() %>&_typeid=<%= o.getTypeid() %>&_type=<%= o.getType() %>&_grpid=appointment&_grp=appointment&_grptype=appointment" class="csui_controls"><img src="<%= Config.fullcontexturl() %>/images/icons/controls/white/edit.png" width="20" height="20" border="0"/></a></td>
						</tr>
					</table>
					<table class="csui" type="default">
						<tr>
							<td class="csui_label" alert="">APPOINTMENT TYPE</td>
							<td class="csui" type="String" itype="appointment" alert="">
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
							<td class="csui_label" alert="">APPOINTMENT SUB TYPE</td>
							<td class="csui" type="String" itype="apptreview" alert="">

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
							<td class="csui_label" alert="">SUBJECT</td>
							<td class="csui" type="String" itype="text" alert="">
								<% if (finaled) { out.print(asubject); } else { %>
								<input name="SUBJECT" type="text" itype="text" value="<%= asubject %>" maxchar="10000">
								<% } %>
							</td>
							<td class="csui_label" alert="">STATUS</td>
							<td class="csui" type="status" itype="status" alert="">
								<%
									if (finaled) { out.print(astatustext); } else {
								%>
								<select id="STATUS_ID" title="Status" name="STATUS_ID" data-placeholder="Choose status..." itype="status" val="" _ent="<%= o.getEntity() %>" valrequired="true">
									<option value=""></option>
									<%
										int sl = status.length;
										for (int i = 0; i < sl; i++) {
											SubObjVO st = status[i];
											out.print("<option value=\"");
											out.print(st.getValue());
											out.print("\"");
											if (add && st.isSelected() || (!add && Operator.equalsIgnoreCase(st.getValue(), stype))) {
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
								%>
							</td>
						</tr>
						<tr>
							<td class="csui_label" alert="">DATE</td>
							<td class="csui" type="datetime" itype="availability_date" alert="">
								<%
									if (finaled) { out.print(startdate.getString("YYYY/MM/DD")); } else {
								%>
									<input name="DATE" title="Date" type="text" itype="availability_date" value="<%= startdate.getString("YYYY/MM/DD") %>" valrequired="true" maxchar="10000">
								<%
									}
								%>
							</td>

							<td class="csui_label" alert="">TIME</td>
							<td class="csui" type="time" itype="availability_time" alert="">
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
							<td class="csui_label" rowspan="2" alert="">NOTES</td>
							<td class="csui" rowspan="2" type="String" itype="textarea" alert=""><textarea name="NOTES" itype="textarea"></textarea></td>
							<td class="csui_label" alert="">TEAM</td>
							<td class="csui" type="team" itype="team" alert="">

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
									} else {
								%>
								<select id="TEAM" name="TEAM" itype="team" data-placeholder="Choose team member..." val="" multiple _ent="<%= o.getEntity() %>">
									<option value=""></option>
									<%
										int tml = team.length;
										for (int i = 0; i < tml; i++) {
											SubObjVO st = team[i];
											out.print("<option value=\"");
											out.print(st.getValue());
											out.print("\"");
											if (st.isSelected()) {
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
								%>
							</td>
						</tr>
						<tr>
							<td class="csui_label" alert="">COLLABORATORS</td>
							<td class="csui" type="people" itype="people" alert="">
								<table cellpadding="2" cellspacing="0" border="0" itype="people" width="100%">
									<tr>
										<td colspan="3" align="right"><a class="lightbox-iframe" href="<%= Config.fullcontexturl() %>/addusers.jsp?_ent=<%= o.getEntity() %>&_type=users&fieldid=COLLABORATORS"><img src="/cs/images/icons/controls/black/add.png"/></a></td>
									</tr>

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
					<div class="csui_buttons"><input type="submit" name="_action" value="cancel" class="csui_button">&nbsp;<input type="submit" name="action" value="save" class="csui_button"></div>

				</form>

				<%= ObjUi.table(nreq, notes, "csuisub") %>

			</div>
		</div>
	</div>




</body>
</html>

