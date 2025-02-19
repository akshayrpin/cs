<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.utils.CsApi"%>
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
<%@page import="csshared.vo.TypeVO"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="alain.core.utils.Cartographer"%>
<%


	Cartographer map = new Cartographer(request,response, true);
	RequestVO req = RequestMapper.getRequest(map);
	RequestVO nav = req.duplicate();
	nav.setAction(map.getString(RequestMapper.action));
//	nav.setRequest("details");
	if (map.equalsIgnoreCase(RequestMapper.action, "add")) {
	//	nav.setRequest("fields");
	}
	else {
		nav.setRequest("details");
	}
	TypeVO o = CsApi.getType(nav);
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	int id = map.getInt(RequestMapper.id);
	String group = map.getString(RequestMapper.group);
	String groupid = map.getString(RequestMapper.groupid);
	String grouptype = map.getString(RequestMapper.grouptype);
	if (!Operator.hasValue(grouptype)) {
		grouptype = type;
	}

	DataVO dvo = DataVO.toDataVO(o);
	SubObjVO[] types = CsApi.getLkupObj("type", entity, "notes", dvo.getInt("LKUP_NOTES_TYPE_ID"));

	RequestVO ureq = req.duplicate();
	ureq.setGrouptype("communications");
	ureq.setRequest("recipients");
	SubObjVO[] people = CsApi.getChoices(ureq);

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
				toggleEmail();
				$('[name=LKUP_NOTES_TYPE_ID]').change(function(e) {
					toggleEmail();
				});
			});

			function toggleEmail() {
				var tselect = $('select[name=LKUP_NOTES_TYPE_ID] option:selected');
				var ntfy = tselect.attr("NOTIFY");
				if (ntfy == 'Y' && <%=people.length%> > 0) {
					$('#EMAILFORM').show();
				}
				else {
					$('#EMAILFORM').hide();
				}
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
											<a href="<%= Config.fullcontexturl() %>/viewpeople.jsp?_ent=<%= entity %>&_type=<%= type %>&_grptype=people&_typeid=<%= typeid %>&_id=<%=id %>"><img src="<%= CsConfig.getImage("back") %>" height="25" width="25" border="0"/></a>
										
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
				<form class="form" action="action.jsp" method="post" success="viewpeople.jsp?_ent=<%= entity %>&_type=<%= type %>&_grptype=people&_typeid=<%= typeid %>&_id=<%=id %>" refresh="true">
					<input type="hidden" name="_ent" value="<%=entity%>">
					<input type="hidden" name="_type" value="<%= type %>">
					<input type="hidden" name="_typeid" value="<%=typeid%>">
					<input type="hidden" name="_grpid" value="notes">
					<input type="hidden" name="_grp" value="notes">
					<input type="hidden" name="_grptype" value="notes">
					<input type="hidden" name="_id" value="<%=id%>">
					<input type="hidden" name="_act" value="saveusernotes">
				
				
					<table class="csui_title csuialert" alert="<%=alert%>">
						<tr>
							<td class="csui_title" nowrap>NOTE</td>
						</tr>
					</table>
					<table class="csui" colnum="2" type="default">
						<tr>
							<%= ObjTables.cells("NOTE", "NOTE", "", "String", "textarea", false, "csui", true) %>
							<%= ObjTables.cells("LKUP_NOTES_TYPE_ID", "TYPE", dvo.getString("LKUP_NOTES_TYPE_ID"), "select", "type", true, "csui", 1, types, false, true) %>
						</tr>
					</table>
			
					<div class="csui_divider"></div>
					<div class="csui_buttons"><input type="submit" name="action" value="save notes"  class="csui_button"></div>
				</form>
			</div>
		</div>
	</div>
	</div>
<br/><br/><br/>

</body>
</html>

