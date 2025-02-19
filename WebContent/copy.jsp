<%@page import="cs.ui.CsUiTools"%>
<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="csshared.vo.ToolsVO"%>
<%@page import="csshared.vo.ToolVO"%>
<%@page import="csshared.vo.ResponseVO"%>
<%@page import="csshared.vo.SubObjVO"%>
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


	Cartographer map = new Cartographer(request,response, true);
	RequestVO req = RequestMapper.getRequest(map);

	RequestVO nav = req.duplicate();
	nav.setAction(map.getString(RequestMapper.action));
	nav.setRequest("details");
	
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	String group = map.getString(RequestMapper.group);
	String groupid = map.getString(RequestMapper.groupid);
	String grouptype = map.getString(RequestMapper.grouptype);
	if (!Operator.hasValue(grouptype)) {
		grouptype = type;
	}

	TypeVO o = ApiHandler.getType(nav);
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();

	ObjGroupVO[] ga = o.getGroups();
	ObjGroupVO g = new ObjGroupVO();
	if (ga.length > 0) {
		g = ga[0];
	}

	if (!g.isUpdate()) {
		o = new TypeVO();
		map.forward("403.jsp");
	}

	RequestVO mreq = req.duplicate();
	mreq.setRequest("modules");
	ToolsVO m = ApiHandler.getTools(mreq);

	SubObjVO[] status = new SubObjVO[0];
	RequestVO stvo = req.duplicate();
	stvo.setId("-1");
	stvo.setGrouptype(type);
	stvo.setRequest("status");
	status = ApiHandler.getChoices(stvo);

	DataVO dvo = DataVO.toDataVO(o);

	String curl = Config.fullcontexturl() + "/summary.jsp?_ent="+entity+"&_typeid="+typeid+"&_type="+type+"&_id="+typeid;
	Timekeeper today = new Timekeeper();
	String appexp = "";
	String exp = "";
	if (dvo.getInt("DAYS_TILL_APPLICATION_EXPIRED") > 0) {
		Timekeeper aexpd = new Timekeeper();
		aexpd.addDay(dvo.getInt("DAYS_TILL_APPLICATION_EXPIRED"));
		appexp = aexpd.getString("YYYY/MM/DD");
	}
	if (dvo.getInt("DAYS_TILL_EXPIRED") > 0) {
		Timekeeper expd = new Timekeeper();
		expd.addDay(dvo.getInt("DAYS_TILL_EXPIRED"));
		exp = expd.getString("YYYY/MM/DD");
	}

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
				$('#SELECT_ALL').click(function() {
					var c = $('#SELECT_ALL').is(':checked');
					if (c) {
						$('[name=LKUP_MODULES_ID]').prop('checked', true);
					}
					else {
						$('[name=LKUP_MODULES_ID]').prop('checked', false);
					}
				});
				$('[name=LKUP_MODULES_ID]').click(function(e) {
					var c = $(this).is(':checked');
					if (!c) {
						$('#SELECT_ALL').prop('checked',false);
					}
				});

				<% if (dvo.getInt("DAYS_TILL_APPLICATION_EXPIRED") > 0) { %>
				$('[name=APPLIED_DATE]').change(function() {
					var aed = $('[name=APPLICATION_EXP_DATE]');
					var ed = $('[name=EXP_DATE]');
					var sd = $('[name=APPLIED_DATE]');
					if (hasValue(sd)) {
						swal({
							title: 'Update Expiration Dates?',
							text: 'Do you want to update the expiration dates based on configuration values?',
							type: 'info',
							showCancelButton: true,
							confirmButtonColor: "#DD6B55",
							confirmButtonText: 'Yes',
							cancelButtonText: 'No',
							closeOnConfirm: true,
							closeOnCancel: true
						},
						function(isConfirm) {
							if (isConfirm) {
								var adate = new Date(sd.val());
								<% if (dvo.getInt("DAYS_TILL_APPLICATION_EXPIRED") > 0) { %>
									var aedate = new Date();
									aedate.setDate(adate.getDate() + <%=dvo.getInt("DAYS_TILL_APPLICATION_EXPIRED")%>);
									var ad = aedate.getFullYear() + '/';
									if (aedate.getMonth() + 1 < 10) { ad += '0'; }
									ad += (aedate.getMonth() + 1) + '/';
									if (aedate.getDate() < 10) { ad += '0'; }
									ad += aedate.getDate();
									aed.val(ad);
								<% } %>
								<% if (dvo.getInt("DAYS_TILL_EXPIRED") > 0) { %>
									var edate = new Date();
									edate.setDate(adate.getDate() + <%=dvo.getInt("DAYS_TILL_EXPIRED")%>);
									var d = edate.getFullYear() + '/';
									if (edate.getMonth() + 1 < 10) { d += '0'; }
									d += (edate.getMonth() + 1) + '/';
									if (edate.getDate() < 10) { d += '0'; }
									d += edate.getDate();
									ed.val(d);
								<% } %>
							}
						});
					}
				});
				<% } %>

				$('select[name=LKUP_ACT_STATUS_ID]').change(function() {
					var stselect = $('select[name=LKUP_ACT_STATUS_ID] option:selected');
					var iss = stselect.attr("ISSUED");
					var isf = stselect.attr("FINAL");
					if (iss == 'Y') {
						swal('Can not be issued','Issued statuses can not be used on copied activities.','info');
						defaultStatus();
						return false;
					}
					else if (isf == 'Y') {
						swal('Can not be finaled','Finaled statuses can not be used on copied activities.','info');
						defaultStatus();
						return false;
					}
				});
			});

			function success(data) {
				var d_entity = entity;
				var d_typeid = typeid;
				var d_type = type;
				var txt = 'Copy successfully completed.'
				try {
			
					var datatype = data.type['type'];
					var datatypeid = data.type['typeid'];
					var dataentity = data.type['entity'];
					if (datatype != undefined && datatype != null && datatype != '' && datatypeid != undefined && datatypeid != null && datatypeid != '') {
						d_type = datatype;
						d_typeid = datatypeid;
					}
					if (dataentity != undefined && dataentity != null && dataentity != '') {
						d_entity = dataentity;
					}
					try {
						txt = '';
						var m = data['messages'];
						var mi = 0;
						for (mi=0; mi<m.length; mi++) {
							txt += m[mi];
							txt += '\n';
						}
					}
					catch(me) {
						txt = 'The ' + d_type + ' has been successfully copied. The reference number for the new '+ d_type +' is ' + data['reference'];
					}
				} catch(e) { }
				swal(
					{
						title: 'Success',
						text: txt,
						type: 'success',
						showCancelButton: true,
						confirmButtonColor: "#DD6B55",
						confirmButtonText: 'view new '+d_type,
						cancelButtonText: 'return to old '+d_type,
						closeOnConfirm: true,
						closeOnCancel: true
					},
					function(isConfirm) {
						if (isConfirm) {
							var t = data['type'];
							parent.getBrowsers(dataentity, d_type, d_typeid);
							self.location = '<%= Config.fullcontexturl() %>/summary.jsp?_ent=<%= entity %>&_type='+t['type']+'&_typeid='+t['typeid']+'&_id='+t['typeid'];
						}
						else {
							parent.getBrowsers(entity, type, typeid);
							self.location = '<%= Config.fullcontexturl() %>/summary.jsp?_ent=<%= entity %>&_type=<%= type %>&_typeid=<%= typeid %>&_id=<%= typeid %>';
						}
					}
				);
			}

			function defaultStatus() {
				var s = $('select[name=LKUP_ACT_STATUS_ID]');
				var d = $('select[name=LKUP_ACT_STATUS_ID] option[DEFLT=Y]');
				if (hasValue(d)) {
					d.prop('selected', true);
				}
				else {
					s.val('');
				}
				s.trigger("chosen:updated");
			}

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
				<table class="csui_title">
					<tr>
						<td class="csui_title" nowrap>Copy</td>
					</tr>
				</table>
				<form action="action.jsp" class="form" refresh="true">
					<input type="hidden" name="_ent" value="<%= entity %>">
					<input type="hidden" name="_type" value="<%= type %>">
					<input type="hidden" name="_typeid" value="<%= typeid %>">
					<input type="hidden" name="_grpid" value="copy">
					<input type="hidden" name="_grp" value="copy">
					<input type="hidden" name="_grptype" value="copy">
					<input type="hidden" name="_act" value="save">
					<table class="csui" style="width: 100%">
						<tr>
							<td class="csui_label">PROJECT NUMBER</td>
							<td class="csui vertical csui_field"><input type="text" value="<%= dvo.get("PROJECT_NBR") %>" itype="text" name="PROJECT_NBR" id="PROJECT_NBR" placeholder="PROJECT NUMBER" valrequired="true"/></td>
							<%= ObjTables.cells("LKUP_ACT_STATUS_ID", "STATUS", "", dvo.getString("LKUP_ACT_STATUS_ID"), "select", "status", true, "csui", 1, status, false, true, false) %>
						</tr>
						<tr>
							<%= ObjTables.cells("APPLIED_DATE", "APPLIED DATE", today.getString("YYYY/MM/DD"), "date", "date", 1, false, "csui", true) %>
							<%= ObjTables.cells("APPLICATION_EXP_DATE", "APPLICATION EXPIRATION DATE", appexp, "date", "date", 1, false, "csui", true) %>
						</tr>
						<tr>
							<%= ObjTables.cells("START_DATE", "START DATE", "", "date", "date", 1, false, "csui", true) %>
							<%= ObjTables.cells("EXP_DATE", "PERMIT EXPIRATION DATE", exp, "date", "date", 1, false, "csui", true) %>
						</tr>
<!-- 						<tr> -->
<%-- 							<%= ObjTables.cells("ISSUED_DATE", "ISSUED DATE", "", "date", "date", 1, false, "csui", true) %> --%>
<%-- 							<%= ObjTables.cells("FINAL_DATE", "FINAL DATE", "", "date", "date", 1, false, "csui", true) %> --%>
<!-- 						</tr> -->
					</table>
					<table class="csuisub_title">
						<tr>
							<td class="csuisub_title" nowrap>Select the modules you would like to copy</td>
						</tr>
					</table>
					<table class="csui" style="width: 100%">
						<tr>
							<td class="csui_label" style="width: 1%"><input type="checkbox" name="SELECT_ALL" id="SELECT_ALL"/></td>
							<td class="csui_label" style="width: 99%" colspan="2">Module</td>
						</tr>

					<%
						ToolVO[] mtools = m.getTools();
						for (int i=0; i<mtools.length; i++) {
							ToolVO tool = mtools[i];
							String ttl = tool.getTool();
							if (Operator.equalsIgnoreCase(ttl, "library") || Operator.equalsIgnoreCase(ttl, "reviews") || Operator.equalsIgnoreCase(ttl, "custom")) {
								ttl = tool.getTitle();
							}
					%>
						<tr>
							<td class="csui csui_field" style="width: 1%"><input type="checkbox" name="LKUP_MODULES_ID" value="<%= tool.id() %>"/></td>
							<td class="csui csui_field" colspan="2" style="width: 99%"><%= ttl.toUpperCase() %></td>
						<%
							if (Operator.equalsIgnoreCase(ttl, "finance")) {
								Timekeeper d = new Timekeeper();
						%>
						</tr>
							<tr>
								<td class="csui_label" style="width: 1%">&nbsp;</td>
								<td class="csui_label" style="width: 1%" nowrap>Permit Fee Date</td>
								<td class="csui csui_field" style="width: 97%"><input type="text" itype="date" name="PERMIT_FEE_DATE" value="<%=d.getString("YYYY/MM/DD")%>"/></td>
						<%
							}
						%>
						</tr>
					<%
						}
					%>

					</table>
					<div class="csui_divider"></div>
					<div class="csui_buttons"><input type="submit" value="copy" class="save"/></div>
				</form>
			</div>
		</div>
	</div>
	</div>


</body>
</html>

