<%@page import="cs.ui.CsUiTools"%>
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
	ResponseVO ro = ApiHandler.getResponseVO(req);
	TypeVO o = ro.getType();
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	ObjGroupVO[] g = o.getGroups();
	ToolsVO tools = o.getTools();
	int length = o.getGroups().length;
	StringBuffer accountid = new StringBuffer();
	ObjGroupVO[] og = o.getGroups();
	/* for(int i=0;i<og.length;i++){
		accountid.append(og[i].getExtras().get("ID")).append(",");
	} */
	
	req.setRequest("getbatch");
	req.setAction("getbatch");
	req.setGrouptype("print");
	req.setGroup("batch");
	SubObjVO[] choice = ApiHandler.getChoices(req);
	int bat_id = 0;
	for(SubObjVO value : choice){
		if(value.getText().length() < 4){
			bat_id = value.getId();
		}
	}
	
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
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/simplepagination/simplePagination.css">
	

<style>
.csui_controls {
	visibility: hidden
}
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
	
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/simplepagination/jquery.simplePagination.js"></script>
 	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	<link href="<%=Config.fullcontexturl() %>/tools/zozotabs_6.5/css/zozo.tabs.min.css" rel="stylesheet">
	
	<style>
		
	</style>

	<script>
		$(document).ready(function() {
			
			if(<%=bat_id%> > 0){
				var response = JSON.parse('{"id":"<%=bat_id%>"}');
				showProgress(response);
			}
		});
		
		function print(){
			/* var checkedValues = $('input:checkbox:checked').map(function() { return this.value; }).get();
			if(checkedValues == ""){
				swal("Select atleast one project");
				return false;
			}
			
			var str = checkedValues.indexOf('on');
			var ids = '';
			if(str == 0) {
				ids = (checkedValues+"").substr(3);
			}else {
				ids = checkedValues;
			} */
			var ids = $('#batch_id').val();

			$.fancybox({
				'width'				: '75%',
				'height'			: '75%',
				'autoScale'			: false,
				'transitionIn'		: 'none',
				'transitionOut'		: 'none',
				'type'				: 'iframe',
				'href' : '<%=Config.fullcontexturl() %>/printbatch.jsp?_ent=lso&_entid=-1&_type=templatetype&_id=-1&_typeid=4&_grp=batch&_grpid='+ids+'&_grptype=print&_act=print&chk=0&subrequest=batch'
			});
		}
			
			function showProgress(response){
				$('progress').show();
				$('progress').val(response.percentcomplete);
				pollForStatus(response);
			}

			function pollForStatus(response)
			{
				
				var method = 'pollstatus';
				$.ajax({
					type : 'POST',
					url : '../../cs/action.jsp?_action='+method,
					dataType : 'json',
					data:{
						_ent: 'lso',
						_entid: -1,
						_type: 'project',
						_typeid: -1,
						_grp: 'parking',
						_grpid: response.id,
						_id: -1,
						_grptype: 'print/batchstatus',
						_act: 'print'
					},
					success : function(response) {
						$('progress').val(response.percentcomplete);
						if(response.percentcomplete < 100){ 
							setTimeout(function() {
								pollForStatus(response);
							},  1000);
						}
						else {
							$('progress').hide();
							document.location.href = 'onlineparking.jsp?_ent=parking&_entid=-1&_type=parking&_typeid=0&_grp=batch&_grptype=parking&_act=onlineprints&_request=onlineprints&batch_id='+response.id+'&_grpid='+response.id+'';
						}
					},
					error : function(error) {
						console.log(error);
						//alert('Your request was not processed. Please check your input data.');
					}
				});
			}
	</script>

</head>
<body alert="<%= alert %>">
<div id="loader"></div>

	<div id="csuicontrols">
		<div id="csuicontrol" class="csuicontrol <%= alert %>">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					
					<td align="left"><%= ObjUi.tools(o.getTools(), "csui") %>
						<a href="parking.jsp?_ent=parking&_type=parking&_typeid=0&_id=0"><img src="/cs/images/icons/controls/white/back.png" height="25" width="25" border="0"/></a>
					</td>
					<td align="right"><%= ObjUi.tools(o.getTools(), "csui") %>
					
					<!-- <table class="csui_tools">
					  <tr>
					
					<td class="csui_tools">
						<a href="renewal.jsp?_ent=parking&_entid=-1&_type=parking&_typeid=0&_grptype=parking&_act=onlineprints&_request=onlineprints" title="Renewal" border="0"  target="_self"  ><img src="/cs/images/icons/controls/white/renew.png" border="0"></a>
					</td> 
					</table>-->
					
				</tr>
			</table>
		</div>
	</div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
			<br/><br/>
			<form id="csform" action="onlineparking.jsp" method="get">
			<input type="hidden" name="_ent" value="parking">
			<input type="hidden" name="_type" value="parking">
			<input type="hidden" name="_typeid" value="0">
			<input type="hidden" name="_grp" value="batch">
			<input type="hidden" name="_grptype" value="parking">
			<input type="hidden" name="_id" value="0">
			<input type="hidden" name="_act" id="_act" value="onlineprints">
			<input type="hidden" name="_request" id="_request" value="onlineprints">
			<input type="hidden" name="batch_id" id="batch_id" value="<%=map.getInt(RequestMapper.groupid)%>">
						
			<progress style="display: none; width: 100%" id="progress" max="100" value="0"></progress>
			<br/>
			<table class="csui_title" alert="warning">
				<tr>
					<td class="csui_title">
						<% if (map.getInt(RequestMapper.groupid) > 0) { %>
								LAST PRINTED BATCH - <%=map.getInt(RequestMapper.groupid)%>
						<% } else { %>
						LAST PRINTED BATCH
						<% } %>
					</td>
					<td class="csui_title"  type="String" itype="String" alert="">
						<input name="_grpid"  id="_grpid" type="text" itype="text" value=""  class="enter" placeholder="Batch#" maxchar="100" >
					</td>
				</tr>
			</table>
			<table class="csui" type="horizontal">
				<tr>
						<td class="csui_header" width="10%">BATCH NUMBER</td>
						<td class="csui_header">FILE NAME</td>
				</tr>
				<% for(int j=0;j<choice.length;j++){ %>
				<tr>
					<td class="csui" type="String" itype="text"><%=choice[j].getId()%></td>
					<td class="csui" type="String" itype="text"><a class="csui" target="_blank" href="../viewfile.jsp?_id=<%=choice[j].getId()%>&subrequest=batch"><%=choice[j].getText()%></a></td>
				</tr>
				<%} %>
			</table>
			</form>
			<br/><br/>
		
				  <table class="csui_title" alert="warning">
						<tr>
							<td class="csui_title">
							<% if (map.getInt(RequestMapper.groupid) > 0) { %>
								BATCH - <%=map.getInt(RequestMapper.groupid)%>
							<% } else { %>
								UNPRINTED PERMITS
							<% } %>
							</td>
							<td class="csui_title" align="right">
								<a href="javascript:void(0);" onclick="print();" target="_self">
									<img src="<%=Config.fullcontexturl()%>/images/icons/controls/white/print.png" width="20" height="20" border="0"/>
								</a>
							</td>
						</tr>
					</table>
				
				<table class="csui" type="horizontal">
					<tr>
						<!-- <td class="csui_header"><input type="checkbox" name="selectorall" id="selectorall" ></td> -->
						<td class="csui_header">ADDRESS</td>
						<td class="csui_header">ACCOUNT NO</td>
						
						<td class="csui_header">TYPE</td>
						<td class="csui_header">CREATED BY</td>
						<td class="csui_header">CREATED</td>
						<td class="csui_header">UPDATED BY</td>
						<td class="csui_header">UPDATED</td>
						
						<td class="csui_header" width="1%">&nbsp;</td>
					</tr>
				
				  <% 
							for(int i=0;i<og.length;i++){
							if(og[i].getGroup().equalsIgnoreCase("multiple") || og[i].getGroup().equalsIgnoreCase("accounts"))	{
						%>
						
						<tr>
							<%-- <td class="csui"><input type="checkbox" name="selector" id="selector" class="selector" value="<%=og[i].getExtras().get("ID") %>"> </td> --%>
							<td class="csui" type="String" itype="text"><a class="csui" href="../summary.jsp?_ent=lso&_id=<%=og[i].getExtras().get("LSO_ID") %>&_type=lso&_typeid=<%=og[i].getExtras().get("LSO_ID") %>"  target="lightbox-iframe"><%=og[i].getExtras().get("ADDRESS") %></a></td>
							<td class="csui" type="String" itype="text"><a class="csui"  target="lightbox-iframe" href="../summary.jsp?_ent=lso&_id=-1&_type=project&_typeid=<%=og[i].getExtras().get("PROJECT_ID") %>" ><%=og[i].getExtras().get("ACCOUNT_NO") %></a></td>
							<td class="csui" type="String" itype="text"><%=og[i].getExtras().get("TYPE") %></td>
							<td class="csui" type="String" itype="text"><%=og[i].getExtras().get("CREATED") %></td>
							<td class="csui" type="String" itype="text"><%=og[i].getExtras().get("CREATED_DATE") %></td>
							<td class="csui" type="String" itype="text"><%=og[i].getExtras().get("UPDATED") %></td>
							<td class="csui" type="String" itype="text"><%=og[i].getExtras().get("UPDATED_DATE") %></td>
							
							<td class="csui" >
								
							<a target="lightbox-iframe-refresh" href="../printall.jsp?_ent=lso&_entid=-1&_type=project&_id=<%=og[i].getExtras().get("ID") %>&_typeid=<%=og[i].getExtras().get("ID") %>&_grptype=print&_act=print"  >
								<img src="<%=Config.fullcontexturl()%>/images/icons/controls/gray/print.png" width="20" height="20" border="0"/></a>
							</td>
						</tr>
					<% } } %>
					   <!-- </form> -->
					</table>
					</br>
				<div class="selector pull-right"></div>
				</div>
		</div>
	</div>

</div>


</body>
</html>

