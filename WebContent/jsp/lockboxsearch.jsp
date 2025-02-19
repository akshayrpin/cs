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

	RequestVO nav = new RequestVO();
	nav.setEntity("lso");
	nav.setToken(map.token());
	nav.setIp(map.getRemoteIp());
	nav.setType("lockbox");
	nav.setRequest("search");
	//nav.setStartdate(startdate);
	
	//String streetlist = ApiHandler.post(CsConfig.getString("dropdownlist.streetlist"), "{}");
	//System.out.println("#######"+streetlist);
	//String streetfractionlist = ApiHandler.post(CsConfig.getString("dropdownlist.streetfractionlist"), "");
	ResponseVO ro = ApiHandler.getResponseVO(nav);
	TypeVO o = ro.getType();
	
	Timekeeper k = new Timekeeper();
	System.out.println(k.getString("FULLDATE"));
	if (map.equalsIgnoreCase("action", "Search")) {
		//RequestVO vo = RequestMapper.getSaveParkingPermit(map);
		System.out.println("Entered upload #################"+map.getString("_reference"));
		RequestVO vo = RequestMapper.getRequest(map);
		
		ro = ApiHandler.getResponseVO(vo);
		
		System.out.println(ro.getMessagecode());
	}
	
	

	

	
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
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/tablesorter/css/theme.dropbox.css">
	

	
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
	
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tablesorter/jquery.tablesorter.min.js"></script>
	
 	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
    
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	<style>
		
	</style>

	<script>
		$(document).ready(function() {
		
			 $(".tablesorter").tablesorter(); 
			
		
		});
		function resetlocbox(){
			document.location.href = "lockbox.jsp?_ent=lso&_entid=-1&_type=lockbox&_typeid=0&_grptype=lockbox";
			
		}
		
		
		function deletetype(id){
			var method = "deletelockbox";
			swal({  
					title: "Are you sure?",   
					text: "You want to delete this record!",   
					type: "warning",   
					showCancelButton: true,   
					confirmButtonColor: "#DD6B55",   
					confirmButtonText: "Yes, delete it!",   
					cancelButtonText: "No, cancel plx!",   
					closeOnConfirm: false,   
					closeOnCancel: false 
				}, 
				function(isConfirm){   
					if (isConfirm) {     
						$.ajax({
				   			  type: "POST",
				   			  url: "../action.jsp?_act="+method,
				   			  dataType: 'json',		  
				   			  data: { 
				   				// feesjson : type,
				   			
				   			      _grptype : "lockbox",
				   			   	  _ent : "lso",
				   			   	  _type : "lockbox",
				   				  _typeid : 0,
				   				  _id : id
				   				
				   			      //mode : mode
				   			    },
				   			    success: function(output) {
				   			    		$('#tr_'+id).remove();
				   			    		swal("Deleted!", "The record has been deleted.", "success");   
				   			    		
				   			    },
				   		    error: function(data) {
				   		    	swal("Problem while perfoming delete looks like the server is busy");  
				   		    }
			   			});		
					
					} 
					else {    
						swal("Cancelled", "The record is safe :)", "error");  
					} 
				});
		}


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
					<td align="left" class="csuicontrol" >
						<a href="lockbox.jsp?_ent=lso&_type=lockbox&_typeid=0&_id=0"><img src="/cs/images/icons/controls/white/back.png" height="25" width="25" border="0"/></a>
					&nbsp; LOCKBOX SEARCH </td>
					
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
				<table class="csui_title" alert="warning">
						<tr>
							<td class="csui_title">
								LOCKBOX SEARCH 
							</td>
							
						</tr>
				</table>
				
				<form id="csform" class="form"  action="lockboxsearch.jsp" method="post" ajax="no"  refresh="true" enctype="multipart/form-data">
				<input type="hidden" name="_ent" value="lso">
				<input type="hidden" name="_type" value="lockbox">
				<input type="hidden" name="_grpid" value="lockbox">
				<input type="hidden" name="_grp" value="lockbox">
				<input type="hidden" name="_grptype" value="lockbox">
				<input type="hidden" name="_id" value="0">
				<input type="hidden" name="_act" value="search">
				<input type="hidden" name="_request" value="search">
				<table class="csui" colnum="2" type="default">
						
					<tr>
						<td class="csui_label" colnum="2" alert="">BATCH ID <font color="red">*</font></td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" alert="" >
						<input name="_ref" id="_ref" type="text" itype="String" valrequired="true" value="<%=map.getString("_ref") %>" ></td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" alert="">
							<input name="action" type="submit"  value="SEARCH" class="csui_button" >
						</td>
					</tr>
					
					
				</table>
				
				<div class="csui_divider"></div>
				</form>
				
				<div class="csui_divider"></div>
				<div class="csui_divider"></div>
				
				
				
				<table class="csui_title" alert="warning">
						<tr>
							<td class="csui_title">
								BATCH ID RESULTS 
							</td>
							
						</tr>
				</table>
				
				<table class="csui tablesorter"  type="horizontal">
				 <thead>
					<tr>
						<!-- <td class="csui_header"><input type="checkbox" name="selectorall" id="selectorall" ></td> -->
						<td class="csui_header">&nbsp;</td>
						<td class="csui_header">BATCH ID</td>
						<td class="csui_header">TRANSACTION NO</td>
						<td class="csui_header">CHECK #</td>
						<td class="csui_header">ACCOUNT NO</td>
						<td class="csui_header">DAY TIME QTY</td>
						<td class="csui_header">OVERNIGHT QTY</td>
						
						<td class="csui_header">PAYMENT AMOUNT</td>
						<td class="csui_header">PROJECT ID</td>
						<td class="csui_header">PAYEE ID</td>
						
						<td class="csui_header">DAY TIME PREV/CURR QTY</td>
						<td class="csui_header">OVERNIGHT PREV/CURR QTY</td>
						<td class="csui_header">UPDATED</td>
						
						<td class="csui_header" width="1%">PROCESS</td>
						<td class="csui_header" width="1%">COMPLETE</td>
						<td class="csui_header" width="1%">PRINT</td>
					</tr>
				</thead>
				<tbody>
				  <% 
				  			ArrayList<HashMap<String, String>> list = ro.getList();
							for(int i=0;i<list.size();i++){
								HashMap<String, String> l = list.get(i);
								int ct = i+1;
								String act = l.get("ACTIVE");
								if(act.equalsIgnoreCase("N")){
									act = "Y";
								}else {
									act = "N";
								}
						%>
						
						<tr id="tr_<%=l.get("ID") %>">
							<%-- <td class="csui"><input type="checkbox" name="selector" id="selector" class="selector" value="<%=og[i].getExtras().get("ID") %>"> </td> --%>
							<td class="csui" type="String" itype="text"><%=ct %></td>
							<td class="csui" type="String" itype="text"><%=l.get("BATCH_NUMBER") %></td>
							<td class="csui" type="String" itype="text"><%=l.get("TRANSACTION_NUMBER") %></td>
							<td class="csui" type="String" itype="text"><%=l.get("CHECK_NO") %></td>
							<td class="csui" type="String" itype="text"><a href="/cs/summary.jsp?_ent=lso&_id=0&_type=project&_typeid=<%=l.get("PROJECT_ID") %>" target="lightbox-iframe"><%=l.get("ACCOUNT_NUMBER") %></a></td>
							<td class="csui" type="String" itype="text"><%=l.get("DAYTIME_QTY") %></td>
							<td class="csui" type="String" itype="text"><%=l.get("OVERNIGHT_QTY") %></td>
							<td class="csui" type="String" itype="text">$<%=l.get("PAYMENT_AMOUNT") %></td>
							<td class="csui" type="String" itype="text"><%=l.get("PROJECT_ID") %></td>
							<td class="csui" type="String" itype="text"><%=l.get("PAYEE_ID") %></td>
							<td class="csui" type="String" itype="text"><%=l.get("DAYTIME_PREV_QTY") %>/<%=l.get("DAYTIME_CURR_QTY") %></td>
							<td class="csui" type="String" itype="text"><%=l.get("OVERNIGHT_PREV_QTY") %>/<%=l.get("OVERNIGHT_CURR_QTY") %></td>
							<td class="csui" type="String" itype="text"><%=l.get("UPDATED_DATE") %></td>
							
							
								
							<td class="csui" type="String" itype="text"><%=l.get("STATUS") %></td>
							<td class="csui" type="String" itype="text"><%=act %></td>
							<td class="csui" type="String" itype="text">
								<%if(Operator.hasValue(l.get("PAYMENT_ID"))) {%>
								<a href="<%=Config.fullcontexturl()%>/print.jsp?_ent=finance&_type=payment&request=transaction&_id=<%=l.get("PAYMENT_ID") %>" target="_blank" ><img src="<%=Config.fullcontexturl()%>/images/icons/controls/gray/print.png" width="20" height="20" border="0"/></a>
									
								<%}else {%>
								
								<%}%>
							</td>
						</tr>
					<% }  %>
					</tbody>
			</div>
		</div>
		
	</div>




</body>
</html>

