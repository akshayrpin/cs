<%@page import="cs.ui.CsUiTools"%>
<%@page import="java.util.ArrayList"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="cs.utils.ObjTables"%>
<%@page import="csshared.vo.DataVO"%>
<%@page import="cs.utils.Cart"%>
<%@page import="csshared.vo.MessageVO"%>
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
<%@page import="java.util.HashMap"%>
<%


	Cartographer map = new Cartographer(request,response,true);
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);

	String hold = map.getString("alert");
	
	ResponseVO ro2 = new ResponseVO();
	
	
	
	System.out.println(map.getString("action"));
	if (map.equalsIgnoreCase("action", "ADD")) {
		//RequestVO vo = RequestMapper.getSaveParkingPermit(map);
		System.out.println("Entered editing of record #################"+map.getString("_reference"));
		RequestVO vo = RequestMapper.getRequest(map);
		HashMap<String, String> extras = new HashMap<String, String>();
		extras.put("ACCOUNT_NUMBER", map.getString("ACCOUNT_NUMBER"));
		extras.put("DAYTIME_QTY", map.getString("DAYTIME_QTY"));
		extras.put("OVERNIGHT_QTY", map.getString("OVERNIGHT_QTY"));
		
		extras.put("BATCH_NUMBER", map.getString("BATCH_NUMBER"));
		extras.put("PAYMENT_AMOUNT", map.getString("PAYMENT_AMOUNT"));
		extras.put("TRANSACTION_NUMBER", map.getString("TRANSACTION_NUMBER"));
		extras.put("CHECK_ACCOUNT", map.getString("CHECK_ACCOUNT"));
		extras.put("CHECK_NO", map.getString("CHECK_NO"));
		extras.put("PROCESS_ID", map.getString("PROCESS_ID"));
		vo.setExtras(extras);
		ro2 = ApiHandler.getResponseVO(vo);
		
		System.out.println(ro2.getMessagecode());
	}

	RequestVO nav = new RequestVO();
	nav.setEntity("lso");
	nav.setToken(map.token());
	nav.setIp(map.getRemoteIp());
	nav.setType("lockbox");
	nav.setRequest("add");
	nav.setId(map.getString("_id"));
	//nav.setStartdate(startdate);
	
	//String streetlist = ApiHandler.post(CsConfig.getString("dropdownlist.streetlist"), "{}");
	//System.out.println("#######"+streetlist);
	//String streetfractionlist = ApiHandler.post(CsConfig.getString("dropdownlist.streetfractionlist"), "");
	ResponseVO ro = new ResponseVO();
	TypeVO o = ro.getType();
	HashMap<String, String> info = ro.getInfo();

	

	
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	ObjGroupVO[] g = o.getGroups();
	ToolsVO tools = o.getTools();


// 	TypeVO co = ApiHandler.getType(nav);
// 	DataVO dvo = DataVO.toDataVO(co);
	
// 	SubObjVO[] status = new SubObjVO[0];
// 	//if (Operator.equalsIgnoreCase(type, "activity") && typeid > 0) {
// 	RequestVO stvo = nav.duplicate();
// 	stvo.setType("activity");
// 	stvo.setId("-1");
// 	stvo.setRequest("status");
// 	status = ApiHandler.getChoices(stvo);
	//}

	
	
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
	

	<style>
		.csui_controls { visibility: hidden }
	</style>
	<script>
	var entity = 'lso';
	var type = '<%= type %>';
	var typeid = '<%= 0 %>';
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
	<style>
		
	</style>

	<script>
		$(document).ready(function() {
		
			 
			<% if(ro2.getMessagecode().equals("cs200") && map.getString("action").startsWith("ADD")){%>
			
			
			
			//window.parent.$("#csform").submit();
		//	window.parent.$("#_tabs").val("tabs-2");
			//
			//window.parent.$('#tabs ul').tabs('select', index);
			//parent.$.fancybox.close();
			
			window.parent.location.reload();
			
		<% }%>
		
		});
		

	</script>

</head>
<body alert="<%= alert %>">
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
	<div id="csuicontrols">
		<div id="csuicontrol" class="csuicontrol <%= alert %>">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="left" class="csuicontrol">LOCKBOX SINGLE ADD </td>
					<td align="right"><%= ObjUi.tools(o.getTools(), "csui") %></td>
				</tr>
			</table>
		</div>
		
	</div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
			<br/><br/>
				
				<%if(ro.getErrors().size()>0){ 
					MessageVO m = ro.getErrors().get(0);
				%><div id="csform_message" class="csform_error">
					<ul>
					<li class="error"><%=m.getMessage() %></li>
					</ul>
					</div>
				<%}%>
				
				<form id="csform" class="form"  action="lockboxadd.jsp" method="post" ajax="no"  refresh="true" enctype="multipart/form-data">
				<input type="hidden" name="_ent" value="lso">
				<input type="hidden" name="_type" value="lockbox">
				<input type="hidden" name="_grpid" value="lockbox">
				<input type="hidden" name="_grp" value="lockbox">
				<input type="hidden" name="_grptype" value="lockbox">
				<input type="hidden" name="_id" value="0">
				<input type="hidden" name="_act" value="add">
				<input type="hidden" name="_request" value="add">
				<table class="csui" colnum="2" type="default">
						
					
					<tr>
						
						<td class="csui_label" colnum="2" alert="">BATCH ID</td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" alert="">
						
								<input name="BATCH_NUMBER" id="BATCH_NUMBER" type="text" itype="String" value="" valrequired="true" >
						
						</td>
						<td class="csui_label" colnum="2" alert="">TRANSACTION NUMBER</td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" alert="">
								<input name="TRANSACTION_NUMBER" id="TRANSACTION_NUMBER" type="text" itype="String" value="" valrequired="true">
						</td>
					</tr>
					
					<tr>
						<td class="csui_label" colnum="2" alert="">ACCOUNT NUMBER</td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" alert="">
						
								<input name="ACCOUNT_NUMBER" id="ACCOUNT_NUMBER" type="text" itype="String" value="" valrequired="true" >
						
						</td>
						<td class="csui_label" colnum="2" alert="">PAYMENT AMOUNT</td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" alert="" >
						
						<input name="PAYMENT_AMOUNT" id="PAYMENT_AMOUNT" type="text" itype="String" value="" valrequired="true" >
						</td>
					</tr>
					
					<tr>
						<td class="csui_label" colnum="2" alert="">CHECK ACCOUNT</td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" alert="">
						
								<input name="CHECK_ACCOUNT" id="CHECK_ACCOUNT" type="text" itype="String" value="" valrequired="true" >
						
						</td>
						<td class="csui_label" colnum="2" alert="">CHECK NO</td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" alert="">
							<input name="CHECK_NO" id="CHECK_NO" type="text" itype="String" value="" valrequired="true" >
						</td>
					</tr>
					<tr>
						<td class="csui_label" colnum="2" alert="">DAYTIME QTY</td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" alert="">
						<input name="DAYTIME_QTY" id="DAYTIME_QTY" type="text" itype="String" value="0" ></td>
						<td class="csui_label" colnum="2" alert="">OVERNIGHT QTY</td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" alert="">
						<input name="OVERNIGHT_QTY" id="OVERNIGHT_QTY" type="text" itype="String" value="0" ></td>
					</tr>
					
					
					
					<tr>
						<td class="csui" colnum="2" type="DATE" itype="DATE" alert="" colspan="4" align="right">
							<input name="action" type="submit"  value="ADD" class="csui_button" >
						</td>
					</tr>
					
					
				</table>
				
				<div class="csui_divider"></div>
				</form>
				
				<div class="csui_divider"></div>
				<div class="csui_divider"></div>
				
				
				
			
			</div>
		</div>
		
	</div>




</body>
</html>

