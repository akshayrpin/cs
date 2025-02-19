<%@page import="cs.ui.CsUiTools"%>
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

	
	Cartographer map = new Cartographer(request,response,true);

	boolean ta = UiAgent.tabAccess("finance", map.token(), map.getRemoteIp());
	if (!ta) { map.forward("403.jsp"); }

	RequestVO nav = new RequestVO();
	nav.setEntity(map.getString("_ent"));
	nav.setToken(map.token());
	nav.setType(map.getString("_type"));
	nav.setTypeid(map.getInt("_typeid"));
	nav.setId(map.getString("_id"));
	nav.setRequest("cart");
	nav.setIp(map.getRemoteIp());
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
	
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	
	<script language="JavaScript" src="<%=Config.fullcontexturl()%>/tools/jq/json2.js"></script>
	
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.qrcode-mini.js"></script>
	<style>
	
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

	td[prntid] {
		cursor: pointer;
		background: url(<%=Config.fullcontexturl() %>/images/arrow-down-black.png) center no-repeat #fff;
		width: 15px;
	}
	td[prntid].prntactive {
		background: url(<%=Config.fullcontexturl() %>/images/arrow-up-white.png) center no-repeat #336699 !important;
		width: 15px !important;
	}

	td[feeid] {
		cursor: pointer;
		background: url(<%=Config.fullcontexturl() %>/images/arrow-down-black.png) center no-repeat #d7e1eb;
		width: 15px;
	}
	td[feeid].feeactive {
		background: url(<%=Config.fullcontexturl() %>/images/arrow-up-white.png) center no-repeat #b98f59 !important;
		width: 15px !important;
	}

	.csui.prntactive1 {
		background-color: #d7e1eb !important;
	}

	.csui_header.fee {
		color: #ffffff !important;
		background-color: #336699 !important;
	}
	.csui.fee {
		background-color: #A3CEE8 !important;
	}

	.csui.feeactive1 {
		background-color: #d7ebda !important;
	}

	.csui_header.child {
		color: #ffffff !important;
		background-color: #805939 !important;
	}
	.csui.child {
		background-color: #E1DF86 !important;
	}

	</style>
	<script>
	
	$(document).ready(function() {
		$(".loadhide").hide();
		
		<%if(Operator.hasValue(map.getString("_cartsession"))){%>
			var output=JSON.stringify(<%=map.getString("_cartsession")%>);
			$("#cart").val(output);
			displaycart();
			highlightSelected(output);
		<%}%>
		
		$('.prntSelector').click(function() {
			var stid = $(this).attr('prntid');
			if ($(this).hasClass('prntactive')) {
				$(this).removeClass('prntactive');
				$('[rel=prnt_'+stid+']').removeClass('prntactive');
			}
			else {
				$(this).addClass('prntactive');
				$('[rel=prnt_'+stid+']').addClass('prntactive');
			}
			showfee(stid);
		});

		$('.feeSelector').click(function() {
			var stid = $(this).attr('feeid');
			if ($(this).hasClass('feeactive')) {
				$(this).removeClass('feeactive');
				$('[rel=fee_'+stid+']').removeClass('feeactive');
			}
			else {
				$(this).addClass('feeactive');
				$('[rel=fee_'+stid+']').addClass('feeactive');
			}
			showfee(stid);
		});

		//selectall
		$("#selectall").change(function () {
   			 $("input:checkbox").prop('checked', $(this).prop("checked"));
   			  calculateamount();
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
						$("input[type='checkbox'][name^='"+group+"']" ).each(function () {
			  	  			var gv = $(this).val();
			  	  			var classname = $(this).attr("class");
			  	  			
			  	  			if(classname=='groupfeescheck'){
			  	  				if($(this).is(':checked')){
			  	  					var fbd = parseFloat($("#"+gv+"_inputamount").attr("bd"));
							
			  	  					if(fbd>=t){
										$("#"+gv+"_inputamount").val(t.toFixed(2));
										t = 0;
									}else {
										var ft = t-fbd;
										t = t-fbd;
										$("#"+gv+"_inputamount").val(fbd.toFixed(2));
									}
			  	  					
									
			  	  				}
			  	  			}
			  	  			
			  			 });
						
						
						if(t==v){
							alert("can't change the value as fee in the group is not checked");
							$(this).val(bd.toFixed(2));
							$("#"+group).prop("checked",false);
							$("#"+parent).prop("checked",false);
						} else if(t!=0 && t<v){
							alert("can't change the value as fee in the group is not checked");
							$(this).val(bd.toFixed(2));
							$("#"+group).prop("checked",false);
							$("#"+parent).prop("checked",false);
						}else {
						
							$("#"+group).prop("checked",true);
							$("#"+parent).prop("checked",true);
						
						}
				}
				
				
				if(itype=='pa'){
					var t = v;
					var ft = v;
					//var count = $(this).attr("lid");
					//var inp = parseFloat(t/count);
					$("input[type='checkbox'][name^='"+parent+"']" ).each(function () {
		  	  			var gv = $(this).val();
		  	  			var classname = $(this).attr("class");
		  	  			if(classname=='groupcheck'){
		  	  				
			  	  			
			  	  			if($(this).is(':checked')){
			  	  				var gbd = parseFloat($("#"+gv+"_inputamount").attr("bd"));
			  	  				
					  	  			if(gbd>=t){
										$("#"+gv+"_inputamount").val(t.toFixed(2));
										t = 0;
									}else {
										t = t-fbd;
										$("#"+gv+"_inputamount").val(gbd.toFixed(2));
									}
			  	  				
			  	  				
			  	  				//$("#"+gv+"_inputamount").val(inp.toFixed(2));
			  	  				
			  	  				var n = $(this).val();
			  	  				
			  	  				$("input[type='checkbox'][name^='"+n+"']" ).each(function () {
					  	  				var gv = $(this).val();
						  	  			var classname = $(this).attr("class");
						  	  			if(classname=='groupfeescheck'){
						  	  				if($(this).is(':checked')){
							  	  				var fbd = parseFloat($("#"+gv+"_inputamount").attr("bd"));
								  	  			if(fbd>=ft){
													$("#"+gv+"_inputamount").val(ft.toFixed(2));
													ft = 0;
												}else {
													//var ft = ft-fbd;
													ft = ft-fbd;
													$("#"+gv+"_inputamount").val(fbd.toFixed(2));
												}
							  	  				
						  	  				}	
						  	  			}
			  	  				
			  	  				 });
		  	  				}
		  	  			}
		  	  			
		  			 });
					
					//alert(t+"--"+ft);
					
					if(t==v || ft==v){
						alert("can't change the value as fee in the group is not checked");
						$(this).val(bd.toFixed(2));
						$("#"+parent).prop("checked",false);
					} else if((t!=0 && t<v) || (ft !=0 && ft<v)){
						alert("can't change the value as fee in the group is not checked");
						$(this).val(bd.toFixed(2));
						$("#"+parent).prop("checked",false);
					}else {
						$("#"+parent).prop("checked",true);
					
					}
					
					//$("#"+parent).prop("checked",true);
				}
				
				//calculateamount();
				
			}
			
			
			
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
				//alert(order);
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
					        alert('Your request was not processed. Please check your input data.');
					    }
					});
				}
				else {
					return false;
				}
				
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
											 var pagfg = $(this).attr("parent_group");
											
											 if(pag==pagfg){
												 var pagfinput = $("#"+pagf+"_inputamount").val();
												
												 pagt = pagt + parseFloat(pagfinput);
												
											 }
										 }
									 });
								$("#"+pag+"_inputamount").val(pagt.toFixed(2));
								 	var paginput = $("#"+pag+"_inputamount").val();
								 	pat = pat + parseFloat(paginput);	
								 	 console.log("pat"+pat);
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
	
	function showfee(id){
		$("#show_"+id).toggle();
	}
	
	function showfee(id){
		$("#show_"+id).toggle();
	}
	
	
	function addtocart(){
		var t = 0;
		var type = {};
		 var statements = [];	
		 var o =0;
		$(".projectcheck").each(function(){
			
			 if($(this).is(':checked')){
				
				 var pa = $(this).val();
				 t += +$("#"+pa+"_inputamount").val();
				
				var d = "{";
		  	    d += "\"projectid\":"+$("#"+pa+"_projectid").val()+",";
		  	  	d += '\"projectname\":"'+$("#"+pa+"_projectname").val()+'",';
		  	  	d += "\"activityid\":"+$("#"+pa+"_id").val()+",";
		  	 	d += "\"order\":"+o+",";
		  	  	d += '\"activitynumber\":"'+$("#"+pa+"_name").val()+'",';
		  	  	d += '\"combined\":"'+pa+'",';
		  	  	d += '\"searched\":"'+$("#"+pa+"_searched").val()+'",';
		  	  	d += '\"type\":"'+$("#"+pa+"_type").val()+'",';
		  	    d += "\"amount\":"+$("#"+pa+"_amount").val()+",";
		 	 	d += "\"paidamount\":"+$("#"+pa+"_paidamount").val()+",";
		 		d += "\"balancedue\":"+$("#"+pa+"_balancedue").val()+",";
		 		d += "\"inputamount\":"+$("#"+pa+"_inputamount").val()+",";

		 		var feegroup= [];
		 		$(".groupcheck").each(function(){
		 			var pag = $(this).val();
		 			var pagact = $("#"+pag+"_act").val();
		 			if($(this).is(':checked') && pagact== pa){
					//	 var pag = $(this).val();
						
						 var g = "{";
					  	  	g += "\"groupid\":"+$("#"+pag+"_id").val()+",";
					  	  	g += '\"group\":"'+$("#"+pag+"_name").val()+'",';
					  	  	g += '\"combined\":"'+pag+'",';
					  	    g += "\"amount\":"+$("#"+pag+"_amount").val()+",";
					 	 	g += "\"paidamount\":"+$("#"+pag+"_paidamount").val()+",";
					 		g += "\"balancedue\":"+$("#"+pag+"_balancedue").val()+",";
					 		g += "\"inputamount\":"+$("#"+pag+"_inputamount").val()+",";
					 		
						 		var fees= [];
						 		$(".groupfeescheck").each(function(){
						 			var pagf = $(this).val(); 
					 				var pagfg = $("#"+pagf+"_group").val();
					 				var pagfact = $("#"+pagf+"_act").val();
						 			if($(this).is(':checked') && pag==pagfg && pagfact== pa){
						 				
						 				
										 var f = "{";
										 //	alert($("#"+pagf+"_id").val());
									  	  	f += "\"statementdetailid\":"+$("#"+pagf+"_id").val()+",";
									  	  	f += '\"name\":"'+$("#"+pagf+"_name").val()+'",';
									  	  	f += '\"combined\":"'+pagf+'",';
									  	    f += "\"amount\":"+$("#"+pagf+"_amount").val()+",";
									 	 	f += "\"paidamount\":"+$("#"+pagf+"_paidamount").val()+",";
									 		f += "\"balancedue\":"+$("#"+pagf+"_balancedue").val()+",";
									 		f += "\"inputamount\":"+$("#"+pagf+"_inputamount").val()+"";
									 		f += "}"; 
									 		fees.push(f);
										 }
									 });
					 		g += '\"fees\":[';
					 		g += fees;
				      		g += ']';
				      		g += "}"; 
					 		feegroup.push(g);
					 }	
				});
		 		d += '\"groups\":[';
		 		d += feegroup;
	      		d += ']';
		 		d += "}"; 
		 		statements.push(d);
				o = o+1;
			 }
			
			
			
		});
		
		var ty = "{";
		 ty += "\"type\":\"finance\",";
		 ty += '\"statements\":[';
		 ty += statements;
 		 ty += ']';
		 ty += "}"; 
		 console.log(ty);
		var method = "addtocart";
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
		 
		//$("#cart").val(ty);
		
		
	}
	
	function scantocart(type, typeid, reference){
		var method = "scantocart";
		
	
		
		$.ajax({
			  type: "POST",
			  url: "action.jsp?_action="+method,
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
	
	
	function ordercart1(order){
		
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
		        alert('Your request was not processed. Please check your input data.');
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
			    	document.forms[0].action = "cart.jsp?_ent=finance&_type=finance&_id=<%=nav.getId()%>";
					document.forms[0].submit();
			    	
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
	
	function paymentlist(){
		document.forms[0].action = "reverse.jsp?_ent=finance&_type=finance&_id=<%=nav.getId()%>";
		document.forms[0].submit();
	}
	
	function resetFees(){
		document.forms[0].action = "cart.jsp?_ent=<%=nav.getEntity()%>&_id=<%=nav.getId()%>&_type=<%=nav.getType()%>&_typeid=<%=nav.getTypeid()%>&_grptype=finance";
		document.forms[0].submit();
	}
	
	
	function deletecart(id){
		var method = "deletecart";
		if(confirm("Are you sure you want to delete this item?")){
		var ty ="{}";
		//alert(id);
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
		 		c += '<td class="csuisub"><a href="cart.jsp?_ent=finance&_type=finance&_id='+v.searched+'"> <img src="<%=Config.fullcontexturl() %>/images/icons/controls/black/edit.png" height="16" width="16" ></a></td>';
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
	
	</script>
</head>

<body alert="<%= alert %>">
	<div id="csuicontrols">
		<div id="csuicontrol" class="csuicontrol <%= alert %>">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td width="10" nowrap align="left" class="csuicontrol">	<a href="exportfinance.jsp" title="Extract Finance" ><img src="/cs/images/icons/controls/white/finance.png" height="20" width="20" border="0"/></a></td>
					<td width="40" nowrap align="left" class="csuicontrol">STATEMENTS</td>
					<td align="right" class="csuicontrol" id="qrcoderesult"></td>
					<td width="50" align="right" nowrap>
						<img src="/cs/images/qrcode.png" height="20" width="20" border="0" id="qrcodestatus"/>
						&nbsp;&nbsp;
					</td>
				</tr>
			</table>
		</div>
		<div id="csuisubcontrol" class="csuisubcontrol <%= alert %>">CART</div>
	</div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
				<form id="csform" action="action.jsp" method="post">
				<input type="hidden" name="_act" value="payment" >
				<input type="hidden" name="_grptype" value="finance" >
				<input type="hidden" id="cart" name="cart" value="0" >
				
						<div class="csui_divider"></div>
						<div class="csui_buttons">
							<input type="button" name="reset" value="reset" class="csui_button" onclick="resetFees();">
							<input type="button" name="addcart" value="Add to Cart" class="csui_button" onclick="addtocart();">
							<!-- <input type="button" name="reverse" value="Reverse Mode" class="csui_button" onclick="paymentlist();"> -->
						</div>
						
					<table class="csui" type="horizontal">
							<tr>
								<td class="csui_header" width="1%" nowrap><input type="checkbox" name="selectAll" class="selectall" id="selectall" ></td>
								<td class="csui_header" width="1%" nowrap>NUMBER</td>
								<td class="csui_header">NAME</td>
								<td class="csui_header" width="1%" nowrap>AMOUNT</td>
								<td class="csui_header" width="1%" nowrap>PAID</td>
								<td class="csui_header" width="1%" nowrap>BALANCE DUE</td>
								<td class="csui_header" width="1%" nowrap>INPUT AMOUNT</td>
								<td class="csui_header" width="1%">&nbsp;</td>
							</tr>
					
					<%
					 int pal = 	o.getStatements().length;
					for(int i=0;i<pal;i++){ 
						StatementVO s = o.getStatements()[i];
						String pa = s.getCombined();
						String searched = s.getSearched();
						boolean check = true;
						nav.setEntity("lso");
						nav.setType("activity");
						nav.setRequest("details");
						nav.setTypeid(s.getActivityid());
						TypeVO ow = ApiHandler.getType(nav);
						if (!ow.isUpdate()) {
							check = false;
						}
						//else if (!ow.isAdmin() && Operator.hasValue(ow.getHold())) {
						else if (Operator.hasValue(ow.getHold())) {
							check = false;
						}
						
						
					%>
						<tr>
							
							
								<%if(check){ %>
								<td class="csui" rel="prnt_<%=pa %>" width="1%" nowrap id="<%=pa %>_checkbox" >
									<input type="checkbox"  class="projectcheck" name="<%=pa %>" id="<%=pa %>" value="<%=pa %>">
								</td>
								<%}else { %>
									<td class="csui"  style="background-color:tomato;" nowrap>
										<font color="white">On Hold</font>
									</td>
								<%} %>
							
							<td class="csui" rel="prnt_<%=pa %>" width="1%" nowrap><a title="Show Activity"  class="csui" href="<%=Config.fullcontexturl() %>/summary.jsp?_ent=lso&_type=activity&_typeid=<%=s.getActivityid() %>" target="lightbox-iframe" ><%=s.getActivitynumber() %></a></td>
							<td class="csui" rel="prnt_<%=pa %>"><%=s.getProjectname() %></td>
							<td class="csui" rel="prnt_<%=pa %>" width="1%" nowrap>$<%=fm.format(s.getAmount()) %></td>
							<td class="csui" rel="prnt_<%=pa %>" width="1%" nowrap>$<%=fm.format(s.getPaidamount()) %></td>
							<td class="csui" rel="prnt_<%=pa %>" width="1%" nowrap>$<%=fm.format(s.getBalancedue()) %></td>
							<td class="csui" rel="prnt_<%=pa %>" width="1%" nowrap>
								<input type="text" id="<%=pa %>_inputamount" name="<%=pa %>_inputamount" value="<%=s.getInputamount() %>" bd=<%=s.getBalancedue() %> parent="<%=pa %>" group="0" itype="pa" lid="<%=s.getGroups().length %>" class="inputamount" >
								<input type="hidden" id="<%=pa %>_amount"  name="<%=pa %>_amount" value="<%=s.getAmount() %>" >
								<input type="hidden" id="<%=pa %>_paidamount" name="<%=pa %>_paidamount" value="<%=s.getPaidamount() %>" >
								<input type="hidden" id="<%=pa %>_balancedue" name="<%=pa %>_balancedue" value="<%=s.getBalancedue() %>" > 
								<input type="hidden" id="<%=pa %>_name" name="<%=pa %>_name" value="<%=s.getActivitynumber() %>" > 
								<input type="hidden" id="<%=pa %>_id" name="<%=pa %>_id" value="<%=s.getActivityid()%>" > 
								<input type="hidden" id="<%=pa %>_projectid" name="<%=pa %>_projectid" value="<%=s.getProjectid()%>" > 
								<input type="hidden" id="<%=pa %>_projectname" name="<%=pa %>_projectname" value="<%=s.getProjectname()%>" > 
								<input type="hidden" id="<%=pa %>_count" name="<%=pa %>_count" value="<%=pal %>" group=<%=pa %>> 
								<input type="hidden" id="<%=pa %>_searched" name="<%=pa %>_searched" value="<%=searched %>" > 
								<input type="hidden" id="<%=pa %>_type" name="<%=pa %>_type" value="<%=s.getType() %>" > 
							
							</td>
							<td class="csui prntSelector" prntid="<%=pa%>">&nbsp;</td>
						</tr>
			
						
						<tr class="loadhide" id="show_<%=pa %>">
							<td colspan="8">
								<table  class="csui" width="100%">
									<tr>
										<td class="csui_header fee" width="1%">&nbsp;</td>
										<td class="csui_header fee">GROUP</td>
										<td class="csui_header fee" width="1%" nowrap>AMOUNT</td>
										<td class="csui_header fee" width="1%" nowrap>PAID</td>
										<td class="csui_header fee" width="1%" nowrap>BALANCE DUE</td>
										<td class="csui_header fee" width="1%" nowrap>INPUT AMOUNT</td>
										<td class="csui_header fee" width="1%">&nbsp;</td>
									</tr>
								<% int pagl = s.getGroups().length;
								for(int j=0;j<pagl;j++){ 
									FeesGroupVO g = s.getGroups()[j];
									String pag = g.getCombined();
								%>
									
										<tr>
											<td class="csui fee" rel="fee_<%=pag%>" width="1%" nowrap id="<%=pag %>_checkbox" ><input type="checkbox" class="groupcheck" name="<%=pag %>" id="<%=pag %>" value="<%=pag %>"> </td>
											<td class="csui fee" rel="fee_<%=pag%>"><%=g.getGroup() %></td>
											<td class="csui fee" rel="fee_<%=pag%>" width="1%" nowrap>$<%=fm.format(g.getAmount()) %></td>
											<td class="csui fee" rel="fee_<%=pag%>" width="1%" nowrap>$<%=fm.format(g.getPaidamount()) %></td>
											<td class="csui fee" rel="fee_<%=pag%>" width="1%" nowrap>$<%=fm.format(g.getBalancedue()) %></td>
											<td class="csui fee" rel="fee_<%=pag%>" width="1%" nowrap>
												<input type="text" id="<%=pag %>_inputamount" name="<%=pag %>_inputamount" value="<%=g.getInputamount() %>" bd=<%=g.getBalancedue() %> parent="<%=pa %>"  group="<%=pag %>"  lid="<%=g.getFees().length %>" itype="group" class="inputamount" >
												<input type="hidden" id="<%=pag %>_amount" name="<%=pag %>_amount" value="<%=g.getAmount() %>" >
												<input type="hidden" id="<%=pag %>_paidamount" name="<%=pag %>_paidamount" value="<%=g.getPaidamount() %>" >
												<input type="hidden" id="<%=pag %>_balancedue" name="<%=pag %>_balancedue" value="<%=g.getBalancedue() %>" > 
												<input type="hidden" id="<%=pag %>_name" name="<%=pag %>_name" value="<%=g.getGroup() %>" > 
												<input type="hidden" id="<%=pag %>_id" name="<%=pag %>_id" value="<%=g.getGroupid()%>" > 
												<input type="hidden" id="<%=pag %>_count" name="<%=pag %>_count" value="<%=pagl %>" group=<%=pa %> > 
												<input type="hidden" id="<%=pag %>_act" name="<%=pag %>_act" value="<%=pa %>" > 
											</td>
											<td class="csui feeSelector" feeid="<%=pag%>" width="1%">&nbsp;</td>
										</tr>
										
										
										
										<tr class="loadhide" id="show_<%=pag%>">
											<td colspan="8" >
												<table class="csui" width="100%">
													<tr>
														<td class="csui_header child" width="1%" nowrap>&nbsp;</td>
														<td class="csui_header child">FEE</td>
														<td class="csui_header child" width="1%" nowrap>AMOUNT</td>
														<td class="csui_header child" width="1%" nowrap>PAID</td>
														<td class="csui_header child" width="1%" nowrap>BALANCE DUE</td>
														<td class="csui_header child" width="1%" nowrap>INPUT AMOUNT</td>
													</tr>
												<%int pagfl = g.getFees().length;
												for(int k=0;k<pagfl;k++){ 
													FeeVO f = g.getFees()[k];
													String pagf = f.getCombined();
												%>
													
														<tr>
															<td class="csui child" width="1%" nowrap><input class="groupfeescheck" type="checkbox" name="<%=pagf %>" id="<%=pagf %>" value="<%=pagf %>" parent_group="<%=pag %>"> </td>
															<td class="csui child" ><%=f.getName() %></td>
															<td class="csui child" width="1%" nowrap>$<%=fm.format(f.getAmount()) %></td>
															<td class="csui child" width="1%" nowrap>$<%=fm.format(f.getPaidamount()) %></td>
															<td class="csui child" width="1%" nowrap>$<%=fm.format(f.getBalancedue()) %></td>
															<td class="csui child" width="1%" nowrap>
																<input type="text" id="<%=pagf %>_inputamount" name="<%=pagf %>_inputamount" value="<%=f.getInputamount() %>" parent="<%=pa %>" bd=<%=f.getBalancedue() %> group=<%=pag %>  itype="fee"  class="inputamount">
																<input type="hidden" id="<%=pagf %>_amount" name="<%=pagf %>_amount" value="<%=f.getAmount() %>" >
																<input type="hidden" id="<%=pagf %>_paidamount" name="<%=pagf %>_paidamount" value="<%=f.getPaidamount() %>" >
																<input type="hidden" id="<%=pagf %>_balancedue" name="<%=pagf %>_balancedue" value="<%=f.getBalancedue() %>" > 
																<input type="hidden" id="<%=pagf %>_name" name="<%=pagf %>_name" value="<%=f.getName() %>" > 
																<input type="hidden" id="<%=pagf %>_id" name="<%=pagf %>_id" value="<%=f.getStatementdetailid() %>" > 
																<input type="hidden" id="<%=pagf %>_count" name="<%=pagf %>_count" value="<%=pagfl %>" group=<%=pag %> > 
																<input type="hidden" id="<%=pagf %>_group" name="<%=pagf %>_group" value="<%=pag %>" > 
																<input type="hidden" id="<%=pagf %>_act" name="<%=pagf %>_act" value="<%=pa %>" > 
															</td>
														</tr>
													
												<%} %>
												</table>
											</td>
										</tr>	
									
								<%} %>
								</table>
							</td>
						</tr>	

						
					<%} %>
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
							<td class="csui" nowrap="nowrap"> <input type="button" name="addcart" value="Clear Cart" class="csui_button" onclick="clearcart();">
							<input type="button" name="CHECKOUT" value="CHECKOUT" class="csui_button" onclick="checkout();"></td>
						</tr>
					</table>
				
				</div>
				<div class="csuisub_divider"></div>
				<div class="csui_divider"></div>
				
				
				<table class="csuisub_title" alert="warning">
					<tr>
						<td class="csuisub_title">TODAY'S TRANSACTIONS</td>
					</tr>
				</table>
				
				<table class="csuisub" type="horizontal" id="itemsadd">
					<tr>
						<td class="csuisub_header">TRANSACTION NO</td>
						<td class="csuisub_header">METHOD</td>
						<td class="csuisub_header">DATE</td>
						<td class="csuisub_header">AMOUNT</td>
						<td class="csuisub_header" width="1%">&nbsp;</td>
						<td class="csuisub_header" width="1%">&nbsp;</td>
					</tr>
					
					<%if(o.getPayment().length>0) {
						for(int i=0;i<o.getPayment().length;i++){
							PaymentVO p = o.getPayment()[i];
					%>
						<tr class="csuisub">
					 		<td class="csuisub" type="String" itype="String"><%=p.getPaymentid()%></td>
					 		<td class="csuisub" type="String" itype="String"><%=p.getMethodname() %></td>
					 		<td class="csuisub" type="String" itype="String"><%=p.getPaymentdate() %></td>
					 		
					 		<td class="csuisub" type="String" itype="String">$<%=p.getAmount() %></td>
					 		<td class="csuisub"><a href="print.jsp?_ent=finance&_type=payment&_id=<%=p.getPaymentid()%>&request=transaction" target="_blank" > <img src="<%=Config.fullcontexturl() %>/images/icons/controls/black/print.png" height="16" width="16" ></a></td>
					 		<td class="csuisub"><a target="lightbox-iframe" href="email.jsp?_ent=finance&_type=payment&_typeid=<%=p.getPaymentid()%>&request=transaction&_grptype=email&_act=email" > <img src="<%=Config.fullcontexturl() %>/images/icons/controls/black/email.png" height="16" width="16" ></a></td>
					 		
					 	</tr>
					
					<%}
					}
					%>
					
				</table>
				
		</div>
	</div>




</body>
</html>

