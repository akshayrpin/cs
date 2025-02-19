<%@page import="cs.ui.CsUiTools"%>
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
	String startdate = map.getString("START_DATE");
	int typeid = map.getInt("PROJECT_ID");
	String renewal = map.getString("_grp");
	String hold = map.getString("alert");
	Timekeeper d = new Timekeeper();
	d.setDate(startdate);

	RequestVO nav = new RequestVO();
	nav.setEntity("parking");
	nav.setToken(map.token());
	nav.setIp(map.getRemoteIp());
	nav.setType("parking");
	nav.setTypeid(typeid);
	nav.setId(typeid+"");
	//nav.setRequest("full");
	//nav.setStartdate(startdate);
	
	//String streetlist = ApiHandler.post(CsConfig.getString("dropdownlist.streetlist"), "{}");
	//System.out.println("#######"+streetlist);
	//String streetfractionlist = ApiHandler.post(CsConfig.getString("dropdownlist.streetfractionlist"), "");
	TypeVO o = new TypeVO();
	ResponseVO ro = new ResponseVO();

	if (map.equalsIgnoreCase("action", "Save")) {
		RequestVO vo = RequestMapper.getRequest(map);
		ro = ApiHandler.getResponseVO(vo);
	}
	
	if (map.equalsIgnoreCase("action", "Save & Pay")) {
		RequestVO vo = RequestMapper.getSaveParkingPermit(map,"savepermit");
		ro = ApiHandler.getResponseVO(vo);
		boolean result = Cart.processPermitCart(map, ro.getType());
	}
	
	

	
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	ObjGroupVO[] g = o.getGroups();
	ToolsVO tools = o.getTools();

	RequestVO req = RequestMapper.getRequest(map);
	
	RequestVO pdtvo = nav.duplicate();
	pdtvo.setRequest("getparkingdates");
 	TypeVO dates = ApiHandler.getType(pdtvo);
 	HashMap<String, String> hm = dates.getGroups()[0].getExtras();
	String stdate = hm.get("START_RENEWAL_DATE");
	String eddate = hm.get("EXP_RENEWAL_DATE");

	SubObjVO[] pcount = null; 
	RequestVO renVO = nav.duplicate();
	renVO.setRequest("renewalcount");
	renVO.setTypeid(typeid);
	pcount = ApiHandler.getChoices(renVO);
	Timekeeper today = new Timekeeper();

	String[] acttypes = new String[0];
	if (pcount.length > 0) {
		acttypes = new String[pcount.length];
		for (int i=0; i<pcount.length; i++) {
			SubObjVO ty = pcount[i];
			acttypes[i] = ty.getValue();
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
	
	<style>
		.csui_controls { visibility: hidden }
	</style>
	<script>
	var entity = 'lso';
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
    
  
	<script>
		$(document).ready(function() {
		
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
				
				var tselect = $('select[name=LKUP_ACT_TYPE_ID] option:selected');
				var pexp = tselect.attr("PERMIT_EXPIRE");
				var aexp = tselect.attr("APPLICATION_EXPIRE");
				var pinp = $('[name=EXP_DATE]');
				var ainp = $('[name=APPLICATION_EXP_DATE]');
				pinp.val(pexp);
				<%if(!Operator.equalsIgnoreCase(renewal, "renewal")){ %>
					ainp.val(aexp);
				<%} %>
				try {
					var stdt = tselect.attr("START_DATE");
					var sinp = $('[name=START_DATE]');
					if (hasValue(stdt)) {
						sinp.val(stdt);
					}
				}
				catch (e) { }

				var qty = $('select[itype=QTY]');
				qty.empty();				
				<%
				//if(!Operator.equalsIgnoreCase(hold, "hold_h")){
					for(SubObjVO obj : pcount){
				%>
						if(acttypeid == '<%=obj.id%>'){
							var max = <%=obj.getAddldata().get("maxallowed")%>;
							if (max < 0) {
								value = 1;
							}
							else {
								$("#allowed").text(max);
								var count = <%=obj.getAddldata().get("count")%>;
								$("#applied").text(count);
								var value = 0;
								if(max > 0 && count > 0) {
									value = max - count;
								}
								else if(max > 0) {
									value = max;
								}
								else { value = 0; }
							}
							for(var i=1;i<=value;i++){
								qty.append('<option value="'+i+'">'+i+'</option>');
							}
							
							try {
								qty.trigger("chosen:updated");
							} catch(e) {}
						}
				<%
					} //}
				%>
				
				
			});
			
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

			
			
			$('#addnote').click(function() {
				var noteval = parseInt($('#notecount').val()) + 1;
				$('#notecount').val(noteval);
				$('#notetable').append('<tr><td style="border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc"><textarea name="NOTE_'+noteval+'" style="width: 100%; height: 50px"></textarea></td></tr>');
			});
			
			
			$('#lkupacttypeid').change(function() {
				var v = $(this).val();
				
				if(v==255 || v==256){
					$('#showvehicle').show();	
				}else {
					$('#showvehicle').hide();	
				}
				
				
			});
			
			
			$('#START_DATE').change(function() {
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
		
	
	function setAddtoCart() {
		var h = $('input[name=_action]');
		h.val('cart');
		return true;
	}

	function success(data) {
		var h = $('input[name=_action]');
		if (h.val() == 'cart') {
			var t = data['type'];
			var d = t['data'];
			var a = d['activities'];
			var method = "addcartpermit";
			
			var ty ="{}";
			
			$.ajax({
			  type: "POST",
			  url: "../action.jsp?_action="+method,
			  dataType: 'json',		  
			  data: { 
				 activities : a
			    },
			    success: function(output) {
					closeLightbox('true');
			    },
			    error: function(data) {
			        alert('Problem while adding permit to the cart.');
			    }
			});
		}
		else {
			closeLightbox('true');
		}
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
					<td align="left" class="csuicontrol">RENEW PERMIT</td>
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
				
				<form id="csform" class="form"  action="/cs/action.jsp" method="post">
				<input type="hidden" name="_ent" value="lso">
				<input type="hidden" name="_type" value="project">
				<input type="hidden" name="_typeid" value="<%= map.getString("PROJECT_ID")%>">
				<input type="hidden" name="_reference" value="<%= map.getString("accountno")%>">
				<input type="hidden" name="_grpid" value="activity">
				<input type="hidden" name="_grp" value="activity">
				<input type="hidden" name="_grptype" value="activity">
				<input type="hidden" name="_id" value="">
				<input type="hidden" name="_act" value="save">
				<input type="hidden" name="_action" value="save">
				<input type="hidden" name="LKUP_ACT_TYPE_ID" value="<%=Operator.join(acttypes, "|")%>"/>
				
				<table class="csui" colnum="2" type="default">

					<tr>
						<%
							if (pcount.length > 0) {
								SubObjVO a = pcount[0];
								int c = Operator.toInt(a.getData("count"));
								int m = Operator.toInt(a.getData("maxallowed"));
								int r = m-c;
						%>
								<td class="csui_label" colnum="2" alert=""><%= a.getText() %></td>
								<td class="csui" colnum="2">
									<%= ObjTables.numericalSelect(a.getValue(), 0, r, r) %>
								</td>
						<%
							}
							else {
						%>
								<td class="csui_label">&nbsp;</td>
								<td class="csui">&nbsp;</td>
						<%
							}
						%>
						<td class="csui_label" colnum="2" alert="">START DATE</td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" alert=""><input name="START_DATE" id="START_DATE" type="text" itype="date" valrequired="true" value="<%= stdate %>"></td>
					</tr>
					
					<tr>
						<%
							if (pcount.length > 1) {
								SubObjVO a = pcount[1];
								int c = Operator.toInt(a.getData("count"));
								int m = Operator.toInt(a.getData("maxallowed"));
								int r = m-c;
						%>
								<td class="csui_label" colnum="2" alert=""><%= a.getText() %></td>
								<td class="csui" colnum="2">
									<%= ObjTables.numericalSelect(a.getValue(), 0, r, r) %>
								</td>
						<%
							}
							else {
						%>
								<td class="csui_label">&nbsp;</td>
								<td class="csui">&nbsp;</td>
						<%
							}
						%>
						<td class="csui_label" colnum="2" alert="">PERMIT EXPIRATION DATE</td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" alert=""><input name="EXP_DATE" type="text" id="EXP_DATE"  itype="date" valrequired="true" value="<%= eddate %>"></td>
					</tr>
					
					<%
						if (pcount.length > 2) {
							for (int x=2; x<pcount.length; x++) {
					%>
								<tr>
					<%
								SubObjVO a = pcount[x];
								int c = Operator.toInt(a.getData("count"));
								int m = Operator.toInt(a.getData("maxallowed"));
								int r = m-c;
					%>
									<td class="csui_label"><%= a.getText() %></td>
									<td class="csui">
										<select name="<%= a.getValue() %>">
											<option value="0">0</option>
					<%
											for (int i=0; i<r; i++) {
												out.print("<option value=\""+(i+1)+"\">"+(i+1)+"</option>");
											}
					%>
										</select>
									</td>
									<td class="csui_label">&nbsp;</td>
									<td class="csui">&nbsp;</td>
								</tr>
					<%
							}
						}
					%>
				</table>
				
				<div class="csui_divider"></div>
				
				
				
				
				<div class="csui_buttons">
					<input type="submit" name="action" value="Save and Add to Cart" class="csui_button" onclick="return setAddtoCart()">
					<input type="submit" name="action" value="Save" class="csui_button" >
			<!-- 	<input type="submit" name="action" value="Save & Pay" class="csui_button" > -->
				</div>
				</form>
				
				<div class="csui_divider"></div>
				<div class="csui_divider"></div>
				
			
				
				
				
			
				
				
				
				
			</div>
		</div>
		
	</div>




</body>
</html>

