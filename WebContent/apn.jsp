<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.utils.CsApi"%>
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
	Cartographer map = new Cartographer(request,response);
	
	RequestVO req = RequestMapper.getRequest(map);
	RequestVO nav = req.duplicate();
	nav.setAction(map.getString(RequestMapper.action));
//	nav.setRequest("details");
	nav.setRequest("details");
	

	TypeVO o = CsApi.getType(nav);
	if (!o.isUpdate()) {
		o = new TypeVO();
		map.forward("403.jsp");
	}

	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	String group = map.getString(RequestMapper.group);
	String groupid = map.getString(RequestMapper.groupid);
	String grouptype = map.getString(RequestMapper.grouptype);
	if (!Operator.hasValue(grouptype)) {
		grouptype = type;
	}

	DataVO dvo = DataVO.toDataVO(o);

	TypeVO l = new TypeVO();
	

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
			});

			function addTeam(choices, fieldid) {
				try {
					var parray = choices.split('|');
					for (i = 0; i < parray.length; i++) { 
						var rec = parray[i];
						var arr = rec.split('::');
						if (arr.length > 0) {
							var id = arr[0];
							if (arr.length > 1) {
								var name = arr[1];
								var type = '';
								if (arr.length > 2) {
									type = arr[2];
								}
								populateTeamTable(id, name, type, fieldid);
							}
						}
					}
				} catch(e) { }
			}

			function addTeamMember(choices, fieldid) {
				try {
					var parray = choices.split('|');
					for (i = 0; i < parray.length; i++) { 
						var rec = parray[i];
						var arr = rec.split('::');
						if (arr.length > 0) {
							var id = arr[0];
							if (arr.length > 1) {
								var name = arr[1];
								var type = '';
								if (arr.length > 2) {
									type = arr[2];
								}
								$('.teamrow_'+fieldid).remove();
								populateTeamTable(id, name, type, fieldid);
							}
						}
					}
				} catch(e) { }
			}

			function populateTeamTable(id, name, type, fieldid) {
				var ctable = $('#table_'+fieldid);
				var ctr = $('<tr class=\"teamrow_'+fieldid+'\"/>');
				ctr.attr('id','team_'+id);
				var cchktd = $('<td/>');
				cchktd.css({
					'border-top': '1px solid #eeeeee',
					'width': '1%'
				});
				cchktd.addClass('csform_checkbox');
				var cchk = $('<input/>');
				cchk.attr('type','checkbox');
				cchk.attr('name', fieldid);
				cchk.prop('checked', true);
				cchk.val(id);
				cchk.addClass('csform_checkbox');
				cchktd.append(cchk);
				ctr.append(cchktd);

				var cnametd = $('<td/>');
				cnametd.css({
					'border-top': '1px solid #eeeeee'
				});
				cnametd.addClass('csform_checkboxtext');
				cnametd.html(name);
				ctr.append(cnametd);

				var ctypetd = $('<td/>');
				ctypetd.css({
					'border-top': '1px solid #eeeeee',
					'text-align': 'right'
				});
				ctypetd.addClass('csform_checkboxtext');
				ctypetd.html(type);
				ctr.append(ctypetd);

				ctable.append(ctr);
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
				<%String s = "<div class=\"csui_buttons\"><input type=\"submit\" name=\"action\" value=\"save\" class=\"csui_button\"></div>" ;%>
				<%= Operator.replace(CsUi.form(req, o, "csui", alert),s,"") %>
				
				
			</div>
		</div>
	</div>
	</div>


</body>
</html>

