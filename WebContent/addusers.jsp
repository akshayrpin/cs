<%@page import="cs.ui.CsUiTools"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="csshared.vo.SubObjVO"%>
<%@page import="cs.common.ApiHandler"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="alain.core.utils.Cartographer"%>
<% 
	Cartographer map = new Cartographer(request,response,true);
	String fieldid = map.getString("fieldid");
	String entity = map.getString(RequestMapper.entity);
	int entityid = map.getInt(RequestMapper.entityid);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	SubObjVO[] res = new SubObjVO[0];
	if (map.hasValue("q")) {
		RequestVO req = new RequestVO();
		req.setEntity(entity);
		req.setEntityid(entityid);
		req.setType(type);
		req.setTypeid(typeid);
		req.setGrouptype("users");
		req.setRequest("search");
		req.setSearch(map.getString("q"));
		req.setOption(map.getString("t"));

		res = ApiHandler.searchPeople(req);
	}
	int l = res.length;
%>

<!DOCTYPE html>
<html>
<head>
<title>City Smart- V1</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

	<%= CsUiTools.getHTMLImports() %>
	<link rel="stylesheet" href="<%=Config.fullcontexturl() %>/tools/bootstrap-3.3.6-dist/css/bootstrap.min.css">
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>


	<script>
		function addToParent(value, text, description) {
			parent.addPeople('people','<%=fieldid%>', value, text, description);
//			parent.$.fancybox.close();
		}
	</script>
	<style>
		div.people_result { padding: 15px; border-bottom: 1px solid #cccccc }
		span.people_result { font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 12px; display: block }
	</style>


</head>

<body>

	<form method="post" action="addusers.jsp">
		<table cellpadding="5" cellspacing="0" border="0" width="100%">
			<tr>
				<td>
						<input type="text" name="q" class="cs_search"/>
				</td>
			</tr>
		</table>
		<input type="hidden" name="<%= RequestMapper.entity %>" value="<%= entity %>"/>
		<input type="hidden" name="<%= RequestMapper.entityid %>" value="<%= entityid %>"/>
		<input type="hidden" name="<%= RequestMapper.type %>" value="<%= type %>"/>
		<input type="hidden" name="<%= RequestMapper.typeid %>" value="<%= typeid %>"/>
		<input type="hidden" name="fieldid" value="<%= fieldid %>"/>
	</form>


	<table cellpadding="5" cellspacing="0" border="0" align="center">
	<%
		for (int i=0; i<l; i++) {
			SubObjVO vo = res[i];
			out.print("<tr>");
			out.print("<td>");

			out.print("<a class=\"lightbox-iframe\" href=\"#\" onclick=\"addToParent('"+Operator.javascriptFriendly(vo.getValue())+"','"+Operator.javascriptFriendly(vo.getText())+"','"+Operator.javascriptFriendly(vo.getDescription())+"')\"><img src=\"" + CsConfig.getImage("black", "add") + "\"/></a>");

			out.print("</td>");
			out.print("<td>");
			out.print(vo.getHtml());
			out.print("</td>");
			out.print("</tr>");
		}
	%>
	</table>


</body>

</html>




















