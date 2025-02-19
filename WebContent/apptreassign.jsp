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
	String ids = map.getString(RequestMapper.id);
	String rids = map.getString("reviewids");

	RequestVO tmreq = new RequestVO();
	tmreq.setEntity(entity);
 	tmreq.setType("inspections");
 	tmreq.setRequest("team");
 	tmreq.setId(rids);
 	SubObjVO[] team = ApiHandler.getChoices(tmreq);

%><html>
<head>
	<%= CsUiTools.getHTMLImports() %>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	<style>
		.csui_controls { visibility: hidden }
		table[itype=people] tr:nth-child(even) {
			background-color: #f2f2f2;
		}
	</style>
	<script>
	var entity = '<%= entity %>';
	var type = '<%= type %>';
	var fullcontexturl = '<%=Config.fullcontexturl()%>';

	function success() {
		parent.fancybox_reload = true;
		parent.$.fancybox.close();
	}

	</script>

	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.apptmulti.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
 	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
	
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
						<td align="left" id="title">REASSIGN</td>
						<td align="right" id="subtitle"></td>
					</tr>
				</table>
				<div id="csform_message"></div>
				<form id="csform" class="form" action="action.jsp" method="post">
					<table class="csui_title">
						<tr>
							<td class="csui_title">
								<table cellpadding="2" cellspacing="0" border="0" width="100%">
									<tr>
										<td align="right"><a target="lightbox-iframe" href="<%= Config.fullcontexturl() %>/selectteam.jsp?_ent=<%= entity %>&_type=users&fieldid=TEAM"><img src="/cs/images/icons/controls/white/add.png"/></a></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<table class="csui" type="default">
						<tr>
							<td class="csui_label" valign="top" valign="top">
							TEAM
							</td>
							<td class="csui_input" type="team" itype="team" alert="" valign="top">
								<table cellpadding="5" cellspacing="0" border="0" width="100%" id="team_table">
									<%
										int tml = team.length;
										for (int i = 0; i < tml; i++) {
											SubObjVO st = team[i];
											out.print("<tr>");
											out.print("<td width=\"1%\">");
											out.print("<input type=\"radio\" name=\"TEAM\" value=\"");
											out.print(st.getValue());
											out.print("\">");
											out.print("</td>");
											out.print("<td class=\"csui_input\">");
											out.print(st.getText());
											out.print("</td>");
											out.print("<td class=\"csui_input\" align=\"right\" nowrap>");
											out.print(st.getDescription());
											out.print("</td>");
											out.print("</tr>\n");
										}
									%>
								</table>
							</td>
						</tr>
					</table>

					<input type="hidden" name="<%= RequestMapper.entity %>" value="<%= entity %>"/>
					<input type="hidden" name="<%= RequestMapper.type %>" value="appointment"/>
					<input type="hidden" name="<%= RequestMapper.groupid %>" value="appointment"/>
					<input type="hidden" name="<%= RequestMapper.group %>" value="appointment"/>
					<input type="hidden" name="<%= RequestMapper.grouptype %>" value="appointment"/>
					<input type="hidden" name="<%= RequestMapper.action %>" value="reassign"/>
					<input type="hidden" name="<%= RequestMapper.id %>" value="<%=ids%>"/>
					<div class="csui_divider"></div>
					<div class="csui_buttons"><input type="submit" name="action" value="save" class="csui_button"></div>

				</form>

			</div>
		</div>
	</div>




</body>
</html>

