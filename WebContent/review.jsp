<%@page import="cs.ui.CsUiTools"%>
<%@page import="cs.ui.Review"%>
<%@page import="alain.core.utils.Logger"%>
<%@page import="csshared.vo.ResponseVO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="csshared.vo.ReviewVO"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="csshared.vo.ComboReviewVO"%>
<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="cs.utils.ObjTables"%>
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
	String entityid = map.getString(RequestMapper.entityid);
	String type = map.getString(RequestMapper.type);
	String group = map.getString(RequestMapper.group);
	String groupid = map.getString(RequestMapper.groupid);
	int typeid = map.getInt(RequestMapper.typeid);
	int reviewid = map.getInt(RequestMapper.reviewid);
	int comboid = map.getInt(RequestMapper.id, 0);

	if (map.hasValue(RequestMapper.action)) {
		ResponseVO rvo = ApiHandler.getSaveResponse(map);
		comboid = rvo.getId();
		StringBuilder sb = new StringBuilder();
		sb.append(Config.fullcontexturl()).append("/review.jsp?_id=").append(comboid).append("&_reviewid=").append(comboid).append("&_entid=").append(entityid).append("&_ent=").append(entity).append("&_typeid=").append(typeid).append("&_type=").append(type).append("&_grpid=").append(groupid).append("&_grp=").append(Operator.urlFriendly(group)).append("&_grptype=review&view=add");
		map.redirect(sb.toString());
	}
	else {
		
		RequestVO t = new RequestVO();
		t.setEntity(entity);
		t.setType(type);
		t.setTypeid(typeid);
		t.setGroup(group);
		t.setId(Operator.toString(comboid));
		if (reviewid > 0) {
			t.setReviewid(reviewid);
		}
		t.setGrouptype("review");
		t.setRequest("details");
	
		ComboReviewVO tvo = ApiHandler.getComboReview(t);
		String title = tvo.getTitle();
		String subtitle = tvo.getSubtitle();
	
		String buttontext = "create";
		SubObjVO[] types = new SubObjVO[0];
		SubObjVO[] atypes = new SubObjVO[0];
		LinkedHashMap<Integer, ReviewVO> reviews = new LinkedHashMap<Integer, ReviewVO>();
	
		Timekeeper now = new Timekeeper();
	
		Timekeeper s = new Timekeeper();
		if (Operator.hasValue(tvo.getStart())) {
			s.setDate(tvo.getStart());
		}
		String start = s.getString("YYYY/MM/DD");
	
		String due = "";
		if (Operator.hasValue(tvo.getDue())) {
			Timekeeper d = new Timekeeper();
			d.setDate(tvo.getDue());
			due = d.getString("YYYY/MM/DD");
		}
	
		RequestVO treq = t.duplicate();
		treq.setGroup(group);
		treq.setGrouptype("review");
		treq.setRequest("types");
		types = ApiHandler.getChoices(treq);
	
		RequestVO areq = t.duplicate();
		areq.setGroup(group);
		areq.setGrouptype("attachments");
		areq.setRequest("types");
		atypes = ApiHandler.getChoices(areq);
	
		RequestVO creq = t.duplicate();
		creq.setGrouptype("appointment");
		creq.setRequest("collaborators");
		SubObjVO[] collaborators = ApiHandler.getChoices(creq);

		reviews = tvo.getReviews();
		if (comboid > 0) {
			buttontext = "update";
		}


%><html>
<head>
	<%= CsUiTools.getHTMLImports() %>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/switchButton/jquery.switchButton.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css">
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/ioscheckboxes/assets/css/mobileCheckbox.iOS.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
	

	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.review.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/toggleswitch/tinytools.toggleswitch.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/switchButton/jquery.switchButton.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/jquery.tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/inputmask.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/jquery.inputmask.js"></script>
	
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/ioscheckboxes/assets/js/jquery.mobileCheckbox.js"></script>
	
 	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>

	<script>
	var comboid = '<%= comboid %>';
	var entity = '<%= entity %>';
	var type = '<%= type %>';
	var typeid = '<%= typeid %>';
	var group = '<%= group %>';
	var groupid = '<%= groupid %>';
	var reviewrefid = '';
	var fullcontexturl = '<%=Config.fullcontexturl()%>';
	$(document).ready(function() {
		<% if (map.equalsIgnoreCase("view", "add")) { %>
		showReviewAdd();
		<% } %>
	});

	</script>

</head>
<body>

	<div id="fullpage">
	<div id="loader">
		<div id="process">
			<table cellpadding="5" cellspacing="0" border="0" id="processtable">
				<tr>
					<td id="processtitle"></td>
				</tr>
				<tr>
					<td id="processmessage"></td>
				</tr>
				<tr>
					<td id="processpercent">
						<table id="processpercentage"><tr><td></td></tr></table>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontrol">
				<div id="csuicontrol" class="csuicontrol">
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

				<table class="csui_title">
					<tr>
						<td class="csui_title"><%= group %></td>
					</tr>
				</table>

				<form class="form" ajax="no" action="review.jsp" method="post" success="<%=Config.fullcontexturl() %>/review.jsp?_id=data.id&_ent=data.entity&_typeid=data.typeid&_type=data.type&_grpid=data.groupid&_grp=data.group&_grptype=review">

					<input type="hidden" name="<%= RequestMapper.entity %>" value="<%= entity %>">
					<input type="hidden" name="<%= RequestMapper.type %>" value="<%= type %>">
					<input type="hidden" name="<%= RequestMapper.typeid %>" value="<%= typeid %>">
					<input type="hidden" name="<%= RequestMapper.groupid%>" value="<%= groupid %>">
					<input type="hidden" name="<%= RequestMapper.group %>" value="<%= group %>">
					<input type="hidden" name="<%= RequestMapper.grouptype %>" value="review">
					<input type="hidden" name="<%= RequestMapper.id %>" value="<%= comboid %>">
					<input type="hidden" name="<%= RequestMapper.action %>" value="<%= buttontext %>">

					<table class="csui" colnum="2" type="default">
						<tr>
							<%= ObjTables.cells("TITLE", "TITLE", tvo.getCombotitle(), "String", "text", true, "csui", !tvo.isFinal()) %>
							<%= ObjTables.cells("START_DATE", "START DATE", start, "String", "date", true, "csui", !tvo.isFinal()) %>
							<% if (!tvo.isFinal()) { %>
								<td style="background-color: #eeeeee" width="1%" nowrap><input type="submit" name="action" value="<%= buttontext %>" class="csui_button"></td>
							<% } %>
						</tr>
					</table>
					<div class="csui_divider"></div>

				</form>

				<% if (comboid > 0) { %>

				<br/><br/>

				<table class="csui_title">
					<tr>
						<td class="csui_title" width="1%" nowrap>Reviews</td>
						<td class="csui_controls" width="99%" id="addreviewbutton" style="cursor: pointer"><img src="<%= ObjTables.WHITEADDIMGURL %>"/></td>
						<td class="csui_controls" width="99%" id="closereviewbutton" style="cursor: pointer; display: none"><img src="<%= ObjTables.WHITEDELETEIMGURL %>"/></td>
						<td class="csui_controls" width="1%" nowrap>&nbsp;</td>
					</tr>
				</table>

				<div id="addreview"<% if (reviews.size() > 0) { %> style="display: none"<% } %>>

				<form class="form" ajax="no" id="addform" action="review.jsp" method="post" enctype="multipart/form-data">

					<input type="hidden" name="<%= RequestMapper.entity %>" value="<%= entity %>">
					<input type="hidden" name="<%= RequestMapper.type %>" value="<%= type %>">
					<input type="hidden" name="<%= RequestMapper.typeid %>" value="<%= typeid %>">
					<input type="hidden" name="<%= RequestMapper.groupid%>" value="<%= groupid %>">
					<input type="hidden" name="<%= RequestMapper.group %>" value="<%= group %>">
					<input type="hidden" name="<%= RequestMapper.grouptype %>" value="review">
					<input type="hidden" name="<%= RequestMapper.id %>" value="<%= comboid %>">
					<input type="hidden" name="<%= RequestMapper.action %>" value="add">

					<table class="csui" colnum="2" type="default">
						<tr>
							<%= ObjTables.cells("REVIEW_ID", "REVIEW", "", "String", "review", true, "csui", 1, types, false, true) %>
							<%= ObjTables.cells("LKUP_REVIEW_STATUS_ID", "STATUS", "", "select", "reviewstatus", true, "csui", true) %>
							<td rowspan="10" style="background-color: #eeeeee" width="1%" valign="top" nowrap><input type="submit" name="action" value="add" class="csui_button"></td>
						</tr>
						<tr id="addform_reviewduedate" style="display: none">
							<%= ObjTables.cells("DUE_DATE", "DUE DATE", "", "text", "reviewduedate", 3, false, "csui", true) %>
						</tr>
						<tr id="addform_team" style="display: none">
							<%= ObjTables.cells("REF_TEAM_ID", "TEAM", "", "select", "reviewteam", true, "csui", 3, new SubObjVO[0], true, true) %>
						</tr>
						<tr id="addform_availability" style="display: none">
							<%= ObjTables.cells("DATE", "DATE", "", "String", "availability", false, "csui", true) %>
							<%= ObjTables.cells("TIME", "TIME", "", "select", "time", false, "csui", 1, new SubObjVO[0], false, true) %>
						</tr>
						<tr id="addform_attach" style="display: none">
							<%= ObjTables.cells("ATTACHMENT_TITLE", "ATTACHMENT TITLE", "", "String", "text", false, "csui", true) %>
							<%= ObjTables.cells("ATTACHMENT", "ATTACHMENT", "", "file", "atachment", false, "csui", true) %>
						</tr>
						<tr id="addform_attach_desc" style="display: none">
							<%= ObjTables.cells("ATTACHMENT_TYPE_ID", "ATTACHMENT TYPE", "", "select", "text", false, "csui", 1, atypes, false, true) %>
							<%= ObjTables.cells("ATTACHMENT_DESCTRIPTION", "ATTACHMENT DESCRIPTION", "", "text", "String", false, "csui", true) %>
						</tr>
						<tr id="addform_collaborators" style="display: none">
							<%= ObjTables.cells("INSPECTOR_ID", "INSPECTOR", "", "select", "inspectors", true, "csui", 1, new SubObjVO[0], false, true) %>
							<td class="csui_label">COLLABORATORS</td>
							<td class="csui vertical csui_field" type="people" itype="people">
								<table cellpadding="2" cellspacing="0" border="0" itype="people" width="100%">
									<%
										StringBuilder sb = new StringBuilder();
										for (int i=0; i<collaborators.length; i++) {
											SubObjVO cvo = collaborators[i];
											String selected = "";
											if (cvo.isSelected()) { selected = " checked"; }
											sb.append("<tr>\n");
											sb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csform_checkbox\"><input type=\"checkbox\" name=\"COLLABORATORS\" value=\"").append(cvo.getValue()).append("\" class=\"csform_checkbox\"").append(selected).append("/></td>");
											sb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"98%\" class=\"csform_checkboxtext\">").append(cvo.getText()).append("</td>");
											sb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csform_checkboxtext\" align=\"right\">").append(cvo.getDescription()).append("</td>");
											sb.append("</tr>");
										}
									%>
									<%= sb.toString() %>

								</table>
							</td>
						</tr>
						<tr id="addform_reviewcomment">
							<%= ObjTables.cells("REVIEW_COMMENTS", "COMMENTS", "", "String", "reviewcomment", false, "csui", true) %>
						</tr>
					</table>

					<input type="hidden" name="LIBRARY_GROUP_ID" value="-1"/>
				</form>

				</div>

				<%
					if (reviews.size() > 0) {
						out.print(Review.hzReview(t, tvo, "csui", !tvo.isFinal()));
				%>

						<div id="editreview" style="display: none">
						<table class="csui_title">
							<tr>
								<td class="csui_title" width="1%" id="edittitle" nowrap>Reviews</td>
								<td class="csui_controls" width="99%" id="closeeditreviewbutton" style="cursor: pointer;"><img src="<%= ObjTables.WHITEDELETEIMGURL %>"/></td>
								<td class="csui_controls" width="1%" nowrap>&nbsp;</td>
							</tr>
						</table>
						</div>


				<% } } %>

			</div>
		</div>
	</div>
	</div>

	<br/><br/>



</body>
</html>
<% } %>

