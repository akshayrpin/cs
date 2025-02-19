<%@page import="cs.ui.CsUiTools"%>
<%@page import="cs.utils.ObjTables"%>
<%@page import="csshared.vo.ComboReviewList"%>
<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="csshared.vo.ToolsVO"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="alain.core.utils.Logger"%>
<%@page import="cs.agent.UiAgent"%>
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
	String startdate = map.getString("START_DATE");
	String id = map.getString(RequestMapper.id);
	int typeid = map.getInt(RequestMapper.typeid);
	Timekeeper d = new Timekeeper();
	d.setDate(startdate);

	RequestVO nav = new RequestVO();
	nav.setEntity(entity);
	nav.setToken(map.token());
	nav.setType("review");
	nav.setRequest("appt");
	nav.setReference("in");
	nav.setId(id);
	nav.setStartdate(startdate);

	ObjGroupVO o = ApiHandler.getGroup(nav);

	RequestVO req = RequestMapper.getRequest(map);

%>
<html>
<head>

	<title>City Smart</title>
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
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.apptlist.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/toggleswitch/tinytools.toggleswitch.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/tinymce/js/tinymce/jquery.tinymce.min.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/tinymce/js/tinymce/tinymce.min.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/inputmask.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/jquery.inputmask.js"></script>
		
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/ioscheckboxes/assets/js/jquery.mobileCheckbox.js"></script>
		
	 	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
	    <script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>

	<style>

		input[itype=date] {
			border: 0px;
			padding-left: 30px;
			width: 250px;
			font-size: 30px;
			cursor: pointer;
			font-family: Oswald, Arial;
			background-image: url(/cs/images/icons/input/calendar.png);
			background-repeat: no-repeat;
			background-position : left 4px center
		}
		.multibutton {
			white-space: nowrap;
			background-color: #eeeeee;
			border: 1px solid #cccccc;
			font-family: Oswald, Arial, Helvetica;
			text-transform: uppercase;
			padding: 10px;
			padding-left: 20px;
			padding-right: 20px;
			margin: 10px;
			font-size: 14px;
			font-weight: bold;
			border-radius: 5px;
			color: #000000;
			cursor: pointer;
			/*
			background-image: url(/cs/images/icons/input/docedit.png);
			background-repeat: no-repeat;
			background-position : left 4px center
			*/
		}
		.multibutton.disabled {
			background-color: #dddddd;
			color: #aaaaaa;
		}
		.multibutton.enabled:hover {
			background-color: #669966;
			color: #ffffff;
		}

	</style>

	<script>
		var fullcontexturl = '<%=Config.fullcontexturl()%>';
		var cbtoggle = true;

		$(document).ready(function() {
			$('input[itype=date]').datetimepicker({
				timepicker:false,
				format:'Y/m/d',
//				inline:true,
				onChangeDateTime:function(dp,$input){
					changeDate($input.val())
				}
			});
			$("a.csui").fancybox({
				width				: '75%',
				height				: '75%',
				autoScale			: false,
				transitionIn		: 'none',
				transitionOut		: 'none',
				type				: 'iframe'
			});
			$('#reassign').apptreassign();
			$('#reschedule').apptreschedule();
			$('input[type=checkbox][availabilityid]').apptavailability();

			//Disabled because availability needs to be validated
			//$('td.csui_header[label=SELECT]').click(function() { selectAll(); })
		});

		function selectAll() {
			var cb = $('td[label=SELECT] input[type=checkbox]');
			cb.prop('checked', cbtoggle);
			if (cbtoggle) {
				cbtoggle = false;
			}
			else {
				cbtoggle = true;
			}
		}

		function changeDate(dt) {
			$("#loader").show();
			var u = 'inspections.jsp?_ent=inspections&_type=inspections&_typeid=<%= map.getString("_typeid") %>&_id=<%= map.getString("_id") %>&START_DATE='+dt;
			self.location.href = u;
		}

		function deleteRecord(grp, grpid,id) {
			if (confirm('Are you sure you want to delete this record?')) {
				if (!hasValue(grp)) { alert('Error: Group name not set.'); }
				else if (!hasValue(id)) { alert('Error: Record ID not set.'); }
				else {
					var d = {
						<%= RequestMapper.action %>: 'delete',
						<%= RequestMapper.entity %>: '<%= entity %>',
						<%= RequestMapper.type %>: '<%= type %>',
						<%= RequestMapper.typeid %>: '<%= typeid %>',
						<%= RequestMapper.group %>: grp,
						<%= RequestMapper.grouptype %>: grp,
						<%= RequestMapper.groupid %>: grpid,
						<%= RequestMapper.id %>: id
					}
					var dres = doAjax('action.jsp', d);
					var mcode = '';
					if (hasValue(dres)) {
						mcode = dres['messagecode'];
					}
					if (!hasValue(mcode) || mcode != 'cs200') {
						var fmsg = '<span class="fancyalert_title">ERROR: ';
						if (!hasValue(mcode)) {
							fmsg += 'Parser Error';
						}
						else {
							fmsg += mcode;
						}
						fmsg += '<span><br/>';
						if (hasValue(dres)) {
							var err = dres.errors;
							if (hasValue(err)) {
								$.each(err, function(idx, error) {
									var emsg = error.message;
									if (hasValue(emsg)) {
										fmsg += '<br/><span class="fancyalert_content">'+emsg+'</span>';
									}
								});
							}
						}
						fancyAlert(fmsg);
					}
					else {
						var d = $('#tr_'+grp+'_'+grpid+'_'+id);
						if (hasValue(d)) {
							d.empty();
							d.remove();
						}
					}
				}
			}
		}
	</script>

</head>
<body>
	<div id="loader"></div>
	<div id="csuicontrols">
		<div id="csuicontrol" class="csuicontrol">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="left" class="csuicontrol">SUMMARY</td>
					<td align="right">&nbsp;</td>
				</tr>
			</table>
		</div>
		<div id="csuisubcontrol" class="csuisubcontrol">INFO</div>
	</div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
				<table cellpadding="10" cellspacing="0" border="0" width="100%" class="sticky">
					<tr>
						<td align="left" nowrap>
							<form method="post">
								<input name="START_DATE" itype="date" value="<%=d.getString("YYYY/MM/DD")%>">
							</form>
						</td>
						<td align="right" width="1%" nowrap>
						<span id="reassign" class="multibutton disabled" rel="inspector" _ent="<%=entity%>" _type="<%=type%>">Reassign</span>
						<span id="reschedule" class="multibutton disabled" rel="inspector" _ent="<%=entity%>" _type="<%=type%>">Reschedule</span>
						</td>
					</tr>
				</table>
				<%= ObjTables.apptReview(req, o, "csui") %>
				<div class="csui_divider"></div>
				<div class="csui_divider"></div>
			</div>
		</div>
		<div id="csuisub">
				<div class="csuisub_divider"></div>
				<div class="csuisubcontent">
				</div>
				<div class="csuisub_divider"></div>
				<div class="csui_divider"></div>
		</div>
	</div>




</body>
</html>

