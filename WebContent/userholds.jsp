<%@page import="cs.ui.CsUiTools"%>
<%@page import="cs.common.ApiHandler"%>
<%@page import="csshared.vo.SubObjVO"%>
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
	Cartographer map = new Cartographer(request,response, true);
	if (!Operator.hasValue(map.token()) || !Operator.hasValue(map.username())) {
		map.logout();
		map.requireLogin();
	}
	RequestVO req = RequestMapper.getRequest(map);
	RequestVO nav = req.duplicate();
	nav.setAction(map.getString(RequestMapper.action));
	String id =map.getString(RequestMapper.id);
//	nav.setRequest("details");
	if (map.equalsIgnoreCase(RequestMapper.action, "add")) {
		nav.setRequest("fields");
	}
	else {
		nav.setRequest("details");
		 id = map.get("PEOPLE_ID");
	}
	
	 if(Operator.hasValue(req.groupid)){
		 nav.setType("users");
	   nav.setTypeid(Operator.toInt(req.groupid));
	} 
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
	String action = map.getString(RequestMapper.action);
	String group = map.getString(RequestMapper.group);
	String groupid = map.getString(RequestMapper.groupid);

	String grouptype = map.getString(RequestMapper.grouptype);
	if (!Operator.hasValue(grouptype)) {
		grouptype = type;
	}
	//typeid= Operator.toInt(groupid);
	DataVO dvo = DataVO.toDataVO(o);
	RequestVO ureq = req.duplicate();
	ureq.setType("users");
	ureq.setGrouptype("holds");
	ureq.setRequest("types");
	ureq.setId(map.get("users_type_id"));
	SubObjVO[] types = CsApi.getChoices(ureq);
	
	TypeVO l = new TypeVO();
	if (dvo.isHistory() && dvo.getId() > 0) {
		RequestVO list = new RequestVO();
		list = req.duplicate();
		list.setType("users");
		list.setTypeid(Operator.toInt(req.groupid));
		list.setGroupid(Operator.toString(dvo.getId()));
		list.setRequest("list");
		l = CsApi.getType(list);
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
				/* $('#editpeople').csform({
					callback: {
						submit: {
							success: function(d) { select(d); }
						}
					}
				}); */
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
				<form  id="editpeople" class="form" action="action.jsp" method="post" success="<%= Config.fullcontexturl() %>/viewpeople.jsp?_ent=<%= entity %>&_type=<%= type %>&_grptype=people&_typeid=<%= typeid %>&_id=<%=id %>" refresh="true">
					<input type="hidden" name="_ent" value="<%= entity %>">
					<input type="hidden" name="_type" value="<%= type %>">
					<input type="hidden" name="_typeid" value="<%= typeid %>">
					<input type="hidden" name="_grpid" value="<%= groupid %>">
					<input type="hidden" name="_act" value="saveuserholds">
					<table class="csui_title csuialert" alert="<%= alert %>">
						<tr>
							<td class="csui_title">holds</td>
						</tr>
					</table>
					<table class="csui" colnum="2" type="default">
						<tr>
							<!-- <td class="csui_label" colnum="2" alert="" id="label_LKUP_HOLDS_TYPE_ID">TYPE</td> -->
							<%if(action.equalsIgnoreCase("add")){ %>
							<!-- <td class="csui vertical csui_field" colnum="2" type="String" itype="String" alert="" id="field_LKUP_HOLDS_TYPE_ID"><select name="LKUP_HOLDS_TYPE_ID" itype="String" val="1" _ent="lso" valrequired="true" lkup="typedescriptions"><option value=""></option></select></td> -->
							<%= ObjTables.cells("LKUP_HOLDS_TYPE_ID", "TYPE", dvo.getString("LKUP_HOLDS_TYPE_ID"), "String", "text", true, "csui", 1, types, false, true) %>
							<%}else{ %>
							<td class="csui_label" colnum="2" alert="" id="label_LKUP_HOLDS_TYPE_ID">TYPE</td>
							<td class="csui vertical csui_field" colnum="2" type="String" itype="String" alert="" id="field_LKUP_HOLDS_TYPE_ID"><%= dvo.getText("LKUP_HOLDS_TYPE_ID") %></td>
							<%} %>
							<td class="csui_label" colnum="2" alert="" id="label_LKUP_HOLDS_STATUS_ID">STATUS</td>
							<td class="csui vertical csui_field" colnum="2" type="String" itype="String" alert="" id="field_LKUP_HOLDS_STATUS_ID"><select name="LKUP_HOLDS_STATUS_ID" itype="String" val="1" _ent="lso" valrequired="true" lkup="statusdescriptions"><option value=""></option></select></td>
						</tr>
						<tr>
							<td class="csui_label" colnum="2" alert="" id="label_DESCRIPTION">DESCRIPTION</td>
							<td class="csui vertical csui_field" colspan="3" colnum="2" type="String" itype="largetextarea" alert="" id="field_DESCRIPTION"><textarea name="DESCRIPTION" itype="largetextarea" valrequired="true"></textarea></td>
						</tr>
					</table>
					<!-- <input type="hidden" name="_grpid" value="holds"> -->
					<input type="hidden" name="_grp" value="holds">
					<input type="hidden" name="_grptype" value="holds">
					<input type="hidden" name="_ref" value="users">
					<input type="hidden" name="_id" value="<%= dvo.getId() %>">
					<div class="csui_divider"></div>
					<div class="csui_buttons"><input type="submit" name="action" value="save" class="csui_button"></div>
				
				</form>
				<%
					if (dvo.isHistory() && dvo.getId() > 0) {
						out.print(CsUi.list(req, l, "csui", alert));
					}
				%>
			</div>
		</div>
	</div>
	</div>


</body>
</html>

