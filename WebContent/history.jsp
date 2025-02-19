<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="cs.ui.CsUi"%>
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

	Cartographer map = new Cartographer(request, response);
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	String group = map.getString(RequestMapper.group);
	int typeid = map.getInt(RequestMapper.typeid);
	String id = map.getString(RequestMapper.id);

	RequestVO nav = new RequestVO();
	nav.setIp(map.getRemoteIp());
	nav.setEntity(entity);
	nav.setToken(map.token());
	nav.setType(type);
	nav.setTypeid(typeid);
	nav.setId(id);
	nav.setRequest("details");

	TypeVO o = ApiHandler.getType(nav);
	if (!o.isRead()) {
		o = new TypeVO();
	}

	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();

	String style = "csui";
	String option = map.getString("option");
	
	RequestVO req = nav.duplicate();
	req.setGroup(group);
	req.setGrouptype("ui");
	req.setRequest("history");
	req.setOption(option);
	
	ObjGroupVO[] groups = ApiHandler.getGroups(req);
	String table = "";
	table = CsUi.history(req, groups, style, alert);


%>
<html>
<head>

	<title>City Smart</title>
	<%= CsUiTools.getHTMLImports() %>
	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">


	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.ui.js"></script>
 	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.act.js"></script>


	<style>
		[first=N].csui_timeline_bullet {
			background-image: url(/cs/images/timeline/bullet.png);
			background-repeat: no-repeat;
			background-position: center center;
			width: 20px;
			cursor: pointer;
		}
		[first=N].csui_timeline_bullet:hover {
			background-image: url(/cs/images/timeline/bullet-on.png) !important;
			background-repeat: no-repeat;
			background-position: center center;
		}
		[first=N].bullet-on {
			background-image: url(/cs/images/timeline/bullet-on.png) !important;
			background-repeat: no-repeat;
			background-position: center center;
		}
		[first=Y].csui_timeline_bullet {
			background-image: url(/cs/images/timeline/bullet-first.png);
			background-repeat: no-repeat;
			background-position: center center;
			width: 20px;
			cursor: pointer;
		}
		[first=Y].bullet-on, [first=Y].csui_timeline_bullet:hover {
			background-image: url(/cs/images/timeline/bullet-first-on.png) !important;
			background-repeat: no-repeat;
			background-position: center center;
		}
		.csui_timeline_line {
			background-image: url(/cs/images/timeline/line.png);
			background-position: center center;
			background-repeat: repeat-y;
			width: 20px;
		}
		.csui_timeline_title {
			font-family: Oswald, Arial, Helvetica;
			font-size: 16px;
		}
		.csui_timeline_date {
			font-family: Oswald, Arial, Helvetica;
			font-size: 25px;
			width: 1%;
			white-space: nowrap;
		}
		.csui_timeline_label { padding: 5px; font-family: Oswald, Arial, Helvetica, sans-serif; font-size: 16px; color: #000000; text-transform: uppercase}
		.csui_timeline_hr { border-top: 0px dashed #eeeeee }
		
	</style>




	<script>
		var entity = '<%= entity %>';
		var type = '<%= type %>';
		var typeid = '<%= typeid %>';
		var fullcontexturl = '<%=Config.fullcontexturl()%>';

		$(document).ready(function() {
//			$('[ui]').csui();
			$('tr.csui_timeline_content').hide();
//			$('td.csui_timeline_bullet[first=Y]').addClass('bullet-on');
			$('td.csui_timeline_bullet').click(function() {
				toggle($(this));
			});
		});

		function toggle(d) {
			var id = d.attr('rel');
			var dv = $('#'+id);
			if (dv.is(':visible')) {
				dv.hide();
				d.removeClass('bullet-on');
			}
			else {
				var m = d.attr('group');
				if (m != 'activity' && m != 'project') {
					var url = elemUiRequestUrl(d);
					historyAjax(url, $('#content_'+id));
				}
				dv.show();
				d.addClass('bullet-on');
			}
		}

		function historyAjax(urladdrss, elem) {
			cslog(urladdrss, 'Ajax URL');
			var r = undefined;
			if (hasValue(urladdrss)) {
				$.ajax({
					url: urladdrss,
					type:'POST', 
					dataType: 'json',
					success: function(result) {
						elem.empty();
						r = result;
						var table = r['table'];
						cslog(table);
						elem.html(table);
						cslog(r, 'Ajax Response');
					},
					error: function(xhr,status,error) {
						cslog(xhr.responseText, 'Ajax Response');
						cslog(status, 'Ajax Error');
					}
				});
			}
			return r;
		}

		function elemUiRequestUrl(elem) {
			var u = '';
			try {
				u += fullcontexturl+'/json/ui.jsp';
				u += '?_ent='+entity;
				u += '&_type='+type;
				u += '&_typeid='+typeid;
				u += '&_grp='+elem.attr('group');
				u += '&_id='+elem.attr('groupid');
				u += '&_grptype=ui';
				u += '&_request=id';
				u += '&style=csui';
				u += '&alert='+elem.attr('uialert');
			}
			catch(e) { }
			return u;

		}

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
<%

if (!o.isRead()) {
%>

	<br/><br/>
	<table width="100%">
		<tr>
			<td align="center">
				<table>
					<tr>
						<td style="padding: 20px"><img src="/cs/images/accessdenied.png" width="100" height="100"/></td>
						<td>
							<div class="error_title">ERROR 403</div>
							<div class="error_description">Access Denied</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>


<%
}
else {

	if (!map.equalsIgnoreCase("banner", "n")) {
%>
	<div id="csuicontrols">
		<div id="csuicontrol" class="csuicontrol csuialert" alert="<%= alert %>">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td class="csui_tools" width="1%" nowrap><a href="<%= Config.fullcontexturl() %>/summary.jsp?_ent=<%= entity %>&_type=<%= type %>&_typeid=<%= typeid %>&_id=<%= typeid %>"><img src="<%= CsConfig.getImage("back") %>" height="25" width="25" border="0"/></a></td>
					<td align="left" class="csuicontrol">HISTORY</td>
				</tr>
			</table>
		</div>
	</div>
<% } %>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
				<table cellpadding="10" cellspacing="0" border="0" width="100%">
					<tr>
						<td align="left" id="title"><%= title %></td>
						<td align="right" id="subtitle"><%= subtitle %></td>
					</tr>
				</table>
				<div class="csui_divider"></div>
				<%= table %>
				<div class="csui_divider"></div>
				<div class="csui_divider"></div>
				
			</div>
		</div>
	</div>
	</div>

<%
}
%>

</body>
</html>
