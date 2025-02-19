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
	//nav.setToken(map.filetoken());
	nav.setType(map.getString("_type"));
	nav.setTypeid(map.getInt("_typeid"));
	nav.setId(map.getString("_id"));
	nav.setGrouptype("deposit");
	nav.setRequest("add");
	
	

	
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
	
	<script>
	
	$(document).ready(function() {
		$("#payeeid").change(function () {
			var v = $(this).val();
			if(v==-1){
				$("#payeedetails").show();
			}else {
				$("#payeedetails").hide();
			}
		 });
		
		
		$("#method").change(function () {
   			var val = $(this).val();
   			var option = $('option:selected', this).attr('deposit');
   			if(option=="Y"){
				$("#applydeposit").val("Y");
			}else {
			
		    	$("#applydeposit").val("N");
			}
			
			
		 });
		
	 });
	
	function resetFees(){
		document.location.href = "depositpayment.jsp?_ent=<%=nav.getEntity()%>&_type=<%=nav.getType()%>&_typeid=<%=nav.getTypeid()%>&_grptype=deposit&_grpid=0";
		
	}
	
	function validatePage(){
		var m = $('#method').val();
		var payee = $('#payeeid').val();
		var payeetxt = $('#payee').val();
		var a = $('#number').val();
		var amt = parseFloat($('#amount').val());
		var applydeposit = $('#applydeposit').val(); 
		//alert(pamt);
		//alert(isNaN(amt));
		if(m==''){
			alert("Please select the method of payment");
			$('#method').focus();
			return false;
		}
		
		if( m!=1 && applydeposit=="N" && a==""){
			alert("Please enter the acc/chq number");
			$('#number').focus();
			return false;
		}
		
		
		
		if(payee==""){
			alert("Please select payee");
			$('#payeeid').focus();
			return false;
		}
		
		if(payee=="-1" && payeetxt==""){
			alert("Please enter the payee info");
			$('#payee').focus();
			return false;
		}
		
		if(isNaN(amt)){
			alert("Please enter the amount");
			$('#amount').focus();
			return false;
		}
		
		
		
		return true;
	}
	
	
	</script>
</head>

<body alert="<%= alert %>">
	<div id="csuicontrols">
		<div id="csuicontrol" class="csuicontrol <%= alert %>">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<%if(!nav.getType().equalsIgnoreCase("users")){ %>
					 <td class="csui_tools">
							<a href="<%=Config.fullcontexturl() %>/summary.jsp?_ent=<%=nav.getEntity() %>&_type=<%=nav.getType() %>&_typeid=<%=nav.getTypeid() %>&_id=<%=nav.getId() %>"><img src="/cs/images/icons/controls/white/back.png" height="25" width="25" border="0"/></a>
						</td>
					<%} %>
					<td align="left" class="csuicontrol">DEPOSIT</td>
					<td align="right"><%= ObjUi.tools(o.getTools(), "csui") %></td>
				</tr>
			</table>
		</div>
		
		<div id="csuisubcontrol" class="csuisubcontrol <%= alert %>">&nbsp;</div>
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
				<input type="hidden" name="_grptype" value="<%=nav.getGrouptype() %>" >
				<input type="hidden" name="_ent" value="<%=nav.getEntity() %>" >
				<input type="hidden" name="_type" value="<%=nav.getType() %>" >
				<input type="hidden" name="_typeid" value="<%=nav.getTypeid() %>" >
				<input type="hidden" name="_action" value="deposit" >
				<input type="hidden" name="applydeposit" id="applydeposit" value="N" >
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
									<%SubObjVO[] methods = o.getPayment()[0].getMethods();
										for(int i=0;i<methods.length;i++){
											
									%>
									<option value="<%=methods[i].getId() %>" deposit="<%=methods[i].getValue() %>"><%=methods[i].getText() %></option>
									<% }%>
								
								</select>
							
							</td>
							<td class="csui_label" colnum="2" alert="">ACC/CHQ NUMBER </td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><input name="number" type="text" itype="text" value="" ></td>
						</tr>
						
						<tr>
							<td class="csui_label" colnum="2" alert="">PAID BY</td>
							<td class="csui" colnum="2" type="String" itype="String" alert="">
							
								<%if(nav.getType().equalsIgnoreCase("users")){ %>
									<%SubObjVO[] payees = o.getPayment()[0].getPayees();
										for(int i=0;i<payees.length;i++){
											
									%>
									
									<input type="hidden" name="payeeid"  id="payeeid" value="<%=payees[i].getValue() %>" >
									<%=payees[i].getText() %>
								
									<% }%>
								<%} else { %>
								
								
								<select name="payeeid"  id="payeeid" itype="String" val="" _ent="finance" valrequired="true">
									<option value="">Please Select</option>
									<%SubObjVO[] payees = o.getPayment()[0].getPayees();
										for(int i=0;i<payees.length;i++){
											
									%>
									<option value="<%=payees[i].getValue() %>"><%=payees[i].getText() %></option>
									<% }%>
									<option value="-1">Other</option>
								</select>
							<%} %>
							</td>
							<td class="csui_label" colnum="2" alert="">DEPOSIT TYPE</td>
							<td class="csui" colnum="2" type="String" itype="String" alert="">
							<input type="hidden" name="counter" value="2">
								<select name="transactiontype" id="transactiontype"itype="String" val="" _ent="finance" valrequired="true">
									<option value="2">Regular (Money Used in payment)</option>
									<option value="4">Bond (Money not used in payment)</option>
								
								</select>
							
							</td>
						</tr>
						
						<tr id="payeedetails" style="display:none;">
							<td class="csui_label" colnum="2" alert="">PAYEE</td>
							<td class="csui" colnum="2" type="String" itype="text" alert="">PAYEE</td>
							<td class="csui_label" colnum="2" alert="">&nbsp;</td>
							<td class="csui" colnum="2" type="String" itype="String" alert="">&nbsp;</td>
						</tr>
						
						<tr>
							<td class="csui_label" colnum="2" alert="">COMMENTS</td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><textarea name="comment" itype="textarea" valrequired="true"></textarea></td>
							<td class="csui_label" colnum="2" alert="">&nbsp;</td>
							<td class="csui" colnum="2" type="String" itype="String" alert="">&nbsp;</td>
						</tr>
						
						
						
						<tr>
							<td class="csui_label" colnum="2" alert="">AMOUNT</td>
							<td class="csui" colnum="2" type="String" itype="text" alert=""><input name="amount" id="amount" type="text" itype="text" value="" ></td>
							<td class="csui_label" colnum="2" alert="">&nbsp;</td>
							<td class="csui" colnum="2" type="String" itype="String" alert="">&nbsp;</td>
						</tr>
						
					</table>
						
					<div class="csui_divider"></div>
						<div class="csui_buttons">
							<input type="button" name="reset" value="reset" class="csui_button" onclick="resetFees();">
							<input type="submit" name="payfees" value="DEPOSIT" class="csui_button" onclick="return validatePage();">
						</div>
				</form>
			</div>
		</div>
		<div id="csuisub">
				<div class="csuisub_divider"></div>
				<div class="csuisubcontent">
			&nbsp;
				</div>
				<div class="csuisub_divider"></div>
				<div class="csui_divider"></div>
		</div>
	</div>




</body>
</html>

