<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.vo.finance.PaymentVO"%>
<%@page import="cs.utils.Cart"%>
<%@page import="csshared.vo.ResponseVO"%>
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
	
	ResponseVO r = ObjMapper.toResponseObj(map.getString("_transactionresponse"));
	TypeVO t = r.getType();
	Cart.replaceCart(t, map);
	
	
	
	
	double tot = 0;
	for(int cr=0;cr<t.getStatements().length;cr++){
		tot += t.getStatements()[cr].getInputamount();
	}	
	
	String title = t.getTitle();
	String subtitle = t.getSubtitle();
	String alert = t.getAlert();
	String mode = map.getString("mode");
	int _trackId = map.getInt("_trackId",0);
	DecimalFormat fm = new DecimalFormat("#,###.00"); 
	//System.out.println("*******************"+t.getPayment().length);
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
	
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
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
			var v = $('#paymentid').val();
		 	$('#sendemail').click(function () {
	      	 $('<a title="Permit" target="lightbox-iframe"  href="<%=Config.fullcontexturl()%>/email.jsp?_ent=finance&_type=payment&_typeid='+v+'&request=transaction&_grptype=email&_act=email" >Friendly description</a>').fancybox({
       		'width'				: '75%',
				'height'			: '75%',
				'autoScale'			: false,
				'transitionIn'		: 'none',
				'transitionOut'		: 'none',
				'type'				: 'iframe'
          }).click();
       	
			});
		 	
		 	
		 	  $("#selectorall").click(function(){
					$('input:checkbox.inspresults').not(this).prop('checked', this.checked);
				 });
		 	
			
		 });
		
		
	
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
			    	
			    },
		    error: function(data) {
		        alert('Your request was not processed. Please check your input data.');
		    }
		});
	}
	
	function checkout(){
		document.forms[0].action = "payment.jsp";
		document.forms[0].submit();
	}
	
	function printu(id){
		var u = 'print.jsp?_ent=finance&_type=payment&_id='+id+'&request=transaction';
		window.open(u,"_blank");
	}
	
	function printe(id){
		//swal({   title: "Email ",   text: "Coming Soon!",   timer: 2000,   showConfirmButton: false });
	
		
		
		
	}
	
	
	function updateStatus(){
		var method = "updateStatusIssued";
		 var v = $('input:checkbox.inspresults:checked').map(function() {    return $(this).attr('act_id'); }).get();
			if(v==""){
				swal("Select checkbox in order to proceed");
				return false;
			}
			
			
			
		var ty ="{}";
		$.ajax({
			  type: "POST",
			  url: "action.jsp?_act="+method,
			  dataType: 'json',		  
			  data: { 
				 _ent : "lso",
				 _type : "activity",
				 _id : v
			     // valuation : valuation,
			      //mode : mode
			    },
			    success: function(output) {
			    	//output = JSON.stringify(output);
			    	
			    	swal("Updated Status Successfully");
			    	//$("#cart").val(output);
			    	//displaycart();	
			    	
			    },
		    error: function(data) {
		        alert('Your request was not processed. Please check your input data.');
		    }
		});
	}
	
	
	</script>
</head>

<body alert="<%= alert %>">
	<div id="csuicontrols">
		<div id="csuicontrol" class="csuicontrol <%= alert %>">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="left" class="csuicontrol">RESULT</td>
					<td align="right"><%= ObjUi.tools(t.getTools(), "csui") %>
					<table class="csui_tools">
						<tr>
							<td class="csui_tools">
								<a href="/cs/jsp/parking.jsp?_ent=lso&_type=<%=_trackId%>&_typeid=<%=_trackId%>&_id=<%=_trackId%>&accountno=<%=_trackId%>"></a>
							</td>
						</tr>
						
						
					</table>
					
					
					</td>
				</tr>
			</table>
		</div>
		<div id="csuisubcontrol" class="csuisubcontrol <%= alert %>">PAYMENTS</div>
	</div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
				<form id="csform" action="action.jsp" method="post">
				<input type="hidden" name="_act" value="payment" >
				<input type="hidden" name="_grptype" value="finance" >
				<input type="hidden" name="_ent" value="finance" >
				<input type="hidden" name="_type" value="finance" >
				<input type="hidden" name="entity" value="finance" >
				
						<div class="csui_divider"></div>
						<div class="csui_buttons">
							<%if(mode.equalsIgnoreCase("payment") && tot>0){ %>
								<input type="button" name="continuepayment" value="Continue Payment" class="csui_button" onclick="checkout();">
							<%} %>
						<!-- 	<input type="button" name="exitpayment" value="Exit Payment" class="csui_button" onclick="clearcart();"> -->
						</div>
						
					<% if(t.getPayment().length>0){
						PaymentVO p = t.getPayment()[0];
					%>
						<input type="hidden" name="paymentid" id="paymentid"  value="<%=p.getPaymentid() %>" >
					<table class="csui_title" alert="warning">
						<tr>
							<td class="csui" align="right"><input type="button" name="PRINT" value="Print" onclick="printu(<%=p.getPaymentid()%>)" > &nbsp; <input type="button" name="EMAIL" value="Email" id="sendemail" ></td>
						</tr>
					</table>
						
					<table class="csui_title" alert="warning">
						<tr>
							<td class="csui_title">TRANSACTION DETAILS</td>
						</tr>
					</table>
					
					<table class="csui" colnum="2" type="default">
						<tr>
							<td class="csui_label" colnum="2" alert="">ID</td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><%=p.getPaymentid() %></td>
							<td class="csui_label" colnum="2" alert="">METHOD</td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><%=p.getMethodname() %></td>
						</tr>
						
						
						
						<tr>
							<td class="csui_label" colnum="2" alert="">DATE</td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><%=p.getPaymentdate() %></td>
							<td class="csui_label" colnum="2" alert="">PAYEE</td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><%=p.getOtherpayeename() %></td>
						</tr>
						
						<tr>
							<td class="csui_label" colnum="2" alert="">COMMENTS</td>
							<td class="csui" colnum="2" type="String" itype="text" alert="" colspan="3"><%=p.getComment() %></td>
							
						</tr>
						
						
						
						<tr>
							<td class="csui_label" colnum="2" alert="">AMOUNT</td>
							<td class="csui" colnum="2" type="String" itype="text" alert="" colspan="3">$<%=fm.format(p.getAmount()) %></td>
						
						</tr>
						
					</table>
					
					</br>
					</br>
					
					<table class="csui_title" alert="warning">
						<tr>
							<td class="csui" align="right"><input type="button" name="STATUS" value="UPDATE STATUS" onclick="updateStatus();" > </td>
						</tr>
					</table>
					<table class="csui_title" alert="warning">
						<tr>
							<td class="csui_title">DETAILS</td>
						</tr>
						
					</table>
					
					<table class="csuisub" type="horizontal" id="itemsadd">
					<tr>
						<td class="csuisub_header" width="1%"><input type="checkbox" name="selectorall" id="selectorall" class="selectorall"></td>
						<td class="csuisub_header">NUMBER</td>
						<td class="csuisub_header">TYPE</td>
						<td class="csuisub_header">STATUS</td>
						<td class="csuisub_header">PRINT</td>
						<td class="csuisub_header" width="1%">&nbsp;</td>
					</tr>
					
					<%if(p.getStatements().length>0) {
						for(int i=0;i<p.getStatements().length;i++){
							StatementVO sv = p.getStatements()[i];
					%>
						<tr class="csuisub">
							<td class="csuisub" type="String" itype="String"><input type="checkbox" name="ID"  class="inspresults" value="<%=sv.getActivityid()%>" type="activity" act_id="<%=sv.getActivityid()%>" /></td>
					 		<td class="csuisub" type="String" itype="String"><%=sv.getActivitynumber()%></td>
					 		<td class="csuisub" type="String" itype="String"><%=sv.getActivitytype() %></td>
					 		<td class="csuisub" type="String" itype="String"><%=sv.getActivitystatus() %></td>
					 		<td class="csuisub"><a target="lightbox-iframe" href="printall.jsp?_ent=lso&_entid=-1&_type=activity&_typeid=<%=sv.getActivityid()%>&_grptype=print&_act=print" target="_blank" > <img src="<%=Config.fullcontexturl() %>/images/icons/controls/black/print.png"></a></td>
					 		<td class="csuisub" width="1%">&nbsp;</td>
					 	</tr>
					
					<%}
					}
					%>
					
				</table>
					
					
					<%} %>	
					
				</form>
			</div>
		</div>
		<div id="csuisub">
				<div class="csuisub_divider"></div>
				<div class="csuisubcontent">
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
					
					<%if(t.getPayment().length>0) {
						for(int i=0;i<t.getPayment().length;i++){
							PaymentVO p = t.getPayment()[i];
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
				<div class="csuisub_divider"></div>
				<div class="csui_divider"></div>
								</div>
				<div class="csuisub_divider"></div>
				<div class="csui_divider"></div>
		</div>
	</div>




</body>
</html>

