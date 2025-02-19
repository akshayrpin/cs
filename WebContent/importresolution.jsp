<%@page import="cs.ui.CsUiTools"%>
<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="csshared.vo.SubObjVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="csshared.vo.ResolutionDetailVO"%>
<%@page import="cs.utils.ObjTables"%>
<%@page import="csshared.vo.ResolutionVO"%>
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
	nav.setRequest("details");

	TypeVO o = ApiHandler.getType(nav);
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	String group = map.getString(RequestMapper.group);
	String grouptype = map.getString(RequestMapper.grouptype);
	String groupid = map.getString(RequestMapper.groupid);
	if (!Operator.hasValue(grouptype)) {
		grouptype = type;
	}

	String backurl = Config.fullcontexturl()+"/summary.jsp?_ent="+entity+"&_type="+type+"&_typeid="+typeid+"&_id="+typeid;

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
		

		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.act.js"></script>
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
				$('[_action]').csact(
					{
						action: '',
						entity: '<%= entity %>',
						type: '<%= type %>',
						typeid: '<%= typeid %>',
						_delete: {
							appointment: {
								confirm: {
									title: 'CANCEL',
									text: 'Are you sure you want to cancel this appointment?',
									button: 'Yes',
									cancel: 'No',
									success: 'Success',
									successtext: 'The selected appointment has been cancelled.'
								},
								prompt : {
									name: 'note',
									required: true
								}
							}
						}
					}
				);
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
											<a href="<%= backurl %>"><img src="<%= CsConfig.getImage("back") %>" height="25" width="25" border="0"/></a>
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
				<div id="saveres">
				<form class="form" action="action.jsp" success="<%=req.actionUrl()%>" method="post" ajax="no" enctype="multipart/form-data">
					<input type="hidden" name="_ent" value="<%=req.getEntity()%>"/>
					<input type="hidden" name="_type" value="<%=req.getType()%>"/>
					<input type="hidden" name="_typeid" value="<%=req.getTypeid()%>"/>
					<input type="hidden" name="_grpid" value=<%=req.getGroupid()%>/>
					<input type="hidden" name="_grp" value="<%=req.getGroup()%>"/>
					<input type="hidden" name="_grptype" value="<%=req.getGrouptype()%>"/>
					<input type="hidden" name="_id" value="<%=req.getId()%>"/>
					<input type="hidden" name="_act" value="import"/>

					<%= ObjTables.title("RESOLUTION", "", "csui", alert, "", "", "", CsConfig.getImage("back"), new String[0], "","","","") %>
					<table class="csui" colnum="2" type="default">

						<%
							out.print("<tr>");
							out.print(ObjTables.cells("FILE", "FILE", "", "file", "file", true, "csui", true));
							out.print("</tr>");
					%>

					</table>
				    <div id="saveresbutton" class="csui_buttons"><input type="submit" name="action" value="save" class="csui_button"></div>
				</form>
				</div>
			</div>



		</div>
	</div>
	</div>
	<br/><br/><br/><br/>

</body>
</html>

