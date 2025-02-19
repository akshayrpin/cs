<%@page import="cs.ui.CsUiTools"%>
<%@page import="alain.core.utils.FileUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="cs.utils.Cart"%>
<%@page import="csshared.utils.ObjMapper"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="csshared.vo.ResponseVO"%>
<%@page import="org.json.JSONObject"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="csshared.vo.SubObjVO"%>
<%@page import="alain.core.utils.Timekeeper"%>
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
	RequestVO req = RequestMapper.getRequest(map);
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	
	
	//req.setAction("parkingapproval");
	
	ResponseVO ro = ApiHandler.getResponseVO(req);
	TypeVO o = ro.getType();
	
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	ObjGroupVO[] g = o.getGroups();
	ToolsVO tools = o.getTools();
	


%>
<html>
<head>

	<title>City Smart</title>
	<%= CsUiTools.getHTMLImports() %>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
	<link href="<%=Config.fullcontexturl() %>/tools/zozotabs_6.5/css/zozo.tabs.min.css" rel="stylesheet">
	

	<style>
		.csui_controls { visibility: hidden }
	</style>
	<script>
	var entity = '<%= entity %>';
	var type = '<%= type %>';
	var typeid = '<%= typeid %>';
	var fullcontexturl = '<%=Config.fullcontexturl()%>';
		
	</script>

	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/toggleswitch/tinytools.toggleswitch.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/jquery.tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/inputmask.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/jquery.inputmask.js"></script>
	
	
 	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	<link href="<%=Config.fullcontexturl() %>/tools/zozotabs_6.5/css/zozo.tabs.min.css" rel="stylesheet">
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/zozotabs_6.5/js/zozo.tabs.min.js"></script>
	
<script>
function attachmentSelector(id){
	$('#tr_attach_'+id).slideToggle('slow');
}
</script>
</head>
<body alert="<%= alert %>">
<div id="fullpage">
<div id="loader"></div>

	<div id="csuicontrols">
		<div id="csuicontrol" class="csuicontrol <%= alert %>">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="left"><%= ObjUi.tools(o.getTools(), "csui") %>
						<table class="csui_tools">
							<tr>
								<td class="csui_tools">
									<a href="parking.jsp?_ent=parking&_type=parking&_typeid=0&_id=0"><img src="/cs/images/icons/controls/white/back.png" height="25" width="25" border="0"/></a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
			<br/><br/>
		
				  <table class="csui_title" alert="warning">
						<tr>
							<td class="csui_title">Approvals</td>
						</tr>
					</table>
				
				<table class="csui" type="horizontal">
					<tr>
						<td class="csui_header">NAME</td>
						<td class="csui_header">ADDRESS</td>
						<td class="csui_header">ACCOUNT NUMBER</td>
						<td class="csui_header">ASSOCIATION</td>
						<td class="csui_header">SPACE AVAILABLE</td>
						<td class="csui_header">CARS</td>
						<td class="csui_header">EMAIL</td>
						<td class="csui_header">EXISTING ACCOUNT</td>
						<td class="csui_header" width="1%">&nbsp;</td>
						<td class="csui_header" width="1%">&nbsp;</td>
						<td class="csui_header" width="1%">&nbsp;</td>
						<td class="csui_header" width="1%">&nbsp;</td>
					</tr>
				
				
					<% 
					ObjGroupVO[] og = o.getGroups();
						for(int i=0;i<og.length;i++){
							if(og[i].getGroup().equalsIgnoreCase("multiple") || og[i].getGroup().equalsIgnoreCase("accounts"))	{
					%>
					<form id="csform" action="parking.jsp" method="post">
					<input type="hidden" name="_ent" value="parking">
					<input type="hidden" name="_type" value="parking">
					<input type="hidden" name="_typeid" value="<%=og[i].getExtras().get("ID") %>">
					<input type="hidden" name="_grpid" value="parking">
					<input type="hidden" name="_grp" value="parking">
					<input type="hidden" name="_grptype" value="parking">
					<input type="hidden" name="_id" value="0">
					<input type="hidden" name="_tab" value="info">
					<input type="hidden" name="_action" value="parkingsearch">
					<input type="hidden" name="accountno" value="<%=og[i].getExtras().get("ACCOUNT_NO") %>">

					<tr id="tr_<%=og[i].getExtras().get("ID") %>">
						<td class="csui" type="String" itype="text"><%=og[i].getExtras().get("FIRST_NAME") %> <%=og[i].getExtras().get("LAST_NAME") %></td>
						<td class="csui" type="String" itype="text">
						
						<a class="csui" href="../index.jsp?entity=lso&type=lso&typeid=<%=og[i].getExtras().get("LSO_ID") %>"  target="_blank">
						<%=og[i].getExtras().get("NEWADDRESS") %>
						
						</a>
						<%if(Operator.hasValue(og[i].getExtras().get("UNIT_ENTERED"))){ %>
							<br><b>UNIT ENTERED : <%=og[i].getExtras().get("UNIT_ENTERED") %></b>
						<%} %>
						</td>
						<td class="csui" type="String" itype="text">
						<%if(Operator.hasValue(og[i].getExtras().get("PROJECT_ID"))){ %>
							<a class="csui" href="../index.jsp?_ent=lso&_id=<%=og[i].getExtras().get("LSO_ID") %>&_type=project&_typeid=<%=og[i].getExtras().get("PROJECT_ID") %>"  target="_blank">
						
							<%=og[i].getExtras().get("ACCOUNT_NO") %>
							</a>
						<%} else { %>
						
						<%=og[i].getExtras().get("ACCOUNT_NO") %>
						<%}  %>
						</td>
						<td class="csui" type="String" itype="text"><%=og[i].getExtras().get("ASSOCIATION") %></td>
						<td class="csui" type="String" itype="text"><%=og[i].getExtras().get("SPACE_AVAIL") %></td>
						<td class="csui" type="String" itype="text"><%=og[i].getExtras().get("NO_CARS") %></td>
						<td class="csui" type="String" itype="text"><%=og[i].getExtras().get("USERNAME") %></td>
						<td class="csui" type="String" itype="text"><%=og[i].getExtras().get("EXISTING_ACT") %></td>
						<td class="csui" width="1%">
							<a target="lightbox-iframe" href="approve.jsp?_ent=lso&_id=-1&_type=<%=type%>&_typeid=<%=typeid%>&ID=<%=og[i].getExtras().get("ID") %>&space=<%=og[i].getExtras().get("SPACE_AVAIL") %>&cars=<%=og[i].getExtras().get("NO_CARS") %>&ADDR=<%= Operator.urlFriendly(og[i].getExtras().get("NEWADDRESS")) %>" title="Create New Project" ><img src="/cs/images/icons/controls/black/checkbriefcase.png" border="0"></a>
						</td>
						<td class="csui" width="1%">
							<a target="lightbox-iframe" href="merge.jsp?_ent=lso&_id=-1&_type=<%=type%>&_typeid=<%=typeid%>&ID=<%=og[i].getExtras().get("ID") %>&ACCT=<%=og[i].getExtras().get("ACCOUNT_NO") %>&ADDR=<%= Operator.urlFriendly(og[i].getExtras().get("NEWADDRESS")) %>" title="Merge with Active Project" ><img src="/cs/images/icons/controls/black/merge.png" border="0"></a>
						</td>
						<td class="csui" width="1%">
							<a target="lightbox-iframe" href="unapprove.jsp?_ent=lso&_id=-1&_type=<%=type%>&_typeid=<%=typeid%>&ID=<%=og[i].getExtras().get("ID") %>" title="Reject" ><img src="/cs/images/icons/controls/gray/delete.png" border="0"></a>
						</td>

<%

	boolean empty = true;
	for (HashMap<String, String> entry : og[i].getExtraslist()) {
		String fullname = entry.get("ATTACHMENT");
		String[] filearr = Operator.split(fullname);
		String filename = "";
		if (filearr.length > 0) {
			filename = filearr[filearr.length-1];
		}
		empty = !Operator.hasValue(filename);
	}

	if (!empty) {
%>
						<td class="csui" width="1%">
							<img src="/cs/images/icons/controls/gray/attachment.png" style="cursor: pointer" onclick="attachmentSelector('<%=og[i].getExtras().get("ID") %>')" border="0" title="Attachment" />
						</td>
<% } else { %>
						<td class="csui" width="1%">&nbsp;</td>
<% } %>
					</tr>
					<tr style="display:none;" id="tr_attach_<%=og[i].getExtras().get("ID") %>">
						<td colspan="13" style="background-color: #ffffff; padding: 10px; padding-bottom: 50px">
							<table class="csui" type="horizontal" width="100%">
								<tr>
									<td class="csui" colspan="2" type="String" style="background-color: #eeeeee" itype="text">Attachments</td>
								</tr>
								<% 
									for (HashMap<String, String> entry : og[i].getExtraslist()) {
										String[] file = entry.get("ATTACHMENT").split("/");
								%>
								<tr>
									<td class="csui" type="type" style="background-color: #eeeeee" itype="type"><%=entry.get("TYPE")%></td>
									<td class="csui" type="String" itype="text"><a class="csui" target="_blank" href="../viewfile.jsp?_id=<%=entry.get("ID")%>&subrequest=online"><%=file[file.length-1]%></a></td>
								</tr>
								
								<%}%>
							</table>
						</td>
					</tr>

				   </form>
					
					<% } } %>
					</table>
				
				</div>
		</div>
	</div>
</div>
<br/><br/>
</body>
</html>

