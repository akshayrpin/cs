<%@page import="cs.ui.CsUiTools"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="alain.core.utils.Logger"%>
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
	String teamtype = map.getString("teamtype");
	String ids = map.getString(RequestMapper.id);
 	Logger.info(entity);

	RequestVO tmreq = new RequestVO();
	tmreq.setEntity(entity);
 	tmreq.setType("inspections");
 	tmreq.setReference(teamtype);
 	tmreq.setGrouptype("team");
 	tmreq.setRequest("type");
 	SubObjVO[] team = ApiHandler.getChoices(tmreq);

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
			$('#csform').csform({
				callback: {
					submit: {
						success: function(result) {
							var mc = result['messagecode'];
							if (mc == 'cs200') {
								parent.$.fancybox.close();
								parent.location.reload();
							}
							else {
								var m = '';
								var rm = result['messages'];
								for (i=0; i<rm.length; i++) {
									m += rm[i]+'\n';
								}
								swal('Error', m, 'error');
							}
						}
					}
				}
			});
			$('#csform').apptmultiform({
			});
			$('input[itype=datetime]').datetimepicker({
				formatTime:'g:i A',
				step: 1
			});
			$('input[itype=availability]').datetimepicker({
				timepicker:false,
				format:'Y/m/d'
			});
			$('input[itype=date]').datetimepicker({
				timepicker:false,
				format:'Y/m/d'
			});
			$('select:not([itype=boolean]):not([valrequired=true])').chosen({
				width:'100%',
				disable_search_threshold: 10,
				allow_single_deselect: true
			});
			$('select:not([itype=boolean])[valrequired=true]').chosen({
				width:'100%',
				disable_search_threshold: 10
			});
			$('textarea[itype!=richtext]').autoGrow();
		});

	</script>

</head>
<body>

	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontrol">
				<div id="csuicontrol" class="csuicontrol">
				</div>

			</div>
			<div class="csuicontent">
				<table cellpadding="10" cellspacing="0" border="0" width="100%">
					<tr>
						<td align="left" id="title">EDIT</td>
						<td align="right" id="subtitle"></td>
					</tr>
				</table>
				<div id="csform_message"></div>
				<form id="csform" action="action.jsp" method="post">
					<table class="csui_title">
						<tr>
							<td class="csui_title">appointment</td>
							<td class="csui_controls">&nbsp;</td>
						</tr>
					</table>
					<table class="csui" type="default">
						<tr>
							<td class="csui_label" valign="top">
							DATE
							</td>
							<td class="csui_input" type="datetime" itype="availability_date" alert="">
								<input id="DATE" name="DATE" title="Date" type="text" itype="availability_date" maxchar="10000"/>
							</td>

							<td class="csui_label" valign="top">
							<input type="checkbox" name="DOTIME" id="DOTIME" value="Y"/>
							TIME
							</td>
							<td class="csui_input" type="time" itype="availability_time" alert="">
								<select id="TIME" name="TIME" title="Time" data-placeholder="Choose time..." type="text" itype="availability_time">
								</select>
							</td>

						</tr>
						<tr>
							<td class="csui_label" valign="top">
							<input type="checkbox" name="DONOTES" id="DONOTES" value="Y"/>
							NOTES
							</td>
							<td class="csui_input" type="String" itype="notes" alert=""><textarea id="NOTES" name="NOTES" itype="notes"></textarea></td>
							<td class="csui_label" valign="top" valign="top">
							<input type="checkbox" name="DOTEAM" id="DOTEAM" value="Y"/>
							TEAM
							</td>
							<td class="csui_input" type="team" itype="team" alert="" valign="top">
								<select id="TEAM" name="TEAM" itype="team" data-placeholder="Choose team member..." multiple>
									<%
										int tml = team.length;
										for (int i = 0; i < tml; i++) {
											SubObjVO st = team[i];
											out.print("<option value=\"");
											out.print(st.getValue());
											out.print("\">");
											out.print(st.getText());
											out.print("</option>\n");
										}
									%>
								</select>
							</td>
						</tr>
					</table>

					<input type="hidden" name="<%= RequestMapper.entity %>" value="<%= entity %>"/>
					<input type="hidden" name="<%= RequestMapper.type %>" value="multi"/>
					<input type="hidden" name="<%= RequestMapper.groupid %>" value="appointment"/>
					<input type="hidden" name="<%= RequestMapper.group %>" value="appointment"/>
					<input type="hidden" name="<%= RequestMapper.grouptype %>" value="appointment"/>
					<input type="hidden" name="<%= RequestMapper.action %>" value="multiedit"/>
					<input type="hidden" name="<%= RequestMapper.id %>" value="<%=ids%>"/>
					<div class="csui_divider"></div>
					<div class="csui_buttons"><input type="submit" name="_action" value="cancel" class="csui_button">&nbsp;<input type="submit" name="action" value="save" class="csui_button"></div>

				</form>

			</div>
		</div>
	</div>




</body>
</html>

