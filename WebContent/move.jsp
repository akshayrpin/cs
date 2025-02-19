<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.utils.CsApi"%>
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
<%@page import="csshared.vo.TypeVO"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="alain.core.utils.Cartographer"%>
<%


	Cartographer map = new Cartographer(request,response);
	RequestVO req = RequestMapper.getRequest(map);
	RequestVO nav = req.duplicate();
	nav.setAction(map.getString(RequestMapper.action));
	nav.setRequest("fields");

	TypeVO o = CsApi.getType(nav);
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

	ObjGroupVO[] ga = o.getGroups();
	ObjGroupVO g = new ObjGroupVO();
	if (ga.length > 0) {
		g = ga[0];
	}

	if (!g.isUpdate()) {
		o = new TypeVO();
		map.forward("403.jsp");
	}

	SubObjVO[] search = new SubObjVO[0];
	SubObjVO[] streets = new SubObjVO[0];
	SubObjVO[] strmod = new SubObjVO[0];

	if (Operator.equalsIgnoreCase(type, "project")) {
		streets = CsApi.getLkupObj("streets", entity, type, -1);
		strmod = CsApi.getLkupObj("strmod", entity, type, -1);
	}
	if (map.equalsIgnoreCase(RequestMapper.action, "search")) {
		RequestVO vo = RequestMapper.getRequest(map,"search");
		search = CsApi.getChoices(vo);
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
				<%
				if (map.equalsIgnoreCase(RequestMapper.action, "search") && search.length < 1) {
				%>
				swal('Search','No results found','info');
				<%
				}
				%>
			});

			function validateMove(name) {
				var r = $('input[type=radio][name='+name+']:checked').length > 0;
				if (!r) {
					swal('Error','Please make a selection','error');
					return false;
				}
				else {
					return true;
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
				<% if (Operator.equalsIgnoreCase(type, "project")) { %>
					<table class="csui_title">
						<tr>
							<td class="csui_title" nowrap>Search Address</td>
						</tr>
					</table>
					<form id="movesearch" action="move.jsp" method="get">
						<input type="hidden" name="_ent" value="<%= entity %>">
						<input type="hidden" name="_type" value="<%= type %>">
						<input type="hidden" name="_typeid" value="<%= typeid %>">
						<input type="hidden" name="_grpid" value="move">
						<input type="hidden" name="_grp" value="move">
						<input type="hidden" name="_grptype" value="move">
						<input type="hidden" name="_act" value="search">
						<table class="csui" style="width: 100%">
							<tr>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase; width: 150px" id ="label_STR_NO">LSO ID</td>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase; width: 50px" id ="label_LSO_ID">&nbsp;</td>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase; width: 150px" id ="label_STR_NO">Street Number</td>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase; width: 150px">Fraction</td>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase" id ="label_STREET">Street Name</td>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase; width: 150px" id="label_UNIT">Unit</td>
							</tr>
							<tr>
								<td class="csui" style="width: 150px"><input type="text" itype="integer" name="LSO_ID" id="LSO_ID" placeholder="LSO ID" style="width: 150px; padding: 6px; border: 1px solid #cccccc" valrequired="true"/></td>
								<td class="csui" style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase; width: 50px; text-align: center">OR</td>
								<td class="csui" style="width: 150px"><input type="text" itype="integer" name="STR_NO" id="STR_NO" placeholder="Street Number" style="width: 150px; padding: 6px; border: 1px solid #cccccc" valrequired="true"/></td>
								<td class="csui" style="width: 150px">
									<select name="STR_MOD" style="width: 100px">
										<option value="">Choose Fraction</option>
										<%
											for (int i=0; i<strmod.length; i++) {
												SubObjVO typ = strmod[i];
												String val = Operator.toString(typ.getId());
												String txt = Operator.toString(typ.getText());
										%>
											<option value="<%= val %>"><%= txt %></option>
										<%
											}
										%>
									</select>
								</td>
								<td class="csui">
									<select name="STREET" valrequired="true">
										<option value="">Choose Street Name</option>
										<%
											for (int i=0; i<streets.length; i++) {
												SubObjVO typ = streets[i];
												String val = Operator.toString(typ.getId());
												String txt = Operator.toString(typ.getText());
										%>
											<option value="<%= val %>"><%= txt %></option>
										<%
											}
										%>
									</select>
								</td>
								<td class="csui" style="width: 150px"><input type="text" itype="String" name="UNIT" placeholder="Unit" style="width: 150px; padding: 6px; border: 1px solid #cccccc"/></td>
							</tr>
						</table>
						<div class="csui_divider"></div>
						<div class="csui_buttons"><input type="submit" value="search" class="search"/></div>
					</form>
	
					<%
						if (search.length > 0) {
					%>
					<table class="csui_title">
						<tr>
							<td class="csui_title" nowrap>Move <%= type %></td>
						</tr>
					</table>
					<form class="form" id="moveform" action="action.jsp" method="post" success="<%=req.actionUrl()%>" refresh="true">
						<input type="hidden" name="_ent" value="<%= entity %>">
						<input type="hidden" name="_type" value="<%= type %>">
						<input type="hidden" name="_typeid" value="<%= typeid %>">
						<input type="hidden" name="_grpid" value="move">
						<input type="hidden" name="_grp" value="move">
						<input type="hidden" name="_grptype" value="move">
						<input type="hidden" name="_act" value="move">
						<input type="hidden" name="_id" value="<%= req.getId() %>">
	
						<table class="csui" colnum="2" type="default">
							<tr>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase" id="label_LSO_ID">&nbsp;</td>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase">LSO ID</td>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase">Type</td>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase">Address</td>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase">City</td>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase">Description</td>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase">APN</td>
							</tr>
						<%
							for (int i=0; i<search.length; i++) {
								SubObjVO typ = search[i];
								String val = Operator.toString(typ.getId());
								String txt = typ.getText();
								String desc = typ.getDescription();
								String apn = typ.getData("APN");
								String ltyp = typ.getData("TYPE");
								String city = typ.getData("CITY");
						%>
								<tr>
									<td class="csui" style="width: 1%" nowrap><input type="radio" name="LSO_ID" value="<%= val %>"></td>
									<td class="csui" style="width: 1%" nowrap><%= val %></td>
									<td class="csui" style="width: 1%" nowrap><%= ltyp %></td>
									<td class="csui" style="width: 1%" nowrap><%= txt %></td>
									<td class="csui" style="width: 1%" nowrap><%= city %></td>
									<td class="csui"><%= desc %></td>
									<td class="csui" style="width: 1%" nowrap><%= apn %></td>
								</tr>
						<%
							}
						%>
						</table>
						<div class="csui_divider"></div>
						<div class="csui_buttons"><input type="submit" name="action" value="move" class="csui_button" onclick="return validateMove('LSO_ID')"></div>
	
					</form>
					<%
						}
					%>

				<% } else if (Operator.equalsIgnoreCase(type, "activity")) { %>
	
						<form id="movesearch" action="move.jsp" method="get">
						<input type="hidden" name="_ent" value="<%= entity %>">
						<input type="hidden" name="_type" value="<%= type %>">
						<input type="hidden" name="_typeid" value="<%= typeid %>">
						<input type="hidden" name="_grpid" value="move">
						<input type="hidden" name="_grp" value="move">
						<input type="hidden" name="_grptype" value="move">
						<input type="hidden" name="_act" value="search">
						<input type="hidden" name="_id" value="<%= req.getId() %>">
						<table class="csui_title">
							<tr>
								<td class="csui_title" nowrap>Move <%= type %></td>
							</tr>
						</table>
						<table class="csui" style="width: 100%">
							<tr>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase; width: 1%; white-space: nowrap" id ="label_PROJECT_NBR">PROJECT NUMBER</td>
								<td class="csui vertical csui_field" ><input type="text" itype="text" name="PROJECT_NBR" id="PROJECT_NBR" value="<%= map.getString("PROJECT_NBR") %>" placeholder="PROJECT NUMBER" style="width: 100%; padding: 6px; border: 1px solid #cccccc"/></td>
							</tr>
						</table>
						<div class="csui_divider"></div>
						<div class="csui_buttons"><input type="submit" value="search" class="save"/></div>
					</form>
					<%
						if (search.length > 0) {
					%>
					<table class="csui_title">
						<tr>
							<td class="csui_title" nowrap>Move <%= type %></td>
						</tr>
					</table>
					<form class="form" id="moveform" action="action.jsp" method="post" success="<%=req.actionUrl()%>" refresh="true">
						<input type="hidden" name="_ent" value="<%= entity %>">
						<input type="hidden" name="_type" value="<%= type %>">
						<input type="hidden" name="_typeid" value="<%= typeid %>">
						<input type="hidden" name="_grpid" value="move">
						<input type="hidden" name="_grp" value="move">
						<input type="hidden" name="_grptype" value="move">
						<input type="hidden" name="_act" value="move">
						<input type="hidden" name="_id" value="<%= req.getId() %>">
	
						<table class="csui" colnum="2" type="default">
							<tr>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase" id="label_PROJECT_ID">&nbsp;</td>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase">Project Number</td>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase">Description</td>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase">Type</td>
								<td style="padding: 10px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase">Address</td>
							</tr>
						<%
							for (int i=0; i<search.length; i++) {
								SubObjVO typ = search[i];
								String val = Operator.toString(typ.getId());
								String txt = typ.getText();
								String desc = typ.getDescription();
								String ltyp = typ.getData("TYPE");
								String address = typ.getData("ADDRESS");
						%>
								<tr>
									<td class="csui" style="width: 1%" nowrap><input type="radio" name="PROJECT_ID" value="<%= val %>"></td>
									<td class="csui" style="width: 1%" nowrap><%= txt %></td>
									<td class="csui"><%= desc %></td>
									<td class="csui" style="width: 1%" nowrap><%= ltyp %></td>
									<td class="csui" style="width: 1%" nowrap><%= address %></td>
								</tr>
						<%
							}
						%>
						</table>
						<div class="csui_divider"></div>
						<div class="csui_buttons"><input type="submit" name="action" value="move" class="csui_button" onclick="return validateMove('PROJECT_ID')"></div>
	
					</form>
					<%
						}
					%>



				<% } %>
			</div>
		</div>
	</div>
	</div>


</body>
</html>

