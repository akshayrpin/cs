<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.vo.TypeInfo"%>
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


	Cartographer map = new Cartographer(request,response);
	RequestVO req = RequestMapper.getRequest(map);
	RequestVO nav = req.duplicate();
	nav.setAction(map.getString(RequestMapper.action));
//	nav.setRequest("details");
	if (map.equalsIgnoreCase(RequestMapper.action, "add")) {
		nav.setRequest("fields");
	}
	else {
		nav.setRequest("details");
	}
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	String group = map.getString(RequestMapper.group);
	String groupid = map.getString(RequestMapper.groupid);
	String grouptype = map.getString(RequestMapper.grouptype);
	if (!Operator.hasValue(grouptype)) {
		grouptype = type;
	}

	RequestVO tpvo = req.duplicate();
	tpvo.setRequest("type");
	SubObjVO[] types = ApiHandler.getChoices(tpvo);

	RequestVO spvo = req.duplicate();
	spvo.setRequest("status");
	SubObjVO[] status = ApiHandler.getChoices(spvo);

	TypeVO o = ApiHandler.getType(nav);
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	TypeInfo tinfo = o.getTypeinfo();

	DataVO dvo = DataVO.toDataVO(o);

	TypeVO l = new TypeVO();
	if (dvo.isHistory() && dvo.getId() > 0) {
		RequestVO list = new RequestVO();
		list = req.duplicate();
		list.setGroupid(Operator.toString(dvo.getId()));
		list.setRequest("list");
		l = ApiHandler.getType(list);
	}
	String createnewurl = Config.fullcontexturl()+"/project.jsp?_ent="+tinfo.getEntity()+"&_entid="+tinfo.getEntityid()+"&_type="+tinfo.getEntity()+"&_typeid="+tinfo.getEntityid()+"&_grptype=project&_act=add&prtype="+dvo.getString("LKUP_PROJECT_TYPE_ID");

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
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.project.js"></script>
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
				<% if (!map.equalsIgnoreCase(RequestMapper.action, "add")) { %>
					var stselect = $('[name=LKUP_PROJECT_STATUS_ID]');
					stselect.change(function() {
						recreate();
					});
				<% } else if (map.getInt("prtype") > 0){ %>
						var sttype = $('[name=LKUP_PROJECT_TYPE_ID]');
						sttype.val('<%=map.getInt("prtype")%>');
						sttype.trigger("chosen:updated");
				<% } %>
			});
			function recreate() {
				var stselect = $('[name=LKUP_PROJECT_STATUS_ID]');
				var ex = $('option:selected', stselect).attr('expired');
				if (ex == 'N') {
					$('#saveandcreate').hide();
				}
				else {
					$('#saveandcreate').show();
				}
			}
			function createredir() {
				altsuccessredirect = true;
				return true;
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
				<table class="csui_title">
					<tr>
						<td class="csui_title" nowrap>Project</td>
					</tr>
				</table>
				<form class="form" id="projectform" action="action.jsp" success="<%= req.actionUrl() %>" altsuccess="<%= createnewurl %>" refresh="true" method="post">
					<input type="hidden" name="_ent" value="<%= entity %>">
					<input type="hidden" name="_type" value="<%= type %>">
					<input type="hidden" name="_typeid" value="<%= typeid %>">
					<input type="hidden" name="_grpid" value="project">
					<input type="hidden" name="_grp" value="project">
					<input type="hidden" name="_grptype" value="project">
					<input type="hidden" name="_id" value="<%= req.getId() %>">


					<table class="csui" colnum="2" type="default">
						<tr>
							<%= ObjTables.cells("NAME", "NAME", dvo.getString("NAME"), "String", "text", true, "csui", true) %>
							<%= ObjTables.cells("LKUP_PROJECT_TYPE_ID", "PROJECT TYPE", dvo.getString("LKUP_PROJECT_TYPE_ID"), "select", "prjtype", true, "csui", 1, types, false, !Operator.equalsIgnoreCase(type, "project")) %>
						</tr>
						<tr>
							<%= ObjTables.cells("DESCRIPTION", "DESCRIPTION", dvo.getString("DESCRIPTION"), "String", "text", false, "csui", true) %>
							<%= ObjTables.cells("LKUP_PROJECT_STATUS_ID", "STATUS", dvo.getString("LKUP_PROJECT_STATUS_ID"), "select", "status", true, "csui", 1, status, false, true) %>
						</tr>
						<tr>
							<%= ObjTables.cells("CIP_ACCTNO", "CIP", dvo.getString("CIP_ACCTNO"), "String", "text", false, "csui", true) %>
							<%= ObjTables.cells("APPLIED_DT", "APPLIED DATE", dvo.getString("APPLIED_DT"), "date", "date", 1, false, "csui", true) %>
						</tr>
						<tr>
							<%= ObjTables.cells("VALUATION_DECLARED", "VALUATION DECLARED", dvo.getString("VALUATION_DECLARED"), "currency", "currency", false, "csui", true) %>
							<%= ObjTables.cells("START_DT", "START DATE", dvo.getString("START_DT"), "date", "date", 1, false, "csui", true) %>
						</tr>
						<tr>
							<%= ObjTables.cells("VALUATION_CALCULATED", "VALUATION CALCULATED", dvo.getString("VALUATION_CALCULATED"), "currency", "currency", false, "csui", true) %>
							<%= ObjTables.cells("COMPLETION_DT", "COMPLETION DATE", dvo.getString("COMPLETION_DT"), "date", "date", 1, false, "csui", true) %>
						</tr>
						<tr>
							<%= ObjTables.cells("", "", "", "", "", false, "csui", false) %>
							<%= ObjTables.cells("EXPIRED_DT", "EXPIRED DATE", dvo.getString("EXPIRED_DT"), "date", "date", false, "csui", true) %>
						</tr>
					</table>
					<div id="autoactivitiesdiv" style="display: none">
						<div class="csui_divider"></div>
						<table class="csui_title">
							<tr>
								<td class="csui_title" nowrap>ADD ACTIVITIES</td>
							</tr>
						</table>
						<table class="csui">
							<tr>
								<%= ObjTables.cells("ACTIVITY_DESCRIPTION", "ACTIVITY DESCRIPTION", "", "String", "text", false, "csui", true) %>
							</tr>
						</table>
						<table class="csui" id="autoactivities">
						</table>
					</div>
					<div class="csui_divider"></div>
					<div class="csui_buttons"><span id="saveandcreate" style="display: none"><input type="submit" name="action" value="save and create new project" class="csui_button save" onclick="return createredir()">&nbsp;</span><input type="submit" name="action" value="save" class="csui_button"></div>




				</form>
			</div>
		</div>
	</div>
	</div>


</body>
</html>

