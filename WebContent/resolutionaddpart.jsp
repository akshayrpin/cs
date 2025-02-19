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

	RequestVO treq = req.duplicate();
	treq.setRequest("status");
	SubObjVO[] status = ApiHandler.getChoices(treq);

	String redirecturl = Config.fullcontexturl()+"/resolutionaddpart.jsp?_id=0&_entid=0&_ent=lso&_typeid="+typeid+"&_type="+type+"&_grpid="+groupid+"&_grp=resolution&_grptype=resolution&_reload=true"; 
	Timekeeper d = new Timekeeper();
	String ftitle = rvo.getNumber() + ": " + rvo.getTitle();


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
						<td align="left" id="title">Add New Part</td>
					</tr>
				</table>
				<div id="csform_message"></div>
				<%
					String t = "permanent";
					if (type.equalsIgnoreCase("project") || type.equalsIgnoreCase("activity")) {
						t = "temporary";
					}
				%>
	
				 <table class="csui_title csuialert">
				   <tr>
				     <td class="csui_title"><%= ftitle %></td>
				   </tr>
				 </table>

				<form class="form" action="action.jsp" method="post" success="<%=redirecturl%>">
					<input type="hidden" name="_ent" value="<%=req.getEntity()%>">
					<input type="hidden" name="_type" value="<%=req.getType()%>">
					<input type="hidden" name="_typeid" value="<%=req.getTypeid()%>">
					<input type="hidden" name="_grpid" value=<%=req.getGroupid()%>>
					<input type="hidden" name="_grp" value="<%=req.getGroup()%>">
					<input type="hidden" name="_grptype" value="<%=req.getGrouptype()%>">
					<input type="hidden" name="_id" value="<%=req.getId()%>">
					<table class="csui" type="horizontal">
					<tr>
					<%= ObjTables.cells("PART", "PART", "", "String", "text", true, "csui", true) %>
					<%= ObjTables.cells("DATE", "RESOLUTION DATE", d.getString("YYYY/MM/DD"), "date", "date", true, "csui", true) %>
					</tr>
					<tr>
					<%= ObjTables.cells("STATUS_ID", "STATUS", "", "String", "text", true, "csui", 1, status, false, true) %>
					<%= ObjTables.cells("EXP_DATE", "EXPIRATION DATE", "", "date", "date", false, "csui", true) %>
					</tr>
					<tr>
					<%= ObjTables.cells("PART_TITLE", "PART TITLE", "", "String", "text", true, "csui", true) %>
					<%= ObjTables.cells("TYPE", "TYPE", t, "String", "text", true, "csui", "permanent,temporary", false, true) %>
					<tr>
					<%= ObjTables.cells("DESCRIPTION", "DESCRIPTION", "", "String", "largetextarea", true, "csui", true) %>
					</table>
				    <div class="csui_buttons"><input type="submit" name="action" value="add" class="csui_button"></div>
				</form>

			</div>



		</div>
	</div>
	</div>


</body>
</html>

