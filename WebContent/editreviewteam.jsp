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
	t.setEntity(entity);
	t.setType(type);
	t.setTypeid(typeid);
	t.setGroup(group);
	t.setId(Operator.toString(comboid));
	t.setReviewrefid(reviewrefid);
	t.setReviewid(reviewid);
	t.setGrouptype("review");
	t.setRequest("details");

	RequestVO treq = t.duplicate();
	treq.setGrouptype("review");
	treq.setRequest("team");
	SubObjVO[] team = ApiHandler.getChoices(treq);

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

	status = ApiHandler.getChoices(treq);
	reviews = tvo.getReviews();
	ReviewVO review = tvo.getReview(reviewrefid);
	int availabilityid = review.getAvailabilityid();
	reviewid = review.getReviewid();

	String due = "";
	if (Operator.hasValue(review.getDuedate())) {
		due = review.duedate().getString("YYYY/MM/DD");
	}

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
		parent.fancybox_reload = true;
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
	});

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
						<td align="left">
							<div id="title"><%= title %></div><div id="subtitle"><%= subtitle %></div>
						</td>
						<td align="right">
							<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td class="csinfo_label">START DATE</td>
									<td class="csinfo_field"><%= start %></td>
								</tr>
								<% if (review.getDaystilldue() >= 0) { %>
								<tr>
									<td class="csinfo_label">DUE DATE</td>
									<td class="csinfo_field">
										<% if (review.getDaystilldue() == 0) { %>
											<input name="DUE_DATE" type="date" itype="date" value="<%=due%>">
										<% } else { %>
											<%=due%>
										<% } %>
									</td>
								</tr>
								<% } %>
								<tr>
									<td class="csinfo_label">TEAM</td>
									<td class="csinfo_field"><%= review.teamMembers() %></td>
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

				<form class="form" ajax="no" id="editform" action="editreview.jsp" method="post" enctype="multipart/form-data">
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
						<tr id="editform_team">
							<%= ObjTables.cells("REF_TEAM_ID", "TEAM", "", "select", "reviewteam", false, "csui", 3, team, true, true) %>
						</tr>
					</table>

					<div class="csui_divider"></div>
					<div class="csui_buttons">
					<input type="submit" name="action" value="add" class="csui_button"></div>

				</form>
				</div>


				<%
					if (reviews.size() > 0) {
						out.print(Review.hzReview(t, tvo, "csui", !tvo.isFinal()));
					}
				%>

			</div>
		</div>
	</div>
	</div>




</body>
</html>

