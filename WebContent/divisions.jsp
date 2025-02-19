<%@page import="cs.ui.CsUiTools"%>
<%@page import="java.util.HashMap"%>
<%@page import="csshared.vo.SubObjVO"%>
<%@page import="csshared.vo.DivisionsVO"%>
<%@page import="csshared.vo.DivisionsList"%>
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
//	nav.setRequest("details");
	if (map.equalsIgnoreCase(RequestMapper.action, "add")) {
		nav.setRequest("fields");
	}
	else {
		nav.setRequest("details");
	}

	TypeVO o = ApiHandler.getType(nav);
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

	DivisionsList d = ApiHandler.getDivisions(req);

%><html>
	<head>
	
		<%= CsUiTools.getHTMLImports() %>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.invisible.css"/>
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

		<style>
			.updating { background-color: #ffffcc !important }
			.success { background-color: #ccffcc !important }
			.error { background-color: #ffcccc !important }
		</style>	

		<script>
			var entity = '<%= entity %>';
			var type = '<%= type %>';
			var typeid = '<%= typeid %>';
			var group = '<%=group%>';
			var groupid = '<%=groupid%>';
			var grouptype = '<%=grouptype%>';
			var fullcontexturl = '<%=Config.fullcontexturl()%>';

			$(document).ready(function() {
				$('select').change(function() {
					var s = $(this);
					var o = $("option:selected", this);
					var dtypeid = s.attr("LKUP_DIVISIONS_TYPE_ID");
					var lsoid = s.attr("LSO_ID");
					var clsoid = s.attr("CURRENT_LSO_ID");
					var divid = o.val();
					var urladdrss = '/cs/json/updateval.jsp?';
					urladdrss += '_ent=lso';
					urladdrss += '&_entid='+clsoid;
					urladdrss += '&_type=lso&_typeid='+lsoid;
					urladdrss += '&_grptype=divisions';
					urladdrss += '&_grpid='+dtypeid;
					urladdrss += '&_id='+divid;
					var c = $('#TYPE_'+dtypeid);
					c.addClass('updating');
					c.removeClass('success');
					c.removeClass('error');
					c.text('updating...');
					var a = $.ajax({
						url: urladdrss,
						async: false,
						type:'POST', 
						dataType: 'json',
						success: function(result) {
							r = result;
							var i = r['info'];
							var d = i['division'];
							setTimeout(function(){
								c.text(d);
								c.removeClass('updating');
								c.addClass('success');
							}, 500);
						},
						error: function(xhr,status,error) {
							c.text('Error')
							c.removeClass('updating');
							c.addClass('error');
							cslog(xhr.responseText, 'Ajax Response');
							cslog(status, 'Ajax Error');
						}
					});

				});
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
				<form class="form" action="action.jsp" method="post" success="<%=req.actionUrl()%>" refresh="true">
					<table class="csui_title csuialert" alert="<%=alert%>">
						<tr>
							<td class="csui_title" nowrap>DIVISIONS</td>
						</tr>
					</table>
				<table class="csui" alert="<%=alert%>">
					<tr>
						<td class="csui_label" type="type" itype="type" valign="top">DIVISION TYPE</td>
						<td class="csui_label" valign="top" style="width: 25%">LAND (L)</td>
					<% int w = 50; %>
					<%
						if (Operator.equalsIgnoreCase(d.level(), "S") || Operator.equalsIgnoreCase(d.level(), "O")) {
							w = 33;
					%>
						<td class="csui_label" valign="top" style="width: 25%">STRUCTURE (S)</td>
					<% } %>
					<%
						if (Operator.equalsIgnoreCase(d.level(), "O")) {
							w = 25;
					%>
						<td class="csui_label" valign="top" style="width: 25%">OCCUPANCY (O)</td>
					<% } %>
						<td class="csui_label" valign="top" style="width: 24%">DERIVED DIVISION</td>
					</tr>

				<%
					while (d.next()) {
						DivisionsVO dvo = d.getDivision();
						DivisionsVO ld = d.getLevel("L");
						DivisionsVO sd = d.getLevel("S");
						DivisionsVO od = d.getLevel("O");
						SubObjVO[] lc = ld.getChoices();
						SubObjVO[] sc = sd.getChoices();
						SubObjVO[] oc = od.getChoices();
						if (!Operator.hasValue(lc)) { lc = dvo.getChoices(); }
						if (!Operator.hasValue(sc)) { sc = dvo.getChoices(); }
						if (!Operator.hasValue(oc)) { oc = dvo.getChoices(); }
						String dtypeid = Operator.toString(dvo.getDivisiontypeid());
						HashMap<String, String> la = new HashMap<String, String>();
						la.put("LSO_ID", Operator.toString(d.landId()));
						la.put("LKUP_DIVISIONS_TYPE_ID", dtypeid);
						la.put("CURRENT_LSO_ID", Operator.toString(d.getLsoid()));
						HashMap<String, String> sa = new HashMap<String, String>();
						sa.put("LSO_ID", Operator.toString(d.structureId()));
						sa.put("LKUP_DIVISIONS_TYPE_ID", dtypeid);
						sa.put("CURRENT_LSO_ID", Operator.toString(d.getLsoid()));
						HashMap<String, String> oa = new HashMap<String, String>();
						oa.put("LSO_ID", Operator.toString(d.occupancyId()));
						oa.put("LKUP_DIVISIONS_TYPE_ID", dtypeid);
						oa.put("CURRENT_LSO_ID", Operator.toString(d.getLsoid()));
						StringBuilder sb = new StringBuilder();
						sb.append("TYPE_").append(dtypeid);
						String colid = sb.toString();
				%>
					<tr>
						<td class="csui_label" type="type" itype="type" valign="top"><%= dvo.getDivisiontype() %></td>
						<td class="csui vertical  csui_field" valign="top" style="width: <%=w%>%">
							<%= ObjTables.select("LKUP_DIVISIONS_ID", "TYPE", Operator.toString(ld.getDivisionid()), "select", false, lc, la, false) %>
						</td>
					<% if (Operator.equalsIgnoreCase(d.level(), "S") || Operator.equalsIgnoreCase(d.level(), "O")) { %>
						<td class="csui vertical  csui_field" valign="top" style="width: <%=w%>%">
							<%= ObjTables.select("LKUP_DIVISIONS_ID", "TYPE", Operator.toString(sd.getDivisionid()), "select", false, sc, sa, false) %>
						</td>
					<% } %>
					<% if (Operator.equalsIgnoreCase(d.level(), "O")) { %>
						<td class="csui vertical  csui_field" valign="top" style="width: <%=w%>%">
							<%= ObjTables.select("LKUP_DIVISIONS_ID", "TYPE", Operator.toString(od.getDivisionid()), "select", false, oc, oa, false) %>
						</td>
					<% } %>
						<td class="csui vertical  csui_field" valign="top" style="background-color: #eeeeee; width: <%=w-1%>%" id="<%=colid%>"><%= dvo.getDivision() %></td>
					</tr>
				<% } %>
				</table>
					<table>
						<tr>
							<td class="common" align="right">Note: Your changes will be automatically saved. Check the "Derived Division" column to determine the derived value for this lso level.</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	</div>


</body>
</html>

