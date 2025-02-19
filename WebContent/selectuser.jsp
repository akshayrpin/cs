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
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	String group = map.getString(RequestMapper.group);
	String groupid = map.getString(RequestMapper.groupid);
	String grouptype = map.getString(RequestMapper.grouptype);
	if (!Operator.hasValue(grouptype)) {
		grouptype = type;
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
				$('input[name=EMAIL]').change(function() {
					refreshData('email');
				});
				$('#clear').click(function() {
					$('input[type=text]').val('');
				});
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
			 	var nchoice = pid+'::'+pname;
			 	try { parent.addUser(nchoice); } catch(e) { }
			 	try{ parent.$.fancybox.close(); } catch(e) { }
			}
			function refreshData(req) {
				var d = datamap(req);
				var url = '/cs/json/post.jsp';
				var r = doAjax(url, d);
				var id = r.id;
				if (id && id > 0) {
					var ttl = 'User Found';
					var txt = 'A user with the username you entered has been found. Do you want to autofill the fields with the existing information?';
					if (req == 'email') {
						ttl = 'Email Found';
						txt = 'A user with the email you entered has been found. Do you want to autofill the fields with the existing information?';
					}
					swal({
						title: ttl,
						text: txt,
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
							$('input[name=USERNAME]').val(info['USERNAME']);
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
					});
				}
			}
			function datamap(req) {
				var ref = $('input[name=USERNAME]').val();
				var eml = $('input[name=EMAIL]').val();
				r = {
					'_ent': '<%=entity%>',
					'_type': '<%=type%>',
					'_typeid': '<%=typeid%>',
					'_reference': ref,
					'_grp': 'users',
					'_grptype': 'users',
					'_request': req,
					'username': ref,
					'email': eml
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
							<%= ObjTables.cells("USERNAME", "USERNAME", "", "String", "text", false, "csui", true) %>
							<%= ObjTables.cells("EMAIL", "EMAIL", "", "String", "text", false, "csui", true) %>
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
							<%= ObjTables.cells("FIRST_NAME", "FIRST NAME", "", "text", "text", true, "csui", true) %>
							<td class="csui_label" colspan="2">&nbsp;</td>
							</tr>
							<tr>
							<%= ObjTables.cells("MIDDLE_NAME", "MIDDLE NAME", "", "text", "text", false, "csui", true) %>
							<%= ObjTables.cells("PHONE_WORK", "PHONE (WORK)", "", "text", "phone", false, "csui", true) %>
							</tr>
							<tr>
							<%= ObjTables.cells("LAST_NAME", "LAST NAME", "", "text", "text", false, "csui", true) %>
							<%= ObjTables.cells("PHONE_CELL", "PHONE (CELL)", "", "text", "phone", false, "csui", true) %>
							</tr>
							<tr>
							<%= ObjTables.cells("ADDRESS", "ADDRESS", "", "text", "text", false, "csui", true) %>
							<%= ObjTables.cells("PHONE_HOME", "PHONE (HOME)", "", "text", "phone", false, "csui", true) %>
							</tr>
							<tr>
							<%= ObjTables.cells("CITY", "CITY", "", "text", "text", false, "csui", true) %>
							<%= ObjTables.cells("FAX", "FAX", "", "text", "phone", false, "csui", true) %>
							</tr>
							<tr>
							<%= ObjTables.cells("STATE", "STATE", "", "text", "text", false, "csui", true) %>
							<%= ObjTables.cells("ZIP", "ZIP", "", "text", "text", false, "csui", true) %>
							</tr>
						</table>
		
						<input type="hidden" name="_grpid" value="users">
						<input type="hidden" name="_grp" value="users">
						<input type="hidden" name="_grptype" value="users">
						<input type="hidden" name="_act" value="select">
						<input type="hidden" name="_id" value="">
						<div class="csui_divider"></div>
						<div class="csui_buttons"><span id="clear" class="button">Clear</span> <input type="submit" name="action" value="select" class="csui_button"></div>
		






				</form>
			</div>
		</div>
	</div>
	</div>


</body>
</html>

