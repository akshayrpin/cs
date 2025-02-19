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
	
	RequestVO tpvo = nav.duplicate();
	tpvo.setRequest("permittype");
	SubObjVO[] acttypes = new SubObjVO[0];
	if(Operator.equalsIgnoreCase(renewal, "renewal")){
		tpvo.setRequest("getrenewaltypes");
		acttypes = ApiHandler.getChoices(tpvo);
	}
	else {
		acttypes = ApiHandler.getChoices(tpvo);
	}

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

	RequestVO pdtvo = nav.duplicate();
	pdtvo.setRequest("getparkingdates");
// 	TypeVO dates = ApiHandler.getType(pdtvo);
// 	HashMap hm = dates.getGroups()[0].getExtras();
// 	String stdate ="";
// 	String eddate ="";
	SubObjVO[] pcount = null; 
	if(Operator.equalsIgnoreCase(renewal, "renewal")){
//		stdate = hm.get("START_RENEWAL_DATE").toString();
//		eddate = hm.get("EXP_RENEWAL_DATE").toString();
		RequestVO renVO = nav.duplicate();
		renVO.setRequest("renewalcount");
		renVO.setTypeid(typeid);
		pcount = ApiHandler.getChoices(renVO);
//		acttypes = pcount;
		
	}else{
//		stdate = d.getString("YYYY/MM/DD");
//		eddate = hm.get("EXP_DATE").toString();
		
		RequestVO reqc = nav.duplicate();
		reqc.setReference(map.getString("PROJECT_ID"));
		reqc.setRequest("lastyearpermitcount");
		pcount = ApiHandler.getChoices(reqc);
	}
	Timekeeper today = new Timekeeper();
	String curl = Config.fullcontexturl() + "/jsp/parkingpermit.jsp?action=ADD&PROJECT_ID="+map.getString("PROJECT_ID")+"&strno=&strname=&fraction=&unit=&accountno=";

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

	<style>
		
	</style>

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
// 				var pexp = tselect.attr("PERMIT_EXPIRE");
// 				var aexp = tselect.attr("APPLICATION_EXPIRE");
// 				var pinp = $('[name=EXP_DATE]');
// 				var ainp = $('[name=APPLICATION_EXP_DATE]');
// 				pinp.val(pexp);
// 				ainp.val(aexp);

				tselect.each(function() {
					var txt = $(this).text();
					var vl = $(this).val();
					var pexp = $(this).attr("PERMIT_EXPIRE");
					var aexp = $(this).attr("APPLICATION_EXPIRE");
					addType(vl, txt, aexp, pexp)
				});
				removeTypes();

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

		function removeTypes() {
			var select = $('select[itype=acttype]');
			var str = select.val();
			var trs = $('#addtypetbl').find('tr.addtypecell');
			trs.each(function() {
				var tid = $(this).attr('rel');
				if (str && str.length > 0) {
					if (str.indexOf(tid) == -1) {
						$(this).remove();
					}
				}
				else {
					$(this).remove();
				}
			});
			var trs = $('#addtypetbl').find('tr.addtypecell');
			if (trs.length < 1) {
				$('#addtypetbl').hide();
			}
		}

		function addType(atype, text, appexpire, exp) {
			var ex = $('#tr_'+atype);
			if (ex && ex.length > 0) {
				
			}
			else {
				var max = getMax(atype);
				var tbl = $('#addtypetbl');
				var tr = $('<tr>');
				tr.attr('id','tr_'+atype);
				tr.attr('rel',atype);
				tr.addClass('addtypecell')
				tr.append(createCell(atype, 'name', text, 'text'));
				tr.append(createInteger(atype, atype, 1, max));
				tr.append(createCell(atype, 'START_DATE_'+atype, '<%=today.getString("YYYY/MM/DD")%>', 'date'));
				tr.append(createCell(atype, 'APPLICATION_EXP_DATE_'+atype, appexpire, 'date'));
				tr.append(createCell(atype, 'EXP_DATE_'+atype, exp, 'date'));
				tbl.append(tr);
				tbl.show();
			}
		}

		function createCell(id, name, value, itype) {
			var td = $('<td/>');
			td.addClass('csui');
			if (itype == 'text') {
				td.html(value);
			}
			else {
				var inp = $('<input/>');
				inp.attr('type','text');
				inp.attr('itype', itype);
				inp.attr('name', name);
				inp.attr('id', name);
				inp.val(value);
				inp.addClass('csform');
				inp.css({
					'border': '1px solid #cccccc',
					'padding':'8px',
					'width':'100%',
					'outline': 'none',
					'background-color': 'transparent',
					'box-sizing':'border-box',
					'-moz-box-sizing': 'border-box',
					'-webkit-box-sizing': 'border-box'
				});
				if (itype == 'date' || itype == 'issueddate') {
					inp.css({
						'background-image': 'url(/cs/images/icons/input/calendar.png)',
						'background-repeat': 'no-repeat',
						'background-position' : 'right 4px top 4px'
					})
					inp.datetimepicker({
						timepicker:false,
						format:'Y/m/d'
					});
				}
				td.html(inp);
			}
			return td;
		}

		function createInteger(id, name, value, max) {
			var td = $('<td/>');
			td.addClass('csui');
			var s = $('<select/>');
			s.attr('name', id);
			s.attr('id', id);
			for (i=0; i<=max; i++) {
				var o = $('<option/>');
				o.attr('value', i);
				o.html(i);
				if (i == value) {
					o.prop('selected', true);
				}
				s.append(o);
			}
			s.css({
				'border': '1px solid #cccccc',
				'padding':'8px',
				'width':'100%',
				'outline': 'none',
				'background-color': 'transparent',
				'box-sizing':'border-box',
				'-moz-box-sizing': 'border-box',
				'-webkit-box-sizing': 'border-box'
			});
			td.html(s);
			return td;
		}

		function getMax(acttypeid) {
			var v = 1;
			<% for (SubObjVO obj : pcount) { %>
					if (acttypeid == '<%=obj.id%>') {
						var max = <%=obj.getAddldata().get("maxallowed")%>;
						if (max < 0) {
							value = 1;
						}
						else if (max == undefined) {
							value = 1;
						}
						else {
							var count = <%=obj.getAddldata().get("count")%>;
							var value = 0;
							if (max > 0 && count > 0) {
								value = max - count;
							}
							else if (max > 0) {
								value = max;
							}
							else { value = 0; }
						}
						var v = parseInt(value);
						if (v == undefined) { v = 1; }
						v;
					}
			<% } %>
			return v;
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
					<td align="left" class="csuicontrol">PERMIT</td>
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
				<input type="hidden" name="_id" value="0">
				<input type="hidden" name="_act" value="save">
				<input type="hidden" name="_action" value="save">
				
				
				<input type="hidden" name="strno" value="<%= map.getString("strno")%>">
				<input type="hidden" name="strname" value="<%= map.getString("strname")%>">
				<input type="hidden" name="fraction" value="<%= map.getString("fraction")%>">
				<input type="hidden" name="unit" value="<%= map.getString("unit")%>">
				<input type="hidden" name="accountno" value="<%= map.getString("accountno")%>">
				
				<input name="ACT_NBR" type="hidden" itype="hidden" value="" >
				<input name="PROJECT_ID" type="hidden" itype="hidden" value="<%= map.getString("PROJECT_ID")%>">
				
				
				
				<input name="APPLIED_DATE" type="hidden" itype="hidden" value="<%=d.getString("YYYY/MM/DD") %>" >
				<input name="ISSUED_DATE" type="hidden" itype="hidden" value="" >
				<input name="VALUATION_DECLARED" type="hidden" itype="hidden" value="0" >
				<input name="VALUATION_CALCULATED" type="hidden" itype="hidden" value="0" >
				<input name="ONLINE" type="hidden" itype="hidden" value="N" >
				<input name="SENSITIVE" type="hidden" itype="hidden" value="N" >
				<input name="PLAN_CHK_REQ" type="hidden" itype="hidden" value="N" >
				
				<input type="hidden" name="vehiclecount" id="vehiclecount" value="0">	
				<table class="csui" colnum="2" type="default">
						
					<tr>
						<td class="csuicontrol" colspan="4" alert="">Add Parking Permit</td>
					</tr>
					<tr>
						<%= ObjTables.cells("LKUP_ACT_TYPE_ID", "ACTIVITY TYPE", "", "select", "acttype", true, "csui", 1, acttypes, true, true) %>
						<%= ObjTables.cells("LKUP_ACT_STATUS_ID", "STATUS", "", "select", "status", true, "csui", 1, new SubObjVO[0], false, true) %>
					</tr>
					<tr>
						<td class="csui_label" colnum="2" alert="">DESCRIPTION</td>
						<td class="csui" colnum="2" type="String" itype="text" alert=""><textarea name="DESCRIPTION" itype="textarea"></textarea></td>
						<td class="csui_label" colnum="2" alert="">&nbsp;</td>
						<td class="csui" colnum="2">&nbsp;</td>
					</tr>
					
				</table>
				
				<br/>
				<table class="csui" alert="<%=alert%>" id="addtypetbl" style="display: none">
					<tr>
						<td class="csui_label">Activity Type</td>
						<td class="csui_label" type="short">Quantity</td>
						<td class="csui_label" type="short">Start Date</td>
						<td class="csui_label" type="short">Temporary Permit Expiration</td>
						<td class="csui_label" type="short">Permit Expiration</td>
						</tr>
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

