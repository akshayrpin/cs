<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.vo.ResponseVO"%>
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

	boolean add = true;
	Cartographer map = new Cartographer(request,response);



%><html>
<head>
	<%= CsUiTools.getHTMLImports() %>

	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.qrcode.js"></script>



</head>
<body>
<div id="qrcoderesult" style="font-family: Oswald, Arial, Helvetica, sans-serif; font-size: 25px; font-weight: 700; text-align: center"></div>
</body>
</html>

