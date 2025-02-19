<%@page import="cs.ui.CsUiTools"%>
<%@page import="cs.ui.CsUi"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
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


	Cartographer map = new Cartographer(request,response, true);

	String uul = Config.fullcontexturl();
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	String startdate = map.getString("START_DATE");
	int typeid = map.getInt(RequestMapper.typeid);
	Timekeeper d = new Timekeeper();
	d.setDate(startdate);

	RequestVO navcount = new RequestVO();
	navcount.setEntity("parking");
	navcount.setToken(map.token());
	navcount.setIp(map.getRemoteIp());
	navcount.setType("parking");
	navcount.setAction("parkingapprovalcount");
	navcount.setRequest("parkingapprovalcount");
	
	ResponseVO cro = ApiHandler.getResponseVO(navcount);
	int count = Operator.toInt(cro.getInfo("numaccounts"), 0); 
	
	RequestVO nav = new RequestVO();
	nav.setEntity("parking");
	nav.setToken(map.token());
	nav.setIp(map.getRemoteIp());
	nav.setType("parking");
	nav.setTypeid(typeid);
	nav.setId(map.getString("_id"));
	
	//System.out.println("#######"+map.filetoken());
	//nav.setRequest("full");
	//nav.setStartdate(startdate);
	
	//String streetlist = ApiHandler.post(CsConfig.getString("dropdownlist.streetlist"), "{}");
	//System.out.println("#######"+streetlist);
	//String streetfractionlist = ApiHandler.post(CsConfig.getString("dropdownlist.streetfractionlist"), "");
	
	
	TypeVO o = new TypeVO();
	ResponseVO ro = new ResponseVO();
	if (map.equalsIgnoreCase("_action", "parkingsearch")) {
	
		RequestVO vo = RequestMapper.getParkingRequest(map,"search");
		ro = ApiHandler.getResponseVO(vo);
		o = ro.getType();
		typeid = o.getTypeid();
	}
	
	TypeVO cartsession = ObjMapper.toTypeObj(map.getString("_cartsession"));
	nav.setStatements(cartsession.getStatements());
	

	
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getHold().toLowerCase();
	ObjGroupVO[] g = o.getGroups();
	ToolsVO tools = o.getTools();
	

	RequestVO req = RequestMapper.getRequest(map);
	

%>
<html>
<head>

	<title>City Smart</title>
	
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
	<link href="<%=Config.fullcontexturl() %>/tools/zozotabs_6.5/css/zozo.tabs.min.css" rel="stylesheet">
	
	
	
	<style>
		.csui_controls { visibility: hidden }
		.onetime_button{}
	</style>
	<script>
	var entity = '<%= entity %>';
	var type = '<%= type %>';
	var typeid = '<%= typeid %>';
	var fullcontexturl = '<%=Config.fullcontexturl()%>';
		
	</script>
<%= CsUiTools.getHTMLImports() %>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.ui.js"></script>
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
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/zozotabs_6.5/js/zozo.tabs.min.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.qrcode-mini.js"></script>
	<style>
		
	</style>

	<script>
		$(document).ready(function() {

			$("#tabbed-nav").zozoTabs({
		        theme: "silver",      
		        animation: {
		            duration: 800,
		            effects: "slideH"
		        },
		        rememberState: true    
		
		    });
			
			$('.typesearch').click(function() {
				try {
					var act = $(this).attr("act");
					parent.addSearchTerm('parking_account_no:'+act);
					parent.linkIframe('/cs/search.jsp?sq=parking_account_no:'+act);
				}
				catch (e) {}
			});


			$(document).ready(function() {
				$('[ui]').csui();
			});

			<%if(Operator.hasValue(map.getString("_cartsession"))){%>
				displaycart();
			<%}%>
			
			/* $('#csform').csform({
				ajaxsubmit: false
			}); */
			
			$('select:not([itype=boolean]):not([valrequired=true])').chosen({
				width:'100%',
				disable_search_threshold: 10,
				allow_single_deselect: true
			});
			$('select:not([itype=boolean])[valrequired=true]').chosen({
				width:'100%',
				disable_search_threshold: 10
			});
			
			$('#addOneExemption').click(function () {
				var lsoId = $(this).attr("lso_id");
			
		      	 $('<a title="Exemption" href="<%=Config.fullcontexturl()%>/jsp/onetimeexemption.jsp?action=ADD&LSO_ID='+lsoId+'&PROJECT_ID=-1&strno=<%=map.getString("strno")%>&strname=<%=map.getString("strname")%>&fraction=<%=map.getString("fraction")%>&unit=<%=map.getString("unit")%>&accountno=-1&subreq=onetime&alert=<%=alert%>" >Friendly description</a>').fancybox({
	       		'width'				: '75%',
					'height'			: '75%',
					'autoScale'			: false,
					'transitionIn'		: 'none',
					'transitionOut'		: 'none',
					'type'				: 'iframe'
	          }).click();
	       	
				});
			
			 $('#addExemption').click(function () {
		      	 $('<a title="Exemption" href="<%=Config.fullcontexturl()%>/jsp/exemption.jsp?action=ADD&PROJECT_ID=<%=o.getTypeid()%>&strno=<%=map.getString("strno")%>&strname=<%=map.getString("strname")%>&fraction=<%=map.getString("fraction")%>&unit=<%=map.getString("unit")%>&accountno=<%=map.getString("accountno")%>" >Friendly description</a>').fancybox({
	       		'width'				: '75%',
					'height'			: '75%',
					'autoScale'			: false,
					'transitionIn'		: 'none',
					'transitionOut'		: 'none',
					'type'				: 'iframe'
	          }).click();
	       	
				});
			
			 
			 $('#addPermit').click(function () {
		      	 $('<a title="Permit" target="lightbox-iframe-refresh"  href="<%=Config.fullcontexturl()%>/jsp/parkingpermit.jsp?action=ADD&PROJECT_ID=<%=o.getTypeid()%>&strno=<%=map.getString("strno")%>&strname=<%=map.getString("strname")%>&fraction=<%=map.getString("fraction")%>&unit=<%=map.getString("unit")%>&accountno=<%=map.getString("accountno")%>" >Friendly description</a>').fancybox({
	       		'width'				: '75%',
					'height'			: '75%',
					'autoScale'			: false,
					'transitionIn'		: 'none',
					'transitionOut'		: 'none',
					'type'				: 'iframe'
	          }).click();
	       	
				});
			 
			 
			 $('#addRenewals').click(function () {
		      	 $('<a title="Permit" target="lightbox-iframe-refresh" href="<%=Config.fullcontexturl()%>/jsp/parkingrenewal.jsp?action=ADD&PROJECT_ID=<%=o.getTypeid()%>&strno=<%=map.getString("strno")%>&strname=<%=map.getString("strname")%>&fraction=<%=map.getString("fraction")%>&unit=<%=map.getString("unit")%>&accountno=<%=map.getString("accountno")%>&_grp=renewal" >Friendly description</a>').fancybox({
	       		'width'				: '75%',
					'height'			: '75%',
					'autoScale'			: false,
					'transitionIn'		: 'none',
					'transitionOut'		: 'none',
					'type'				: 'iframe'
	          }).click();
	       	
				});
			
			 
			//$('#strname').val("<%=map.getString("strnamevalue")%>");
			
			
			 $('.enter').keypress(function (e) {
				  if (e.which == 13) {
				    $('form#csform').submit();
				    return false;    //<---- Add this line
				  }
				});
			 
				 <%
				
				if(Operator.toInt(ro.getMessagecode())==1){	
				%>
				 $('.search').hide();
				<%} %>
				$("#sch").click(function(){
				    $(".search").toggle();
				});
		});
		
	
		function checkout(){
			var t = $('#_trackId').val();
			document.location.href = "../payment.jsp?_ent=finance&_type=finance&mode=parking&_trackId="+t;
			//document.forms[0].submit();
		}
		
		
		function displaycart(){
//			var output= $("#cart").val();
			//output = JSON.stringify(output);
	 		//alert(output);
	 		//console.log(output);
//	 		output = JSON.parse(output);
			var output = doAjax('/cs/jsp/cart.jsp');
			cslog(output);

	 		//alert(output['statements'].length);
	 		var c = '';
	 		c += '<tr id="lista">';
			c += '<td class="csuisub_header">NUMBER</td>';
			c += '<td class="csuisub_header">AMOUNT</td>';
			c += '<td class="csuisub_header" width="1%">&nbsp;</td>';
			c += '<td class="csuisub_header" width="1%">&nbsp;</td>';
			c += '<td class="csuisub_header" width="1%">&nbsp;</td>';
			c += '</tr>';
			//c += '<table class="sortable">';
	 		var t = 0;	
	 		$.each(output['statements'], function(k,v) {
	 			if(v.inputamount>0){
					t += v.inputamount;
					
					c+= '<tr class="csuisub" id="list'+v.order+'" style="cursor:pointer;" >';
			 		c += '<td class="csuisub" type="String" itype="String">'+v.activitynumber+'</td>';
			 		c += '<td class="csuisub" type="String" itype="String">$'+v.inputamount.toFixed(2)+'</td>';
			 		c += '<td class="csuisub"><a href="../cart.jsp?_ent=finance&_type=finance&_id='+v.searched+'"> <img src="<%=Config.fullcontexturl() %>/images/icons/controls/black/edit.png" height="16" width="16" ></a></td>';
			 		c += '<td class="csuisub"><a href="#" onclick="deletecart(\''+v.combined+'\');" value="'+v.combined+'" > <img src="<%=Config.fullcontexturl() %>/images/icons/controls/black/delete.png" height="16" width="16" ></a></td>';
			 		c += '<td class="csuisub"> <img title ="Drag & drop to sort the items" src="<%=Config.fullcontexturl() %>/images/icons/controls/black/updown.png" height="16" width="16" ></td>';
			 		c += '</tr>';
			 		//console.log(c);
			 		
				}	
	 		});
	 		//c += '</table>';
	 		//alert(t);
	 		
	 		c += '<tr class="csuisub" id="listt">';
	 		c += '<td class="csuisub" type="String" itype="String">TOTAL</td>';
	 		c += '<td class="csuisub" type="String" colspan="4" itype="String">$'+t.toFixed(2)+'</td>';
	 		
	 		c += '</tr>';
	 		
	 		$("#itemsadd").html(c);
	 		
			
		}
		
		function addtocart(id){
			var method = "addcartpermit";
			
			var ty ="{}";
			
			$.ajax({
				  type: "POST",
				  url: "../action.jsp?_action="+method,
				  dataType: 'json',		  
				  data: { 
					 cartjson : id
				     // valuation : valuation,
				      //mode : mode
				    },
				    success: function(output) {
				    	swal({   title: "<%= subtitle %>",   text: "Added to Cart!",   timer: 2000,   showConfirmButton: false });
				    	//$('form').submit();
				    //	window.location.href="parking.jsp?_action=parkingsearch&accountno=";
				    	 // $('form#csform').submit();
				    	 
				    	 
				    	var u ="../jsp/parking.jsp?_action=parkingsearch&_ent=parking&_type=parking&_grp=parking";
						//u +=""+fullcontexturl;
						//u +="/jsp/parking.jsp?_action=parkingsearch&_ent=parking&_type=parking&_grp=parking";
						u += "&strno="+$('#strno').val();
						u += "&strname="+$('#strname').val();
						u += "&unit="+$('#unit').val();
						u += "&fraction="+$('#fraction').val();
						u += "&accountno="+$('#accountno').val();
						
					//	u += "&projectno="+$('#projectno').val();
						u += "&licno="+$('#licno').val();
						u += "&name="+$('#name').val();
			   
			     
			            window.location.href= u;
				    	 
				    },
			    error: function(data) {
			        alert('Your request was not processed. Please check your input data.');
			    }
			});
		
		}
		
		function deletecart(id){
			var method = "deletecart";
			if(confirm("Are you sure you want to delete this item?")){
			var ty ="{}";
			
				$.ajax({
					  type: "POST",
					  url: "../action.jsp?_action="+method,
					  dataType: 'json',		  
					  data: { 
						 cartjson : id
					     // valuation : valuation,
					      //mode : mode
					    },
					    success: function(output) {
					    	output = JSON.stringify(output);
					    	$("#cart").val(output);
					    	displaycart();	
					    	//$("input:checkbox").prop('checked', false);
					    	//highlightSelected(output);
					    	
					    },
				    error: function(data) {
				        alert('Your request was not processed. Please check your input data.');
				    }
				});
			}
		}
		
		
		function print(id){
			
			//alert(id);
			var url = "<%=Config.fullcontexturl()%>/print.jsp?_ent=lso&_entid=-1&_type=project&_id="+id+"&_typeid="+id+"&_grptype=stickers&_act=print" ;
			var ids ="";
			$('input[type=checkbox]:checked').map(function(_, el) {
				ids +=  $(el).val()+",";
			}).get();
			if(ids!=""){
				ids += 0;
				
				url += "&_reference="+ids;
			}
			//alert(ids);
			window.open(url,'_blank');
			
		}
		
		function renew(){
			swal("Cannot renew. Fee not defined for the fiscal year");
		}
		
		function resetSearch(){
			$('#strno').val("");
			$('#fraction').val("");
			$('#strname').val("");
			$('#unit').val("");
			$('#accountno').val("");
			$('#licno').val("");
			$('#name').val("");
			$('#_action').val("");
			document.location.href = "parking.jsp";
			
		}
		
		function searcher(){
			var u ="";
				//u +=""+fullcontexturl;
				//u +="/jsp/parking.jsp?_action=parkingsearch&_ent=parking&_type=parking&_grp=parking";
				u += "&strno="+$('#strno').val();
				u += "&strname="+$('#strname').val();
				u += "&unit="+$('#unit').val();
				u += "&fraction="+$('#fraction').val();
				u += "&accountno="+$('#accountno').val();
			//	u += "&projectno="+$('#projectno').val();
				u += "&licno="+$('#licno').val();
				u += "&name="+$('#name').val();
	   
	       alert(u);
	       document.forms[0].action = "/jsp/parking.jsp?_action=parkingsearch&_ent=parking&_type=parking&_grp=parking"+u;
	       document.forms[0].submit();
		
		}
		
		function searcher2(accnt){
			
			var u ="../jsp/parking.jsp?_action=parkingsearch&_ent=parking&_type=parking&_grp=parking";
			//u +=""+fullcontexturl;
			//u +="/jsp/parking.jsp?_action=parkingsearch&_ent=parking&_type=parking&_grp=parking";
		
			u += "&accountno="+accnt;
			
		//	u += "&projectno="+$('#projectno').val();
		
     
            window.location.href= u;
		}

		function scantocart(type, typeid, reference){
			var method = "scantocart";
			$.ajax({
				  type: "POST",
				  url: "../action.jsp?_action="+method,
				  dataType: 'json',		  
				  data: { 
					  _ent: 'finance',
					  _type: type,
					  _typeid: typeid,
					  _reference: reference,
					  _grptype: 'finance',
					  _request: 'scantocart'
					// cartjson : ty
				     // valuation : valuation,
				      //mode : mode
				    },
				    success: function(output) {
				    	output = JSON.stringify(output);
				    	$("#cart").val(output);
				    	displaycart();	
				    	
				    },
			    error: function(data) {
			        alert('Your request was not processed. Please check your input data.');
			    }
			});
			 
			//$("#cart").val(ty);
			
			
		}
		
		
	</script>

</head>
<body alert="<%= alert %>">
<div id="loader"></div>

	<div id="csuicontrols">
		<div id="csuicontrol" class="csuicontrol <%= alert %>">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="left" class="csuicontrol">PARKING</td>
					<td align="right" class="csuicontrol" id="qrcoderesult"></td>
					<td align="right"><%= ObjUi.tools(o.getTools(), "csui") %>
					
					<table class="csui_tools">
					  <tr>
					<!--  --> 
					<td class="csui_tools">
						<a href="lockbox.jsp?_ent=lso&_entid=-1&_type=lockbox&_typeid=0&_grptype=lockbox&reload=Y" title="Lockbox Upload" border="0"  target="_self"  ><img src="/cs/images/icons/controls/white/lockbox.png" border="0"></a>
					</td>
					 
					<td class="csui_tools">
						<a href="onlineparking.jsp?_ent=parking&_entid=-1&_type=parking&_typeid=0&_grptype=parking&_act=onlineprints&_request=onlineprints" title="Print Batch" border="0"  target="_self"  ><img src="/cs/images/icons/controls/white/print.png" border="0"></a>
					</td>
					<%if(count > 0){%>
					<td class="csui_tools">
					<a href="parkingapproval.jsp?_ent=parking&_entid=-1&_type=parking&_typeid=0&_grptype=parking&_act=parkingapproval&_request=parkingapproval" title="Approvals" border="0"  target="_self"  ><img src="/cs/images/icons/controls/white/approveaccount.png" border="0"></a>
					</td>
					<%} %>
					<td class="csui_tools">
						<a href="renewal.jsp?_ent=parking&_entid=-1&_type=parking&_typeid=0&_grptype=parking&_act=getbatch&_request=getbatch" title="Renewal Letters" border="0"  target="_self"  ><img src="/cs/images/icons/controls/white/renew.png" border="0"></a>
					</td>
					<%
				
					if(Operator.toInt(ro.getMessagecode())==1){	
					%>
					<td class="csui_tools">
					<a href="parking.jsp"><img title="Search" src="/cs/images/icons/controls/white/search.png" border="0"></a>
					</td>
					<%} %>
					
					<td class="csui_tools">
						<img src="/cs/images/qrcode.png" height="20" width="20" border="0" id="qrcodestatus"/>
					</td>

					 </tr>
					</table>
					
					
					
					</td>
				</tr>
			</table>
		</div>
		<div id="csuisubcontrol" class="csuisubcontrol <%= alert %>">INFO</div>
	</div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
			<br/><br/>
				
				
				
				
				
				
				
				<%
				
				
				ObjGroupVO[] og = o.getGroups();
				
				if(Operator.toInt(ro.getMessagecode())==-1){					
				%>
				
				<table class="csui_title" alert="hold">
					<tr>
					<td class="csui_title">NO RESULTS FOUND </td>
					<%if(ro.getId() > 0){ %>
					<td class="csui_title"><input type="submit" name="action" value="Add One Time Exemption" id="addOneExemption" lso_id="<%=ro.getId() %>" class="csui_button onetime_button" style="margin:0;padding-bottom:0;padding-top:0;height: auto"></td>
					<%} %>
				</table>
				
				<%
				
				}else if(Operator.toInt(ro.getMessagecode())==2){	
				%>
				
				
				
				  <table class="csui_title" alert="warning">
						<tr>
							<td class="csui_title">RESULTS</td>
						</tr>
					</table>
				
				<table class="csui" type="horizontal">
					<tr>
						<td class="csui_header" width="1%" nowrap>ACCOUNT NO</td>
						<% if (map.hasValue("name")) { %>
							<td class="csui_header" width="25%" nowrap>NAME</td>
						<% } else if (map.hasValue("licno")) { %>
							<td class="csui_header">LICENSE</td>
						<% } else if (map.hasValue("email")) { %>
							<td class="csui_header">EMAIL</td>
						<% } %>
						<td class="csui_header">ADDRESS</td>
						<td class="csui_header" width="1%" nowrap>STATUS</td>
						
						<td class="csui_header" width="1%">&nbsp;</td>
					</tr>
				
				
				  <% 
							for(int i=0;i<og.length;i++){
							if(og[i].getGroup().equalsIgnoreCase("multiple") || og[i].getGroup().equalsIgnoreCase("accounts"))	{
								
						%>
						
						<form id="csform" action="parking.jsp" method="get" ajax="no">
						<input type="hidden" name="_ent" value="parking">
						<input type="hidden" name="_type" value="parking">
						<input type="hidden" name="_typeid" value="0">
						<input type="hidden" name="_grpid" value="parking">
						<input type="hidden" name="_grp" value="parking">
						<input type="hidden" name="_grptype" value="parking">
						<input type="hidden" name="_id" value="0">
						<input type="hidden" name="_tab" value="info">
						<input type="hidden" name="_action" value="parkingsearch">
						<input type="hidden" name="accountno" value="<%=og[i].getExtras().get("ACCOUNT_NO") %>">
						<tr class="csui">
							<td class="csui" width="1%" nowrap><%=og[i].getExtras().get("ACCOUNT_NO") %></td>
							<% if (map.hasValue("name") || map.hasValue("email") || map.hasValue("licno")) { %>
								<td class="csui" width="25%" nowrap><%=og[i].getExtras().get("HIT") %></td>
							<% } %>
							<td class="csui" ><%=og[i].getExtras().get("ADDRESS") %></td>
							<td class="csui" width="1%" nowrap ><%=og[i].getExtras().get("STATUS") %></td>
							
							<td class="csui_rowcontrols" style="cursor:pointer"  nowrap><input type="submit" name="action" value="Select" class="csui_button"></td>
						</tr>
					
					   </form>
					
					
					
					
				
						
					<% } } %>
					</table>
				
				<%
				
				}else if(Operator.toInt(ro.getMessagecode())==1){	
				%>
				
				
				
				
				
				
				
				
				<%
				
				if(og.length>0){
					
				%>
				<div class="csui_buttons">
				<input type="submit" name="action" value="Add One Time Exemption" id="addOneExemption" lso_id="<%=og[0].getExtras().get("LSO_ID") %>" class="csui_button">		
				<input type="submit" name="action" value="Add Exemption" id="addExemption" class="csui_button">
				<a target="lightbox-iframe" href="<%=Config.fullcontexturl()%>/jsp/parkingpermit.jsp?action=ADD&PROJECT_ID=<%=o.getTypeid()%>&strno=<%=map.getString("strno")%>&strname=<%=map.getString("strname")%>&fraction=<%=map.getString("fraction")%>&unit=<%=map.getString("unit")%>&accountno=<%=map.getString("accountno")%>" class="button">Add Permit</a>
				<a target="lightbox-iframe" href="<%=Config.fullcontexturl()%>/jsp/parkingrenewal.jsp?action=ADD&PROJECT_ID=<%=o.getTypeid()%>&strno=<%=map.getString("strno")%>&strname=<%=map.getString("strname")%>&fraction=<%=map.getString("fraction")%>&unit=<%=map.getString("unit")%>&accountno=<%=map.getString("accountno")%>&_grp=renewal" class="button">Add Renewals</a>
			
				</div>
				
				<div id="tabbed-nav">
			 	 <ul>
			 		<li><a target="_self">Info</a></li>
				    <li><a target="_self">Permits</a></li>
				    <li><a target="_self">Exemptions</a></li>
				    <li><a target="_self">History</a></li>
			 	 </ul>
			 	 
			 	 <div>
			 	 <!-- INFO -->	
			 	  <div>
				   
					<% 
							int projectId =0;
							for(int i=0;i<og.length;i++) {
								if(og[i].getGroup().equalsIgnoreCase("info"))	{
									projectId=	Operator.toInt(og[i].getExtras().get("PROJECT_ID"));
					%>
					
				   <table class="csui_title csuialert" alert="<%=alert%>">
						<tr>
						<td class="csui_title">ACCOUNT: <%=og[i].getExtras().get("ACCOUNT_NO") %></td>
						<td class="csui_title  typesearch" align="right" style="cursor: pointer" act="<%=og[i].getExtras().get("ACCOUNT_NO") %>" title="global search <%=og[i].getExtras().get("ACCOUNT_NO") %>">
							<img src="/cs/images/icons/controls/white/search.png" border="0">
						</td>
						<td class="csui_title" align="right">
							<a class="csui" target="lightbox-iframe-refresh" href="../summary.jsp?_ent=lso&_id=<%=nav.getId()%>&_type=project&_typeid=<%=og[i].getExtras().get("PROJECT_ID") %>" title="View Project">
							<img src="<%=Config.fullcontexturl() %>/images/icons/controls/white/briefcase.png">
							</a>
						</td>
						</tr>
					</table>
					
					<table class="csui" colnum="2" type="default">

						<tr>
							<td class="csui_label" colnum="2" alert="">ADDRESS</td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><%=og[i].getExtras().get("ADDRESS") %></td>
							<td class="csui_label" colnum="2" alert="">ACCOUNT NO</td>
							<td class="csui" colnum="2" type="String" itype="text" alert="">
							<a class="csui" target="lightbox-iframe-refresh" href="../summary.jsp?_ent=lso&_id=<%=nav.getId()%>&_type=project&_typeid=<%=og[i].getExtras().get("PROJECT_ID") %>" >
							<%=og[i].getExtras().get("ACCOUNT_NO") %></a>
							<input type="hidden" name="_trackId" id="_trackId" value="<%=og[i].getExtras().get("ACCOUNT_NO") %>"> 
							</td>
						</tr>

						<tr>
							<td class="csui_label" colnum="2" alert="">NUMBER OF SPACES</td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><%=og[i].getExtras().get("NO_SPACES") %></td>
							<td class="csui_label" colnum="2" alert="">NUMBER OF CARS</td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><%=og[i].getExtras().get("NO_CARS") %></td>
						</tr>

						<tr>
							<td class="csui_label" colnum="2" alert="">APPROVED SPACES</td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><%=og[i].getExtras().get("APPROVED_SPACE") %></td>
							<td class="csui_label" colnum="2" alert="">SECRET CODE</td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><%=og[i].getExtras().get("SECRET") %></td>
						</tr>

						<tr>
							<td class="csui_label" colnum="2" alert="">ACTIVE HOLDS</td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><%=og[i].getExtras().get("HOLDS") %></td>
							<td class="csui_label" colnum="2" alert="">&nbsp</td>
							<td class="csui" colnum="2" type="String" itype="text" alert="">&nbsp;</td>
						</tr>


						<%
							String divisions = og[i].getExtras().get("DIVISIONS");
							String[] darr = Operator.split(divisions, ",");
							int col = 1;
							for (int di=0; di<darr.length; di++) {
								if (col == 1) {
									out.print("<tr>");
								}
								String info = og[i].getExtras().get("INFO_"+darr[di]);
								out.print("<td class=\"csui_label\" valign=\"top\">");
								out.print(darr[di]);
								out.print("</td>");
								out.print("<td class=\"csui\" valign=\"top\">");
								if (Operator.hasValue(og[i].getExtras().get(darr[di]))) {
									out.print(og[i].getExtras().get(darr[di]));
								}
								else {
									out.print("None");
								}
								if (Operator.hasValue(info)) {
									out.print("<br/><br/>");
									out.print(info);
								}
								out.print("</td>");
								if (col > 1) {
									out.print("</tr>");
									col = 1;
								}
								else {
									col++;
								}
							}
							if (col > 1) {
								out.print("<td class=\"csui_label\">&nbsp;</td>");
								out.print("<td class=\"csui\">&nbsp;</td>");
								out.print("</tr>");
							}
						%>
					</table>

					<% 
							ArrayList<HashMap<String, String>> ppla = g[i].getExtraslist();
							if (ppla.size() > 0) {
					%>

					<br/>
				   <table class="csui_title">
						<tr>
						<td class="csui_title csuialert" alert="<%=alert%>">PEOPLE</td>
						</tr>
					</table>
					<table class="csui" colnum="2" type="default">
						<tr>
							<td class="csui_rowcontrols" style="width:1%">&nbsp;</td>
							<td class="csui_label" style="width:34%">NAME</td>
							<td class="csui_label" style="width:25%" nowrap>EMAIL</td>
							<td class="csui_label" style="width:10%" nowrap>PHONE (cell)</td>
							<td class="csui_label" style="width:10%" nowrap>PHONE (home)</td>
							<td class="csui_label" style="width:10%" nowrap>PHONE (work)</td>
							<td class="csui_label" style="width:10%" nowrap>TYPE</td>
						</tr>

					<% 
							for(int x=0; x<ppla.size(); x++) {
								HashMap<String, String> ppl = ppla.get(x);
								String username = ppl.get("USERNAME");
								String email = ppl.get("EMAIL");
					%>
						<tr>
							<td class="csui_rowcontrols" style="width:1%">
							<%
								if (Operator.hasValue(username) || Operator.hasValue(email)) {
									String hasacct = ppl.get("HASACCOUNT");
									//System.out.println(hasacct+"iffffffffffffffffff");
									if (Operator.equalsIgnoreCase(hasacct, "Y")) {
							%>
										<img src="/cs/images/icons/controls/color/onlineaccount.png" style="cursor: pointer" title="User has an existing account. Click here to reset user password." onclick="refusersonlineaccount(<%= ppl.get("REF_USERS_ID") %>, '<%=ppl.get("EMAIL")%>')"/>
							<%
									} else {
										
										//System.out.println("elseeeeeeeeeeeeee");
							%>
										<img src="/cs/images/icons/controls/gray/onlineaccount.png" style="cursor: pointer" title="Create Online Account" onclick="refusersonlineaccount(<%= ppl.get("REF_USERS_ID") %>, '<%=ppl.get("EMAIL")%>')"/>
							<%
									} 
								}
							%>
							</td>
							<td class="csui" style="width:35%"><%=ppl.get("NAME") %></td>
							<td class="csui" style="width:25%" nowrap><%=ppl.get("EMAIL") %></td>
							<td class="csui" style="width:10%" nowrap><%=ppl.get("PHONE_CELL") %></td>
							<td class="csui" style="width:10%" nowrap><%=ppl.get("PHONE_HOME") %></td>
							<td class="csui" style="width:10%" nowrap><%=ppl.get("PHONE_WORK") %></td>
							<td class="csui" style="width:10%" nowrap><%=ppl.get("TYPE") %></td>
						</tr>
					<%
							}
					%>
					</table>

					<%
							}
							}
							}
					%>
					<br/>
				   <%= CsUi.ajaxElem("notes", "ext", "csui", "") %>
				   <%= CsUi.ajaxElem("attachments", "ext", "csui", "") %>
				   <table class="csui_title">
						<tr>
						<td class="csui_title csuialert" alert="<%=alert%>">PERMITS</td>
						</tr>
					</table>
					<table class="csui" type="horizontal">
						<tr>
							<td class="csui_header">NUMBER</td>
							<td class="csui_header">TYPE</td>
							<td class="csui_header">START DATE</td>
							<td class="csui_header">END DATE</td>
							<td class="csui_header">STATUS</td>
							<td class="csui_header">BALANCE</td>
							<td class="csui_header">PRINTED</td>
							<td class="csui_header">CREATED BY</td>
							<td class="csui_header">CREATED DATE</td>
						
							<!-- <td class="csui_header" width="1%">Renew</td> -->
							<td class="csui_header" width="1%">Pay/Print</td>
							
						</tr>
						
						<% 
							for(int i=0;i<og.length;i++){
							if(og[i].getGroup().equalsIgnoreCase("permits"))	{
								
						%>
						
						<tr class="csui">
							<td class="csui" type="String" itype="text"><a class="csui"  target="lightbox-iframe-refresh" href="../summary.jsp?_ent=lso&_id=<%=nav.getId()%>&_type=activity&_typeid=<%=og[i].getExtras().get("ID") %>" ><%=og[i].getExtras().get("ACT_NBR") %></a></td>
							<td class="csui" type="text" itype="text"><%=og[i].getExtras().get("TYPE") %></td>
							<td class="csui" type="String" itype="date"><%=og[i].getExtras().get("START_DATE") %></td>
							<td class="csui" type="String" itype="date"><%=og[i].getExtras().get("EXP_DATE") %></td>
							<td class="csui" type="status" itype="status"><%=og[i].getExtras().get("STATUS") %></td>
							<td class="csui" type="currency" itype="currency"><%=og[i].getExtras().get("BALANCE") %></td>
							<td class="csui" type="status" itype="status"><%=og[i].getExtras().get("PRINTED") %></td>
							<td class="csui" type="user" itype="user"><%=og[i].getExtras().get("CREATED") %></td>
							<td class="csui" type="String" itype="date"><%=og[i].getExtras().get("CREATED_DATE") %></td>
							
							
							<%if(og[i].getExtras().get("PRINT").equalsIgnoreCase("Y")){ %>
								
								<!--
								<td class="csui" type="String" itype="text">
								
								
								<a class="csui" target="_self" href="javascript:void(0);" onclick="renew();" title="Renew" ><img style="cursor:pointer;"  src="/cs/images/icons/controls/black/renew.png" border="0" > </a>
								</td>
								-->
								
								<td class="csui" style="cursor:pointer"  nowrap>
									<a href="<%=Config.fullcontexturl()%>/printall.jsp?_ent=lso&_entid=-1&_type=activity&_typeid=<%=og[i].getExtras().get("ID") %>&_grptype=print&_act=print" target="lightbox-iframe" ><img src="<%=Config.fullcontexturl()%>/images/icons/controls/gray/print.png" width="20" height="20" border="0"/></a>
								</td>
							<%} else { %>
							<!--
								<td class="csui" type="String" itype="text">
									&nbsp;
								</td>
								-->
							
								<td class="csui" style="cursor:pointer"  nowrap>
								<a target="_self" href="javascript:void(0);" title="Add to cart" onclick="addtocart(<%=og[i].getExtras().get("ID") %>);" ><img src="<%=Config.fullcontexturl()%>/images/icons/controls/black/cart.png" width="20" height="20" border="0"/></a>
								</td>
								
							<%} %>
							
						</tr>
					
						<% } } %>
					</table>
				   
				   
				  </div>
			 	  <!-- PERMITS -->	
				  <div>
				   
				   <table class="csui_title csuialert" alert="<%=alert%>">
						<tr>
							<td class="csui_title">Permits</td>
							<td class="csui_title" align="right">
								
								
								<a target="lightbox-iframe-refresh" href="../printall.jsp?_ent=lso&_entid=-1&_type=project&_typeid=<%=projectId%>&_grptype=print&_act=print" target="_blank" >
								<img src="<%=Config.fullcontexturl() %>/images/icons/controls/white/print.png">
								</a>
							</td>
						</tr>
					</table>
					
					<table class="csui" type="horizontal">
						<tr>
							<td class="csui_header">NUMBER</td>
							<td class="csui_header">TYPE</td>
							<td class="csui_header">START DATE</td>
							<td class="csui_header">END DATE</td>
							<td class="csui_header">STATUS</td>
							<td class="csui_header">BALANCE</td>
							<td class="csui_header">PRINTED</td>
							<td class="csui_header">CREATED BY</td>
							<td class="csui_header">CREATED DATE</td>
						
							<!-- <td class="csui_header" width="1%">Renew</td> -->
							<td class="csui_header" width="1%">Pay/Print</td>
							
						</tr>
						
						<% 
							for(int i=0;i<og.length;i++){
							if(og[i].getGroup().equalsIgnoreCase("permits"))	{
								
						%>
						
						<tr class="csui">
							<td class="csui" type="String" itype="text"><a class="csui"  target="lightbox-iframe-refresh" href="../summary.jsp?_ent=lso&_id=<%=nav.getId()%>&_type=activity&_typeid=<%=og[i].getExtras().get("ID") %>" ><%=og[i].getExtras().get("ACT_NBR") %></a></td>
							<td class="csui" type="text" itype="text"><%=og[i].getExtras().get("TYPE") %></td>
							<td class="csui" type="String" itype="date"><%=og[i].getExtras().get("START_DATE") %></td>
							<td class="csui" type="String" itype="date"><%=og[i].getExtras().get("EXP_DATE") %></td>
							<td class="csui" type="status" itype="status"><%=og[i].getExtras().get("STATUS") %></td>
							<td class="csui" type="currency" itype="currency"><%=og[i].getExtras().get("BALANCE") %></td>
							<td class="csui" type="status" itype="status"><%=og[i].getExtras().get("PRINTED") %></td>
							<td class="csui" type="user" itype="user"><%=og[i].getExtras().get("CREATED") %></td>
							<td class="csui" type="String" itype="date"><%=og[i].getExtras().get("CREATED_DATE") %></td>
							
							
							<%if(og[i].getExtras().get("PRINT").equalsIgnoreCase("Y")){ %>
								
								<!--
								<td class="csui" type="String" itype="text">
								
								
								<a class="csui" target="_self" href="javascript:void(0);" onclick="renew();" title="Renew" ><img style="cursor:pointer;"  src="/cs/images/icons/controls/black/renew.png" border="0" > </a>
								</td>
								-->
								
								<td class="csui" style="cursor:pointer"  nowrap>
									<a href="<%=Config.fullcontexturl()%>/printall.jsp?_ent=lso&_entid=-1&_type=activity&_typeid=<%=og[i].getExtras().get("ID") %>&_grptype=print&_act=print" target="lightbox-iframe" ><img src="<%=Config.fullcontexturl()%>/images/icons/controls/gray/print.png" width="20" height="20" border="0"/></a>
								</td>
								
							<%} else { %>
							<!--
								<td class="csui" type="String" itype="text">
									&nbsp;
								</td>
								-->
							
								<td class="csui" style="cursor:pointer"  nowrap>
								<a target="_self" href="javascript:void(0);" title="Add to cart" onclick="addtocart(<%=og[i].getExtras().get("ID") %>);" ><img src="<%=Config.fullcontexturl()%>/images/icons/controls/black/cart.png" width="20" height="20" border="0"/></a>
								</td>
								
							<%} %>
							
						</tr>
					
						<% } } %>
					</table>
				   
				   
				   
				  </div>
				  
				   <!-- EXEMPTION -->	
				   <div>
				   
				   <table class="csui_title csuialert" alert="<%= alert %>">
						<tr>
						<td class="csui_title">Last 50 Exemptions</td>
						</tr>
					</table>
					
					<table class="csui" type="horizontal">
						<tr>
							<td class="csui_header">NUMBER</td>
							<td class="csui_header">TYPE</td>
							<td class="csui_header"># of Vehicles</td>
							<td class="csui_header">START DATE</td>
							<td class="csui_header">END DATE</td>
							
							<td class="csui_header">CREATED BY</td>
							<td class="csui_header">CREATED DATE</td>
							<td class="csui_header" width="1%">Email</td>
							<td class="csui_header" width="1%">Print</td>
						</tr>
						
						<% 
							for(int i=0;i<og.length;i++){
							if(og[i].getGroup().equalsIgnoreCase("exemptions"))	{
							
						%>
						
						<tr class="csui">
							<td class="csui" type="String" itype="text"><a class="csui"  target="lightbox-iframe-refresh" href="../summary.jsp?_ent=lso&_id=<%=nav.getId()%>&_type=activity&_typeid=<%=og[i].getExtras().get("ID") %>" ><%=og[i].getExtras().get("ACT_NBR") %></a></td>
							<td class="csui" type="String" itype="text"><%=og[i].getExtras().get("TYPE") %></td>
							<td class="csui" type="short" itype="short"><%=og[i].getExtras().get("QTY")!=null?og[i].getExtras().get("QTY"):"" %></td>
							<td class="csui" type="String" itype="date"><%=og[i].getExtras().get("START_DATE") %></td>
							<td class="csui" type="String" itype="date"><%=og[i].getExtras().get("EXP_DATE") %></td>
							
							<td class="csui" type="user" itype="user"><%=og[i].getExtras().get("CREATED") %></td>
							<td class="csui" type="String" itype="date"><%=og[i].getExtras().get("CREATED_DATE") %></td>
							<td class="csui" width="1%">
										<a  href="../email.jsp?_ent=lso&_entid=-1&_type=activity&_typeid=<%=og[i].getExtras().get("ID") %>&_id=&_grptype=email&_act=email&_reference=12&subject=City%20of%20Beverly%20Hills%20-%20Parking%20Exemption&body=Your%20exemption%20code%20is%20attached." title="E-mail" border="0"  target="lightbox-iframe"  ><img src="/cs/images/icons/controls/black/email.png" border="0"></a>
									</td>
							
							<td class="csui" style="cursor:pointer"  nowrap><a href="<%=Config.fullcontexturl()%>/print.jsp?_ent=lso&_entid=-1&_type=activity&_typeid=<%=og[i].getExtras().get("ID") %>&_grptype=print&_act=print&_reference=12" target="_blank" ><img src="<%=Config.fullcontexturl()%>/images/icons/controls/gray/print.png" width="20" height="20" border="0"/></a></td>
						</tr>
					
						<% } } %>
					</table>
				   
				   
				   
				  </div>
				  
				   <!-- HISTORY -->	
				   <div>
				   
				   <table class="csui_title csuialert" alert="<%= alert %>">
						<tr>
						<td class="csui_title">Permits History</td>
						</tr>
					</table>
					
					<table class="csui" type="horizontal">
						<tr>
							<td class="csui_header">NUMBER</td>
							<td class="csui_header">TYPE</td>
							<td class="csui_header">START DATE</td>
							<td class="csui_header">END DATE</td>
							<td class="csui_header">STATUS</td>
							<td class="csui_header">BALANCE</td>
							<td class="csui_header">PRINTED</td>
						
							<td class="csui_header" width="1%">Print</td>
							<td class="csui_header" width="1%">Pay</td>
						</tr>
						
						<% 
							for(int i=0;i<og.length;i++){
							if(og[i].getGroup().equalsIgnoreCase("permitsall"))	{
								
						%>
						
						<tr class="csui">
							<td class="csui" type="String" itype="text"><a class="csui"  target="lightbox-iframe-refresh" href="../summary.jsp?_ent=lso&_id=<%=nav.getId()%>&_type=activity&_typeid=<%=og[i].getExtras().get("ID") %>" ><%=og[i].getExtras().get("ACT_NBR") %></a></td>
							<td class="csui" type="String" itype="text"><%=og[i].getExtras().get("TYPE") %></td>
							<td class="csui" type="date" itype="date"><%=og[i].getExtras().get("START_DATE") %></td>
							<td class="csui" type="date" itype="date"><%=og[i].getExtras().get("EXP_DATE") %></td>
							<td class="csui" type="status" itype="status"><%=og[i].getExtras().get("STATUS") %></td>
							<td class="csui" type="String" itype="text"><%=og[i].getExtras().get("BALANCE") %></td>
							<td class="csui" type="status" itype="status"><%=og[i].getExtras().get("PRINTED") %></td>
							
							<td class="csui" style="cursor:pointer"  nowrap>
							
							<%if(og[i].getExtras().get("PRINT").equalsIgnoreCase("Y")){ %>
								<a href="<%=Config.fullcontexturl()%>/printall.jsp?_ent=lso&_entid=-1&_type=activity&_typeid=<%=og[i].getExtras().get("ID") %>&_grptype=print&_act=print" target="lightbox-iframe" ><img src="<%=Config.fullcontexturl()%>/images/icons/controls/gray/print.png" width="20" height="20" border="0"/></a>
							<%} else { %>
								&nbsp;
							<%} %>
							</td>
							<td class="csui" style="cursor:pointer"  nowrap>
							
							<%if(og[i].getExtras().get("PRINT").equalsIgnoreCase("Y")){ %>
								&nbsp;
							<%} else { %>
								<a target="_self" href="javascript:void(0)" title="Add to cart" onclick="addtocart(<%=og[i].getExtras().get("ID") %>);" ><img src="<%=Config.fullcontexturl()%>/images/icons/controls/black/cart.png" width="20" height="20" border="0"/></a>
							<%} %>
							</td>
						</tr>
					
						<% } } %>
					</table>
				   
				   
				   
				  </div>
				 
				</div>
				</div>
				
				<%} %>
				
				<%
				
				}	
				%>
				<div id="csform_message"></div>
				<div class="csui_divider"></div>
				<form class="form" id="csform" ajax="no" action="parking.jsp" method="get">
				<input type="hidden" name="_ent" value="parking">
				<input type="hidden" name="_type" value="parking">
				<input type="hidden" name="_typeid" value="0">
				<input type="hidden" name="_grpid" value="parking">
				<input type="hidden" name="_grp" value="parking">
				<input type="hidden" name="_grptype" value="parking">
				<input type="hidden" name="_id" value="0">
				<input type="hidden" name="_action" id="_action" value="parkingsearch">
				<input type="hidden" name="_tabs" id="_tabs" value="tabs-1">
				<input type="hidden" name="strnamevalue" id="strnamevalue" value="<%=map.getString("strnamevalue")%>">	
				<input type="hidden" id="cart" name="cart" value="0" >
				<input type="hidden" name="_reference" value="<%= map.getString("accountno")%>">
				<table class="csui_title search" alert="" >
				<tr>
					<td class="csui_title">SEARCH</td>
					<td class="csui_controls">&nbsp;</td>
				</tr>
				</table>
				
				<table class="csui search"  colnum="2" type="default">
					<tr>
						<td class="csui_label" colnum="2" alert="">ADDRESS</td>
						
						<td class="csui" colnum="5" type="String" itype="String" alert="">
							<table  colnum="2" type="default" width="100%">
								<tr>
									<td style="width:100px">
										<input name="strno" id="strno" type="text" itype="integer" value="<%=map.getString("strno") %>"  placeholder="Street#" maxchar="100">
									</td>
									<td style="width:100px">
										<select name="fraction" id="fraction"  itype="String" _ent="parking"  placeholder="Fraction" json="<%=CsConfig.getString("dropdownlist.streetfractionlist")%>?selected=<%=map.getString("fraction")%>">
										</select>
									</td>
									<td>
										<select name="strname" id="strname" itype="String" _ent="parking" json="<%=CsConfig.getString("dropdownlist.streetlist")%>?selected=<%=map.getString("strname")%>"></select>
									</td>
									<td style="width:100px">
										<input name="unit" id="unit"  type="text" itype="text" value="<%=map.getString("unit") %>" class="enter" placeholder="Unit" maxchar="100">
									</td>
							
								</tr>
							</table>
						</td>
					</tr>
					
					<tr>
						<td class="csui_label" colnum="2" alert="">ACCOUNT NO</td>
						<td class="csui"  type="String" itype="String" alert="">
							<input name="accountno"  id="accountno" type="text" itype="text" value="<%=map.getString("accountno") %>"  class="enter" placeholder="Account#" maxchar="100" >
						</td>
					</tr>
					
					<tr>
						<td class="csui_label" colnum="2" alert="">NAME</td>
						<td class="csui"  type="String" itype="String" alert="">
							<input name="name"  id="name" type="text" itype="text" value="<%=map.getString("name") %>"  class="enter" placeholder="Name" maxchar="100" >
						</td>
					</tr>
					
					<tr>
						<td class="csui_label" colnum="2" alert="">EMAIL</td>
						<td class="csui"  type="String" itype="String" alert="">
							<input name="email"  id="email" type="text" itype="text" value="<%=map.getString("email") %>"  class="enter" placeholder="Email" maxchar="100" >
						</td>
					</tr>
					
					<tr>
						<td class="csui_label" colnum="2" alert="">PERMIT #</td>
						<td class="csui"  type="String" itype="String" alert="">
							<input name="permit"  id="permit" type="text" itype="text" value="<%=map.getString("permit") %>"  class="enter" placeholder="Permit #" maxchar="100" >
						</td>
					</tr>
					
					<tr>
						<td class="csui_label" colnum="2" alert="">LICENSE #</td>
						<td class="csui"  type="String" itype="String" alert="">
							<input name="licno"  id="licno" type="text" itype="text" value="<%=map.getString("licno") %>"  class="enter" placeholder="License #" maxchar="100" >
						</td>
					</tr>
					
					<tr>
						<td class="csui_label"  align="right" colspan="4">
							<span class="button" onclick="resetSearch();">Reset</span>&nbsp;
							<input type="submit" name="action" value="Search"  class="csui_button" >
						</td>
					</tr>
				
				</table>
				
				
				</form>
				
				
			</div>
		</div>
		<div id="csuisub">
				<div class="csuisub_divider"></div>
				<div class="csuisubcontent">
				
				<table class="csuisub_title" alert="warning">
				<tr>
					<td class="csuisub_title">ITEMS IN CART</td>
				</tr>
				</table>
				
				<table class="csuisub sortable" type="horizontal" id="itemsadd" >
					
					
				</table>
				<div class="csuisub_divider"></div>
				<div class="csui_divider"></div>
				
				<table class="csuisub" type="horizontal">
						<tr>
							<td class="csui" align="right"> 
								<input type="submit" name="CHECKOUT" value="CHECKOUT" class="csui_button" onclick="checkout();">
							</td>
						</tr>
					</table>
				
				
				</div>
				<div class="csuisub_divider"></div>
				<div class="csui_divider"></div>
				
				
				
		</div>
	</div>




</body>
</html>

