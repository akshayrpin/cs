<%@page import="cs.ui.CsUiTools"%>
<%@page import="cs.utils.ObjTables"%>
<%@page import="csshared.vo.DataVO"%>
<%@page import="csshared.vo.ResponseVO"%>
<%@page import="org.json.JSONObject"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="csshared.vo.SubObjVO"%>
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
	Timekeeper d = new Timekeeper();
	String id = map.getString("ID");
	String account = map.getString("ACCT");
	String address = map.getString("ADDRESS");

%>
<html>
<head>

	<title>City Smart</title>
	<%= CsUiTools.getHTMLImports() %>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">

	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/toggleswitch/tinytools.toggleswitch.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/jquery.tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/inputmask.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/jquery.inputmask.js"></script>
	
 	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>

</head>
<body alert="">
<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontrol ">
				<div id="csuicontrol" class="csuicontrol">
					
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<td align="left">
								<table class="csui_tools">
									<tr>
										<td class="csui_tools">
											&nbsp;
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
						<td align="left" id="title">MERGE TO AN EXISTING ACCOUNT</td>
						<td align="right" id="subtitle">&nbsp;</td>
					</tr>
				</table>
				
				<div id="csform_message"></div>
				<form id="csform" class="form"  action="/cs/action.jsp" method="post" close="true" refresh="true">
					<input type="hidden" name="_ent" value="lso">
					<input type="hidden" name="_type" value="parking">
					<input type="hidden" name="_grp" value="parking">
					<input type="hidden" name="_grptype" value="parking">
					<input type="hidden" name="_typeid" value="<%=id%>">
					<input type="hidden" name="_request" value="merge">
					<input type="hidden" name="_action" value="onlineapproval">
					
					<table class="csui_title">
						<tr>
							<td class="csui_title">MERGE</td>
							<td class="csui_controls">&nbsp;</td>
						</tr>
					</table>
						<table class="csui" colnum="2" type="default">
							<tr>
								<td class="csui_label" colnum="2" alert="">ACCOUNT NUMBER</td>
								<td class="csui" colnum="2" type="String" itype="text" alert=""><input name="account" type="text" id="account"  itype="String" valrequired="true" value="<%= account %>" maxchar="1000"></td>
								<td class="csui_label" colnum="2" alert="">&nbsp;</td>
								<td class="csui" colnum="2" type="String" itype="text" alert="">&nbsp;</td>
							</tr>
					</table>
					<div class="csui_divider">
			</div>
			<div class="csui_buttons">
				<input type="submit" name="_action" value="cancel" class="csui_button">&nbsp;
				<input type="submit" name="_action" value="save" class="csui_button">
			</div>
			</form>
			</div>
		</div>
	</div>
</body>
</html>


