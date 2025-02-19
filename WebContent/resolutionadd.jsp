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
	boolean isaddresolution = map.getInt(RequestMapper.groupid) < 1 && map.equalsIgnoreCase(RequestMapper.action, "add");
	
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
	ResolutionDetailVO dvo = rvo.getDetail();
	ArrayList<ResolutionDetailVO> details = rvo.array();

	String adopted = "";
	if (rvo.adoptedDate().hasValue()) {
		adopted = rvo.adoptedDate().getString("YYYY/MM/DD");
	}

	boolean editgroup = false;
	if (!dvo.hasValue()) {
		editgroup = true;
	}

	RequestVO treq = req.duplicate();
	treq.setRequest("status");
	SubObjVO[] status = ApiHandler.getChoices(treq);

	String addparturl = Config.fullcontexturl()+"/resolutionaddpart.jsp?_id=0&_entid=0&_ent=lso&_typeid="+typeid+"&_type="+type+"&_grpid="+groupid+"&_grp=resolution&_grptype=resolution&_act=add"; 
	String expirepartsurl = Config.fullcontexturl()+"/resolutionexpireparts.jsp?_id=0&_entid=0&_ent=lso&_typeid="+typeid+"&_type="+type+"&_grpid="+groupid+"&_grp=resolution&_grptype=resolution"; 
	String redirecturl = Config.fullcontexturl()+"/resolution.jsp?_id=0&_entid=0&_ent=lso&_typeid="+typeid+"&_type="+type+"&_grpid="+groupid+"&_grp=resolution&_grptype=resolution&_code=data.messagecode"; 
	String backurl = Config.fullcontexturl()+"/summary.jsp?_ent="+entity+"&_type="+type+"&_typeid="+typeid+"&_id="+typeid;
	String multiurl = Config.fullcontexturl()+"/resolutionmulti.jsp?_id=0&_entid=0&_ent=lso&_typeid="+typeid+"&_type="+type+"&_grpid="+groupid+"&_grp=resolution&_grptype=resolution&_act=add"; 



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
				<form class="form" action="action.jsp" method="post" success="<%=redirecturl%>" successalert="The resolution has been successfully saved.">
					<input type="hidden" name="_ent" value="<%=req.getEntity()%>">
					<input type="hidden" name="_type" value="<%=req.getType()%>">
					<input type="hidden" name="_typeid" value="<%=req.getTypeid()%>">
					<input type="hidden" name="_grpid" value=<%=req.getGroupid()%>>
					<input type="hidden" name="_grp" value="<%=req.getGroup()%>">
					<input type="hidden" name="_grptype" value="<%=req.getGrouptype()%>">
					<input type="hidden" name="_id" value="<%=req.getId()%>">

					<%= ObjTables.title("RESOLUTION", "", "csui", alert, "", "", "", CsConfig.getImage("back"), new String[0], "","","","") %>
					<table class="csui" colnum="2" type="default">

						<%
						Timekeeper d = new Timekeeper();
						String adopteddate = "";
						if (rvo.isAdopted()) {
							adopteddate = rvo.adoptedDate().getString("YYYY/MM/DD");
						}
						String t = "permanent";
						if (type.equalsIgnoreCase("project") || type.equalsIgnoreCase("activity")) {
							t = "temporary";
						}

						out.print("<tr>");
						out.print(ObjTables.cells("RESOLUTION_NUMBER", "NUMBER", rvo.getNumber(), "String", "text", true, "csui", editgroup));
						out.print(ObjTables.cells("ADOPTED_DATE", "ADOPTED DATE", adopteddate, "date", "date", true, "csui", false));
						out.print("</tr>");
						out.print("<tr>");
						out.print(ObjTables.cells("TITLE", "TITLE", rvo.getTitle(), "String", "largetext", true, "csui", editgroup));
						out.print("</tr>");
						%>

					</table>
				    <div id="saveresbutton" class="csui_buttons"><input type="submit" name="action" value="save" class="csui_button"></div>
				</form>
				</div>


				<div id="addrespart" style="display: none">
				<%
				%>
	
				 <table class="csui_title csuialert">
				   <tr>
				     <td class="csui_title">ADD NEW PART</td>
					     <td class="csui_controls">
					       <img src="<%= ObjTables.WHITEDELETEIMGURL %>" width="20" height="20" border="0" id="addpartclose" style="cursor: pointer" title="Add new part"/>
					     </td>
					     <td class="csui_controls">&nbsp;</td>
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
					<%= ObjTables.cells("DATE", "DATE", d.getString("YYYY/MM/DD"), "date", "date", true, "csui", true) %>
					</tr>
					<tr>
					<%= ObjTables.cells("TYPE", "TYPE", t, "String", "text", true, "csui", "permanent,temporary", false, true) %>
					<%= ObjTables.cells("STATUS_ID", "STATUS", "", "String", "text", true, "csui", 1, status, false, true) %>
					</tr>
					<tr>
					<%= ObjTables.cells("PART_TITLE", "PART TITLE", "", "String", "largetext", true, "csui", true) %>
					<tr>
					<%= ObjTables.cells("DESCRIPTION", "DESCRIPTION", "", "String", "largetextarea", true, "csui", true) %>
					</table>
				    <div class="csui_buttons"><input type="submit" name="action" value="add" class="csui_button"></div>
				</form>
				</div>

				<% if (details.size() > 0) { %>
				 <table class="csui_title csuialert">
				   <tr>
				     <td class="csui_title">PARTS</td>
				     <td class="csui_controls" style="padding-right: 15px;">
				       <a href="<%=multiurl %>" class="csui_controls" title="Change All Status" target="lightbox-iframe"><img src="<%= ObjTables.WHITEMULTIEDITIMGURL %>" width="20" height="20" border="0"/></a>
				     </td>
				     <td class="csui_controls" style="padding-right: 15px;">
				       <a href="<%= expirepartsurl %>" class="csui_controls" title="Expire All Parts" target="lightbox-iframe"><img src="<%= ObjTables.WHITEEXPIREIMGURL %>" width="20" height="20" border="0" style="cursor: pointer"/></a>
				     </td>
				     <td class="csui_controls" style="padding-right: 15px;">
				       <a href="<%= addparturl %>" class="csui_controls" title="Edit All Parts" target="lightbox-iframe"><img src="<%= ObjTables.WHITEADDIMGURL %>" width="20" height="20" border="0" id="addparttoggle" style="cursor: pointer"/></a>
				     </td>
				   </tr>
				 </table>
				<%= ObjTables.resolutionDetail(req, type, typeid, group, groupid, grouptype, rvo, details, "csui", alert, true, true) %>
				<% } %>

			</div>



		</div>
	</div>
	</div>
	<br/><br/><br/><br/>

</body>
</html>

