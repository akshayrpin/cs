<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.vo.finance.StatementVO"%>
<%@page import="csshared.vo.ResponseVO"%>
<%@page import="csshared.vo.finance.FeeVO"%>
<%@page import="org.json.JSONObject"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="csshared.vo.finance.FeesGroupVO"%>
<%@page import="java.util.HashMap"%>
<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="csshared.vo.finance.FinanceVO"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="cs.utils.ObjUi"%>
<%@page import="csshared.vo.ObjGroupVO"%>
<%@page import="cs.common.ApiHandler"%>
<%@page import="csshared.vo.TypeVO"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="alain.core.utils.Cartographer"%>
<%


	Cartographer map = new Cartographer(request,response);
	RequestVO req = RequestMapper.getRequest(map);
	RequestVO nav = req.duplicate();
	//nav.setAction(map.getString(RequestMapper.action));
	//System.out.println(nav.getAction()+"####act########"+nav.getGroupid());
	
	nav.setRequest("getmanualaccounts");
	
	String ui = map.getString("ui");
	
	ResponseVO r = ApiHandler.getResponse(nav);
	
	TypeVO t = r.getType();
	FeeVO[] fees  = new FeeVO[0];
	StatementVO[] statements = t.getStatements();
	if(statements.length>0){
		fees = statements[0].getGroups()[0].getFees();
	}
	
	
	
	


%><html>
<head>
	<%= CsUiTools.getHTMLImports() %>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
	<style>

		html, body { padding: 0px; margin: 0px; height: 100% }

		.csuicontent { padding-left: 30px; padding-right: 30px; }

		.csuicontrol { background-color: #aaaaaa; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 12px; color: #ffffff; font-weight: 700; vertical-align: middle; height: 35px; padding-left: 10px }
		.csui_controls { visibility: hidden }

		.csuicontrol.expired { background-image: url(<%=Config.fullcontexturl() %>/images/alerts/hourglass.png); background-repeat: no-repeat; background-position: 99% center; }

		.issued { background-color: #64865f; }
		.csuicontrol.issued { background-image: url(<%=Config.fullcontexturl() %>/images/alerts/good.png); background-repeat: no-repeat; background-position: 99% center; }

		.hold { background-color: #996666; }
		.csuicontrol.hold { background-image: url(<%=Config.fullcontexturl() %>/images/alerts/alert.png); background-repeat: no-repeat; background-position: 99% center; }

		.alert { background-color: #996666; }
		.csuicontrol.alert { background-image: url(<%=Config.fullcontexturl() %>/images/alerts/alert.png); background-repeat: no-repeat; background-position: 99% center; }


		#title { padding: 5px; font-family: Oswald, Arial, Helvetica, sans-serif; font-size: 40px; font-weight: 700; vertical-align: bottom; color: #555555 }
		#subtitle { padding: 5px; font-family: Oswald, Arial, Helvetica, sans-serif; font-size: 25px; font-weight: 700; vertical-align: bottom; color: #bbbbbb; }

		table.csui, table.csui_title { width: 100%; padding: 0px; }
		table.csui { background-color: #cccccc; border-spacing: 1px; border-collapse: separate; }
		td.csui { padding: 6px; font-family: Armata, Arial, Helvetica, sans-serif; font-size: 12px; background-color: #ffffff; vertical-align: top; }

		table.csui_title { border-spacing: 0px; background-color: #777777; }
		td.csui_title { padding: 5px; width: 100%; font-family: Oswald, Arial, Helvetica, sans-serif; font-size: 18px; font-weight: 700; color: #ffffff; vertical-align: top; text-transform: uppercase }
		table.csui_title[alert="issued"] { background-color: #64865f; }
		table.csui_title[alert="hold"] { background-color: #8f6662; }
		table.csui_title[alert="alert"] { background-color: #8f6662; }

		td.csui_header, td.csui_label { padding: 6px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 10px; background-color: #eeeeee; text-transform: uppercase }
		td.csui_label { width: 10%; white-space: nowrap; vertical-align: top; padding: 8px; padding-top: 15px }
		div.csui_divider { height: 25px; }

		table[colnum="2"] td.csui { width: 40%; }
		table[colnum] td.csui_header { width: 10%; white-space: nowrap }
		td[mtype="currency"], td[mtype="integer"], td[mtype="number"] { text-align: right }

		a.csui_title { color: #ffffff; text-decoration: none }
		a.csuisub_title { color: #555555; text-decoration: none }
		a.csuisub_header_title { color: #888888; text-decoration: none }

		td.csui_label[alert="issued"], td.csuisub_label[alert="issued"] { border-left: 6px solid #64865f;  }
		td.csui_label[alert="hold"], td.csuisub_label[alert="hold"] { border-left: 6px solid #8f6662;  }
		td.csui_label[alert="alert"], td.csuisub_label[alert="alert"] { border-left: 6px solid #8f6662;  }

		input, select option { font-family: Armata, Arial, Helvetica, sans-serif; font-size: 12px }
		.csui_buttons { text-align: right }
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
		input[type=button][value=save] {
			background-image: url(<%=Config.fullcontexturl() %>/images/icons/controls/black/save.png);
			background-repeat: no-repeat;
			background-position: 20px center;
			padding-left: 45px;
		}
		input[type=button][value=cancel] {
			background-image: url(<%=Config.fullcontexturl() %>/images/icons/controls/black/delete.png);
			background-repeat: no-repeat;
			background-position: 20px center;
			padding-left: 45px;
		}
		input[type=button]:hover {
			background-color: #336699;
			color: #ffffff;
		}
		input[type=button][value=save]:hover {
			background-color: #669966;
			background-image: url(<%=Config.fullcontexturl() %>/images/icons/controls/white/save.png);
			color: #ffffff;
		}
		input[type=button][value=cancel]:hover {
			background-color: #996666;
			background-image: url(<%=Config.fullcontexturl() %>/images/icons/controls/white/delete.png);
			color: #ffffff;
		}
		.csform { border: 1px solid #cccccc; width: 100%; box-sizing:border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box; }
		.csform_highlight { border: 1px solid #9ecaed; box-shadow: 0 0 10px #9ecaed; }

	</style>

	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/toggleswitch/tinytools.toggleswitch.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/jquery.tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/inputmask.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/jquery.inputmask.js"></script>
	<script language="JavaScript" src="<%=Config.fullcontexturl()%>/tools/jq/json2.js"></script>

	<script>

		$(document).ready(function() {
			$('#csform').csform({
				url: {
					success: '<%=req.summaryUrl()%>'
				}
			});
			$('input[itype=datetime]').datetimepicker({
				formatTime:'g:i A',
				step: 1
			});
			$('input[itype=date]').datetimepicker({
				timepicker:false,
				format:'Y/m/d'
			});
			$('select:not([itype=boolean]):not([required=true])').chosen({
				width:'100%',
				disable_search_threshold: 10,
				allow_single_deselect: true
			});
			$('select:not([itype=boolean])[required=true]').chosen({
				width:'100%',
				disable_search_threshold: 10
			});
			$('input[itype=boolean]').toggleSwitch({
				onLabel: 'YES',
				offLabel: 'NO',
				height: '30px'
			});
			$('input[itype=active]').toggleSwitch({
				onLabel: 'ACTIVE',
				offLabel: 'INACTIVE',
				height: '30px',
				width: '140px'
			});
			$('input[itype=enable]').toggleSwitch({
				onLabel: 'ENABLED',
				offLabel: 'DISABLED',
				height: '30px',
				width: '140px'
			});
			$('textarea[itype!=richtext]').autoGrow();
			tinymce.init({
            	selector: "textarea[itype=richtext]"
	        });
			$('input[itype=phone]').inputmask({
				"mask":"(999) 999-9999"
			});
//			$('textarea').tinymce();
		});
		
		
		function addfees(){
			//alert('came');
			$('input[itype=radio]').each(function (){
				 if ($(this).is(":checked")) {
			     	var id = $(this).val();
			     	var acc = $(this).attr('acc');
			     	
			     	//JSON.parse(jsonString);
			      	parent.addAccount(id,"<%=ui%>",acc);
			      
		    	   }
				 
			});
			parent.$.fancybox.close();
		}
		
		

	</script>

</head>
<body>

	<div id="csuibody">
		<div id="csuimain">
			
			<div class="csuicontent">
				<form id="csfeepick" action="feespick.jsp" method="post">
				
				<table class="csui_title">
					<tr>
						<td class="csui_title">FINANCE MAP </td>
						<td class="csui_controls">&nbsp;</td>
					</tr>
				</table>
			
				<div class="csui_divider"></div>
				<div class="csui_buttons"><input type="button" name="action" value="Connect" class="csui_button" onclick="addfees();"></div>
				
							<table class="csui" type="horizontal">
								<tr>
									<td class="csui_header">&nbsp;</td>
									<td class="csui_header">FEE NAME</td>
									<td class="csui_header">ACCOUNT</td>
									<td  class="csui_header">KEY</td>
									<td  class="csui_header">FUND</td>
									<td  class="csui_header">BUDGET</td>
								</tr>
				
							<%
								int l = fees.length;
								for(int i=0;i<l;i++){ 
									FeeVO fvo = fees[i];
									int feeId = fvo.getFinancemapid();
									String name = fvo.getName();
							%>
								<tr class="csui">
									
									<td class="csui" type="checkbox" itype="checkbox" >
										<input name="selectfees_<%=feeId %>" id="selectfees_<%=feeId %>"  type="radio" itype="radio" value="<%=feeId %>" acc="<%=fvo.getAccountnumber()  %>" >
									</td>
									
									
									<td class="csui" type="String" itype="String"><%=name %></td>
									<td class="csui" type="String" itype="String"><%=fvo.getAccountnumber() %></td>
									<td class="csui" type="date" itype="date"><%=fvo.getKeycode() %></td>
									<td class="csui" type="date" itype="date"><%=fvo.getFund() %></td>
									<td class="csui" type="date" itype="date"><%=fvo.getBudgetunit() %></td>
								
								</tr>
							<%} %>
				
				</table>

				</form>
			</div>
		</div>
	</div>




</body>
</html>

