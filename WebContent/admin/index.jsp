<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="alain.core.utils.Cartographer"%>
<% 
	Cartographer map = new Cartographer(request,response,true);
	if (CsConfig.isPublic()) {
		map.forward("../403.jsp");
	}

%>

<!DOCTYPE html>
<html>
<head>
<title>City Smart- V1</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<%= CsUiTools.getHTMLImports() %>
	<link rel="stylesheet" href="<%=Config.fullcontexturl() %>/tools/alain/cs.css">

	<link rel="stylesheet" href="<%=Config.fullcontexturl() %>/tools/bootstrap-3.3.6-dist/css/bootstrap.min.css">
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/jscookie/js.cookie.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.treetools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tree.js"></script>

	<script language="JavaScript">
	
	$(document).ready(function() {
		var p = {
				"menu": {
					"item": {
						"url": "/cs/json/admin/menu.jsp"
					},
					"type": "menu"
				},
				"main": {
					"type": "tree"
				},
				"sub": {
					"type": "tree"
				},
				"link": {
					"type": "iframe",
					"hide": "false"
				}
			};
		init(p);
	});

	function funSearch(){	
		var val = document.all.sq.value;
		document.forms[0].action='../index.jsp?q='+val;
		document.forms[0].submit();
	}

	function displayKeyCode(evt){
		
	    var charCode = (evt.which) ? evt.which : event.keyCode;
	    if (charCode == 13){
	    	funSearch();		
	    } 
	}

	</script>
	<link href='https://fonts.googleapis.com/css?family=Oswald:300,700' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Armata' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700' rel='stylesheet' type='text/css'>

</head>

<body>

<ul id="csheader">
	<li id="shield"><a href="<%=Config.fullcontexturl()%>"><img src="<%=Config.fullcontexturl() %>/images/bhshield.png" width="40" height="40"/></a></li>
	<li id="cslogo"><a href="<%=Config.fullcontexturl()%>"><img src="<%=Config.fullcontexturl() %>/images/cslogo.png"/></a></li>
	<li id="glsearch">
	<form name="idx"  >
	<input class="glsearch" type="text" name="sq" onkeypress="displayKeyCode(event);" style="width: 100%"/>
	</form>
	</li>
	<li id="csadmin"><a href="<%=Config.fullcontexturl()%>"><img src="<%=Config.fullcontexturl() %>/images/admin-back.png"/></a></li>
</ul>
<div id="csui">
	<div id="menu"></div>
	<div id="main"></div>
	<div id="sub"></div>
	<div id="linkcontainer"><div id="link"></div></div>
</div>
</body>

</html>




















