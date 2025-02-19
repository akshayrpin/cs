<%@page import="cs.ui.CsUiTools"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="cs.utils.ObjTables"%>
<%@page import="csshared.vo.DataVO"%>
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


	Cartographer map = new Cartographer(request,response,true);
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	String startdate = map.getString("START_DATE");
	int typeid = map.getInt("PROJECT_ID");
	String subreq = map.getString("subreq");
	String hold = map.getString("alert");
	String maxallowed ="";
	Timekeeper d = new Timekeeper();
	d.setDate(startdate);

	RequestVO nav = new RequestVO();
	nav.setEntity("parking");
	nav.setToken(map.token());
	nav.setIp(map.getRemoteIp());
	nav.setType("parking");
	nav.setTypeid(typeid);
	nav.setId(typeid+"");
	
	TypeVO o = new TypeVO();
	ResponseVO ro = new ResponseVO();
	//ro.setMessagecode("cs200");
	if (map.equalsIgnoreCase("_action", "saveexemption")) {
		//RequestVO vo = RequestMapper.getSaveExemption(map);
		//ro = ApiHandler.getResponseVO(vo);
	}
	
	

	
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	ObjGroupVO[] g = o.getGroups();
	ToolsVO tools = o.getTools();


	RequestVO req = RequestMapper.getRequest(map);
	
	
	
	RequestVO tpvo = nav.duplicate();
	tpvo.setRequest("exemptiontype");
	SubObjVO[] acttypes = ApiHandler.getChoices(tpvo);
	
	RequestVO reqc = nav.duplicate();
	reqc.setRequest("listlastyeartypes");
	SubObjVO[] pcount = ApiHandler.getChoices(reqc);

//	TypeVO co = ApiHandler.getType(nav);
//	DataVO dvo = DataVO.toDataVO(co);
	

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
	var type = 'project';
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
  
	<style>
		
	</style>

	<script>
		$(document).ready(function() {
//				addvehicle();
				$('select[itype=acttype]').change(function() {
					var select = $('select[itype=acttype]');
					var acttypeid = select.val();
					var st = $('select[itype=status]');
					if (hasValue(st)) {
						var u = '_id=' + acttypeid + '&_type=activity&_request=status';
						st.empty();
						st.attr('json', u);
						st.attr('auto','false');
						jsonSelect(st, 'choices');
						try {
							select.trigger("chosen:updated");
						} catch(e) {}
					}
					
					var qty = $('select[itype=NO_OF_VEHICLES]');
					qty.empty();	
					
					<%
					if(!Operator.equalsIgnoreCase(hold, "hold_h")){
					if(!Operator.hasValue(subreq)){
						for(SubObjVO obj : pcount){%>
							if(acttypeid == '<%=obj.id%>'){
								var max = <%=obj.getAddldata().get("maxallowed")%>;
								$("#allowed").text(max);
								var count = <%=obj.getAddldata().get("count")%>;
								$("#applied").text(count);
								var value = 0;
								if(max > 0 && count > 0)
									value = max - count;
								else if(max > 0)
									value = max;
								else value = 0;
								
								for(var i=1;i<=value;i++){
									qty.append('<option value="'+i+'">'+i+'</option>');
								}
								try {
									qty.trigger("chosen:updated");
								} catch(e) {}
							}
					<%	}
					}else{
					%>
						$("#allowed").text("1");
						qty.append('<option value="1">1</option>');
						try {
							qty.trigger("chosen:updated");
						} catch(e) {}
					<%}
					} else{%>
						$("#allowed").text("Hold Exist on your account");
					<%}%>
				});
				
// 				$('select[itype=NO_OF_VEHICLES]').change(function() {
// 					$('#vhhtml').empty();
// 					for(var i=0;i<$('select[itype=NO_OF_VEHICLES]').val();i++)
// 						addvehicle();
// 				});
			
		<% if(ro.getMessagecode().equals("cs200") && map.getString("action").startsWith("Save")){%>
	
			
		
			//window.parent.$("#csform").submit();
		//	window.parent.$("#_tabs").val("tabs-2");
			//
			//window.parent.$('#tabs ul').tabs('select', index);
			//parent.$.fancybox.close();
			
			window.parent.location.reload();
			
		<% }%>
		
			
			$('input[itype=date]').datetimepicker({
				timepicker:false,
				format:'Y/m/d',
				minDate:'<%=d.getString("YYYY/MM/DD") %>'
			});
			
			$('select:not([itype=boolean]):not([valrequired=true])').chosen({
				width:'100%',
				disable_search_threshold: 10,
				allow_single_deselect: true
			});
			$('select:not([itype=boolean])[valrequired=true]').chosen({
				width:'100%',
				disable_search_threshold: 10
			});

			
			
// 			$('#addvh').click(function() {
// 				addvehicle();
// 			});
			
// 			function addvehicle(){
// 				var vhval =0;
				
// 				vhval = parseInt($('#vehiclecount').val()) + 1;
				
				
// 				$('#vehiclecount').val(vhval);
// 				$('#customsize').val(vhval);
				
// 				vhval = vhval -1;
				
// 				var h = '<tr id="vh_'+vhval+'">';
// 					h += '<td class="csui"><input type="text" valrequired="true" itype="String" class="required" id="LICENSE_PLATE_'+vhval+'" name="LICENSE_PLATE_'+vhval+'"></td>';
// 					h += '<td class="csui"><input type="text" id="REG_STATE_'+vhval+'" name="REG_STATE_'+vhval+'"></td>';
// 					h += '<td class="csui"><input type="text" id="VEHICLE_MAKE_'+vhval+'" name="VEHICLE_MAKE_'+vhval+'"></td>';
// 					h += '<td class="csui"><input type="text" id="VEHICLE_MODEL_'+vhval+'" name="VEHICLE_MODEL_'+vhval+'"></td>';
// 					h += '<td class="csui"><input type="text" id="VEHICLE_COLOR_'+vhval+'" name="VEHICLE_COLOR_'+vhval+'"></td>';
<%-- 					h += '<td class="csui" width="1%"><a title="Delete Vehicle" href="javascript:void('+vhval+');" onclick="removevehicle('+vhval+');" ><img src="<%=Config.fullcontexturl() %>/images/icons/controls/gray/delete.png"  width="20" height="20" border="0"/></a></td>'; --%>
// 					h += '</tr>';
				
// 				$('#vhhtml').append(h);
// 			}
			
			$('#lkupacttypeid').change(function() {
				var v = $(this).val();
				
				//if(v==255 || v==256){
				//	$('#showvehicle').show();	
				//}else {
				//	$('#showvehicle').hide();	
				//}
				
				
			});
			
			$('#START_DATE').change(function() {
				var v = $(this).val();
				$('#EXP_DATE').val(v);
				if($('#EXP_DATE') != 'undefined'){
					if($('#START_DATE').val() > $('#EXP_DATE').val()){
						swal('Start date cannot exceed exp date','','error');
						$('#START_DATE').val('');
					}
				}
			});
			
			$('#EXP_DATE').change(function() {
				if($('#START_DATE') != 'undefined'){
					if($('#START_DATE').val() > $('#EXP_DATE').val()){
						swal('Start date cannot exceed exp date','','error');
						$('#START_DATE').val('');
					}
				}
			});
		
		});
		
function removevehicle(id){
	$('#vh_'+id).remove();
}	
function addExemption(){
	
	
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
					<td align="left" class="csuicontrol">EXEMPTION</td>
					<td align="right"><%= ObjUi.tools(o.getTools(), "csui") %></td>
				</tr>
			</table>
		</div>
		
	</div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
			
			<br/><br/>
				<div id="csform_message"></div>
				<form class="form" action="/cs/action.jsp" method="post" success="/cs/<%=req.actionUrl()%>">
				<input type="hidden" name="_ent" value="lso">
				<input type="hidden" name="_type" value="project">
				<input type="hidden" name="_typeid" value="<%= map.getString("PROJECT_ID")%>">
				<input type="hidden" name="_grpid" value="activity">
				<input type="hidden" name="_grp" value="activity">
				<input type="hidden" name="_grptype" value="activity">
				<input type="hidden" name="_id" value="0">
				<input type="hidden" name="_act" value="save">
				<input type="hidden" name="_reference" value="<%= map.getString("accountno")%>">
				
				
				<input type="hidden" name="strno" value="<%= map.getString("strno")%>">
				<input type="hidden" name="strname" value="<%= map.getString("strname")%>">
				<input type="hidden" name="fraction" value="<%= map.getString("fraction")%>">
				<input type="hidden" name="unit" value="<%= map.getString("unit")%>">
				<input type="hidden" name="accountno" value="<%= map.getString("accountno")%>">
				
				
				
				<input name="ACT_NBR" type="hidden" itype="hidden" value="" >
				<input name="PROJECT_ID" type="hidden" itype="hidden" value="<%= map.getString("PROJECT_ID")%>">
				<input name="_appttypeid" type="hidden" itype="hidden" value="<%= map.getString("LSO_ID")%>">
				<input name="_ref" type="hidden" itype="hidden" value="lso">
				
				<input name="APPLIED_DATE" type="hidden" itype="hidden" value="<%=d.getString("YYYY/MM/DD") %>" >
				<input name="ISSUED_DATE" type="hidden" itype="hidden" value="<%=d.getString("YYYY/MM/DD") %>" >
				<input name="VALUATION_DECLARED" type="hidden" itype="hidden" value="0" >
				<input name="VALUATION_CALCULATED" type="hidden" itype="hidden" value="0" >
				<input name="ONLINE" type="hidden" itype="hidden" value="N" >
				<input name="SENSITIVE" type="hidden" itype="hidden" value="N" >
				<input name="PLAN_CHK_REQ" type="hidden" itype="hidden" value="N" >
				<input name="QTY" type="hidden" itype="hidden" value="1" >
				<input name="NO_OF_VEHICLES" type="hidden" itype="hidden" value="1" >
				<input type="hidden" name="vehiclecount" id="vehiclecount" value="1">	
				<input type="hidden" name="customsize" id="customsize" value="1">	
				<input type="hidden" name="<%= RequestMapper.subgroup %>" value="vehicle">	
				<input type="hidden" name="<%= RequestMapper.subgroupsize %>" value="1">	
				
				<table class="csui" colnum="2" type="default">
					<tr>
						<td class="csuicontrol" colspan="2" alert="">Maximum Allowed : <span id="allowed"></span></td>
						<td class="csuicontrol" colspan="2" alert="">Applied : <span id="applied"></span></td>
					</tr>
					<tr>
						<%= ObjTables.cells("LKUP_ACT_TYPE_ID", "ACTIVITY TYPE", "", "select", "acttype", true, "csui", 1, acttypes, false, true) %>
						<%= ObjTables.cells("LKUP_ACT_STATUS_ID", "STATUS", "", "select", "status", true, "csui", 1, new SubObjVO[0], false, true) %>
					</tr>
					
					<tr>
						<td class="csui_label" colnum="2" id="label_START_DATE">START DATE</td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" id="field_START_DATE"><input name="START_DATE" id="START_DATE" type="text" itype="date" value="<%=d.getString("YYYY/MM/DD") %>" valrequired="true" value="" maxchar="10000"></td>
						<td class="csui_label" colnum="2" id="label_EXP_DATE">EXP DATE</td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" id="field_EXP_DATE"><input name="EXP_DATE" type="text" id="EXP_DATE"  itype="date" value="<%=d.getString("YYYY/MM/DD") %>" valrequired="true" value="" maxchar="10000"></td>
					</tr>
					<tr>
						<td class="csui_label" colnum="2" id="label_DESCRIPTION">DESCRIPTION</td>
						<td class="csui" colnum="2" type="String" itype="text" id="field_DESCRIPTION"><textarea name="DESCRIPTION" itype="textarea"></textarea></td>
						<td class="csui_label" colnum="2" alert="">&nbsp;</td>
						<td class="csui" colnum="2" type="currency" itype="currency" alert="">&nbsp;</td>
					</tr>
					
				</table>
				
				<div class="csui_divider"></div>
				
				<div id="showvehicle">
				  <table class="csui_title" alert="warning">
						<tr>
						<td class="csui_title">VEHICLE INFORMATION</td>
<%-- 						<td class="csui_title"><a  id="addvh" title="Add Vehicle" href="javascript:void(0);" target="_self"><img src="<%=Config.fullcontexturl() %>/images/icons/controls/white/add.png"  width="20" height="20" border="0"/></a></td></tr> --%>
					</table>
				
				<table class="csui" type="horizontal" id="vhhtml">
						<tr>
							<td class="csui_header">LICENSE PLATE #</td>
							<td class="csui_header">STATE</td>
							<td class="csui_header">MAKE</td>
							<td class="csui_header">MODEL</td>
							<td class="csui_header">YEAR</td>
							<td class="csui_header">COLOR</td>
<!-- 							<td class="csui_header" width="1%">&nbsp;</td> -->
						</tr>
						<tr id="vh_0">
							<td class="csui"><input type="text" itype="String" id="LICENSE_PLATE_0" name="LICENSE_PLATE_0"></td>
							<td class="csui"><input type="text" id="REG_STATE_0" name="REG_STATE_0" maxlength="2"></td>
							<td class="csui"><input type="text" id="VEHICLE_MAKE_0" name="VEHICLE_MAKE_0"></td>
							<td class="csui"><input type="text" id="VEHICLE_MODEL_0" name="VEHICLE_MODEL_0"></td>
							<td class="csui"><input type="text" id="VEHICLE_YEAR_0" name="VEHICLE_YEAR_0" maxlength="4"></td>
							<td class="csui"><input type="text" id="VEHICLE_COLOR_0" name="VEHICLE_COLOR_0"></td>
<%-- 							<td class="csui" width="1%"><a title="Delete Vehicle" href="javascript:void(1);" onclick="removevehicle(1);" ><img src="<%=Config.fullcontexturl() %>/images/icons/controls/gray/delete.png"  width="20" height="20" border="0"/></a></td> --%>
						</tr>
				</table>
				
				</div>
				
				
				<div class="csui_buttons"><input type="submit" name="action" value="Save" class="csui_button" ></div>
				</form>
				
				<div class="csui_divider"></div>
				<div class="csui_divider"></div>
				
			
				
			</div>
		</div>
		
	</div>




</body>
</html>

