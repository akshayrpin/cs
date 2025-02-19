<%@page import="cs.ui.CsUiTools"%>
<%@page import="alain.core.security.Token"%>
<%@page import="csshared.utils.CsApi"%>
<%@page import="csshared.utils.CsConfig"%>
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
	int typeid = map.getInt(RequestMapper.typeid);

	RequestVO nav = new RequestVO();
	nav.setEntity(entity);
	nav.setToken(map.token());
	nav.setType(type);
	nav.setTypeid(typeid);
	nav.setId(map.getString("_id"));
	nav.setRequest("summary");

	TypeVO o = ApiHandler.getType(nav);
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	ObjGroupVO[] g = o.getGroups();
	ToolsVO tools = o.getTools();


	nav.setRequest("info");

	TypeVO so = ApiHandler.getType(nav);
	Token u = CsApi.getToken(map.token(), map.getRemoteIp());


	RequestVO req = RequestMapper.getRequest(map);

%>
<html>
<head>

	<title>City Smart</title>
	<%= CsUiTools.getHTMLImports() %>
	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">


	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
 	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.act.js"></script>

</head>

<script>


function zoom(){
//	$('#link', parent.document).html('<iframe src="https://gis.beverlyhills.org/VBHforCS/PublicwSearch/?mobileBreakPoint=5&Q=10045">clicked</iframe>');
$('#loader').remove();
window.parent.pa();

}
</script>
<body alert="<%= alert %>">

	<div id="fullpage">
	<div id="loader"></div>
	
	<!-- 
	<div id="csuicontrols">
		<div id="csuicontrol" class="csuicontrol <%= alert %>">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="left" class="csuicontrol">MAP</td>
					<td align="right">
					
					
					<a href="javascript:void(0);" onclick="zoom();" title="Maximize"><img src="/cs/images/icons/controls/black/maximize.png" /></a> 
					</td>
				</tr>
			</table>
		</div>
	</div> -->
	<div id="csuibody">
		<%if(u.isStaff()){ %>
		<iframe src="<%= CsConfig.getString("tools.map") %>?Q=<%= typeid %>&mobileBreakPoint=5" frameborder="0" style="width: 100%; height: calc(100% - 25px); border: 0px; padding: 0px; margin: 0px"></iframe>
		<%}else { %>
		<iframe src="https://gis.beverlyhills.org/vbhforcs/public/?mobileBreakPoint=5&Q=<%= typeid %>" frameborder="0" style="width: 100%; height: calc(100% - 25px); border: 0px; padding: 0px; margin: 0px"></iframe>
		<%} %>
	</div>




</body>
</html>

