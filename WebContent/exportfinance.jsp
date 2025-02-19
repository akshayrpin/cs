<%@page import="cs.ui.CsUiTools"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="cs.utils.ObjTables"%>
<%@page import="csshared.vo.DataVO"%>
<%@page import="cs.utils.Cart"%>
<%@page import="csshared.vo.MessageVO"%>
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
<%@page import="java.util.HashMap"%>
<%


	Cartographer map = new Cartographer(request,response,true);
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	Timekeeper d = new Timekeeper();
	
	RequestVO nav = new RequestVO();
	nav.setEntity("finance");
	nav.setToken(map.token());
	nav.setIp(map.getRemoteIp());
	nav.setType("finance");
	nav.setTypeid(typeid);
	nav.setId(typeid+"");
	//nav.setRequest("full");
	//nav.setStartdate(startdate);
	
	//String streetlist = ApiHandler.post(CsConfig.getString("dropdownlist.streetlist"), "{}");
	//System.out.println("#######"+streetlist);
	//String streetfractionlist = ApiHandler.post(CsConfig.getString("dropdownlist.streetfractionlist"), "");
	TypeVO o = new TypeVO();
	ResponseVO ro = new ResponseVO();

	if (map.equalsIgnoreCase("action", "extract")) {
		//RequestVO vo = RequestMapper.getSaveParkingPermit(map);
		//System.out.println("#################"+map.getString("action"));
		RequestVO vo = RequestMapper.getRequest(map);
			System.out.println(vo.getUrl());
		ro = ApiHandler.getResponseVO(vo);
		
		System.out.println(ro.getMessagecode());
	}
	

	
%>
<html>
<head>

	<title>City Smart</title>
	<%= CsUiTools.getHTMLImports() %>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
	
	
	<style>
		.csui_controls { visibility: hidden }
	</style>
	<script>
	var entity = 'lso';
	var type = '<%= type %>';
	var typeid = '<%= typeid %>';
	var fullcontexturl = '<%=Config.fullcontexturl()%>';
		
	</script>

	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
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
    
  
	<style>
		
	</style>

	<script>
		$(document).ready(function() {
		
			
			
			
			
		
		});
		
		 function openexport(){
			 var url = "viewfinanceexport.jsp?";
		 	 url += "&START_DATE="+$('#START_DATE').val(); 
		 	 url += "&department="+$('#department').val();  
		 	  
		 var n = url;
		 window.open(n,"_blank");
			 	
			 } 

		
	</script>

</head>
<body alert="">
	<div id="loader">
		<div id="process">
			<table cellpadding="5" cellspacing="0" border="0" id="processtable">
				<tr>
					<td id="processtitle"></td>
				</tr>
				<tr>
					<td id="processmessage"></td>
				</tr>
				<tr>
					<td id="processpercent">
						<table id="processpercentage"><tr><td></td></tr></table>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div id="csuicontrols">
		<div id="csuicontrol" class="csuicontrol">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="left" class="csuicontrol">EXTRACT</td>
					<td align="right"><%= ObjUi.tools(o.getTools(), "csui") %>
					<table class="csui_tools">
						<tr>
							<td class="csui_tools">
								<a href="cart.jsp?_ent=finance&_type=finance&_typeid=0&_id=0"><img src="/cs/images/icons/controls/white/back.png" height="25" width="25" border="0"/></a>
							</td>
						</tr>
						
						
					</table>
					</td>
				</tr>
			</table>
		</div>
		
	</div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
			<br/><br/>
				
				<%if(ro.getErrors().size()>0){ 
					MessageVO m = ro.getErrors().get(0);
				%><div id="csform_message" class="csform_error">
					<ul>
					<li class="error"><%=m.getMessage() %></li>
					</ul>
					</div>
				<%}%>
				
				<form id="csform" class="form"  action="viewfinanceexport.jsp" method="post" close="true" refresh="true">
				<input type="hidden" name="_ent" value="lso">
				<input type="hidden" name="_type" value="finance">
				<input type="hidden" name="_typeid" value="">
				<input type="hidden" name="_reference" value="">
				<input type="hidden" name="_grpid" value="finance">
				<input type="hidden" name="_grp" value="finance">
				<input type="hidden" name="_grptype" value="finance">
				<input type="hidden" name="_id" value="0">
				<input type="hidden" name="_act" value="extractfinance">
				
				
				
				<table class="csui" colnum="2" type="default">
					<tr>
						<td class="csui_label" colnum="2" alert="">START DATE</td>
						<td class="csui" colnum="2" type="DATE" itype="DATE" alert=""><input name="START_DATE" id="START_DATE" type="text" itype="date" value="<%=d.getString("YYYY/MM/DD") %>" valrequired="true"  maxchar="10000"></td>
						<td class="csui_label" colnum="2" alert="">DEPARTMENT</td>
						
						
						<td style="width:100px" class="csui">
							<select name="department" id="department"  itype="String" _ent="finance"  placeholder="Department" json="<%=CsConfig.getString("dropdownlist.department")%>">
							<option value="0">All</option>
							</select>
						</td>
						
						
					</tr>
					
					
				</table>
				
				<div class="csui_divider"></div>
				
				
				
				
				<div class="csui_buttons"><input type="submit" name="action" value="Extract" onclick="openexport();" class="csui_button" >
			<!-- 	<input type="submit" name="action" value="Save & Pay" class="csui_button" > -->
				</div>
				</form>
				
				<div class="csui_divider"></div>
				<div class="csui_divider"></div>
				
			
				
				
				
				
				
				
				
			
				
				
				
				
			</div>
		</div>
		
	</div>




</body>
</html>

