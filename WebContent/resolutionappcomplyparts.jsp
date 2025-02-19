<%@page import="cs.ui.CsUiTools"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
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
	int id = map.getInt(RequestMapper.id);
	int typeid = map.getInt(RequestMapper.typeid);
	String group = map.getString(RequestMapper.group);
	String grouptype = map.getString(RequestMapper.grouptype);
	String groupid = map.getString(RequestMapper.groupid);

	if (!Operator.hasValue(grouptype)) {
		grouptype = type;
	}

	ObjGroupVO[] gvos = o.getGroups();
	ObjGroupVO gvo = new ObjGroupVO();
	ResolutionVO rvo = new ResolutionVO();
	if (gvos.length > 0) {
		gvo = gvos[0];
		ResolutionVO[] rvos = gvo.getResolutions();
		if (rvos.length > 0) {
			rvo = rvos[0];
		}
	}

	String ftitle = rvo.getNumber() + ": " + rvo.getTitle();
	String redirecturl = Config.fullcontexturl()+"/resolutionappcomplyparts.jsp?_id=0&_entid=0&_ent="+entity+"&_typeid="+typeid+"&_type="+type+"&_grpid="+groupid+"&_grp="+group+"&_grptype="+grouptype+"&_reload=true"; 

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
			var grouptype = '<%=grouptype%>';
			var fullcontexturl = '<%=Config.fullcontexturl()%>';
			$(document).ready(function() {
				<% if (map.equalsIgnoreCase("_reload","true")) { %>
				parent.fancybox_reload = true;
				parent.jQuery.fancybox.close();
				<% } %>
			});
		</script>
	
	</head>
<body>

	<div id="fullpage">
	<div id="loader"></div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
				<table cellpadding="10" cellspacing="0" border="0" width="100%">
					<tr>
						<td align="left" id="title">Application Compliance - Comply All</td>
					</tr>
				</table>
				<div id="csform_message"></div>
				<form class="form" action="action.jsp" method="post" success="<%=redirecturl%>">
					<input type="hidden" name="_ent" value="<%=req.getEntity()%>">
					<input type="hidden" name="_type" value="<%=req.getType()%>">
					<input type="hidden" name="_typeid" value="<%=req.getTypeid()%>">
					<input type="hidden" name="_grpid" value=<%=req.getGroupid()%>>
					<input type="hidden" name="_grp" value="<%=req.getGroup()%>">
					<input type="hidden" name="_grptype" value="<%=req.getGrouptype()%>">
					<input type="hidden" name="_id" value="<%=req.getId()%>">
					<input type="hidden" name="_act" value="appcomplyall">

					<%= ObjTables.title(ftitle, "", "csui", alert, "", "", "", CsConfig.getImage("back"), new String[0], "","","","") %>
					<table class="csui" colnum="2" type="default">
						<tr>
							<td class="csui_label" id="label_DATE" valign="top">COMPLIANCE DATE</td>
							<td class="csui vertical csui_field" id="field_DATE" valign="top">
								<input name="COMPLIANCE_DATE" type="text" itype="date" value="">
							</td>
						</tr>
					</table>
					<br/>
				    <div class="csui_buttons"><input type="submit" name="action" value="save" class="csui_button"></div>

				</form>

			</div>



		</div>
	</div>
	</div>


</body>
</html>

