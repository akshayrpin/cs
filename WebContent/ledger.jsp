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

	
	Cartographer map = new Cartographer(request,response);
	RequestVO nav = new RequestVO();
	nav.setEntity(map.getString("_ent"));
	//nav.setToken(map.filetoken());
	nav.setType(map.getString("_type"));
	nav.setTypeid(map.getInt("_typeid"));
	nav.setId(map.getString("_id"));
	nav.setRequest("paymentlist");
	nav.setGrouptype("finance");
	
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
	<script language="JavaScript" src="<%=Config.fullcontexturl()%>/tools/jq/json2.js"></script>
	
	
	<script>
	
	$(document).ready(function() {
		$('.typesearch').click(function() {
			try {
				parent.addSearchTerm('activity_id:<%=nav.getTypeid()%>');
				parent.linkIframe('/cs/searchledger.jsp?sq=activity_id:<%=nav.getTypeid()%>');
			}
			catch (e) {}
		});
		
		$('.typesearch2').click(function() {
			
			try {
				var id = $(this).attr("id");
				
				parent.addSearchTerm('payment_id:'+id+'');
				parent.linkIframe('/cs/searchledger.jsp?sq=payment_id:'+id+'');
			}
			catch (e) {}
		});

		
	});
	
	

	function stringStartsWith(string, prefix) {
	    return string.slice(0, prefix.length) == prefix;
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
		c += '			<td class="csui_header" colspan="2" align="right">NO</td>';
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
			c += '			<td class="csui" colspan="2" align="right"><h4>'+v.description+'</h4></td>';
			c += '			<td class="csui_header" colspan="2" align="center">'+v.name+'</td>';
			c += '			<td class="csui">$'+v.amount.formatMoney(2, '.', ',')+'</td>';
			c += '			<td class="csui">$'+v.paidamount.formatMoney(2, '.', ',')+'</td>';
			//c += '			<td class="csui">'+v.balancedue+'</td>';
			c += '			<td class="csui" width="1%" >&nbsp;</td>';
			c += '			<td class="csui" width="1%">&nbsp;</td>';
			c += '			<td class="csui" width="1%">&nbsp;</td>';
			c += '		</tr>';
		
 		});
		
	
		c += '';
		c += '	</table>';
		c += '</td>';
		
		$("#show_"+id).html(c);
		
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
					 <td class="csui_tools">
						<a href="<%=Config.fullcontexturl() %>/fees.jsp?_ent=<%=nav.getEntity() %>&_type=<%=nav.getType() %>&_typeid=<%=nav.getTypeid() %>&_id=<%=nav.getId() %>&_grp=finance&_grptype=finance&_act=add"><img src="/cs/images/icons/controls/white/back.png" height="25" width="25" border="0"/></a>
					 </td>
					 
					<td align="left" class="csuicontrol">LEDGER</td>
					<td align="right"><%= ObjUi.tools(o.getTools(), "csui") %></td>
				</tr>
			</table>
		</div>
		
	</div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
			
			<table cellpadding="10" cellspacing="0" border="0" width="100%">
					<tr>
						<td align="left" id="title"><%=title %></td>
						<td align="right" id="subtitle"><%=subtitle %></td>
					</tr>
				</table>
				
					
				<form id="csform" action="action.jsp" method="post">
				<input type="hidden" name="_act" value="reverse" >
				<input type="hidden" name="_grptype" value="finance" >
				<input type="hidden" name="_ent" value="finance" >
				<input type="hidden" name="entity" value="finance" >
				<input type="hidden" id="cart" name="cart" value="0" >
				<input type="hidden" name="_action" value="reverse" >
						<div class="csui_divider"></div>
					<table class="csui_title" >
							
							<tr>
								<td class="csui_title">LEDGER</td>
								<td class="csui_tools typesearch" style="cursor: pointer" title="search">
									<img src="/cs/images/icons/controls/white/search.png" border="0">
								</td>
							</tr>
							
						</table>	
						
					<table class="csui" type="horizontal" >
						<tr>
							<td class="csui_header">TRANSACTION NO</td>
							<td class="csui_header">DATE</td>
							<td class="csui_header">METHOD</td>
							<td class="csui_header">TYPE</td>
							<td class="csui_header">AMOUNT</td>
							<td class="csui_header">PAID BY</td>
							<td class="csui_header">ONLINE</td>
							<td class="csui_header">&nbsp;</td>
							<td class="csui_header">&nbsp;</td>
							<td class="csui_header" width="1%">&nbsp;</td>
						</tr>
					<%
					double total = 0;
					for(int l=0;l<o.getPayment().length;l++){ 
						PaymentVO p = o.getPayment()[l];
						String pap = p.getPaymentid()+"";
						total = Operator.addDouble(total, p.getAmount());
					%>
					
					
						<tr>
							
							<td class="csui"><%=p.getPaymentid() %></td>
							
							<td class="csui"><%=p.getPaymentdate() %></td>
							<td class="csui"><%=p.getMethodname() %></td>
							<td class="csui"><%=p.getTransactiontypename() %></td>
							<td class="csui">$<%=fm.format(p.getAmount()) %></td>
							<td class="csui"><%=p.getOtherpayeename() %></td>
							<td class="csui"><%=p.getOnlinetranasactionnumber() %></td>
							<td class="csui typesearch2" style="cursor: pointer" title="search" id="<%=p.getPaymentid() %>">
									<img src="/cs/images/search.png" border="0" width="16" height="16">
								</td>
							<td class="csui" width="1%"><a href="<%=Config.fullcontexturl() %>/print.jsp?_ent=<%=nav.getEntity() %>&_type=payment&_typeid=<%=nav.getTypeid() %>&_id=<%=p.getPaymentid() %>&_grp=finance&_grptype=finance&request=transaction" target="_blank"> <img src="<%=Config.fullcontexturl() %>/images/icons/controls/black/print.png" height="16" width="16" ></a></td>
							<td class="csui" width="1%"><a href="javascript:void(0);" onclick="showchildgroup(<%=p.getPaymentid()%>);"> <img src="<%=Config.fullcontexturl() %>/images/icons/controls/black/downarrow.png" height="16" width="16" ></a></td>
						</tr>
						
						
						<tr id="show_<%=p.getPaymentid() %>" style="display:none;">
							
						</tr>	
					
					<%} 
						
					%>
						
						<tr>
							<td class="csui_header" >TOTAL FOR THIS PERMIT TRANSACTIONS</td>
							<td class="csui" colspan="11" style="font-weight:bold;">$<%=fm.format(o.getAmount()) %></td>
							
							
						</tr>
						<tr>
							<td class="csui_header" >TOTAL ALL TRANSACTIONS</td>
							<td class="csui" colspan="11" style="font-weight:bold;">$<%=fm.format(total) %></td>
							
							
						</tr>
					</table>	
					
			
			</div>
		</div>
		
	</div>

	</form>


</body>
</html>

