<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.vo.ObjVO"%>
<%@page import="csshared.vo.ResponseVO"%>
<%@page import="csshared.vo.SubObjVO"%>
<%@page import="cs.utils.ObjTables"%>
<%@page import="cs.ui.CsUi"%>
<%@page import="csshared.vo.DataVO"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="csshared.utils.CsConfig"%>
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
	nav.setRequest("details");

	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	String group = map.getString(RequestMapper.group);
	String groupid = map.getString(RequestMapper.groupid);
	String grouptype = map.getString(RequestMapper.grouptype);
	if (!Operator.hasValue(grouptype)) {
		grouptype = type;
	}
	String subject ="";
	String body ="";
	if(type.equals("payment")){
		subject ="City of Beverly Hills - Thank you for your  payment ";
		body = "Attached is your transaction receipt for transaction #"+typeid;;
	}	
	
	if(Operator.hasValue(map.getString("subject"))){
		subject = map.getString("subject","");
	}
	
	if(Operator.hasValue(map.getString("body"))){
		body = map.getString("body","");
	}
	ResponseVO v = ApiHandler.getResponse(nav);
	
	TypeVO t = v.getType();
	
	ObjGroupVO g = t.getGroups()[0];

%><html>
	<head>
	
		<%= CsUiTools.getHTMLImports() %>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
		<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/ioscheckboxes/assets/css/mobileCheckbox.iOS.css">
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css">
		

		<link href='https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css' rel='stylesheet' type='text/css'>
	
		<style>
			.csui_controls { visibility: hidden }
		</style>
	
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.project.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/toggleswitch/tinytools.toggleswitch.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/tinymce/js/tinymce/jquery.tinymce.min.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/tinymce/js/tinymce/tinymce.min.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/inputmask.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/jquery.inputmask.js"></script>
		
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/ioscheckboxes/assets/js/jquery.mobileCheckbox.js"></script>
		
	 	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
	    <script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
	
		<script>
			var entity = '<%= entity %>';
			var type = '<%= type %>';
			var typeid = '<%= typeid %>';
			var group = '<%=group%>';
			var groupid = '<%=groupid%>';
			var grouptype = '<%=grouptype%>';
			var fullcontexturl = '<%=Config.fullcontexturl()%>';
			
			
			
			$(document).ready(function() {
			
			$('.emailcontrol').select2({
				  tags: true,
				  tokenSeparators: [',']
				});
			
			});
		</script>
	
	</head>
<body>

	<div id="fullpage">
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
	<div id="csuibody">
		<div id="csuimain">
		
			<div class="csuicontent">
				<table cellpadding="10" cellspacing="0" border="0" width="100%">
					<tr>
						<td align="left" id="title"><%= t.getTitle() %></td>
						<td align="right" id="subtitle"><%= t.getSubtitle() %></td>
					</tr>
				</table>
				
				<div id="csform_message"></div>
				<table class="csui_title">
					<tr>
						<td class="csui_title" nowrap>EMAIL</td>
					</tr>
				</table>
				<form class="form" action="action.jsp" method="post"  refresh="true" close="true">
					<input type="hidden" name="_ent" value="<%= entity %>">
					<input type="hidden" name="_type" value="<%= type %>">
					<input type="hidden" name="_typeid" value="<%= typeid %>">
					<input type="hidden" name="_grpid" value="<%= groupid %>">
					<input type="hidden" name="_grp" value="<%= group %>">
					<input type="hidden" name="_grptype" value="<%= grouptype %>">
					<input type="hidden" name="_id" value="<%= nav.getId() %>">
					<input type="hidden" name="_reference" value="<%= nav.getReference() %>">
					<input type="hidden" name="_act" value="<%= grouptype %>">
					<div class="csui_divider"></div>
					<div class="csui_buttons">
						<input type="submit" name="action" value="send" class="csui_button">
					</div>

					<table class="csui" colnum="2" type="default">
						<tr>
							<td class="csui_label" colnum="2" alert="">TO: </td>
							<td class="csui"> <select class="emailcontrol" name="email_bcc" multiple="multiple"  style="width:100%">
									 <%for(int i=0;i<g.getObj().length;i++){ 
									  	ObjVO e = g.getObj()[i];
									  %>
									  		<option value="<%= e.getFieldid() %>"><%= e.getLabel() %></option>
									  <%} %>
								</select>
							</td>
						</tr>
						
						
						<tr>
							<td class="csui_label" colnum="2" alert="">SUBJECT: </td>
							<td class="csui"> <input type="text" name="email_subject" id="email_to" value="<%=subject %>" ></td>
						</tr>
						
						<tr>
							<td class="csui_label" colnum="2" alert="">BODY: </td>
							<td class="csui"> <textarea name="email_body" id="email_to"><%=body %></textarea></td>
						</tr>
					
					</table>
					
				




				</form>
			</div>
		</div>
	</div>
	</div>


</body>
</html>

