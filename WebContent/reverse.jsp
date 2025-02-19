<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.vo.SubObjVO"%>
<%@page import="csshared.vo.finance.PaymentVO"%>
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
	nav.setRequest("paymentlist");

	
	TypeVO o = ApiHandler.getType(nav);
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	
	//ToolsVO tools = o.getTools();


	//nav.setRequest("info");

	//TypeVO so = ApiHandler.getType(nav);
	
	//System.out.println(title+"ENTERED############"+nav.getId()+"--44--"+subtitle);
	
	//RequestVO req = RequestMapper.getRequest(map);
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
		$(".loadhide").hide();
		
		
		
		
		
		//selectall
		$("#selectall").change(function () {
   			 $("input:checkbox").prop('checked', $(this).prop("checked"));
   			  calculateamount();
		 });
		
		$(".paymentcheck").change(function () {
  			var v = $(this).val();
  			var amount = $('#'+v+"_amount").val();
  			$('#paymentidhtml').html(v);
  			$('#amounthtml').html("$-"+amount);
  			$('#transactionmethod').val("")
  			
  			$('#paymentid').val(v);
  			$('#amount').val("-"+amount);
  			
			//$('[id^='+v+']').prop('checked', $(this).prop("checked"));
			
		 });
		
		$(".projectcheck").change(function () {
  			var v = $(this).val();
			$('[id^='+v+']').prop('checked', $(this).prop("checked"));
			calculateamount();
		 });
		
		$(".groupcheck").change(function () {
  			var v = $(this).val();
  			//alert(v);
  			$('[id^='+v+']').prop('checked', $(this).prop("checked"));
  			
  			
  			var c = $("#"+v+"_count").val()
  			var g = $("#"+v+"_count").attr("group");
  			var gp = 0;
  			//alert(c);
  			var l1 = false;
  			
  			$("input[type='checkbox'][id^='"+g+"']" ).each(function () {
  	  			var gv = $(this).val();
  	  			//alert("inside"+gv+"--"+g);
  	  			if(gv!=g){
	  	  			if($(this).prop("checked")){
	  	  				if(!l1){
	  	  					l1=true;
	  	  				
	  	  				}
	  	  				
	  	  			}
  	  			}
  	  		 });
  			
  			$("input[type='checkbox'][name^='"+g+"']" ).each(function () {
  	  			var gv = $(this).val();
  	  			var classname = $(this).attr("class");
  	  			//alert(gv +"--"+$(this).prop("checked")+"---"+classname);
  	  			if($(this).prop("checked") && classname=='groupcheck'){
  	  				gp = gp+1;
  	  			}
  			 });
  			
  			//alert("gg"+g+"-"+c+"-"+gp+"-"+l1);
			if(l1){ $("#"+g).prop("checked",true); } else { $("#"+g).prop("checked",false);  }
			if(gp==0){
  				
  				$("#"+g+"_checkbox").css({"background-color": "white"});
  			}
  			else if(gp<c) {  $("#"+g+"_checkbox").css({"background-color": "yellow"});  }
  			else if(gp==c) {  $("#"+g+"_checkbox").css({"background-color": "white"});  }
			calculateamount();
		 });
		
		$(".groupfeescheck").change(function () {
  			var v = $(this).val();
  			//alert(v);
  			//group 
  			var c = $("#"+v+"_count").val()
  			var g = $("#"+v+"_count").attr("group");
  			var gp = 0;
  			//alert(g);
  			var l1 = false;
  			$("input[type='checkbox'][name^='"+g+"']" ).each(function () {
  	  			var gv = $(this).val();
  	  			
  	  			//alert(gv +"--"+$(this).prop("checked"));
  	  			if($(this).prop("checked") && l1){
  	  				gp = gp+1;
  	  			}
  	  			if(!l1){
	  				l1 = true;
	  			}
  			 });
			
			//alert(c+"_"+gp);
			//var ph = false;
  			if(gp==0){
  				$("#"+g).prop('checked',false);
  				$("#"+g+"_checkbox").css({"background-color": "white"});
  			}
  			else if(gp<c) {  $("#"+g+"_checkbox").css({"background-color": "yellow"}); $("#"+g).prop('checked',true); }
  			else if(gp==c) {  $("#"+g+"_checkbox").css({"background-color": "white"}); $("#"+g).prop('checked',true); }
  			
  			
  			//parent
  			
  			var c = $("#"+g+"_count").val()
  			var g = $("#"+g+"_count").attr("group");
  			var gp = 0;
  			
  			var l1 = false;
  			$("input[type='checkbox'][name^='"+g+"']" ).each(function () {
  	  			var gv = $(this).val();
  	  			var classname = $(this).attr("class");
  	  			//alert(gv +"--"+$(this).prop("checked")+"---"+classname);
  	  			if($(this).prop("checked") && classname=='groupcheck'){
  	  				gp = gp+1;
  	  			}
  			 });
			
  			//alert("ppp"+g+"-"+c+"-"+gp);
  			if(gp==0){ 	$("#"+g).prop('checked',false);	$("#"+g+"_checkbox").css({"background-color": "white"});  }
  			else if(gp<c) {  $("#"+g+"_checkbox").css({"background-color": "yellow"}); 	$("#"+g).prop('checked',true); }
  			else if(gp==c) {  $("#"+g+"_checkbox").css({"background-color": "white"}); 	$("#"+g).prop('checked',true); }
  			
  			
  			
  			calculateamount();
  			
			
		 });
		
		//inputamount
		$(".inputamount").change(function () {
  			var v = parseFloat($(this).val());
  			var bd = parseFloat($(this).attr("bd"));
  			var parent = $(this).attr("parent");
  			var group = $(this).attr("group");
  			var itype = $(this).attr("itype");
			//alert(v+"_"+bd+"_"+parent+"_"+group+"_"+itype);
			var change = true;
			if(v>bd){
				alert("Input amount is greater than balance due reverting back to original");
				$(this).val(bd.toFixed(2));
				change = false;
			}
			
			if(change){
				if(itype=='group'){
						var t = v;
						var count = $(this).attr("lid");
						var inp = parseFloat(t/count);
						$("input[type='checkbox'][name^='"+group+"']" ).each(function () {
			  	  			var gv = $(this).val();
			  	  			var classname = $(this).attr("class");
			  	  			if(classname=='groupfeescheck'){
			  	  				var fbd = parseFloat($("#"+gv+"_inputamount").attr("bd"));
			  	  				if(inp<fbd){
			  	  					$(this).prop("checked",true);
			  	  					$("#"+gv+"_inputamount").val(inp.toFixed(2));
			  	  				}
			  	  			}
			  	  			
			  			 });
						$("#"+group).prop("checked",true);
						$("#"+parent).prop("checked",true);
				}
				
				
				if(itype=='pa'){
					var t = v;
					var count = $(this).attr("lid");
					var inp = parseFloat(t/count);
					$("input[type='checkbox'][name^='"+parent+"']" ).each(function () {
		  	  			var gv = $(this).val();
		  	  			var classname = $(this).attr("class");
		  	  			if(classname=='groupcheck'){
		  	  				
			  	  			var gbd = parseFloat($("#"+gv+"_inputamount").attr("bd"));
		  	  				if(inp<gbd){
		  	  				
			  	  				$(this).prop("checked",true);
			  	  				$("#"+gv+"_inputamount").val(inp.toFixed(2));
			  	  				
			  	  				var fcount = $("#"+gv+"_inputamount").attr("lid");
			  	  				//alert(inp+"##"+fcount);
			  	  				var finp =  parseFloat(inp/fcount);
			  	  				var n = $(this).val();
			  	  				
			  	  				$("input[type='checkbox'][name^='"+n+"']" ).each(function () {
					  	  				var gv = $(this).val();
						  	  			var classname = $(this).attr("class");
						  	  			if(classname=='groupfeescheck'){
						  	  				var fbd = parseFloat($("#"+gv+"_inputamount").attr("bd"));
						  	  				if(finp<fbd){
							  	  				$(this).prop("checked",true);
							  	  				$("#"+gv+"_inputamount").val(finp.toFixed(2));
							  	  			}
						  	  			}
			  	  				
			  	  				 });
		  	  				}
		  	  			}
		  	  			
		  			 });
					$("#"+parent).prop("checked",true);
				}
				
				//calculateamount();
				
			}
			
			
			
		 });
		
	});
	
	
	function calculateamount(){
		//TODO proper calcualte discuss with alain
		$(".projectcheck").each(function(){
			 var pat =0.00;	
			 var pa = $(this).val();
			 
			 if($(this).is(':checked')){
			
				 $(".groupcheck").each(function(){
			 			var pagt =0.00;
			 			var pag = $(this).val();
			 			if($(this).is(':checked')){
			 				
			 				
							 if(stringStartsWith(pag,pa)){
								 var pagft =0.00;
								 $(".groupfeescheck").each(function(){
										
										if($(this).is(':checked')){
											 var pagf = $(this).val();
											 if(stringStartsWith(pagf,pag)){
												 var pagfinput = $("#"+pagf+"_inputamount").val();
												 pagt = pagt + parseFloat(pagfinput);
											 }
										 }
									 });
								 $("#"+pag+"_inputamount").val(pagt.toFixed(2));
								 	var paginput = $("#"+pag+"_inputamount").val();
								 	pat = pat + parseFloat(paginput);	
							 }
							
							 
							 	
						 }	
					});
			 		
			 }
			 	
			$("#"+pa+"_inputamount").val(pat.toFixed(2));
			 
			 
			
			
		});
 		
	}
	
	function stringStartsWith(string, prefix) {
	    return string.slice(0, prefix.length) == prefix;
	}
	
	//function showchildgroup(id){
	//	$("#show_"+id).toggle();
	//}
	
	//function showchild(id){
	//	$("#show_"+id).toggle();
	//}
	
	
	function reversePayment(){
		var t = 0;
		var type = {};
		var payments = [];	
		var statements = [];	
		var d ="";
		$(".paymentcheck").each(function(){
			
			 if($(this).is(':checked')){
				
				 var pay = $(this).val();
				// t += +$("#"+pa+"_inputamount").val();
				
				d += "{";
		  	    d += "\"paymentid\":"+$('#paymentid').val()+",";
		  	  	d += '\"method\":"'+$('#transactionmethod').val()+'",';
		  	  	d += "\"amount\":"+$('#amount').val()+",";
		  	  	d += '\"comment\":"'+$('#comment').text()+'",';
		  	    	
		 		//d += '\"groups\":[';
		 		//d += feegroup;
	      		//d += ']';
		 		
		 		
		 		d += "}"; 
		 		
			
			 }
			
			
			
		});
		
		var ty = "{";
		 ty += "\"_type\":\"finance\",";
		 ty += '\"payment\":';
		 ty += d;
 		 ty += "}"; 
		 console.log(ty);
		 alert(ty);
		var method = "reverse";
		$.ajax({
			  type: "POST",
			  url: "action.jsp?_action="+method,
			  dataType: 'json',		  
			  data: { 
				 reversejson : ty
			     // valuation : valuation,
			      //mode : mode
			    },
			    success: function(output) {
			    	//output = JSON.stringify(output);
			    	//$("#cart").val(output);
			    	
			    	
			    },
		    error: function(data) {
		        alert('Your request was not processed. Please check your input data.');
		    }
		});
		 
		//$("#cart").val(ty);
		
		
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
			    	output = JSON.stringify(output);
			    	
			    	$("#cart").val(output);
			    	displaycart();	
			    	
			    },
		    error: function(data) {
		        alert('Your request was not processed. Please check your input data.');
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
				    	output = JSON.stringify(output);
				    	$("#cart").val(output);
				    	displaycart();	
				    	$("input:checkbox").prop('checked', false);
				    	highlightSelected(output);
				    	
				    },
			    error: function(data) {
			        alert('Your request was not processed. Please check your input data.');
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
		var output= $("#cart").val();
		//output = JSON.stringify(output);
 		//alert(output);
 		//console.log(output);
 		output = JSON.parse(output);
 		//alert(output['statements'].length);
 		var c = '<tr >';
		c += '<td class="csuisub_header">ACTIVITY</td>';
		c += '<td class="csuisub_header">AMOUNT</td>';
		c += '<td class="csuisub_header" width="1%">&nbsp;</td>';
		c += '<td class="csuisub_header" width="1%">&nbsp;</td>';
		c += '</tr>';
		
 		var t = 0;	
 		$.each(output['statements'], function(k,v) {
 			if(v.inputamount>0){
				t += v.inputamount;
				
				c+= '<tr class="csuisub">';
		 		c += '<td class="csuisub" type="String" itype="String">'+v.activitynumber+'</td>';
		 		c += '<td class="csuisub" type="String" itype="String">$'+v.inputamount.toFixed(2)+'</td>';
		 		c += '<td class="csuisub"><a href="cart.jsp?_ent=finance&_type=finance&_id='+v.searched+'"> <img src="<%=Config.fullcontexturl() %>/images/icons/controls/black/edit.png" height="16" width="16" ></a></td>';
		 		c += '<td class="csuisub"><a href="#" onclick="deletecart(\''+v.combined+'\');" value="'+v.combined+'" > <img src="<%=Config.fullcontexturl() %>/images/icons/controls/black/delete.png" height="16" width="16" ></a></td>';
		 		c += '</tr>';
		 		//console.log(c);
		 		
			}	
 		});
 		
 		//alert(t);
 		
 		c += '<tr class="csuisub">';
 		c += '<td class="csuisub" type="String" itype="String">TOTAL</td>';
 		c += '<td class="csuisub" type="String" colspan="3" itype="String">$'+t.toFixed(2)+'</td>';
 		
 		c += '</tr>';
 		
 		$("#itemsadd").html(c);
 		
		
	}
	
	function paymentlist(){
		document.forms[0].action = "cart.jsp?_ent=finance&_type=finance&_id=<%=nav.getId()%>";
		document.forms[0].submit();
	}
	
	function showchildgroup(id){
		$("#show_"+id).toggle();
		showPayment(id);
	}
	
	function showchild(id){
		$("#show_"+id).toggle();
		showPayment(id);
	}
	
	
	
	
	function showPayment(id){
		//alert(id);
		var method = "showledger";
		var ty ="{}";
		$.ajax({
			  type: "POST",
			  url: "action.jsp?_action="+method,
			  dataType: 'json',		  
			  data: { 
				 cartjson : ty,
			  	  _ent : "<%=nav.getEntity()%>",
				 _type:"finance",
			      P_ID : id
			      //mode : mode
			    },
			    success: function(output) {
			    	displayledger(output,id);
			    	
			    },
		    error: function(data) {
		        alert('Your request was not processed. Please check your input data.');
		    }
		});
	}
	
	
	

	function displayledger(output,id){
		output = JSON.stringify(output);
		output = JSON.parse(output);
		
		var c='';
		c += '<td colspan="8" >';
		c += '	<table class="csui" width="100%" >';
		c += '		<tr>';
		c += '			<td class="csui_header" colspan="2" align="right">&nbsp;</td>';
		c += '			<td class="csui_header" colspan="2" align="center">FEE</td>';
		c += '			<td class="csui_header">AMOUNT</td>';
		c += '			<td class="csui_header">PAID</td>';
		//c += '			<td class="csui_header">BALANCE DUE</td>';
		c += '			<td class="csui_header" width="1%">&nbsp;</td>';
		c += '			<td class="csui_header" width="1%">&nbsp;</td>';
		c += '		</tr>';
		c += '';
		
		
		$.each(output['fees'], function(k,v) {
			c += '		<tr>';
			c += '			<td class="csui" colspan="2" align="right">&nbsp;</td>';
			c += '			<td class="csui_header" colspan="2" align="center">'+v.name+'</td>';
			c += '			<td class="csui">'+v.amount+'</td>';
			c += '			<td class="csui">'+v.paidamount+'</td>';
			//c += '			<td class="csui">'+v.balancedue+'</td>';
			c += '			<td class="csui" width="1%" >&nbsp;</td>';
			c += '			<td class="csui_header" width="1%">&nbsp;</td>';
			c += '		</tr>';
		
 		});
		
	
		c += '';
		c += '	</table>';
		c += '</td>';
		
		$("#show_"+id).html(c);
		
	}
	
	</script>
</head>

<body alert="<%= alert %>">
	<div id="csuicontrols">
		<div id="csuicontrol" class="csuicontrol <%= alert %>">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="left" class="csuicontrol">REVERSE</td>
					<td align="right"><%= ObjUi.tools(o.getTools(), "csui") %></td>
				</tr>
			</table>
		</div>
		<div id="csuisubcontrol" class="csuisubcontrol <%= alert %>">&nbsp;</div>
	</div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
				<form id="csform" class="form" ajax="no" action="action.jsp" method="post">
				<input type="hidden" name="_act" value="reverse" >
				<input type="hidden" name="_grptype" value="finance" >
				<input type="hidden" name="_ent" value="lso" >
				<input type="hidden" name="_type" value="finance" >
				<input type="hidden" name="_typeid" value="0" >
				<input type="hidden" name="entity" value="finance" >
				<input type="hidden" id="cart" name="cart" value="0" >
				<input type="hidden" name="_action" value="reverse" >
				<input type="hidden" name="_ref" value="<%=o.getType() %>" >
				
						<div class="csui_divider"></div>
						<div class="csui_buttons">
						<!--	<input type="submit" name="reset" value="reset" class="csui_button" onclick="resetFees();">-->
					<!--		<input type="button" name="reverse" value="Payment Mode" class="csui_button" onclick="paymentlist();"> -->
						</div>
						
					<table class="csui" type="horizontal" >
						<tr>
							<td class="csui_header">&nbsp;</td>
							<td class="csui_header">REF NUMBER</td>
							<td class="csui_header">DATE</td>
							<td class="csui_header">METHOD</td>
							<td class="csui_header">TYPE</td>
							<td class="csui_header">AMOUNT</td>
							<td class="csui_header">PAID BY</td>
							<td class="csui_header">ONLINE</td>
							<td class="csui_header">&nbsp;</td>
							<td class="csui_header" width="1%">&nbsp;</td>
						</tr>
					<%
					 //int  = 	o.getStatements().length;
					for(int l=0;l<o.getPayment().length;l++){ 
						PaymentVO p = o.getPayment()[l];
						String pap = p.getPaymentid()+"";
						//String searched = p.getOnline();
					%>
					
					
						<tr>
							<td class="csui"  id="<%=pap %>_checkbox" >
							<%if(p.getRevpaymentid()==0){ %>
							<input type="radio" name="payment" class="paymentcheck" id="payment" value="<%=pap %>" > 
							<input type="hidden" name="<%=pap %>_amount"  id="<%=pap %>_amount" value="<%=p.getRevamount() %>" >
							<input type="hidden" name="payeeid"  id="payeeid" value="<%=p.getPayeeid() %>" >
							<%}else { %>
							&nbsp;
							<%} %> 
							</td>
							
							<td class="csui"><%=p.getPaymentid() %></td>
							
							<td class="csui"><%=p.getPaymentdate() %></td>
							<td class="csui"><%=p.getMethodname() %></td>
							<td class="csui"><%=p.getTransactiontypename() %></td>
							<td class="csui">$<%=fm.format(p.getRevamount()) %></td>
							<td class="csui"><%=p.getOtherpayeename() %></td>
							<td class="csui"><%=p.getOnlinetranasactionnumber() %></td>
							<td class="csui">&nbsp;</td>
							<td class="csui" width="1%"><a href="javascript:void(0);" onclick="showchildgroup(<%=p.getPaymentid()%>);"> <img src="<%=Config.fullcontexturl() %>/images/icons/controls/black/downarrow.png" height="16" width="16" ></a></td>
							
							
						</tr>
						<tr id="show_<%=p.getPaymentid() %>" style="display:none;">
							
						</tr>	
					
					<%} %>
					</table>	
					
					
				<div class="csui_divider"></div>
				<div class="csui_divider"></div>	
				<table class="csuisub_title" alert="warning">
					<tr>
						<td class="csuisub_title">TRANSACTION MANAGER</td>
					</tr>
				</table>
				
				<table class="csuisub" type="horizontal" id="itemsadd">
					<tr>
						<td class="csuisub_header">TRANSACTION NO
							<input type="hidden" name="paymentid"  id="paymentid" value="0" > 
							<input type="hidden" name="amount"  id="amount" value="0" > 
						</td>
						<td class="csui" id="paymentidhtml">0</td>
					</tr>
					<tr>
						<td class="csuisub_header">RETURN METHOD</td>
						<td class="csui">
						<select name="method" itype="String" val="" _ent="finance" valrequired="true" id="transactionmethod">
							<option value="">Please Select</option>
							
							<%
					
							for(int l=0;l<o.getPayment().length;l++){ 
							PaymentVO p = o.getPayment()[l];
							
							
					
							%>	
								<%
									SubObjVO[] methods = p.getMethods();
										for(int i=0;i<methods.length;i++){
									%>
										<option value="<%=methods[i].getId() %>"><%=methods[i].getValue() %></option>
									<% }%>
							
							<%
							}%>
						</select>
							
						</td>
					</tr>
					<tr>	
						<td class="csuisub_header">AMOUNT</td>
						<td class="csui" id="amounthtml">$0.00</td>
					</tr>
					<tr>
						<td class="csuisub_header" width="1%">&nbsp;</td>
						<td class="csui" width="1%">&nbsp;</td>
					</tr>
					
					<tr>
						<td class="csuisub_header">COMMENT</td>
						<td class="csui"> <textarea name="comment" id="comment" rows="5" cols="40"></textarea></td>
					</tr>
					
					
					
				</table>
				<div class="csui_buttons">
					 	<input type="submit" name="CHECKOUT" value="REVERSE" class="csui_button" >  
					
					</div>
				
				<div class="csuisub_divider"></div>
				<div class="csui_divider"></div>
				<table class="csuisub" type="horizontal">
					
				</table>
				</form>
			</div>
		</div>
		<div id="csuisub">
				<div class="csuisub_divider"></div>
				<div class="csuisubcontent">
				
				<div class="csuisub_divider"></div>
				<div class="csui_divider"></div>
		</div>
	</div>




</body>
</html>

