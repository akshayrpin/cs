<%@page import="cs.ui.CsUiTools"%>
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
<%@page import="cs.common.ApiHandler"%>
<%@page import="csshared.vo.TypeVO"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="alain.core.utils.Cartographer"%>
<%


	Cartographer map = new Cartographer(request,response);
	RequestVO req = RequestMapper.getRequest(map);
	String id = req.getId();
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

	DataVO dvo = DataVO.toDataVO(o);

	SubObjVO[] types = ApiHandler.getLkupObj("type", entity, "people", dvo.getInt("LKUP_USERS_TYPE_ID"));

	RequestVO treq = new RequestVO();
	treq.setGrouptype("people");
	treq.setRequest("type");
	//types = ApiHandler.getChoices(treq);

	TypeVO l = new TypeVO();
	if (dvo.isHistory() && dvo.getId() > 0) {
		RequestVO list = new RequestVO();
		list = req.duplicate();
		list.setGroupid(Operator.toString(dvo.getId()));
		list.setRequest("list");
		l = ApiHandler.getType(list);
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
				$('#editpeople').csform({
					callback: {
						submit: {
							success: function(d) { select(d); }
						}
					}
				});
				$('input[name=USERNAME]').change(function() {
					refreshData('username');
				});
				$('#verifylicense').click(function() {
					verifyLicense();
				});
				$('select[name=LKUP_USERS_TYPE_ID]').change(function() {
					refreshData('license');
					toggleLicense();
				});
				toggleLicense();
			});
			function select(d) {
				var pid = d.id;
			 	var pname = d.info['NAME'];
			 	var pemail = d.info['EMAIL'];
			 	var pusername = d.info['USERNAME'];
			 	var pgroup = ''; //d.info['group'];
			 	var paddress = d.info['ADDRESS'];
			 	var plic = ''; //d.info['license'];
			 	var ptype = d.info['TYPE'];
			 	parent.selectPeople(pid, pname, pemail, pusername, pgroup, paddress, plic, ptype);
			 	parent.$.fancybox.close();
			}
			function refreshData(req) {
				if (req == 'license') {
// 					$('input[name=FIRST_NAME]').val('');
// 					$('input[name=MIDDLE_NAME]').val('');
// 					$('input[name=LAST_NAME]').val('');
// 					$('input[name=PHONE_WORK]').val('');
// 					$('input[name=PHONE_CELL]').val('');
// 					$('input[name=PHONE_HOME]').val('');
// 					$('input[name=EMAIL]').val('');
// 					$('input[name=FAX]').val('');
// 					$('input[name=ADDRESS]').val('');
// 					$('input[name=CITY]').val('');
// 					$('input[name=STATE]').val('');
// 					$('input[name=ZIP]').val('');
					$('input[name=LIC_NO]').val('');
					$('input[name=LIC_EXP_DT]').val('');
					$('input[name=BUS_LIC_NO]').val('');
					$('input[name=BUS_LIC_EXP_DT]').val('');
					$('input[name=GEN_LIABILITY_DT]').val('');
					$('input[name=AUTO_LIABILITY_DT]').val('');
					$('input[name=WORK_COMP_EXP_DT]').val('');
				}
				var d = datamap(req);
				var url = '/cs/json/post.jsp';
				var r = doAjax(url, d);
				var id = r.id;
				if (id && id > 0) {
					swal({
						title: 'User Found',
						text: 'A user with the username you entered has been found. Do you want to autofill the fields with the existing information?',
						type: "warning",
						showCancelButton: true,
						confirmButtonColor: "#DD6B55",
						confirmButtonText: 'Yes',
						cancelButtonText: 'No',
						closeOnConfirm: true,
						closeOnCancel: true
					},
					function(isConfirm) {
						if (isConfirm) {
							var info = r.info;
							if (req != 'license') {
								$('input[name=FIRST_NAME]').val(info['FIRST_NAME']);
								$('input[name=MIDDLE_NAME]').val(info['MIDDLE_NAME']);
								$('input[name=LAST_NAME]').val(info['LAST_NAME']);
								$('input[name=PHONE_WORK]').val(info['PHONE_WORK']);
								$('input[name=PHONE_CELL]').val(info['PHONE_CELL']);
								$('input[name=PHONE_HOME]').val(info['PHONE_HOME']);
								$('input[name=EMAIL]').val(info['EMAIL']);
								$('input[name=FAX]').val(info['FAX']);
								$('input[name=ADDRESS]').val(info['ADDRESS']);
								$('input[name=CITY]').val(info['CITY']);
								$('input[name=STATE]').val(info['STATE']);
								$('input[name=ZIP]').val(info['ZIP']);
							}
							$('input[name=LIC_NO]').val(info['LIC_NO']);
							$('input[name=LIC_EXP_DT]').val(info['LIC_EXP_DT']);
							$('input[name=BUS_LIC_NO]').val(info['BUS_LIC_NO']);
							$('input[name=BUS_LIC_EXP_DT]').val(info['BUS_LIC_EXP_DT']);
							$('input[name=GEN_LIABILITY_DT]').val(info['GEN_LIABILITY_DT']);
							$('input[name=AUTO_LIABILITY_DT]').val(info['AUTO_LIABILITY_DT']);
							$('input[name=WORK_COMP_EXP_DT]').val(info['WORK_COMP_EXP_DT']);
						}
					});
				}
			}
			function toggleLicense() {
				var typ = $('select[name=LKUP_USERS_TYPE_ID]');
				var req = typ.find('option:selected').attr('REQUIRED_LICENSE');
				var ver = typ.find('option:selected').attr('VALIDATE_LICENSE_URL');
				try {
					var d = $('#licensediv');
					if (req == 'Y') {
						d.show();
						if (!hasValue(ver)) { $('#verifylicense').hide(); }
						else { $('#verifylicense').show(); }
					}
					else {
						d.hide();
					}
				} catch(e) { }
			}
			function verifyLicense() {
				var typ = $('select[name=LKUP_USERS_TYPE_ID]');
				var ver = typ.find('option:selected').attr('VALIDATE_LICENSE_URL');
				var lic = $('input[name=LIC_NO]').val();
				var u = ver.replace('<LIC_NO>',lic);
				window.open(u); 
			}
			function datamap(req) {
				var ref = $('input[name=USERNAME]').val();
				var typ = $('select[name=LKUP_USERS_TYPE_ID]').val();
				r = {
					'_ent': '<%=entity%>',
					'_type': '<%=type%>',
					'_typeid': '<%=typeid%>',
					'_reference': ref,
					'_grp': 'people',
					'_grptype': 'people',
					'_request': req,
					'username': ref,
					'usertype': typ
					
				}
				return r;
			}
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
						<td align="left" id="title"><%= title %></td>
						<td align="right" id="subtitle"><%= subtitle %></td>
					</tr>
				</table>
				<div id="csform_message"></div>
				<form id="editpeople" action="action.jsp" method="post">

						<input type="hidden" name="_ent" value="<%=entity%>">
						<input type="hidden" name="_type" value="<%=type%>">
						<input type="hidden" name="_typeid" value="<%=typeid%>">
		
						<table class="csui_title csuialert" alert="picked up">
							<tr>
								<td class="csui_title">USER</td>
								<td class="csui_controls">&nbsp;</td>
							</tr>
						</table>
						<table class="csui">
							<tr>
							<%= ObjTables.cells("USERNAME", "USERNAME", "Enter the username that the customer uses to access their online account. In most cases, the value entered here should be the same as the email address.", dvo.getString("USERNAME"), "String", "text", false, "csui", 1, new SubObjVO[0], false, true) %>
							<%= ObjTables.cells("LKUP_USERS_TYPE_ID", "TYPE", dvo.getString("LKUP_USERS_TYPE_ID"), "String", "text", true, "csui", 1, types, false, true) %>
							</tr>
						</table>
						<table class="csui_title csuialert" alert="picked up">
							<tr>
								<td class="csui_title">CONTACT</td>
								<td class="csui_controls">&nbsp;</td>
							</tr>
						</table>
						<table class="csui">
							<tr>
							<%= ObjTables.cells("FIRST_NAME", "FIRST NAME", dvo.getString("FIRST_NAME"), "String", "text", true, "csui", true) %>
							<%= ObjTables.cells("EMAIL", "EMAIL", dvo.getString("EMAIL"), "String", "text", false, "csui", true) %>
							</tr>
							<tr>
							<%= ObjTables.cells("MIDDLE_NAME", "MIDDLE NAME", dvo.getString("MIDDLE_NAME"), "String", "text", false, "csui", true) %>
							<%= ObjTables.cells("PHONE_WORK", "PHONE (WORK)", dvo.getString("PHONE_WORK"), "String", "phone", false, "csui", true) %>
							</tr>
							<tr>
							<%= ObjTables.cells("LAST_NAME", "LAST NAME", dvo.getString("LAST_NAME"), "String", "text", false, "csui", true) %>
							<%= ObjTables.cells("PHONE_CELL", "PHONE (CELL)", dvo.getString("PHONE_CELL"), "String", "phone", false, "csui", true) %>
							</tr>
							<tr>
							<%= ObjTables.cells("ADDRESS", "ADDRESS", dvo.getString("ADDRESS"), "String", "text", false, "csui", true) %>
							<%= ObjTables.cells("PHONE_HOME", "PHONE (HOME)", dvo.getString("PHONE_HOME"), "String", "phone", false, "csui", true) %>
							</tr>
							<tr>
							<%= ObjTables.cells("CITY", "CITY", dvo.getString("CITY"), "String", "text", false, "csui", true) %>
							<%= ObjTables.cells("FAX", "FAX", dvo.getString("FAX"), "String", "phone", false, "csui", true) %>
							</tr>
							<tr>
							<%= ObjTables.cells("STATE", "STATE", dvo.getString("STATE"), "String", "text", false, "csui", true) %>
							<%= ObjTables.cells("ZIP", "ZIP", dvo.getString("ZIP"), "String", "text", false, "csui", true) %>
							</tr>
						</table>
						<div id="licensediv" style="display: none">
						<table class="csui_title csuialert" alert="picked up">
							<tr>
								<td class="csui_title">LICENSE</td>
								<td class="csui_title" id="verifylicense" style="cursor: pointer"><img src="/cs/images/icons/white/cloudverify.png" width="20" height="20" title="verify license number"/></td>
							</tr>
						</table>
						<table class="csui">
							<tr>
							<%= ObjTables.cells("LIC_NO", "LICENSE NUMBER", dvo.getString("LIC_NO"), "String", "text", false, "csui", true) %>
							<%= ObjTables.cells("LIC_EXP_DT", "EXPIRATION", dvo.getString("LIC_EXP_DT"), "String", "date", false, "csui", true) %>
							</tr>
							<tr>
							<%= ObjTables.cells("GEN_LIABILITY_DT", "GENERAL LIABILITY DATE", dvo.getString("GEN_LIABILITY_DT"), "String", "date", false, "csui", true) %>
							<%= ObjTables.cells("AUTO_LIABILITY_DT", "AUTO LIABILITY DATE", dvo.getString("AUTO_LIABILITY_DT"), "String", "date", false, "csui", true) %>
							</tr>
							<tr>
							<%= ObjTables.cells("WORK_COMP_EXP_DT", "WORKERS COMP EXPIRATION DATE", dvo.getString("WORK_COMP_EXP_DT"), "String", "date", false, "csui", true) %>
							<td class="csui_label" colspan="2">&nbsp;</td>
							</tr>
						</table>
						</div>
		
						<input type="hidden" name="_grpid" value="people">
						<input type="hidden" name="_grp" value="people">
						<input type="hidden" name="_grptype" value="people">
						<input type="hidden" name="_act" value="select">
						<input type="hidden" name="_id" value="<%=id%>">
						<div class="csui_divider"></div>
						<div class="csui_buttons"><input type="submit" name="action" value="select" class="csui_button"></div>
		






				</form>
			</div>
		</div>
	</div>
	</div>


</body>
</html>

