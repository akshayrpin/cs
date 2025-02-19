<%@page import="cs.utils.ObjForm"%>
<%@page import="csshared.utils.CsApi"%>
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
	//nav.setRequest("details");
	if (map.equalsIgnoreCase(RequestMapper.action, "add")) {
		nav.setRequest("fields");
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
	SubObjVO[] projecttype = CsApi.getLkupObj("status", entity, "projectinfo", dvo.getInt("LKUP_PROJECTINFO_PROJECT_ID"));

	SubObjVO[] buildingtype = CsApi.getLkupObj("type", entity, "projectinfo", dvo.getInt("LKUP_PROJECTINFO_BUILDINGTYPE_ID"));
	
	SubObjVO[] buildinguse = CsApi.getLkupObj("typedescriptions", entity, "projectinfo", dvo.getInt("LKUP_PROJECTINFO_BUILDINGUSE_ID"));

	//SubObjVO[] changeuse = CsApi.getLkupObj("statusdescriptions", entity, "projectinfo", dvo.getInt("LKUP_PROJECTINFO_USE_ID"));


%><html>
	<head>
	
		<link href='https://fonts.googleapis.com/css?family=Oswald:300,700' rel='stylesheet' type='text/css'>
		<link href='https://fonts.googleapis.com/css?family=Armata' rel='stylesheet' type='text/css'>
		<link href='https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700' rel='stylesheet' type='text/css'>
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
	
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/jquery.min.js"></script>
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
			
			$(document).ready(function(){
				checkProject();
				
				$('[name=LKUP_PROJECTINFO_PROJECT_ID]').chosen().change(function (){
					checkProject();
				});
				$('[name=LKUP_PROJECTINFO_BUILDINGTYPE_ID]').chosen().change(function (){
					checkProject();
				});
				$('[name=LKUP_PROJECTINFO_BUILDINGUSE_ID]').chosen().change(function (){
					checkProject();
				});
				/* $('[name=LKUP_PROJECTINFO_USE_ID]').chosen().change(function (){
					checkProject();
				}); */
				
				$('#OTHER_USE_EXISTING').val("<%= dvo.getString("OTHER_USE_EXISTING") %>");
				$('#OTHER_USE_EXISTING').trigger('chosen:updated');
				$('#OTHER_USE_PROPOSED').val("<%= dvo.getString("OTHER_USE_PROPOSED") %>");
				$('#OTHER_USE_PROPOSED').trigger('chosen:updated');
			});
			
			function checkProject() {
				if($("[name=LKUP_PROJECTINFO_PROJECT_ID] option:selected").text() == 'Other') {
					$('#p1').show();
					$('#p2').hide();
				} else { 
					$('#p1').hide();
					$('#p2').show();
				}
				if($("[name=LKUP_PROJECTINFO_BUILDINGTYPE_ID] option:selected").text() == 'Other') {
					$('#b1').show();
					$('#b2').hide();
				} else {
					$('#b1').hide();
					$('#b2').show();
				}
				if($("[name=LKUP_PROJECTINFO_BUILDINGUSE_ID] option:selected").text() == 'Mixed Use' || $("[name=LKUP_PROJECTINFO_BUILDINGUSE_ID] option:selected").text() == 'Other') {
					$('#bu1').show();
					$('#bu2').hide();
				} else {
					$('#bu1').hide();
					$('#bu2').show();
					$('#OTHER_BUILDING_USE').val('');
				}
				if($("[name=LKUP_PROJECTINFO_BUILDINGUSE_ID] option:selected").text() == 'Change of Use') {
					$('#change').show();
				} else {
					$('#change').hide();
					$('#OTHER_USE_EXISTING').val('');$('#OTHER_USE_EXISTING').trigger('chosen:updated');
					$('#OTHER_USE_PROPOSED').val('');$('#OTHER_USE_PROPOSED').trigger('chosen:updated');
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
				
				<div id="csform_message"></div>
				<form class="form" action="action.jsp" method="post" success="<%=req.actionUrl()%>" refresh="true">
					<input type="hidden" name="_ent" value="<%=entity%>">
					<input type="hidden" name="_type" value="<%=type%>">
					<input type="hidden" name="_typeid" value="<%=typeid%>">
					<input type="hidden" name="_grpid" value="projectinfo">
					<input type="hidden" name="_grp" value="projectinfo">
					<input type="hidden" name="_grptype" value="projectinfo">
					<input type="hidden" name="_id" value="<%=id%>">
				
				
					<table class="csui_title csuialert" alert="<%=alert%>">
						<tr>
							<td class="csui_title" nowrap>Project Information</td>
						</tr>
					</table>
					<table class="csui" colnum="2" type="default">
						<tr>
							<%= ObjTables.cells("LKUP_PROJECTINFO_PROJECT_ID", "Project Scope", dvo.getString("LKUP_PROJECTINFO_PROJECT_ID"), "select", "status", true, "csui", 1, projecttype, false, true) %>
							<td id="p1" style="display:none" class="csui" type="String" itype="text" alert=""><input name="OTHER_PROJECT_TYPE" type="text" id="OTHER_PROJECT_TYPE"  itype="String" value="<%=dvo.getString("OTHER_PROJECT_TYPE") %>" valrequired="true" maxlength="50"></td>
							<td id="p2" class="csui" type="String" itype="text" alert="">&nbsp;</td>
						</tr>
						<tr>
							<%= ObjTables.cells("LKUP_PROJECTINFO_BUILDINGTYPE_ID", "Building Type", dvo.getString("LKUP_PROJECTINFO_BUILDINGTYPE_ID"), "select", "type", true, "csui", 1, buildingtype, false, true) %>
							<td id="b1" style="display:none" class="csui"type="String" itype="text" alert=""><input  name="OTHER_BUILDING_TYPE" type="text" id="OTHER_BUILDING_TYPE"  itype="String" value="<%=dvo.getString("OTHER_BUILDING_TYPE") %>" valrequired="true" maxlength="50"></td>
							<td id="b2" class="csui" type="String" itype="text" alert="">&nbsp;</td>
						</tr>
						<tr>
							<%= ObjTables.cells("LKUP_PROJECTINFO_BUILDINGUSE_ID", "Building Use", dvo.getString("LKUP_PROJECTINFO_BUILDINGUSE_ID"), "select", "typedescriptions", true, "csui", 1, buildinguse, false, true) %>
							<td id="bu1" style="display:none" class="csui"type="String" itype="text" alert=""><input name="OTHER_BUILDING_USE" type="text" id="OTHER_BUILDING_USE"  itype="String" value="<%=dvo.getString("OTHER_BUILDING_USE") %>" valrequired="true" maxlength="50"></td>
							<td id="bu2" class="csui" type="String" itype="text" alert="">&nbsp;</td>
						</tr>
					</table>
					<table class="csui" colnum="2" type="default" id="change" style="display:none" >
						<tr>
							<td class="csui_label"  colspan="4"> CHANGE OF USE</td>
						</tr>
						<tr>
							<td id="u1" class="csui_label" type="String" itype="text" alert="">Existing</td>
							<td id="u2" class="csui" type="String" itype="text" alert="">
								<select class="required chosen" name="OTHER_USE_EXISTING" id="OTHER_USE_EXISTING" valrequired="true" >
								<option value="" disabled selected style="display:none">Please Select</option>
								<%for(int i=0;i<buildinguse.length;i++){ 
								if(!(buildinguse[i].getText().equalsIgnoreCase("Other") || buildinguse[i].getText().equalsIgnoreCase("Mixed Use") || buildinguse[i].getText().equalsIgnoreCase("Change of Use"))) {
								%> 
								<option value="<%=buildinguse[i].getId()%>"><%=buildinguse[i].getText()%></option> 
								<%} }%>
								</select>
							</td>
							<td id="u3" class="csui_label" type="String" itype="text" alert="">Proposed</td>
							<td id="u4" class="csui" type="String" itype="text" alert="">
								<select class="required chosen" name="OTHER_USE_PROPOSED" id="OTHER_USE_PROPOSED" valrequired="true">
								<option value="" disabled selected style="display:none">Please Select</option>
								<%for(int i=0;i<buildinguse.length;i++){ 
								if(!(buildinguse[i].getText().equalsIgnoreCase("Other") || buildinguse[i].getText().equalsIgnoreCase("Mixed Use") || buildinguse[i].getText().equalsIgnoreCase("Change of Use"))) {
								%> 
								<option value="<%=buildinguse[i].getId()%>"><%=buildinguse[i].getText()%></option> 
								<%} }%>
								</select>
							</td> 
						</tr>
					</table>

					<div class="csui_divider"></div>
					<div class="csui_buttons"><input type="submit" name="action" value="save" class="csui_button"></div>
				</form>
			</div>
		</div>
	</div>
	</div>


</body>
</html>

