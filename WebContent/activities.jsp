<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.vo.SubObjVO"%>
<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="csshared.vo.ResponseVO"%>
<%@page import="cs.utils.ObjTables"%>
<%@page import="cs.ui.CsUi"%>
<%@page import="csshared.vo.DataVO"%>
<%@page import="alain.core.utils.Operator"%>
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
	nav.setAction(map.getString(RequestMapper.action));
	nav.setRequest("fields");

	TypeVO o = ApiHandler.getType(nav);
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	String entity = map.getString(RequestMapper.entity);
	int entityid = map.getInt(RequestMapper.entityid);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	String group = map.getString(RequestMapper.group);
	String groupid = map.getString(RequestMapper.groupid);
	String grouptype = map.getString(RequestMapper.grouptype);
	if (!Operator.hasValue(grouptype)) {
		grouptype = type;
	}

	RequestVO actreq = req.duplicate();
	actreq.setRequest("active");
	ResponseVO actres = ApiHandler.getResponse(actreq);
	ArrayList<HashMap<String, String>> activities = actres.getList();
	String curl = Config.fullcontexturl() + "/activities.jsp?_id=0&_entid=0&_ent="+entity+"&_typeid="+typeid+"&_type="+type+"&_grpid=activities&_grp=activities&_grptype=activities&_act=multiedit";

	RequestVO ureq = req.duplicate();
	ureq.setGrouptype("communications");
	ureq.setRequest("peopletypes");
	SubObjVO[] peopletypes = ApiHandler.getChoices(ureq);

%><html>
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
			td[isactive=N], a[isactive=N] { background-color: #efefef; color: #888888 }
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
	
		<script>
			var entity = '<%= entity %>';
			var type = '<%= type %>';
			var typeid = '<%= typeid %>';
			var group = '<%=group%>';
			var groupid = '<%=groupid%>';
			var grouptype = '<%=grouptype%>';
			var fullcontexturl = '<%=Config.fullcontexturl()%>';

			$(document).ready(function() {
				$('#selectall').click(function() {
					selectAll();
					updateStatus();
				});
				$('[name=ACTIVITY_ID]').click(function() {
					updateStatus();
				});
				$('#SEND_EMAIL').click(function(e) {
					var div = $('#EMAILFORM');
					if ($('#SEND_EMAIL').is(':checked')) {
						div.show();
					}
					else {
						div.hide();
					}
				});
			});
			function selectAll() {
				var selected = $('#selectall:checkbox:checked').length > 0;
				if (selected) {
					$('input[name=ACTIVITY_ID][isactive=Y]').prop('checked', true);
					if ($('input[name=ACTIVITY_ID][isactive=N]').length > 0) {
						swal('Note','Finaled and expired permits are not automatically selected','info');
					}
				}
				else {
					$('input[name=ACTIVITY_ID]').prop('checked', false);
				}
			}
			function updateStatus() {
				var checkValues = $('input[name=ACTIVITY_ID]:checked').map(function() { return $(this).val(); }).get();
				var actids = checkValues.join('|');
				var st = $('select[name=LKUP_ACT_STATUS_ID]');
				if (hasValue(st)) {
					var u = '_id=' + actids + '&_type=activities&_request=status';
					st.empty();
					st.attr('json', u);
					st.attr('auto','false');
					jsonSelect(st, 'choices');
					try {
						select.trigger("chosen:updated");
					} catch(e) {}
					$("#statusmessage").fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100);
				}
			}
			function success(data) {
				swal(
					{
						title: 'Success',
						text: 'Your update has been saved successfuly',
						type: 'success',
						showCancelButton: true,
						confirmButtonColor: "#DD6B55",
						confirmButtonText: 'continue editing',
						cancelButtonText: 'back to summary',
						closeOnConfirm: true,
						closeOnCancel: true
					},
					function(isConfirm) {
						if (isConfirm) {
							self.location = '<%=curl%>&_result='+data.messagecode;
						}
						else {
							self.location = '<%= Config.fullcontexturl() %>/summary.jsp?_ent=<%= entity %>&_type=<%= type %>&_typeid=<%= typeid %>&_id=<%= typeid %>';
						}
					}
				);
			}

		</script>
	
	</head>
<body>

	<div id="fullpage">
	<div id="loader">
		<div id="process">
			<table cellpadding="5" cellspacing="0" border="0" id="processtable">
				<tr>
					<td id="processtitle"></td>
				</tr>
				<tr>
					<td id="processmessage"></td>
				</tr>
				<tr>
					<td id="processpercent">
						<table id="processpercentage"><tr><td></td></tr></table>
					</td>
				</tr>
			</table>
		</div>
	</div>
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
				<%
					if (activities.size() > 0) {
				%>
				<form class="form" action="action.jsp" method="post">
					<input type="hidden" name="_ent" value="<%= entity %>">
					<input type="hidden" name="_type" value="<%= type %>">
					<input type="hidden" name="_typeid" value="<%= typeid %>">
					<input type="hidden" name="_grpid" value="activities">
					<input type="hidden" name="_grp" value="activities">
					<input type="hidden" name="_grptype" value="activities">

				<table class="csui_title">
					<tr>
						<td class="csui_title" style="width: 1%" nowrap>
						Choose the Activities to Edit
						</td>
						<td id="statusmessage" style="width: 99%; font-family: Oswald, Arial, Helvetica, sans-serif; font-size: 15px; font-weight: 700; color: #eeeeee;">
						: Status options below will be updated to include only statuses that are common to the selected activity types
						</td>
					</tr>
				</table>
					<table class="csui" cellpadding="10" cellspacing="0" border="0" type="horizontal">
						<tr>
							<td class="csui_label" type="short"><input type="checkbox" id="selectall"/></td>
							<td class="csui_label" type="short">ACTIVITY NUMBER</td>
							<td class="csui_label">TYPE</td>
							<td class="csui_label" type="short">STATUS</td>
							<td class="csui_label" type="short">VAL CALCULATED</td>
							<td class="csui_label" type="short">FEE AMOUNT</td>
							<td class="csui_label" type="short">FEE PAID</td>
							<td class="csui_label" type="short">BALANCE DUE</td>
							<td class="csui_label" type="short">START</td>
							<td class="csui_label" type="short">ISSUED</td>
							<td class="csui_label" type="short">FINALED</td>
							<td class="csui_label" type="short">APPLICATION EXPIRE</td>
							<td class="csui_label" type="short">PERMIT EXPIRE</td>
						</tr>
					<%
						for (int i=0; i<activities.size(); i++) {
							HashMap<String, String> a = activities.get(i);
							String actid = a.get("ID");
							String actnbr = a.get("ACT_NBR");
							String acttype = a.get("TYPE");
							String desc = a.get("DESCRIPTION");
							String status = a.get("STATUS");
							String amount = a.get("FEE_AMOUNT");
							String paid = a.get("FEE_PAID");
							String balance = a.get("BALANCE_DUE");
							String updated = a.get("UPDATED");
							String vdeclared = a.get("VALUATION_DECLARED");
							String vcalc = a.get("VALUATION_CALCULATED");
							String applied = a.get("APPLIED_DATE");
							String start = a.get("START_DATE");
							String issued = a.get("ISSUED_DATE");
							String exp = a.get("EXP_DATE");
							String appexp = a.get("APPLICATION_EXP_DATE");
							String fdate = a.get("FINAL_DATE");
							String plchk = a.get("PLAN_CHK_REQ");
							String sensitive = a.get("SENSITIVE");
							String inherit = a.get("INHERIT");
							String active = a.get("ACTIVE");
							if (Operator.hasValue(exp)) {
								Timekeeper e = new Timekeeper();
								e.setDate(exp);
								exp = e.getString("MM/DD/YYYY");
							}
							if (Operator.hasValue(fdate)) {
								Timekeeper e = new Timekeeper();
								e.setDate(fdate);
								fdate = e.getString("MM/DD/YYYY");
							}
							if (Operator.hasValue(appexp)) {
								Timekeeper e = new Timekeeper();
								e.setDate(appexp);
								appexp = e.getString("MM/DD/YYYY");
							}
							if (Operator.hasValue(issued)) {
								Timekeeper e = new Timekeeper();
								e.setDate(issued);
								issued = e.getString("MM/DD/YYYY");
							}
							if (Operator.hasValue(start)) {
								Timekeeper e = new Timekeeper();
								e.setDate(start);
								start = e.getString("MM/DD/YYYY");
							}
							if (Operator.hasValue(applied)) {
								Timekeeper e = new Timekeeper();
								e.setDate(applied);
								applied = e.getString("MM/DD/YYYY");
							}
	
					%>
						<tr>
							<td class="csui" type="short" isactive="<%=active%>"><input type="checkbox" name="ACTIVITY_ID" value="<%= actid %>" isactive="<%=active%>"/></td>
							<td class="csui" type="short" isactive="<%=active%>"><a href="summary.jsp?_ent=<%= entity %>&_entid=<%= entityid %>&_type=activity&_typeid=<%= actid %>" target="lightbox-iframe" class="csui" isactive="<%=active%>"><%= actnbr %></a></td>
							<td class="csui" isactive="<%=active%>"><%= acttype %></td>
							<td class="csui" type="short" isactive="<%=active%>"><%= status %></td>
							<td class="csui" type="short" isactive="<%=active%>"><%= vcalc %></td>
							<td class="csui" type="short" isactive="<%=active%>"><%= amount %></td>
							<td class="csui" type="short" isactive="<%=active%>"><%= paid %></td>
							<td class="csui" type="short" isactive="<%=active%>"><%= balance %></td>
							<td class="csui" type="short" isactive="<%=active%>"><%= start %></td>
							<td class="csui" type="short" isactive="<%=active%>"><%= issued %></td>
							<td class="csui" type="short" isactive="<%=active%>"><%= fdate %></td>
							<td class="csui" type="short" isactive="<%=active%>"><%= appexp %></td>
							<td class="csui" type="short" isactive="<%=active%>"><%= exp %></td>
						</tr>
					<%
						}
					%>
					</table>

				<table class="csuisub_title">
					<tr>
						<td class="csuisub_title" nowrap>Enter values only for the fields you want to update</td>
					</tr>
				</table>
					<table class="csui" colnum="2" type="default">
						<tr>
							<%= ObjTables.cells("APPLIED_DATE", "APPLIED DATE", "", "date", "date", 1, false, "csui", true) %>
							<%= ObjTables.cells("LKUP_ACT_STATUS_ID", "STATUS", "", "select", "actstatus", false, "csui", true) %>
						</tr>
						<tr>
							<%= ObjTables.cells("START_DATE", "START DATE", "", "date", "date", 1, false, "csui", true) %>
							<td class="csui_label" id="label_VALUATION_CALCULATED" valign="top" style="background-color: #e3cbc8">VALUATION CALCULATED</td>
							<td class="csui vertical csui_field" id="field_VALUATION_CALCULATED" valign="top" style="background-color: #f9e9e6">
								Note: Updating this field will affect activity fees and transactions<br/>
								<input name="VALUATION_CALCULATED" type="currency" itype="currency" value="" style="background-color: #ffffff !important">
							</td>
						</tr>
						<tr>
							<%= ObjTables.cells("ISSUED_DATE", "ISSUED DATE", "", "date", "date", 1, false, "csui", true) %>
							<%= ObjTables.cells("VALUATION_DECLARED", "VALUATION DECLARED", "", "currency", "currency", false, "csui", true) %>
						</tr>
						<tr>
							<%= ObjTables.cells("APPLICATION_EXP_DATE", "APPLICATION EXPIRATION DATE", "", "date", "date", 1, false, "csui", true) %>
							<%= ObjTables.cells("PLAN_CHK_REQ", "PLAN CHECK REQUIRED", "", "text", "String", false, "csui", 1, ObjTables.yesno(), false, true)%>
						</tr>
						<tr>
							<%= ObjTables.cells("EXP_DATE", "PERMIT EXPIRATION DATE", "", "date", "date", 1, false, "csui", true) %>
							<%= ObjTables.cells("INHERIT", "INHERIT", "", "text", "String", false, "csui", 1, ObjTables.yesno(), false, true)%>
						</tr>
						<tr>
							<%= ObjTables.cells("FINAL_DATE", "FINAL DATE", "", "date", "date", 1, false, "csui", true) %>
							<%= ObjTables.cells("SENSITIVE", "SENSITIVE", "", "text", "String", false, "csui", 1, ObjTables.yesno(), false, true)%>
						</tr>
						<tr>
							<td class="csui_label">SEND EMAIL</td>
							<td class="csui vertical csui_field"><input type="checkbox" id="SEND_EMAIL" name="SEND_EMAIL" value="Y"/></td>
							<td class="csui_label">&nbsp;</td>
							<td class="csui vertical csui_field">&nbsp;</td>
						</tr>
					</table>

					<div id="EMAILFORM" style="display: none">
					<table class="csuisub_title" alert="<%=alert%>">
						<tr>
							<td class="csuisub_title" nowrap>Send Email Notification</td>
						</tr>
					</table>
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<td width="50%" valign="top">
								<table cellpadding="2" cellspacing="0" border="0" class="csui" type="horizontal" width="100%">
									<%
										StringBuilder nsb = new StringBuilder();
										nsb.append("<tr>\n");
										nsb.append("<td style=\"border-top: 1px solid #eeeeee\" colspan=\"2\" width=\"1%\" nowrap class=\"csui_label\">Recipients</td>");
										nsb.append("</tr>");
										nsb.append("<tr>\n");
										nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csui\" type=\"short\"><input type=\"checkbox\" name=\"NOTIFY_TYPES\" value=\"PRIMARY\" class=\"csform_checkbox\"/></td>");
										nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"99%\" nowrap class=\"csui\">Primary Contact</td>");
										nsb.append("</tr>");
										for (int i=0; i<peopletypes.length; i++) {
											SubObjVO uvo = peopletypes[i];
											nsb.append("<tr>\n");
											nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csui\" type=\"short\"><input type=\"checkbox\" name=\"NOTIFY_TYPES\" value=\"").append(uvo.getValue()).append("\" class=\"csform_checkbox\"/></td>");
											nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"99%\" nowrap class=\"csui\">").append(uvo.getText()).append("</td>");
											nsb.append("</tr>");
										}
									%>
									<%= nsb.toString() %>
								</table>
							</td>
							<td width="50%" valign="top">
								<table cellpadding="2" cellspacing="0" border="0" class="csui" type="horizontal" width="100%">
									<tr>
										<td class="csui_label">Add Comment</td>
									</tr>
									<tr>
										<td class="csui"><textarea name="COMMENT" style=""></textarea></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					</div>

					<div class="csui_divider"></div>
					<div class="csui_buttons"><input type="submit" name="action" value="save" class="csui_button"></div>

				</form>
				<%
					}
					else {
				%>
					<table class="csuisub_title" alert="<%=alert%>">
						<tr>
							<td class="csuisub_title" nowrap>No activities found for this project</td>
						</tr>
					</table>
				
				<%
					}
				%>
			</div>
		</div>
	</div>
	</div>
<br/><br/><br/>

</body>
</html>

