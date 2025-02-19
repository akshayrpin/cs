<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.vo.ObjVO"%>
<%@page import="csshared.vo.ObjMap"%>
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
	nav.setEntity("lso");
	nav.setToken(map.token());
	nav.setType(type);
	nav.setTypeid(typeid);
	nav.setId(id);
	nav.setGroup("archive");
	nav.setGrouptype("archive");
	nav.setGroupid("archive");
	nav.setRequest("details");
	

	
	
	//Pagination
		int maxrows = map.getInt("MAX", 50);
		int pg = map.getInt("PAGE",1);
		String sortfield= map.getString("SORT_FIELD","field12");
		String order= map.getString("ORDER","ASC");
		String ord= order;
		if(order.equalsIgnoreCase("DESC")){
			ord = "ASC";
		}else {
			ord="DESC";
		}
		int start = (1)*maxrows;
		
		int end = (pg-1)*maxrows;
		if(end==0){end= 0; }
		nav.setStart(start);
		nav.setEnd(end);
		TypeVO o = CsApi.getType(nav);
		if (!o.isRead()) {
			o = new TypeVO();
			map.forward("403.jsp");
		}

		String title = o.getTitle();
		String subtitle = o.getSubtitle();
		String alert = o.getAlert();
		String entitydesc = "";
		ObjGroupVO g = new ObjGroupVO();
		if(o.getGroups().length>0){
			g = o.getGroups()[0];
		}
		int records = g.getCustomsize();
		
		if(end-maxrows ==0){
			end = 50;
		}
		String show = "TOTAL RECORDS: "+ g.getCustomsize();
		System.out.println(start);
		System.out.println(end);
	
		StringBuffer url = new StringBuffer();
		StringBuffer urlsort = new StringBuffer();
		url.append("archives.jsp?_ent=lso&_id=").append(id).append("&_type=").append(type).append("&_typeid=").append(typeid).append("&MAX=").append(maxrows).append("&SORT_FIELD=").append(sortfield).append("&ORDER=").append(order);
	
		RequestVO req = RequestMapper.getRequest(map);
	 int totalpages = Operator.getTotalPages(records,maxrows);
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
		 .pageindex, .pageindex a, .pageindex a:link, .pageindex a:active, .pageindex a:visited, a.pageindex:link, a.pageindex:active, a.pageindex:visited {
		 font-family: Arial, Helvetica, Sans-Serif;
		 font-size: 12px;
		 color: #ffffff;
		 text-decoration: none;
		 padding: 5px;
		 background-color: transparent;

	}
	 .pageindex-current, .pageindex-current a, .pageindex-current a:link, .pageindex-current a:active, .pageindex-current a:visited, a.pageindex-current:link, a.pageindex-current:active, a.pageindex-current:visited {
		 font-family: Arial, Helvetica, Sans-Serif;
		 font-size: 15px;
		 font-weight: bold;
		 color: #000000;
		 text-decoration: none;
		 padding: 5px;
		 background-color: #ffffff;
		 border: 1px solid #000000;
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
			
			

		
		});

		function openFancybox(url) {
			$('<a href="'+url+'"/>').fancybox().click();
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
					 <td class="csui_tools">
						<a href="<%=Config.fullcontexturl() %>/summary.jsp?_ent=<%=nav.getEntity() %>&_type=<%=nav.getType() %>&_typeid=<%=nav.getTypeid() %>&_id=<%=nav.getId() %>"><img src="/cs/images/icons/controls/white/back.png" height="25" width="25" border="0"/></a>
					 </td>
					 
					<td align="left" class="csuicontrol"><%=g.getLabel() %></td>
					<td align="right">&nbsp;</td>
				</tr>
			</table>
		</div>
		
	</div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
				<table cellpadding="10" cellspacing="0" border="0" width="100%" class="animated bounceInDown">
					<tr>
						<td align="left" id="title"><%= title %></td>
						<td align="right" id="subtitle"><div id="entitydescription"><%= entitydesc %></div><%= subtitle %></td>
					</tr>
				</table>
					
					<table class="csui_title">
						<tr>
							<td class="csui_title"><%=g.getLabel() %> (<%=show %>)</td>
							<td class="csui_controls">&nbsp;</td>
						</tr>
					</table>

					<form id="csform" action="archives.jsp" method="post">
					<input type="hidden" name="_ent" value="<%=nav.getEntity() %>" >
					<input type="hidden" name="_type" value=<%=nav.getType() %> >
					<input type="hidden" id="_typeid" name="_typeid" value="<%=nav.getTypeid() %>" >
					
					<table class="csui" type="horizontal" >
					
					<%
					
					ObjMap[] omap = g.getValues();
					String[] fields = g.getFields();
					int fl = fields.length;
					int l = omap.length;
					String group = g.getGroup();
					String grouptype = g.getType();
					String groupid = g.getGroupid();
					boolean empty = true;
					 
					
						
					%>  
					<tr>
					<td class="csui_header">&nbsp;</td>
						<%	
							//columns
							for (int x=0; x < fl; x++) {
						%>  
							<td class="csui_header"><%=fields[x] %></td>
						<%
							} //columns end
						
						%>  
		
					</tr>
						
						
						
					<%
					
					
					for (int i=0; i < l; i++) {
						ObjMap m = omap[i];
						int j = i+1;
						if(pg>1){
							j = end+i+1;
						}
					%>  
						<tr>
						<td class="csui"><%=j %></td>
							<%	//rows
							for (int x=0; x < fl; x++) {
								ObjVO vo = m.getValues().get(fields[x]);
							%>  
								<td class="csui"><a href="<%=vo.getLink() %>" class="csui" target ="<%=vo.getTarget() %>" ><%=vo.getValue() %></a></td>
							<%} // end rows %>
						</tr>
						
					<% }%>
					</table>	
					
						<table cellpadding="20" cellspacing="0" border="0" width="100%" >
							<tr>
								<td align="center" style="background-color: #4d4d4d"><%=Operator.pageIndex(url.toString(),totalpages,pg) %></td>
							</tr>
						</table>
					</form>

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
