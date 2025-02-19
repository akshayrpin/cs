<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.vo.finance.DepositCreditVO"%>
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
	nav.setGrouptype("deposit");
	nav.setTypeid(map.getInt("_typeid"));
	nav.setId(map.getString("_id"));
	nav.setRequest("showdepositoptions");

	
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
	
	
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
	
	<script language="JavaScript" src="<%=Config.fullcontexturl()%>/tools/jq/json2.js"></script>
	
	
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>

	
 	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
    
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	
	
	<script>
	var u = "<%=Config.fullcontexturl() %>";
	$(document).ready(function() {
		
		$('#level').change(function(){
			 var v = $(this).val();
			// var level = $(this).attr("level");
			 var level = $('option:selected', this).attr('level');
			
			 showLedger(v,level);
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
	
	
	
	
	
	
	function showLedger(id,type){
		
		var method = "depositlist";
		var ty ="{}";
		$.ajax({
			  type: "POST",
			  url: "action.jsp?_action="+method,
			  dataType: 'json',		  
			  data: { 
				
			  	  _ent : "<%=nav.getEntity()%>",
				 _type:type,
				 _grptype:"deposit",
				 _grp:"deposit",
				 _typeid:id,
				
			      //mode : mode
			    },
			    success: function(output) {
			    	displayshowLedger(output,id,type);
			    	
			    },
		    error: function(data) {
		    	var c =''
		    	$("#showLedger").html(c);
		    }
		});
	}
	
	
	
	function displayshowLedger(output,id,type){
		output = JSON.stringify(output);
		output = JSON.parse(output);
		
		var c='';
		c += '	<table class="csui"  cellspacing="0" cellpading="0" border="0" >';
		c += '		<tr>';
		c += '			<td class="csui_title">DEPOSIT LEDGER</td>';
		c += '		<td class="csui_title" align="right">';
		c += '		 <a href="'+u+'/depositpayment.jsp?_ent=lso&_id='+id+'&_type='+type+'&_typeid='+id+'&ID='+id+'&_grptype=deposit&_act=depositpayment" title="Add deposit" border="0" ><img src="/cs/images/icons/controls/white/deposit.png" border="0">';
		c += '		</a>';
		c += '		</td>';
		c += '		</tr>';
		c += '		</table>	';
			
		c += '	<table  class="csui" cellspacing="0" cellpading="0" border="0">';
		
		c += '		<tr>';
		c += '			<td class="csui_header">DEPOSIT NO</td>';
		c += '			<td class="csui_header" >DATE</td>';
		c += '			<td class="csui_header">TYPE</td>';
		c += '			<td class="csui_header">AMOUNT</td>';
		c += '			<td class="csui_header">CURRENT AMOUNT</td>';
	
		c += '			<td class="csui_header">TRANSACTION ID</td>';
		c += '			<td class="csui_header">PARENT ID</td>';
		c += '			<td class="csui_header" width="1%">&nbsp;</td>';
		c += '			<td class="csui_header" width="1%">&nbsp;</td>';
		c += '		</tr>';
		c += '';
		
		
		$.each(output['depositcredits'], function(k,v) {
			c += '		<tr>';
			c += '			<td class="csui" width="1%" >'+v.id+'</td>';
			c += '			<td class="csui">';
			c += v.createddate;
			c+='</td>';
				
			c += '			<td class="csui">'+v.typename+'</td>';
			c += '			<td class="csui">$'+v.amount.formatMoney(2, '.', ',')+'</td>';
			c += '			<td class="csui">$'+v.currentamount.formatMoney(2, '.', ',')+'</td>';
			c += '			<td class="csui">'+v.paymentid+'</td>';
			c += '			<td class="csui">'+v.parentid+'</td>';
			c += '	<td class="csui" width="1%"><a href="'+u+'/print.jsp?_ent=lso&_type=payment&_typeid='+v.paymentid+'&_id='+v.paymentid+'&_grp=finance&_grptype=finance&request=transaction" target="_blank"> <img src="'+u+'/images/icons/controls/black/print.png" height="16" width="16" ></a></td>';
			c += '	<td class="csui" width="1%"><a href="javascript:void(0);" onclick="showchildgroup('+v.id+');"> <img src="'+u+'/images/icons/controls/black/downarrow.png" height="16" width="16" ></a></td>';

			c += '		</tr>';
			c += '<tr id="show_'+v.id+'" style="display:none;">';
			
				c += '</tr>	';
		
 		});
		
		//alert(c);
		c += '';
		c += '	</table>';
	
	
		
		$("#showLedger").html(c);
		
	}
	
	function showPayment(id){
		//alert(id);
		var method = "showdepositledger";
		var ty ="{}";
		$.ajax({
			  type: "POST",
			  url: "action.jsp?_action="+method,
			  dataType: 'json',		  
			  data: { 
				 cartjson : ty,
			  	  _ent : "<%=nav.getEntity()%>",
				 _type:"finance",
				 _grptype:"deposit",
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
		c += '			<td class="csui_header" colspan="2" align="center">DATE</td>';
		c += '			<td class="csui_header">AMOUNT</td>';
		c += '			<td class="csui_header">CURRENT AMOUNT</td>';
		c += '			<td class="csui_header">PARENT ID</td>';
		c += '			<td class="csui_header">TRANSACTION ID</td>';
		c += '			<td class="csui_header" width="1%">&nbsp;</td>';
		c += '			<td class="csui_header" width="1%">&nbsp;</td>';
		c += '		</tr>';
		c += '';
		
		
		$.each(output['depositcredits'], function(k,v) {
			c += '		<tr>';
			c += '			<td class="csui" colspan="2" align="right">&nbsp;</td>';
			c += '			<td class="csui_header" colspan="2" align="center">'+v.createddate+'</td>';
			c += '			<td class="csui">$'+v.amount.formatMoney(2, '.', ',')+'</td>';
			c += '			<td class="csui">$'+v.currentamount.formatMoney(2, '.', ',')+'</td>';
			c += '			<td class="csui">'+v.parentid+'</td>';
			c += '			<td class="csui">'+v.paymentid+'</td>';
			c += '	<td class="csui" width="1%"><a href="'+u+'/print.jsp?_ent=lso&_type=payment&_typeid='+v.paymentid+'&_id='+v.paymentid+'&_grp=finance&_grptype=finance&request=transaction" target="_blank"> <img src="'+u+'/images/icons/controls/black/print.png" height="16" width="16" ></a></td>';

			c += '			<td class="csui_header" width="1%">&nbsp;</td>';
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
					<td align="left" class="csuicontrol">DEPOSITS/CREDITS</td>
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
				<form id="csform"  action="depositledger.jsp" method="post">
				<table class="csui" colnum="2" type="default">
					<tr>
						<td class="csui_label" colnum="2" alert="">LEVEL</td>
						<td style="width:100px" class="csui">
							<select name="level" id="level"  class="chosen" itype="String" _ent="finance"  placeholder="level">
							<option value="" >Please Select</option>
							<option value="<%=map.getInt("_typeid")%>" level="activity">ACTIVITY - <%=title %> <%=subtitle %></option>
							<%for(int i=0;i<o.getDepositcredits().length;i++){
								int id = o.getDepositcredits()[i].getId();
								String level = o.getDepositcredits()[i].getLevel();
								String typename = o.getDepositcredits()[i].getTypename();
							%>
							<option value="<%=id %>" level="users">USER - <%=typename %></option>
							<%} %>
							</select>
						</td>
						
						
					</tr>
					
					
				</table>
				
				<div class="csui_divider"></div>
				
				
				
				</form>
				
				
				<form id="csform" action="action.jsp" method="post">
				<input type="hidden" name="_act" value="reverse" >
				<input type="hidden" name="_grptype" value="finance" >
				<input type="hidden" name="_ent" value="finance" >
				<input type="hidden" name="entity" value="finance" >
				<input type="hidden" id="cart" name="cart" value="0" >
				<input type="hidden" name="_action" value="reverse" >
				<div class="csui_divider"></div>
						
						
					<div id="showLedger"  >
						
					
				
					</div>	
					
			
			</div>
		</div>
		
	</div>

	</form>


</body>
</html>

