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
//ResponseVO ro = ApiHandler.getResponseVO(req);
ResponseVO ro = new ResponseVO();
TypeVO o = ro.getType();
String title = o.getTitle();
String subtitle = o.getSubtitle();
String alert = o.getAlert(); 

req.setRequest("getbatch");
req.setAction("getbatch");
req.setGrouptype("print");
req.setGroup("renewal");
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

	<script>
	$(document).ready(function() {
		
		if(<%=bat_id%> > 0){
			var response = JSON.parse('{"id":"<%=bat_id%>", "_grp":"renewal"}');
			showProgress(response);
		}
	});
		
		function print(){
			var checkedValues = $('input:radio:checked').map(function() { return this.value; }).get();
			if(checkedValues == ""){
				swal("Select atleast one project");
				return false;
			}
			
			$(' <a title="Config Route" id="addroute"  href="<%=Config.fullcontexturl() %>/printbatch.jsp?_ent=lso&_entid=-1&_type=templatetype&_id=-1&_typeid=5&_grp=renewal&_grpid='+checkedValues+'&_grptype=print&_act=print&chk=0&subrequest=batch&_ref='+checkedValues+'" >Friendly description</a>').fancybox({
       			'width'				: '75%',
				'height'			: '75%',
				'autoScale'			: false,
				'transitionIn'		: 'none',
				'transitionOut'		: 'none',
				'type'				: 'iframe'
			
          	}).click();
		}
		
		function showProgress(response){
			$('progress').show();
			$('progress').val(response.percentcomplete);
			pollForRenStatus(response);
		}

		function pollForRenStatus(response)
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
					_grp: 'renewal',
					_grpid: response.id,
					_id: -1,
					_grptype: 'print/batchstatus',
					_act: 'print'
				},
				success : function(response) {
					$('progress').val(response.percentcomplete);
					if(response.percentcomplete < 100){ 
						setTimeout(function() {
							pollForRenStatus(response);
						},  1000);
					}
					else {
						$('progress').hide();
						document.location.href = 'renewal.jsp?_ent=parking&_entid=-1&_type=parking&_typeid=0&_grptype=parking&_act=getbatch&_request=getbatch';
					}
				},
				error : function(error) {
					console.log(error);
					alert('Your request was not processed. Please check your input data.');
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
				</tr>
			</table>
		</div>
	</div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
			<br/><br/>
			<form id="csform" action="onlineparking.jsp" method="post">
			<input type="hidden" name="_ent" value="parking">
			<input type="hidden" name="_type" value="parking">
			<input type="hidden" name="_typeid" value="0">
			<input type="hidden" name="_grp" value="batch">
			<input type="hidden" name="_grptype" value="parking">
			<input type="hidden" name="_id" value="0">
			<input type="hidden" name="_act" id="_act" value="onlineprints">
			<input type="hidden" name="_request" id="_request" value="onlineprints">

			<progress style="display: none; width: 100%" id="progress" max="100" value="0"></progress>
			<br/>
			<table class="csui_title" alert="warning">
				<tr>
					<td class="csui_title">BATCH</td>
					
				</tr>
			</table>
			<table class="csui" type="horizontal">
				<tr>
						<td class="csui_header" width="10%">BATCH NUMBER</td>
						<td class="csui_header">FILE NAME</td>
				</tr>
				<% for(int j=0;j<choice.length;j++){ %>
				<tr>
					<td class="csui" type="String" itype="text"><%=choice[j].getId() %></td>
					<td class="csui" type="String" itype="text"><a class="csui" target="_blank" href="../viewfile.jsp?_id=<%=choice[j].getId()%>&subrequest=batch"><%=choice[j].getText()%></a></td>
				</tr>
				<%} %>
			</table>
			<br/>
				  <table class="csui_title" alert="warning">
						<tr>
							<td class="csui_title">RENEWAL</td>
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
						<td class="csui_header"><input name="RENEWAL" type="radio"  valrequired="false" value="251">Over Night</td>
						<td class="csui_header"><input name="RENEWAL" type="radio"  valrequired="false" value="252">Preferential</td>
						<td class="csui_header"><input name="RENEWAL" type="radio"  valrequired="false" value="0">Both</td>
					</tr>
				
					</table>
					</br>
					   </form>
				<div class="selector pull-right"></div>
				</div>
		</div>
	</div>

</div>


</body>
</html>

