<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.vo.SubObjVO"%>
<%@page import="csshared.utils.ObjMapper"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="csshared.vo.finance.FeesGroupVO"%>
<%@page import="csshared.vo.finance.StatementVO"%>
<%@page import="csshared.vo.finance.FeeVO"%>
<%@page import="csshared.vo.finance.FinanceVO"%>
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
<!--sunil  -->
<%

	
	Cartographer map = new Cartographer(request,response);
	RequestVO nav = new RequestVO();
	nav.setEntity(map.getString("_ent"));
	nav.setToken(map.token());
	nav.setType(map.getString("_type"));
	nav.setTypeid(map.getInt("_typeid"));
	nav.setId(map.getString("_id"));
	nav.setRequest("paymentdetails");
	nav.setIp(map.getRemoteIp());
	TypeVO cartsession = ObjMapper.toTypeObj(map.getString("_cartsession"));
	nav.setStatements(cartsession.getStatements());
	String mode = map.getString("mode","");
	int _trackId = map.getInt("_trackId",0);
	
	TypeVO o = ApiHandler.getType(nav);
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	
	//ToolsVO tools = o.getTools();


	//nav.setRequest("info");

	//TypeVO so = ApiHandler.getType(nav);
	
	//System.out.println(title+"ENTERED############"+nav.getId()+"--44--"+subtitle);
	
	RequestVO req = RequestMapper.getRequest(map);
	DecimalFormat fm = new DecimalFormat("#,###.00"); 
	
	
	
	//System.out.println("CART############"+map.getString("_cartsession"));

%>
<html>
<head>

	<title>City Smart</title>
	<%= CsUiTools.getHTMLImports() %>
	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>
	
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	

	<style>
		.csui_controls { visibility: hidden }
		
	
	input[type=button] {
		background-color: #eeeeee;
		border: 1px solid #cccccc;
		font-family: Oswald, Arial, Helvetica;
		text-transform: uppercase;
		padding: 10px;
		padding-left: 20px;
		padding-right: 20px;
		margin: 10px;
		font-size: 16px;
		font-weight: bold;
		border-radius: 5px;
		color: #000000;
		cursor: pointer;
	}
	
	input[type=button]:hover {
		background-color: #336699;
		color: #ffffff;
	}
	</style>
	

	
	
	<script language="JavaScript" src="<%=Config.fullcontexturl()%>/tools/jq/json2.js"></script>
	
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
	
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/toggleswitch/tinytools.toggleswitch.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/jquery.tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/inputmask.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/jquery.inputmask.js"></script>
	
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
	
	<script>
	
	$(document).ready(function() {
		
		<%if(Operator.hasValue(map.getString("_cartsession"))){%>
			var output=JSON.stringify(<%=map.getString("_cartsession")%>);
			$("#cart").val(output);
			displaycart();
			
			//highlightSelected(output);
			//highlightcart();
		<%}%>
		
		$('select:not([itype=boolean]):not([valrequired=true])').chosen({
			width:'100%',
			disable_search_threshold: 10,
			allow_single_deselect: true
		});
		$('select:not([itype=boolean])[valrequired=true]').chosen({
			width:'100%',
			disable_search_threshold: 10
		});
		
		//selectall
		$("#method").change(function () {
   			var val = $(this).val();
   			var option = $('option:selected', this).attr('deposit');
   			
   			if(option=="Y"){
				dochangecombined();
				$("#applydeposit").val("Y");
			}else {
				$("#combined").val("");
				
				var $el = $("#combined");
		    	$el.empty(); // remove old options
		    	$('#combined').trigger('chosen:updated');
		    	$("#applydeposit").val("N");
			}
   			//highlightcart();
			
		 });
		
		$("#payeeid").change(function () {
			var v = $(this).val();
			if(v==-1){
				$("#payeedetails").show();
			}else {
				$("#payeedetails").hide();
			}
			
			var res = v.split("_");
			
			var damount = parseFloat(res[2]);
			var amount = parseFloat($('#amount').val());
			
			if(amount>damount){
				swal("Can't use this option as the amount is greater than deposit/credit amount.");
				$(this).val("");
			}
			
		 });
		
		$("#combined").change(function () {
			var v = $(this).val();
			
			
			var res = v.split("_");
			
			var user = res[0];
			var pid = res[1];
			
			if(user=="USER"){
				$('#payeeid').val(pid);
				$('#payeeid').trigger('chosen:updated');
			}
			
			var damount = parseFloat(res[2]);
			var amount = parseFloat($('#paymentamount').val());
			var pids = res[4];
			//swal(damount+"--"+amount+"--"+pids);
			//if(amount>damount){
			if(damount>amount){	
				//swal("Can't use this option as the amount is greater than deposit/credit amount.");
				//$(this).val("");
				//var d = damount - amount;
				
				var output= $("#cart").val();
				output = JSON.parse(output);
 				var t = 0;	
 				$.each(output['statements'], function(k,v) {
	 				if(v.inputamount>0 && v.activityid==pids){
						t += v.inputamount;
					}	
 				});
 				$('#dpamount').val(t);
				
				$('#amount').val(t);
			}else {
				$('#amount').val(damount);
				$('#dpamount').val(damount);
				
			}
			highlightcart();
		 });
		
		$("#amount").change(function () {
   			highlightcart();
			
			
		 });
	
		
		
		//order
		$('#itemsadd').sortable({items: 'tr',
	
			update: function saveOrder(){
				var result = $('.sortable').sortable('toArray');
				var order ="";
				for (var i = 0; i < result.length; i++) {
					
					if(result[i]=='lista' || result[i]=='listt'){
						
					}else{
						order += result[i] + ",";
					}
				}
				//swal(order);
				if(order != ''){
					
					order = order.substring(0, order.length-1);
					var method = "ordercart";
					var ty ="{}";
					$.ajax({
						  type: "POST",
						  url: "action.jsp?_action="+method,
						  dataType: 'json',		  
						  data: { 
							 order : order
						    },
						    success: function(output) {
						    	output = JSON.stringify(output);
						    	$("#cart").val(output);
						    	displaycart();	
						    	
						    },
					    error: function(data) {
					        swal('Your request was not processed. Please check your input data.');
					    }
					});
				}
				else {
					return false;
				}
				
			}
		});
		
	});
	
	
	function addUser(choices) {
		try {
			var parray = choices.split('|');
			for (i = 0; i < parray.length; i++) { 
				var rec = parray[i];
				var arr = rec.split('::');
				if (arr.length > 0) {
					var id = arr[0];
					if (arr.length > 1) {
						var name = arr[1];
						populateUser(id, name);
					}
				}
			}
		} catch(e) { }
	}

	function populateUser(id, name) {
		$('#user_id').val(id);
		$('#user_name').html(name);
	}

	function doChange() {
		try {
			var amount = parseFloat($('#amount').val()).toFixed(2);
			var payment = parseFloat($('#payment').val()).toFixed(2);
			if (payment > amount) {
				//var t = formatThousands((payment - amount).toFixed(2))
				var t = payment - amount;
				 t = t.formatMoney(2, '.', ',')+'';
				$('#change').html('$'+t);
				
				
			}
			else {
				$('#change').html('0.00');
			}
		}
		catch (e) { }
	}
	
	function stringStartsWith(string, prefix) {
	    return string.slice(0, prefix.length) == prefix;
	}
	
	function dochangecombined(){
		var method = "depositpayees";
		var ty ="{}";
		$.ajax({
			  type: "POST",
			  url: "action.jsp?_action="+method,
			  dataType: 'json',		  
			  data: { 
				 cartjson : ty
			     // valuation : valuation,
			      //mode : mode
			    },
			    success: function(output) {
			    	output = JSON.stringify(output);
			    	//swal(output);
			    	output = JSON.parse(output);
			    	//console.log(output);
			    	var payees = output['depositcredits'];
			    	//swal(payees);
			    	var $el = $("#combined");
			    	$el.empty(); // remove old options
			    	$el.append($("<option></option>")
				    	    .attr("value", "").attr("amount", "0").text("Please select"));
			    	$.each(payees, function(k,v) {
			    		//swal(v.parentid);
			    		var type= "deposit";
			    		if(v.type==2) type= "credit";
			    		var value = v.level+"_"+v.parentid+"_"+v.amount+"_"+v.type+"_"+v.id;
			    		
			    		var txt = v.level+" "+v.typename+" $"+v.amount.toFixed(2)+" "+type;
			    		//swal(value+"-"+txt);
			    		
			    		$el.append($("<option></option>")
			    	    .attr("value", value).attr("amount", v.amount).text(txt));
			    	});
			    	
			    	$('#combined').trigger('chosen:updated');
			    },
		    error: function(data) {
		        swal(' Your request was not processed. Please check your input data.'+data);
		    }
		});
	}
	
	
	function clearcart(){
		
		var method = "clearcart";
		var ty ="{}";
		$.ajax({
			  type: "POST",
			  url: "action.jsp?_action="+method,
			  dataType: 'json',		  
			  data: { 
				 cartjson : ty
			     // valuation : valuation,
			      //mode : mode
			    },
			    success: function(output) {
			    	//output = JSON.stringify(output);
			    	
			    	//$("#cart").val(output);
			    	//displaycart();	
			    	refreshPage();
			    	
			    },
		    error: function(data) {
		        swal('Your request was not processed. Please check your input data.');
		    }
		});
	}
	
	function checkout(){
		document.forms[0].action = "payment.jsp?_ent=finance&_type=finance";
		document.forms[0].submit();
	}
	
	
	
	function deletecart(id){
		var method = "deletecart";
		if(confirm("Are you sure you want to delete this item?")){
		var ty ="{}";
		
			$.ajax({
				  type: "POST",
				  url: "action.jsp?_action="+method,
				  dataType: 'json',		  
				  data: { 
					 cartjson : id
				     // valuation : valuation,
				      //mode : mode
				    },
				    success: function(output) {
				    	//output = JSON.stringify(output);
				    	//$("#cart").val(output);
				    	//displaycart();	
				    	//$("input:checkbox").prop('checked', false);
				    	//highlightSelected(output);
				    	refreshPage();
				    	
				    },
			    error: function(data) {
			        swal('Your request was not processed. Please check your input data.');
			    }
			});
		}
	}
	
	function highlightSelected(output){
		output = JSON.parse(output);
		$.each(output['statements'], function(k,v) {
 			var pa = v.combined;
 			if(v.inputamount>0){
				$("#"+pa+"_inputamount").val(v.inputamount);
 			 }	
 			 $("#"+pa).prop("checked",true);
 			var groups = v.groups;	
 			$.each(groups, function(f,a) {
				var pag = a.combined;
 				if(a.inputamount>0){
 					$("#"+pag+"_inputamount").val(a.inputamount);
				}
 				 $("#"+pag).prop("checked",true);
 				var fees = a.fees;	
 				$.each(fees, function(g,j) {
 					var pagf =j.combined;
 	 				if(j.inputamount>0){
 	 					$("#"+pagf+"_inputamount").val(j.inputamount);
 					}
 	 				 $("#"+pagf).prop("checked",true);
 				});
 				
			});
				
 		});
	}
	
	function displaycart(){
		displaycartid(1);
	}
	
	function displaycartid(id){
		var output= $("#cart").val();
		//output = JSON.stringify(output);
 		//swal(output);
 		//console.log(output);
 		output = JSON.parse(output);
 		//swal(output['statements'].length);
 		var c = '';
 		c += '<tr id="lista">';
 		c += '<td class="csuisub_header">&nbsp;</td>';
		c += '<td class="csuisub_header">NUMBER</td>';
		c += '<td class="csuisub_header">AMOUNT</td>';
		c += '<td class="csuisub_header" width="1%">&nbsp;</td>';
		c += '<td class="csuisub_header" width="1%">&nbsp;</td>';
		c += '<td class="csuisub_header" width="1%">&nbsp;</td>';
		c += '</tr>';
		//c += '<table class="sortable">';
		//swal(id);
 		var t = 0;	
 		var it =0;
 		$.each(output['statements'], function(k,v) {
 			if(v.inputamount>0){
				t += v.inputamount;
				it++;
				c+= '<tr class="csuisub" id="list'+v.order+'" style="cursor:pointer;" >';
				if(id>0){
					c += '<td type="String" id="'+v.combined+'" itype="String" bgcolor="">&nbsp;</td>';
				}else {
					c += '<td type="String" id="'+v.combined+'" itype="String" bgcolor="'+v.highlight+'">&nbsp;</td>';
				}
		 		c += '<td class="csuisub" type="String" itype="String">'+v.activitynumber+'</td>';
		 		c += '<td class="csuisub" type="String" itype="String">$'+v.inputamount.toFixed(2)+'</td>';
		 		c += '<td class="csuisub"><a href="cart.jsp?_ent=finance&_type=finance&_id='+v.searched+'"> <img src="<%=Config.fullcontexturl() %>/images/icons/controls/black/edit.png" height="16" width="16" ></a></td>';
		 		c += '<td class="csuisub"><a href="#" onclick="deletecart(\''+v.combined+'\');" value="'+v.combined+'" > <img src="<%=Config.fullcontexturl() %>/images/icons/controls/black/delete.png" height="16" width="16" ></a></td>';
		 		c += '<td class="csuisub"> <img title ="Drag & drop to sort the items" src="<%=Config.fullcontexturl() %>/images/icons/controls/black/updown.png" height="16" width="16" ></td>';
		 		c += '</tr>';
		 		//console.log(c);
		 		
			}	
 		});
 		//c += '</table>';
 		//swal(t);
 		$('#itemsincart').val(it);
 		c += '<tr class="csuisub" id="listt">';
 		c += '<td class="csuisub" type="String" itype="String">&nbsp;</td>';
 		c += '<td class="csuisub" type="String" itype="String">TOTAL</td>';
 		c += '<td class="csuisub" type="String" colspan="4" itype="String">$'+t.toFixed(2)+'</td>';
 		
 		c += '</tr>';
 		
 		$("#itemsadd").html(c);
 		if(id>0){
 			$("#amount").val(t.toFixed(2));
 			$("#paymentamount").val(t.toFixed(2));
 		}
	}
	
	function refreshPage(){
		document.location.href = "payment.jsp?_ent=finance&_type=finance";
		
	}
	
	function highlightcart(){
		var method = "highlightcart";
		var m = $('#method').val();
		var dc = $('#combined').val(); 
		var amt = parseFloat($('#amount').val());
		var pamt = parseFloat($('#paymentamount').val()); 
		var applydeposit = ($('#applydeposit').val()); 
		var ty ="{}";
		if(!isNaN(amt)){
			$.ajax({
				  type: "POST",
				  url: "action.jsp?_action="+method,
				  dataType: 'json',		  
				  data: { 
					 m : m,
					 dc : dc,
					 amt :amt,
					 pamt : pamt,
					 applydeposit: applydeposit
				     // valuation : valuation,
				      //mode : mode
				    },
				    success: function(output) {
				    	output = JSON.stringify(output);
				    	$("#cart").val(output);
				    	displaycartid(0);	
				    //	$("input:checkbox").prop('checked', false);
				    //	highlightSelected(output);
				    	
				    },
			    error: function(data) {
			        swal('Your request was not processed. Please check your input data.');
			    }
			});
		}
	}
	
	function validatePage(){
	
		var m = $('#method').val();
		var payee = $('#payeeid').val();
		var payeetxt = $('#payee').val();
		var a = $('#number').val();
		var dc = $('#combined').val(); 
		var amt = parseFloat($('#amount').val());
		var pamt = parseFloat($('#paymentamount').val()); 
		var dpamt = parseFloat($('#dpamount').val()); 
		var applydeposit = $('#applydeposit').val(); 
		
	
		
		
		
		if(dc!="" && applydeposit=="Y"){
			var res = dc.split("_");
			var user = res[0];
			var pid = res[1];
			
			if(user=="USER"){
				if($('#payeeid').val()!=pid){
					swal("Error","Please select the correct deposit payee","error");
					$('#payeeid').focus();
					return false;
				}
			}
		}
		
		
		
		//swal(pamt);
		//swal(amt);
		if(m==''){
			swal("Please select the method of payment");
			$('#method').focus();
			return false;
		}
		
		if( m!=1 && applydeposit=="N" && a==""){
			swal("Please enter the acc/chq number");
			$('#number').focus();
			return false;
		}
		
	
		if(payee==""){
			swal("Please select payee");
			$('#payeeid').focus();
			return false;
		}
		
		if(payee=="-1" && payeetxt==""){
			swal("Please enter the payee info");
			$('#payee').focus();
			return false;
		}
		
		if(payee=="-1" && $('#user_id').val()==""){
			swal("Please select other payee");
			$('#payeeid').focus();
			return false;
		}
		
		if(applydeposit=="Y" && dc==""){
			swal("Please choose the deposit/credits ");
			$('#combined').focus();
			return false;
		}
		if(isNaN(amt)){
			swal("Please enter the amount");
			$('#amount').focus();
			return false;
		}	
		
		if(applydeposit=="Y" && amt>dpamt){
			swal("Can't use the deposit amount greater than criteria met.Reverting the amount ");
			$('#combined').val("");
			$('#amount').focus();
			return false;
		}
		
		if(amt>pamt){
			swal("Payment amount can't be greater than the total amount in the cart.");
			$('#amount').focus();
			return false;
		}
		
		
		if(amt<=0){
			swal("Payment amount can't be $0.00.");
			$('#amount').focus();
			return false;
		}
		
		if($('#itemsincart').val()<=0){
			swal("Items in the cart is empty");
			return false;
		}
		
		
		$('#payfees').val('Payment processing Please wait ...');
		$('#payfees').prop('disabled',true);
		$('#csform').submit();

		
		
		
		return true;
	}
	
	
	Number.prototype.formatMoney = function(c, d, t){
		var n = this, 
		    c = isNaN(c = Math.abs(c)) ? 2 : c, 
		    d = d == undefined ? "." : d, 
		    t = t == undefined ? "," : t, 
		    s = n < 0 ? "-" : "", 
		    i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))), 
		    j = (j = i.length) > 3 ? j % 3 : 0;
		   return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
		 };
	
	</script>
</head>

<body alert="<%= alert %>">
	<div id="csuicontrols">
		<div id="csuicontrol" class="csuicontrol <%= alert %>">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="left" class="csuicontrol">PAYMENTS</td>
					<td align="right"><%= ObjUi.tools(o.getTools(), "csui") %>
					<table class="csui_tools">
						<tr>
							<td class="csui_tools">
								<a href="#" onclick="history.back();"><img src="/cs/images/icons/controls/white/back.png" height="25" width="25" border="0"/></a>
							</td>
						</tr>
						
						
					</table>
					
					
					</td>
				</tr>
			</table>
		</div>
		<div id="csuisubcontrol" class="csuisubcontrol <%= alert %>">CART</div>
	</div>
	<div id="csuibody">
		<div id="csuimain">
		
			<div class="csuicontent">
				<form id="csform" class="form" action="action.jsp" ajax="no" method="post">
				<input type="hidden" name="_grptype" value="finance" >
				<input type="hidden" name="_type" value="finance" >
				<input type="hidden" name="_ent" value="finance" >
				<input type="hidden" id="cart" name="cart" value="0" >
				<input type="hidden" name="_action" value="payment" >
				<input type="hidden" name="_act" value="payment" >
				<input type="hidden" name="transactiontype" value="1" >
				<input type="hidden" name="applydeposit" id="applydeposit" value="N" >
				<input type="hidden" name="dpamount" id="dpamount" value="0" >
				<input type="hidden" name="itemsincart" id="itemsincart" value="0" >
				<input type="hidden" name="mode" id="mode" value="<%=mode %>" >
				<input type="hidden" name="_trackId" id="_trackId" value="<%=_trackId %>" >
				
						<div class="csui_divider"></div>
						
					<table class="csui_title" alert="warning">
						<tr>
							<td class="csui_title">TRANSACTION MANAGER</td>
						</tr>
					</table>
					<table class="csui" colnum="2" type="default">
						<tr>
							<td class="csui_label" colnum="2" alert="">METHOD</td>
							<td class="csui" colnum="2" type="String" itype="text" alert="">
								<select name="method" id="method" itype="String" val="" _ent="finance" valrequired="true">
									<option value="">Please Select</option>
									<%
									SubObjVO[] methods = o.getPayment()[0].getMethods();
										for(int i=0;i<methods.length;i++){
									%>
									<option cashflag="<%=methods[i].getItype() %>"  value="<%=methods[i].getId() %>" deposit="<%=methods[i].getValue() %>"><%=methods[i].getText() %></option>
									<% }%>
								
								</select>
							
							</td>
							<td class="csui_label" colnum="2" alert="">ACC/CHQ NUMBER</td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><input name="number" id="number" type="text" itype="text" value="" ></td>
						</tr>
						
						<tr>
							<td class="csui_label" colnum="2" alert="">PAID BY</td>
							<td class="csui" colnum="2" type="String" itype="String" alert="">
								<select name="payeeid" id="payeeid" itype="String" val="" _ent="finance" valrequired="true">
									<option value="">Please Select</option>

									<%SubObjVO[] payees = o.getPayment()[0].getPayees();
										for(int i=0;i<payees.length;i++){
									%>

									<option value="<%=payees[i].getValue() %>"><%=payees[i].getText() %></option>

									<% }%>
									<option value="-1">Other</option>


								</select>
							
							</td>
							<td class="csui_label" colnum="2" alert="">DEPOSIT / CREDITS</td>
							<td class="csui" colnum="2" type="String" itype="String" alert="">
							<input  name="counter" type="hidden" value="1" >
								<select name="combined" id="combined" itype="String" val="" _ent="finance" valrequired="false">
									<option value="">Please Select</option>
									
								
								</select>
							
							</td>
						</tr>
						
						<tr id="payeedetails" style="display:none;">
							<td class="csui_label" colnum="2" alert="">
								PAID BY (OTHER)
							</td>
							<td alert="" style="padding: 0px">
								<table cellpadding="0" cellspacing="5" border="0" bgcolor="#ffffff" style="border: 0px">
									<tr>
										<td class="csui" colnum="2" type="String" itype="text" id="user_name" width="99%"></td>
										<td width="1%" nowrap><a target="lightbox-iframe" href="<%=Config.fullcontexturl() %>/users.jsp?_id=0&_entid=<%= map.getString(RequestMapper.entityid) %>&_ent=<%= map.getString(RequestMapper.entity) %>&_typeid=-1&_type=finance&_grpid=users&_grp=users&_grptype=users"><img src="/cs/images/icons/controls/black/add.png" height="25" width="25" border="0"/></a></td>
									</tr>
								</table>
							</td>
							<td class="csui_label" colnum="2" alert="">&nbsp;</td>
							<td class="csui" colnum="2" type="String" itype="String" alert="">&nbsp;</td>
						</tr>
						
						<tr>
							<td class="csui_label" colnum="2" alert="" rowspan="3">COMMENTS</td>
							<td class="csui" colnum="2" type="String" itype="text" alert="" rowspan="3" valign="top"><textarea name="comment" itype="textarea"></textarea></td>
							<td class="csui_label" colnum="2" alert="">AMOUNT PAID</td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><input name="amount"  id="amount" type="text" itype="text" value="" onchange="doChange()">
							<input name="paymentamount"  id="paymentamount" type="hidden" itype="text" value="0.00" valrequired="true"></td>
						</tr>
						
						<tr>
							<td class="csui_label" colnum="2" alert="">PAYMENT RECIEVED</td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><input name="paymentrec"  id="payment" type="text" itype="text" value="" onchange="doChange()"></td>
						</tr>

						<tr>
							<td class="csui_label" colnum="2" alert="">CHANGE</td>
							<td class="csui" colnum="2" type="String" itype="text" alert="" id="change" style="font-size: 20px; font-weight: bold" align="right"></td>
						</tr>

					</table>
						
					<div class="csui_divider"></div>
						<div class="csui_buttons" id="paybtns" >
<!-- 							<input type="button" name="reset" value="RESET" class="csui_button" onclick="refreshPage();"> -->
							<input type="submit" name="payfees" value="PAY" id="payfees" class="csui_button" onclick="return validatePage();" >
						</div>

					 <input name="payee" id="user_id" type="hidden" value=""> 
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
							<td class="csui" align="right"> <input type="button" name="addcart" value="Clear Cart" class="csui_button" onclick="clearcart();">
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

