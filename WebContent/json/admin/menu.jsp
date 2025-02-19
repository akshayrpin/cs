<%@page import="alain.core.utils.Cartographer"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="cs.agent.UiAgent"%>
<% 


%>

{

	"panels": {
		"menu": {
			"url": "<%=Config.fullcontexturl() %>/json/admin/menu.jsp"
		},
		"main": {
		},
		"sub": {
		},
		"link": {
		}
	},
	"root": [
	<%= UiAgent.admin() %>
	]


}