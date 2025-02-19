<%@page import="cs.ui.CsUiTools"%>
<%@page import="org.json.JSONObject"%>
<%@page import="cs.search.GlobalSearch"%>
<%@page import="org.json.JSONArray"%>
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
	int bookmarkId = map.getInt("bookmarkId",0);
	int shareId = map.getInt("shareId",0);
	int userId = map.getInt("userId",0);
	
	String title = map.getString("title","");
	JSONArray sl = GlobalSearch.getStaff();
	JSONObject o = GlobalSearch.getBookmark(bookmarkId);
	boolean result = false;
	
	if(map.equalsIgnoreCase("action", "share")){
		result = GlobalSearch.shareControl(map);
	}
	
	
%><html>
	<head>
	
		<%= CsUiTools.getHTMLImports() %>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
		<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/ioscheckboxes/assets/css/mobileCheckbox.iOS.css">
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css">
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
		
		
	
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
		<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>
	
		<script>
		
			
			
			$(document).ready(function() {
				$(".chosen").chosen({width: "95%"});
				
				<% if(result){%>
				
				window.parent.$("#csform").submit();
		
				parent.$.fancybox.close();
				
				<% }%>
			
			
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
						<td align="left" id="title"><%=title %></td>
						<td align="right" id="subtitle">BOOKMARK MANAGER</td>
					</tr>
				</table>
				
				<div id="csform_message"></div>
				
				<table class="csui_title">
					<tr>
						<td class="csui_title" nowrap>SHARE</td>
					</tr>
				</table>
				<form class="form" action="bookmarkshare.jsp" method="post" ajax="no" >
						<input type="hidden" id="bookmarkId" name="bookmarkId" value="<%=bookmarkId%>">
						<input type="hidden" id="shareId" name="shareId" value="<%=shareId%>">
						<input type="hidden" id="userId" name="userId" value="<%=userId%>">
						<table class="csui" colnum="2" type="default">
						<tr>
							<td class="csui_label" colnum="2" alert="">SHARE </td>
							<td class="csui"> <select class="chosen" name="share" multiple="multiple"  style="width:100%">
									 <%for(int i=0;i<sl.length();i++){ 
									  	JSONObject e = sl.getJSONObject(i);
									  %>
									  		<option value="<%= e.getInt("ID") %>$<%= e.getString("USERNAME") %>" ><%= e.getString("FIRST_NAME") %>,<%= e.getString("LAST_NAME") %> - <%= e.getString("USERNAME") %> <%= e.getString("TITLE") %></option>
									  <% }%>
								</select>
							</td>
						</tr>
						<tr>
							<td class="csui_label" colnum="2" alert="">EMAIL RECURRENCE PATTERN</td>
								<td class="csui"> <select class="chosen" name="recurrence_pattern"   style="width:100%">
									<option value="">Please Select</option>
									<option value="daily">Daily</option>
									<option value="weekly">Weekly</option>
									<option value="monthly">Monthly</option>
								</select>
							</td>
						</tr>
					
					</table>
					
					<div class="csui_divider"></div>
					<div class="csui_buttons">
						<input type="submit" name="action" value="Share" class="csui_button">
					</div>

				</form>
				
				
				
				
				
				
			</div>
		</div>
	</div>
	</div>


</body>
</html>

