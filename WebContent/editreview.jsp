<%@page import="cs.ui.CsUiTools"%>
<%@page import="cs.ui.Review"%>
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

	String token = map.token();
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	String group = map.getString(RequestMapper.group);
	String groupid = map.getString(RequestMapper.groupid);
	int typeid = map.getInt(RequestMapper.typeid);
	int reviewid = map.getInt(RequestMapper.reviewid);
	int reviewrefid = map.getInt(RequestMapper.reviewrefid);
	int comboid = map.getInt(RequestMapper.id, 0);

	if (map.hasValue(RequestMapper.action)) {
		ResponseVO rvo = ApiHandler.getSaveResponse(map);
		comboid = rvo.getId();
	}

	RequestVO t = new RequestVO();
	t.setToken(token);
	t.setIp(map.getRemoteIp());
	t.setEntity(entity);
	t.setType(type);
	t.setTypeid(typeid);
	t.setGroup(group);
	t.setId(Operator.toString(comboid));
	t.setReviewrefid(reviewrefid);
	t.setReviewid(reviewid);
	t.setGrouptype("review");
	t.setRequest("details");

	ComboReviewVO tvo = ApiHandler.getComboReview(t);
	String title = tvo.getTitle();
	String subtitle = tvo.getSubtitle();

	LinkedHashMap<Integer, ReviewVO> reviews = new LinkedHashMap<Integer, ReviewVO>();

	Timekeeper now = new Timekeeper();

	Timekeeper s = new Timekeeper();
	if (Operator.hasValue(tvo.getStart())) {
		s.setDate(tvo.getStart());
	}
	String start = s.getString("YYYY/MM/DD");

	SubObjVO[] status = new SubObjVO[0];
	SubObjVO[] atypes = new SubObjVO[0];

	RequestVO treq = t.duplicate();
	treq.setGroup(group);
	treq.setGrouptype("review");
	treq.setRequest("reviewstatus");
	treq.setReviewid(reviewid);
	treq.setId(Operator.toString(reviewid));

	status = ApiHandler.getChoices(treq);
	reviews = tvo.getReviews();
	ReviewVO review = tvo.getReview(reviewrefid);
	int availabilityid = review.getAvailabilityid();
	reviewid = review.getReviewid();

	RequestVO creq = t.duplicate();
	creq.setGrouptype("appointment");
	creq.setRequest("reviewcollaborators");
	creq.setId(Operator.toString(reviewrefid));
	SubObjVO[] collaborators = ApiHandler.getChoices(creq);

	RequestVO areq = t.duplicate();
	areq.setGroup(group);
	areq.setGrouptype("attachments");
	areq.setRequest("types");
	atypes = ApiHandler.getChoices(areq);

	String due = "";
	if (Operator.hasValue(review.getDuedate())) {
		due = review.duedate().getString("YYYY/MM/DD");
	}
    String expired = " expired=\"false\"";
    if (review.daystilldue >= 0) {
    	if (review.duedate().past()) {
    		if (!tvo.isApproved() && !tvo.isFinal()) {
	    		expired = " expired=\"true\"";
    		}
    	}
    }
    String emailimg = ObjTables.GRAYOPENEMAILIMGURL;

%><html>
<head>
	<%= CsUiTools.getHTMLImports() %>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
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
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/jquery.tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/inputmask.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/jquery.inputmask.js"></script>
	
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/ioscheckboxes/assets/js/jquery.mobileCheckbox.js"></script>
	
 	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>

	<style>
		td.emaillabel { padding: 6px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 9px; color: #ffffff; background-color: #99cc99; text-transform: uppercase }
		td.email { padding: 6px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 11px; background-color: #e6f4e7; text-transform: uppercase }
		td.small { width: 1%; white-space: nowrap }
	</style>
	<script>
	var comboid = '<%= comboid %>';
	var entity = '<%= entity %>';
	var type = '<%= type %>';
	var typeid = '<%= typeid %>';
	var group = '<%= group %>';
	var groupid = '<%= groupid %>';
	var reviewrefid = <%= reviewrefid %>;
	var fullcontexturl = '<%=Config.fullcontexturl()%>';
	$(document).ready(function() {

		<%
		if (map.hasValue(RequestMapper.action)) {
		%>
		parent.location.reload(true);
		<%
		}
		%>

		var st = $('#editform select[itype=reviewstatus]');
		st.change(function() {
			var sched = st.find('option:selected').attr('schedule');
			var avid = st.find('option:selected').attr('availability_id');
			var tm = st.find('option:selected').attr('assign');
			var att = st.find('option:selected').attr('attachment');
			hideReviewAvailability('editform');
			hideReviewTeam('editform');
			hideAttachment('editform');
			hideCollaborators('editform');
			if (sched == 'Y') {
				showReviewAvailability('editform', comboid, <%= reviewid %>, st.val(), <%= availabilityid%>);
				showInspectors('editform', <%= reviewid %>);
				showCollaborators('editform');
			}
			if (tm == 'Y') {
				showReviewTeam('editform', <%= reviewid %>);
			}
			if (att == 'Y') {
				showAttachment('editform');
			}
		});
		
		$('input:checkbox.csform_checkbox').not(this).prop('checked', true);
		

		$('.showemail').click(function(e) {
			var eid = $(this).attr('rel');
			var row = $('#notifications_'+eid+'_row');
			if (row.is(':hidden')) {
				showNotification(eid);
			}
			else {
				row.hide();
			}
		});

		$("input:checkbox").click(function() { swal("Can't unselect, send email is mandatory."); return false; });


	});

	function showNotification(id) {
		var url = '/cs/json/choices.jsp?_ent=<%=entity%>&_type=review&_typeid='+id+'&_grptype=communications&_request=notifications&_id='+id;
		var row = $('#notifications_'+id+'_row');
		var cell = $('#notifications_'+id+'_cell');
		var ajx = doAjax(url);
		var choices = ajx.choices;
		var tb = $('<table>');
		tb.css({
			'width': '100%'
		});
		var htr = $('<tr>');
		var rech = $('<td>').addClass('emaillabel').addClass('small').html('RECIPIENT');
		var subh = $('<td>').addClass('emaillabel').html('SUBJECT');
		var dth = $('<td>').addClass('emaillabel').addClass('small').html('SENT DATE');
		var tth = $('<td>').addClass('emaillabel').addClass('small').html('SENT TIME');
		var crh = $('<td>').addClass('emaillabel').addClass('small').html('SENT_BY');
		var vh = $('<td>').addClass('emaillabel').addClass('small').html('VIEW EMAIL');
		htr.append(rech);
		htr.append(subh);
		htr.append(dth);
		htr.append(tth);
		htr.append(crh);
		htr.append(vh);
		tb.append(htr);
		for (i=0; i<choices.length; i++) {
			var choice = choices[i];
			var data = choice.addldata;
			var tr = $('<tr>');
			var rectd = $('<td>').addClass('email').addClass('small').html(data['RECIPIENT']);
			var subtd = $('<td>').addClass('email').html(data['SUBJECT']);
			var dttd = $('<td>').addClass('email').addClass('small').html(data['DATE']);
			var ttd = $('<td>').addClass('email').addClass('small').html(data['TIME']);
			var crtd = $('<td>').addClass('email').addClass('small').html(data['CREATED_BY']);
			var va = $('<a>');
			va.attr('href', '/cs/notification.jsp?_ent=<%=entity%>&_type=<%=type%>&_typeid=<%=typeid%>&_grptype=communications&_id='+choice.id);
			va.attr('target', '_blank')
			va.addClass('csui');
			va.html('<img src="<%=emailimg%>">');
			var vtd = $('<td>').addClass('email').addClass('small').html(va);
			tr.append(rectd);
			tr.append(subtd);
			tr.append(dttd);
			tr.append(ttd);
			tr.append(crtd);
			tr.append(vtd);
			tb.append(tr);
		}
		cell.html(tb);
		row.show();
	}

	</script>

</head>
<body>

	<div id="fullpage">
	<div id="loader"></div>
	<div id="csuibody">
		<div id="csuimain">

			<div class="csuicontent">
				<form class="form" ajax="no" id="editform" action="editreview.jsp" method="post" enctype="multipart/form-data">
				<table cellpadding="10" cellspacing="0" border="0" width="100%">
					<tr>
						<td align="left">
							<div id="title"><%= title %></div><div id="subtitle"><%= subtitle %></div>
						</td>
						<td align="right">
							<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td class="csinfo_label" style="text-align: left">START DATE</td>
									<td class="csinfo_field"><%= start %></td>
									<td class="csinfo_label">&nbsp;</td>
								</tr>
								<tr>
									<td class="csinfo_label" style="text-align: left">DUE DATE</td>
									<td class="csinfo_field"<%= expired %>>
										<% if (Operator.hasValue(due)) { %>
											<%=due%>
										<% } else { %>
											- -
										<% } %>
									</td>

									<% if (!tvo.isUpdate()) { %>
										<td class="csinfo_label">&nbsp;</td>
									<% } else if (review.getDaystilldue() == 0) { %>
										<td class="csinfo_label"><a href="reviewdue.jsp?_id=<%= comboid %>&_ent=<%= entity %>&_type=<%= type %>&_typeid=<%= typeid %>&_grp=<%= group %>&_grpid=<%= groupid %>&_grptype=review&_reviewid=<%= reviewid %>&_revrefid=<%= reviewrefid%>"><img src="/cs/images/icons/controls/gray/edit.png"/></a></td>
									<% } else { %>
										<td class="csinfo_label">&nbsp;</td>
									<% } %>
								</tr>
								<tr>
									<td class="csinfo_label" style="text-align: left">TEAM</td>
									<td class="csinfo_field"><%= review.teamMembers() %></td>
									<% if (!tvo.isUpdate()) { %>
										<td class="csinfo_label">&nbsp;</td>
									<% } else { %>
										<td class="csinfo_label"><a href="reviewteam.jsp?_id=<%= comboid %>&_ent=<%= entity %>&_type=<%= type %>&_typeid=<%= typeid %>&_grp=<%= group %>&_grpid=<%= groupid %>&_grptype=review&_reviewid=<%= reviewid %>&_revrefid=<%= reviewrefid%>"><img src="/cs/images/icons/controls/gray/edit.png"/></a></td>
									<% } %>
								</tr>
							</table>
						</td>
				</table>

				<div id="editreview">
				<table class="csui_title">
					<tr>
						<td class="csui_title" width="1%" id="edittitle" nowrap><%= review.getReview() %></td>
					</tr>
				</table>
				<% if (!tvo.isFinal() && tvo.isUpdate()) { %>

					<input type="hidden" name="_ent" value="<%= entity %>">
					<input type="hidden" name="_type" value="<%= type %>">
					<input type="hidden" name="_typeid" value="<%= typeid %>">
					<input type="hidden" name="_grpid" value="<%= groupid %>">
					<input type="hidden" name="_grp" value="<%= group %>">
					<input type="hidden" name="_grptype" value="review">
					<input type="hidden" name="_id" value="<%= comboid %>">
					<input type="hidden" name="_revrefid" value="<%= reviewrefid %>">
					<input type="hidden" name="_act" value="add">

					<table class="csui" colnum="2" type="default">
						<tr>
							<%= ObjTables.cells("LKUP_REVIEW_STATUS_ID", "STATUS", "", "select", "reviewstatus", true, "csui", 3, status, false, true) %>
						</tr>
						<tr id="editform_team" style="display: none">
							<%= ObjTables.cells("REF_TEAM_ID", "TEAM", "", "select", "reviewteam", false, "csui", 3, new SubObjVO[0], true, true) %>
						</tr>
						<tr id="editform_availability" style="display: none">
							<%= ObjTables.cells("DATE", "DATE", "", "String", "availability", false, "csui", true) %>
							<%= ObjTables.cells("TIME", "TIME", "", "select", "time", false, "csui", 1, new SubObjVO[0], false, true) %>
						</tr>
						<tr id="editform_attach" style="display: none">
							<%= ObjTables.cells("ATTACHMENT_TITLE", "ATTACHMENT TITLE", "", "String", "text", false, "csui", true) %>
							<%= ObjTables.cells("ATTACHMENT", "ATTACHMENT", "", "file", "atachment", false, "csui", true) %>
						</tr>
						<tr id="editform_attach_desc" style="display: none">
							<%= ObjTables.cells("ATTACHMENT_TYPE_ID", "ATTACHMENT TYPE", "", "select", "text", false, "csui", 1, atypes, false, true) %>
							<%= ObjTables.cells("ATTACHMENT_DESCTRIPTION", "ATTACHMENT DESCRIPTION", "", "text", "String", false, "csui", true) %>
						</tr>
						<tr id="editform_collaborators" style="display: none">
							<%= ObjTables.cells("INSPECTOR_ID", "INSPECTOR", "", "select", "inspectors", false, "csui", 1, new SubObjVO[0], false, true) %>
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
						<tr>
							<%= ObjTables.cells("REVIEW_COMMENTS", "COMMENTS", "", "String", "largetextarea", false, "csui", true) %>
						</tr>
						<%
							if (collaborators.length > 0) {
						%>
						<tr>
							<td class="csui_label">SEND EMAIL</td>
							<td colspan="3" class="csui vertical csui_field" type="people" itype="people" valign="top">
								<table cellpadding="2" cellspacing="0" border="0" itype="people" width="100%">
									<%
										StringBuilder nsb = new StringBuilder();
										String luser = review.getCurrent().getCreatedby();
										boolean isinsp = review.isInspection();
										for (int i=0; i<collaborators.length; i++) {
											SubObjVO cvo = collaborators[i];
											if (Operator.hasValue(cvo.getDescription())) {
												String selected = "";
												if (isinsp && Operator.equalsIgnoreCase(cvo.getDescription(), luser)) {
													//selected = " checked";
												}
												nsb.append("<tr>\n");
												nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csform_checkbox\"><input type=\"checkbox\" name=\"NOTIFY\" value=\"").append(cvo.getValue()).append("\" class=\"csform_checkbox\"").append(selected).append("/></td>");
												nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"98%\" class=\"csform_checkboxtext\">").append(cvo.getText()).append("</td>");
												nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csform_checkboxtext\" align=\"right\">").append(cvo.getDescription()).append("</td>");
												nsb.append("</tr>");
											}
										}
									%>
									<%= nsb.toString() %>
								</table>
							</td>
						</tr>
						<%
							}
						%>
					</table>

					<div class="csui_divider"></div>
					<div class="csui_buttons">
					<input type="submit" name="action" value="add" class="csui_button"></div>

				<% } %>
				</div>


				<%
					if (reviews.size() > 0) {
						out.print(Review.hzReview(t, tvo, "csui", !tvo.isFinal()));
					}
				%>

				</form>
			</div>
		</div>
	</div>
	</div>


</body>
</html>

