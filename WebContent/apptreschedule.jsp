<%@page import="cs.ui.CsUiTools"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="csshared.utils.ObjMapper"%>
<%@page import="csshared.vo.ObjVO"%>
<%@page import="java.util.HashMap"%>
<%@page import="csshared.vo.SubObjVO"%>
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
	String availabilityid = map.getString("availabilityid");
	String ids = map.getString(RequestMapper.id);

%><html>
<head>
	<%= CsUiTools.getHTMLImports() %>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
	<style>
		.csui_controls { visibility: hidden }
		table[itype=people] tr:nth-child(even) {
			background-color: #f2f2f2;
		}
	</style>

	<script>
		var entity = '<%= entity %>';
		var type = '<%= type %>';
		var typeid = 0;
		var availabilityid = '<%= availabilityid %>';
		var fullcontexturl = '<%=Config.fullcontexturl()%>';
	</script>

	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.apptmulti.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	
	<script>
		$(document).ready(function() {
			var d = $('#DATE');
			var t = $('#TIME');
			jsonAvailabilityIdDate(d, t, entity, availabilityid);
			
			$("input:checkbox").click(function() { swal("Can't unselect, send email is mandatory."); return false; });
		});
		function success() {
			parent.$.fancybox.close();
			parent.fancybox_reload = true;
		}
	</script>

</head>
<body>

	<div id="fullpage">
	<div id="loader"></div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontrol">
				<div id="csuicontrol" class="csuicontrol">
				</div>

			</div>
			<div class="csuicontent">
				<table cellpadding="10" cellspacing="0" border="0" width="100%">
					<tr>
						<td align="left" id="title">RESCHEDULE</td>
						<td align="right" id="subtitle"></td>
					</tr>
				</table>
				<div id="csform_message"></div>
				<form id="csform" class="form" action="action.jsp" method="post">
					<table class="csui_title">
						<tr>
							<td class="csui_title">&nbsp;</td>
							<td class="csui_controls">&nbsp;</td>
						</tr>
					</table>
					<table class="csui" type="default">
						<tr>
							<td class="csui_label" valign="top">
							DATE
							</td>
							<td class="csui_input" type="datetime" itype="availability" alert="">
								<input id="DATE" name="DATE" title="Date" type="text" itype="availability" maxchar="10000"/>
							</td>

							<td class="csui_label" valign="top">
							TIME
							</td>
							<td class="csui_input" type="time" itype="time" alert="">
								<select id="TIME" name="TIME" title="Time" data-placeholder="Choose time..." type="text" itype="availability_time">
								</select>
							</td>

						</tr>
						<tr>
							<td class="csui_label" valign="top">
							SEND EMAIL
							</td>
							<td class="csui_input" alert="" colspan="3">
								<input id="NOTIFY" name="NOTIFY" type="checkbox" value="Y" checked/> Send email notification to all collaborators
							</td>
						</tr>
					</table>

					<input type="hidden" name="<%= RequestMapper.entity %>" value="<%= entity %>"/>
					<input type="hidden" name="<%= RequestMapper.type %>" value="appointment"/>
					<input type="hidden" name="<%= RequestMapper.groupid %>" value="appointment"/>
					<input type="hidden" name="<%= RequestMapper.group %>" value="appointment"/>
					<input type="hidden" name="<%= RequestMapper.grouptype %>" value="appointment"/>
					<input type="hidden" name="<%= RequestMapper.action %>" value="reschedule"/>
					<input type="hidden" name="<%= RequestMapper.id %>" value="<%=ids%>"/>
					<div class="csui_divider"></div>
					<div class="csui_buttons"><input type="submit" name="action" value="save" class="csui_button"></div>

				</form>

			</div>
		</div>
	</div>
</div>



</body>
</html>

