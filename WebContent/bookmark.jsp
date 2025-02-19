<%@page import="cs.ui.CsUiTools"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="cs.search.GlobalSearch"%>
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
	String title = "Bookmark";
	String subtitle = "";
	String alert = "Bookmark";
	
	 if(!Operator.hasValue(map.token())){
			map.logout();
			map.redirect("index.jsp");
		}
	 
	 int bookmarkId = map.getInt("bookmarkId",0);
	 String action = map.getString("action");
	 if(action.equals("delete")){
		 GlobalSearch.deleteBookmark(bookmarkId);
	 }
	 
	 int userid = GlobalSearch.userId(map.token(), map.getRemoteIp());
	 JSONArray a = GlobalSearch.getBookmarks(userid);
%>
<html>
<head>

	<title>City Smart</title>
	<%= CsUiTools.getHTMLImports() %>
	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
	
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/tablesorter/css/theme.dropbox.css">
	
	
	<script language="JavaScript" src="<%=Config.fullcontexturl()%>/tools/jq/json2.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
		<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tablesorter/jquery.tablesorter.min.js"></script>
	
	<script>
	
	$(document).ready(function() {
		 $(".tablesorter").tablesorter(); 

		
	});
	
	function deletetype(id){
		var method = "deletetype";
		swal({  
				title: "Are you sure?",   
				text: "You want to delete this record!",   
				type: "warning",   
				showCancelButton: true,   
				confirmButtonColor: "#DD6B55",   
				confirmButtonText: "Yes, delete it!",   
				cancelButtonText: "No, cancel plx!",   
				closeOnConfirm: false,   
				closeOnCancel: false 
			}, 
			function(isConfirm){   
				if (isConfirm) {     
					
					document.forms[0].action = "bookmark.jsp?action=delete&bookmarkId="+id;
					document.forms[0].submit();
				
				} 
				else {    
					swal("Cancelled", "The record is safe :)", "error");  
				} 
			});
	}

	
	
	
	</script>
</head>

<body alert="<%= alert %>">
	<div id="csuicontrols">
		<div id="csuicontrol" class="csuicontrol <%= alert %>">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				&nbsp;
			</table>
		</div>
		
	</div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
			
			
				<form id="csform" action="bookmark.jsp" method="post">
				<input type="hidden" name="_act" value="reverse" >
				<input type="hidden" name="_grptype" value="finance" >
				<input type="hidden" name="_ent" value="finance" >
				
				
						<div class="csui_divider"></div>
						
					<table class="csui_title" >
							<tr>
								<td class="csui_title">BOOKMARKS</td>
							</tr>
							
						</table>		
					<table class="csui tablesorter" type="horizontal" >
						 <thead>
						
						<tr>
							
							<td class="csui_header">TITLE</td>
							<td class="csui_header">DESCRIPTION</td>
							<td class="csui_header">CREATED BY</td>
							<td class="csui_header">CREATED</td>
							<td class="csui_header">&nbsp;</td>
							<td class="csui_header" width="1%">&nbsp;</td>
							<td class="csui_header" width="1%">&nbsp;</td>
							<td class="csui_header" width="1%">&nbsp;</td>
							<td class="csui_header" width="1%">&nbsp;</td>
						</tr>
						</thead>
						<tbody>
					<%
					for(int l=0;l<a.length();l++){ 
						JSONObject r = a.getJSONObject(l);
						
					%>
					
					 
					
						<tr>
							
							<td class="csui"><a href="<%=r.getString("LOCATION") %>.jsp?bookmarkId=<%=r.getInt("ID") %>" target="_self"><%=r.getString("TITLE") %></a></td>
							<td class="csui"><a href="<%=r.getString("LOCATION") %>.jsp?bookmarkId=<%=r.getInt("ID") %>" target="_self"><%=r.getString("DESCRIPTION") %></a></td>
							<td class="csui" style="cursor:pointer;"  rel="<%=r.getString("ID") %>" ><%=r.getString("CREATED") %></td>
							<td class="csui" style="cursor:pointer;"  rel="<%=r.getString("ID") %>" ><%=r.getString("C_CREATED_DATE") %></td>
							<td class="csui" width="1%">
								<a href="<%=r.getString("LOCATION") %>.jsp?bookmarkId=<%=r.getInt("ID") %>" target="_self" title="view- <%=r.getString("TITLE") %>" ><img src="/cs/images/icons/controls/black/eye.png" border="0" style="cursor:pointer" ></a>
							</td>
							<td class="csui" width="1%">
								<a href="bookmarkedit.jsp?userId=<%=userid %>&bookmarkId=<%=r.getInt("ID") %>&title=<%=r.getString("TITLE") %>&shareId=<%=r.getInt("SHARE_ID") %>" target="lightbox-iframe" title="edit-<%=r.getString("TITLE") %>" ><img src="/cs/images/icons/controls/black/edit.png" border="0"></a>
								</td>
							<td class="csui" width="1%">
								<a href="bookmarkshare.jsp?userId=<%=userid %>&bookmarkId=<%=r.getInt("ID") %>&title=<%=r.getString("TITLE") %>&shareId=<%=r.getInt("SHARE_ID") %>" target="lightbox-iframe" title="share-<%=r.getString("TITLE") %>" ><img src="/cs/images/icons/controls/black/share.png" border="0" style="cursor:pointer"  ></a>
							</td>
							
							<td class="csui" width="1%">
								<a href="bookmarkemail.jsp?userId=<%=userid %>&bookmarkId=<%=r.getInt("ID") %>&title=<%=r.getString("TITLE") %>&shareId=<%=r.getInt("SHARE_ID") %>" target="lightbox-iframe" title="email-<%=r.getString("TITLE") %>" >
									<%if(r.getString("EMAIL_ON").equals("Y")){ %>
										<img src="/cs/images/icons/controls/color/email-green.png" border="0" style="cursor:pointer"   >
									<%} else {%>
										<img src="/cs/images/icons/controls/black/email.png" border="0" style="cursor:pointer"   >
									<%} %>
								</a>
							</td>
							
							
							
							<td class="csui" width="1%">
								<img src="/cs/images/icons/controls/black/delete.png" border="0" style="cursor:pointer" title="Delete-<%=r.getString("TITLE") %>" onclick="deletetype(<%=r.getString("ID") %>);" >
							</td>
						</tr>
						
						
					<%} %>
					</tbody>
					</table>	
					
			
			</div>
		</div>
		
	</div>

	</form>


</body>
</html>

