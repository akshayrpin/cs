<%@page import="cs.ui.CsUiTools"%>
<%@page import="alain.core.security.Token"%>
<%@page import="csshared.utils.CsApi"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="csshared.vo.ResponseVO"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="alain.core.utils.Cartographer"%>
<% 
	Cartographer map = new Cartographer(request,response);
	
	if (CsConfig.isPublic() && !map.username().equals("Guest")) {
		
		//Token u = CsApi.getToken(map.token(), "0:0:0:0:0:0:0:1");
	//	System.out.println(u.getToken()+"jsssssssssssssssssssssssssssssp");
		//session.setAttribute("U_SECURITY_USERNAME","Guest");
		//session.setAttribute("U_ACCESS_TOKEN",u.getToken());
	}
	
	
	
	session.setMaxInactiveInterval(1800);
	if(request.getScheme().equals("http") && !Config.rooturl().startsWith("http://localhost")){
		map.redirect(Config.rooturl()+"/cs");
	}
	if (!Operator.hasValue(map.token()) || !Operator.hasValue(map.username())) {
		//map.logout();
	}
	
	
	
	if (!CsConfig.isPublic()) {
		map.requireLogin();
	}

	String entity = map.getString(RequestMapper.entity, map.getString("entity"));
	String type = map.getString(RequestMapper.type, map.getString("type"));
	String typeid = map.getString(RequestMapper.typeid, map.getString("typeid"));
	String reference = map.getString(RequestMapper.reference, map.getString("reference"));
	String sq = map.getString("sq","");

	RequestVO req = new RequestVO();
	req.setEntity("lso");
	req.setType("lso");
	req.setIp(map.getRemoteIp());
	req.setToken(map.token());
	req.setAction("version");
 	ResponseVO info = CsApi.getResponse(req);
 	Token u = CsApi.getToken(map.token(), map.getRemoteIp());
 	

 	String logintitle = "login";
 	String loginurl = "/cs/login.jsp";
 	String loginsrc = Config.fullcontexturl() + "/images/icons/controls/white/login.png";

	String initial = "";
	String plogin = "";

	if (map.isLoggedIn()) {
		if (Operator.hasValue(map.name())) {
			initial = Operator.subString(map.name(), 0, 1);
		}
		else {
			initial = Operator.subString(map.username(), 0, 1);
		}
		StringBuilder psb = new StringBuilder();
		if (Operator.hasValue(map.name())) {
			psb.append(map.name());
			psb.append("<br/>");
		}
		else if (Operator.hasValue(map.f_name())) {
			psb.append(map.f_name());
			if (Operator.hasValue(map.l_name())) {
				psb.append(" ");
				psb.append(map.l_name());
			}
			psb.append("<br/>");
		}
		psb.append(map.username());
		plogin = psb.toString();
	 	logintitle = "Sign Out";
	 	loginurl = "/cs/logout.jsp";
	}
	else {
		initial = "G";
		plogin = "Guest";
	 	logintitle = "Sign In";
	 	loginurl = "/cs/login.jsp";
	}

%><!DOCTYPE html>
<html>
<head>
<title>City Smart- 2021.07</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<%= CsUiTools.getHTMLImports() %>
	<link rel="stylesheet" href="<%=Config.fullcontexturl() %>/tools/alain/cs.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/powertip/css/jquery.powertip-cs.css">

	<link rel="stylesheet" href="<%=Config.fullcontexturl() %>/tools/bootstrap-3.3.6-dist/css/bootstrap.min.css">

	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/jscookie/js.cookie.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.treetools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tree.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/powertip/jquery.powertip.js"></script>

	<style>
		.sweet-alert p {
			font-size: 14px;
		}
	</style>

	<script language="JavaScript">
	
	$(document).ready(function() {
		var p = getPanels('<%=entity%>','<%=type%>','<%=typeid%>','<%=reference%>');
//		init(p);

		var uin = $('#userinitial');
		var pp = loginpopup('<%= initial %>', '<%= plogin %>', '<%= logintitle %>', '<%= loginurl %>', '<%= map.token() %>', '<%= map.getRemoteIp() %>', '<%= map.getSessionDate() %>', '<%= info.getInfo("VERSION") %>');
		uin.data('powertipjq', pp)
		uin.powerTip({
			placement: 'se-alt',
			followMouse: false,
			smartPlacement: true,
			offset: 18,
			openEvents: ['click'],
			closeEvents: ['click'],
			keepAlive: true
		});
//		uin.on({
//			powerTipRender: function() {
//				alert();
//			}
//		});

		<%
			if (map.hasValue("menu")) {
				out.print(" try { ");

				StringBuilder sb = new StringBuilder();
				sb.append("csui_menus['").append(map.getString("menu")).append("']();");
				out.print(sb.toString());

				out.print(" } catch(e) { } ");

			}
		%>
		// $('.cs_label_tools_pin').addClass('cs_pinned');
	});

	function funSearch(){	
		var val = document.all.sq.value;
		document.forms[0].action='search.jsp?q='+val;
		document.forms[0].submit();
	}

	function displayKeyCode(evt){
		
	    var charCode = (evt.which) ? evt.which : event.keyCode;
	    if (charCode == 13){
	    	funSearch();		
	    } 
	}
	
	function check(){
		<%if(Operator.hasValue(sq)){%>
			$('#globalsearch_query').val("<%=sq%>");

		
		<%}%>
	}

	function hasInitial() {
		var uin = $('#userinitial');
		var r = hasValue(uin);
		return r;
	}

	function removeLoginPopup() {
		if (hasInitial()) {
			var l = $('#cslogin');
			l.empty();
			var la = $('<a/>');
			la.attr('href', '/cs/login.jsp');
			la.addClass('resignin');
			la.html('Sign In');
			l.append(la);
			la.addClass('animated flip');
		}
	}

	function addSearchTerm(q) {
		var inp = $('#globalsearch_query');
		inp.val(q);
	}
	
	

	</script>

</head>

<body onload="check();">
<ul id="csheader">
	<li id="shield"><a href="<%=Config.fullcontexturl()%>"><img src="<%=Config.fullcontexturl() %>/images/bhshield.png" width="40" height="40"/></a></li>
<%
			if (u.isStaff()) {
	%>
	<li id="cslogo"><a href="<%=Config.fullcontexturl()%>"><img src="<%=Config.fullcontexturl() %>/images/cslogo.png"/></a></li>
	<%
			} else {
		%>
			<li id="cslogo"><a href="<%=Config.fullcontexturl()%>"><img src="<%=Config.fullcontexturl() %>/images/propertyinfologo.png"/></a></li>

		<%
			}
	%>	
	<li id="glsearch">
	<%
		if (u.isStaff()) {
	%>
			<form name="idx" id="globalsearch">
			<input class="glsearch" id="globalsearch_query" type="text" name="sq" style="width: calc(100% - 10px)"/>
			</form>
	<%
		} else {
	%>
			
	<%
		}
	%>
	</li>
	<%
		if (u.isStaff()) {
	%>
			<li id="csbkmark"><img id="view_bookmark" src="<%=Config.fullcontexturl() %>/images/icons/controls/white/bookmark.png" border="0" width="30" height="30" title="Manage Bookmark"/></li>
	<%
		}
		
	%>
	<%
		if (!CsConfig.isPublic()) {
	%>
			
			<li id="csreport"><a href="http://csdb01/reports/browse/" target="_blank"><img id="ssrs" src="<%=Config.fullcontexturl() %>/images/icons/controls/white/reports.png" border="0" width="30" height="30" title="Reports"/></a></li>
			<li id="csadmin"><a href="<%=Config.fullcontexturl() %>/admin?_token=<%=map.token() %>"><img src="<%=Config.fullcontexturl() %>/images/icons/controls/white/settings.png" border="0" width="30" height="30" title="Settings"/></a></li>
	<%
		}
		if (map.isLoggedIn()) {
	%>
			<li id="cslogin"><div id="userinitial"><%= initial %></div></li>
	<%
		}
		else {
	%>
			
	<%
		}
	%>
</ul>
<div id="csui">
	<div id="menu"></div>
	<div id="main"></div>
	<div id="sub"></div>
	<div id="linkcontainer"><div id="link"></div></div>
	
	
</div>
</body>

</html>




















