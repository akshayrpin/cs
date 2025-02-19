<%@page import="cs.ui.CsUiTools"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="csshared.utils.CsApi"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="cs.ui.CsUi"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="csshared.vo.ToolsVO"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="alain.core.utils.Logger"%>
<%@page import="cs.agent.UiAgent"%>
<%@page import="cs.utils.ObjUi"%>
<%@page import="csshared.vo.ObjGroupVO"%>
<%@page import="csshared.vo.TypeVO"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="alain.core.utils.Cartographer"%>
<%
	boolean ispublic = CsConfig.isPublic();

	Cartographer map = new Cartographer(request,response);
	if (!Operator.hasValue(map.token()) || !Operator.hasValue(map.username())) {
		map.logout();
	}
	if (!CsConfig.isPublic()) {
		map.requireLogin();
	}
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	String id = map.getString(RequestMapper.id);

	RequestVO nav = new RequestVO();
	nav.setIp(map.getRemoteIp());
	nav.setEntity(entity);
	nav.setToken(map.token());
	nav.setType(type);
	nav.setTypeid(typeid);
	nav.setId(id);
	if (map.equalsIgnoreCase("_act", "refresh")) {
		nav.setRequest("refreshmodules");
	}
	else {
		nav.setRequest("modules");
	}

	TypeVO o = CsApi.getType(nav);
	if (!o.isRead()) {
		o = new TypeVO();
		map.forward("403.jsp");
	}

	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	String entitydesc = "";
	if (type.equalsIgnoreCase("project") || type.equalsIgnoreCase("activity")) {
		entitydesc = o.getTypeinfo().getEntitydescription();
	}
	ObjGroupVO[] g = o.getGroups();
	ToolsVO tools = o.getTools();

	RequestVO req = RequestMapper.getRequest(map);

%>
<html>
<head>

	<title>City Smart</title>
	<%= CsUiTools.getHTMLImports() %>
	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/carouFredSel/cs.slides.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/magic/magic.css">


 	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.ui.js?v=1"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/carouFredSel/jquery.carouFredSel-6.2.1-packed.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/carouFredSel/helper-plugins/jquery.mousewheel.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/carouFredSel/helper-plugins/jquery.transit.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/carouFredSel/helper-plugins/jquery.ba-throttle-debounce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.act.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/carouFredSel/cs.carouFredSel.js"></script>

	<style>
		.slidenav:hover {
			background-color: #aaa !important;
		}
	</style>

	<script>
		var entity = '<%= entity %>';
		var type = '<%= type %>';
		var typeid = '<%= typeid %>';
		var fullcontexturl = '<%=Config.fullcontexturl()%>';

		$(document).ready(function() {
			<% if (!map.isLoggedIn()) { %>
					try {
						parent.removeLoginPopup();
					} catch(e) { }
			<% } %>
			$('[ui]').csui();
			$('a[target=imglightbox]').fancybox();

			$('.typesearch').click(function() {
				try {
					parent.addSearchTerm('lso_id:<%= typeid %>');
					parent.linkIframe('/cs/search.jsp?sq=lso_id:<%= typeid %>');
				}
				catch (e) {}
			});
		});

		function openFancybox(url) {
			$('<a href="'+url+'"/>').fancybox().click();
		}
		
		function pa(){
			var ht = '<iframe src="https://gis.beverlyhills.org/vbhforcs/public/?Q=<%= typeid %>" frameborder="0" style="width: 100%; height: calc(100% - 25px); border: 0px; padding: 0px; margin: 0px"></iframe>';
			$('.csuicontent').html(ht);
			
			
			var t = '<a href="summary.jsp?_act=refresh&_ent=lso&_type=lso&_typeid=<%= typeid %>&_id=<%= typeid %>"><img src="/cs/images/icons/controls/black/minimize.png" width="25" height="25" border="0" title="minimize"/> &nbsp;&nbsp;&nbsp;</a>'
			$('#tools').html(t);	
			
			
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
%>
	<div id="csuicontrols">
		<div id="csuicontrol" class="csuicontrol csuialert" alert="<%= alert %>">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="left" width="1%" nowrap><a href="summary.jsp?_act=refresh&_ent=<%= entity %>&_type=<%= type %>&_typeid=<%= typeid %>&_id=<%= id %>"><img src="/cs/images/icons/controls/white/refresh.png" width="25" height="25" border="0" title="refresh"/></a></td>
					<td align="left" class="csuicontrol">SUMMARY</td>
					<td align="right" id="tools" ><%= ObjUi.tools(o.getTools(), "csui") %></td>
				</tr>
			</table>
		</div>
		<div id="csuisubcontrol" class="csuisubcontrol csuialert" alert="<%= alert %>">INFO</div>
	</div>
	<div id="csuimessage" style="display: none;"><div class="csuimessage_title">Errors were encountered. Try refreshing the summary. If the problem persists, contact csadmin@beverlyhills.org</div></div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
				<table cellpadding="10" cellspacing="0" border="0" width="100%" class="animated bounceInDown">
					<tr>
						<td align="left" id="title"><%= title %></td>
						<td align="right" id="subtitle"><div id="entitydescription"><%= entitydesc %></div><%= subtitle %></td>
					</tr>
				</table>
				<%= CsUi.modules(req, o, "summary", "csui", alert) %>
				<div class="csui_divider"></div>
				<div class="csui_divider"></div>
				
			</div>
		</div>
		<div id="csuisub">
				<div class="csuisub_divider"></div>
				<div class="csuisubcontent">
				<%= CsUi.modules(req, o, "info", "csuisub", alert) %>
				</div>
				<div class="csuisub_divider"></div>
				<div class="csui_divider"></div>
		</div>
	</div>
	</div>

<%
}
%>

</body>
</html>
