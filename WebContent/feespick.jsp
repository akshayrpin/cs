<%@page import="cs.ui.CsUiTools"%>
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
	nav.setAction(map.getString(RequestMapper.action));
	//System.out.println(nav.getAction()+"####act########"+nav.getGroupid());
	String date ="";
	
	if(map.equalsIgnoreCase("EXECUTE", "SFEELIST")){
		date =   map.getString("START_DATE");
		HashMap<String,String> extras = new HashMap<String,String>();
		extras.put("FEE_DATE",date);
		nav.setExtras(extras);
	}else {
		Timekeeper k = new Timekeeper();
		date =  k.getString("YYYY/MM/DD");
		HashMap<String,String> extras = new HashMap<String,String>();
		extras.put("FEE_DATE", date);
		nav.setExtras(extras);
	}
//	nav.setRequest("details");
	if (map.equalsIgnoreCase(RequestMapper.action, "calculate")) {
		nav.setRequest("calculate");
	}
	else {
		nav.setRequest("feespick");
	}
	
	
	
	
	FeesGroupVO o = ApiHandler.getFeesGroupVO(nav);
	


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
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sticky/jquery.sticky.js"></script>
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
			$('input[itype=checkbox]').each(function (){
				 if ($(this).is(":checked")) {
			     	var id = $(this).val();
			     	var date = $('#START_DATE').val();
			     	var data = $("#"+id).val();
			     	var fname = $("#"+id).attr("fname");
			     	//JSON.parse(jsonString);
			       	parent.addFees(<%=req.getGroupid()%>,data,date,fname);
			      
		    	   }
				 
			});
			parent.$.fancybox.close();
		}
		
		function selectRequired(){
			//alert('came');
			$('input[itype=checkbox]').each(function (){
				var rq = $(this).attr("frequired");
				
				if(rq=="Y"){
					$(this).prop("checked",true);
				}
				 
				 
			});
			
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
						<td class="csui_title">FEES</td>
						<td class="csui_controls">&nbsp;</td>
					</tr>
				</table>
				<table class="csui" colnum="2" type="default">
					<tr>
						<td class="csui_label" colnum="0" alert="">FEE DATE</td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" alert="">
							<input name="START_DATE" type="text" itype="date" id="START_DATE" value="<%= date %>" >
							&nbsp; <input type="submit" name="action" value="Refresh" class="csui_button">
						</td>
					</tr>
				</table>
				<input type="hidden" name="_grpid" value="<%=nav.getGroupid()%>">
				<input type="hidden" name="_grp" value="finance">
				<input type="hidden" name="_grptype" value="finance">
				<input type="hidden" name="_type" value="<%=nav.getType()%>">
				<input type="hidden" name="_typeid" value="<%=nav.getTypeid()%>">
				<input type="hidden" name="_id" value="<%=nav.getId()%>">
				<input type="hidden" name="_ent" value="<%=nav.getEntity()%>">
				<input type="hidden" name="EXECUTE" value="SFEELIST">
				<div class="csui_divider"></div>
				<div class="csui_buttons sticky">
					<input type="button" name="Required" value="Required" class="csui_button" onclick="selectRequired();">
					<input type="button" name="action" value="Add" class="csui_button" onclick="addfees();">
				</div>
				
							<table class="csui" type="horizontal">
								<tr>
									<td class="csui_header">&nbsp;</td>
									
									<td class="csui_header">FEE NAME</td>
									<td class="csui_header">START DATE</td>
									<td  class="csui_header">EXP DATE</td>
									
								</tr>
				
							<%
							int l = o.getFees().length;
							for(int i=0;i<l;i++){ 
									FeeVO fvo = o.getFees()[i];
									int feeId = fvo.getFeeid();
									String name = fvo.getName();
										
									String startDate = fvo.getStartdate();
									String expDate = fvo.getExpdate();
									String json = fvo.getDescription();
									String required = fvo.getRequired().trim();
										//String manual = o.getFees()[i].getAccountnumber();
									int formulaid = fvo.getFormulaId();
										//JSONObject u = new JSONObject(json);
										
										//u.put("name",name.replace("'", ""));
										
										
										
									%>
								<tr class="csui">
									<%if(formulaid==0){ %>
										<td  type="checkbox" itype="checkbox" bgcolor="#6B3333" >
											&nbsp;
										</td>
									<%} else {   %>
										<td class="csui" type="checkbox" itype="checkbox" >
											<input name="selectfees_<%=feeId %>" id="selectfees_<%=feeId %>"  type="checkbox" itype="checkbox" value="<%=feeId %>" frequired="<%=required %>" >
										 	<input name="<%=feeId %>" id ="<%=feeId %>" type="hidden"  value='<%=json %>' fname ="<%=name %>"> 
										 	
											
										</td>
									<%} %>
									
									<td class="csui" type="String" itype="String"><%=name %></td>
									<td class="csui" type="String" itype="String"><%=startDate %></td>
									<td class="csui" type="date" itype="date"><%=expDate %></td>
								
								</tr>
							<%} %>
				
				</table>

				</form>
			</div>
		</div>
	</div>




</body>
</html>

