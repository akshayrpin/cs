<%@page import="java.util.List"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="org.json.JSONArray"%>
<%@page import="cs.search.GlobalSearch"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="alain.core.utils.Cartographer"%>

<%@page import="java.io.PrintStream"%>
<%@page import="java.nio.charset.Charset"%>

<%@ page import="java.io.ByteArrayOutputStream" %>
<%@page trimDirectiveWhitespaces="true" %> 
<%
Cartographer map = new Cartographer(request,response);
String contextroot = request.getContextPath();
JSONArray fields = GlobalSearch.getFields(map.getString("source"));
String bookmarkid = map.getString("bookmarkid","0");
List bookmarkFields = GlobalSearch.getExportFieldsForBookmark(bookmarkid);
int i=0; 
%>
<html>
	<head>
		<link href='https://fonts.googleapis.com/css?family=Oswald:300,700' rel='stylesheet' type='text/css'>
		<link href='https://fonts.googleapis.com/css?family=Armata' rel='stylesheet' type='text/css'>
		<link href='https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700' rel='stylesheet' type='text/css'>
		<link rel="stylesheet" type="text/css" href="<%=contextroot %>/tools/alain/cs.ui.css">
		<link rel="stylesheet" type="text/css" href="<%=contextroot %>/tools/sweetalert/dist/sweetalert.css">
		<style>
			.csui_controls { visibility: hidden }
		</style>
		<script type="text/javascript" src="<%= contextroot %>/tools/jquery.min.js"></script>
		<script type="text/javascript" src="<%= contextroot %>/tools/alain/cs.tools.js"></script>
		<script type="text/javascript" src="<%= contextroot %>/tools/chosen/chosen.jquery.js"></script>
		<script type="text/javascript" src="<%= contextroot %>/tools/tinymce/js/tinymce/jquery.tinymce.min.js"></script>
		<script type="text/javascript" src="<%= contextroot %>/tools/tinymce/js/tinymce/tinymce.min.js"></script>
		<script type="text/javascript" src="<%= contextroot %>/tools/inputmask/dist/inputmask/inputmask.js"></script>
		<script type="text/javascript" src="<%= contextroot %>/tools/inputmask/dist/inputmask/jquery.inputmask.js"></script>
		<script type="text/javascript" src="<%= contextroot %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
		<script type="text/javascript">
		
		 function openexport(){
	            var checkedchk = $("[id*=chkids] input:checked");
	            var columns = "";
				if(checkedchk.length >0){
					checkedchk.each(function () {
	                var value = $(this).val();
	                columns += value;
	                columns += ",";
	            });
			 	var url = "<%= Config.fullcontexturl() %>/actionsearch.jsp?fl="+columns;
			  	url += "&<%=request.getQueryString()%>";
				var n = url;
				window.open(n, "_blank");
				parent.jQuery.fancybox.close();
				} else {
					swal("Please select the columns to export");
				}
			}
		 
		 function selectall() {
			 var checkboxes = document.querySelectorAll('input[type="checkbox"]');
		     for (var i = 0; i < checkboxes.length; i++) {
		      if (checkboxes[i].type == 'checkbox')
		        checkboxes[i].checked = true;
		     }
		 }
		 
		 function unselectall() {
			 var checkboxes = document.querySelectorAll('input[type="checkbox"]');
		     for (var i = 0; i < checkboxes.length; i++) {
		      if (checkboxes[i].type == 'checkbox')
		        checkboxes[i].checked = false;
		     }
		 }
		</script>
	</head>
<body >

	<div class="csui_divider"></div>
						<!-- List TEMPLATES-->
					 <table class="csui_title" alert="warning">
							<tr>
								<td class="csui_title">CSV Download</td>
							</tr>
						</table>
					
					<table class="csui" type="horizontal">
							 <thead>
								<tr>
									<td class="csui_header" colspan="3">
									<div class="csui_buttons">
										<input type="button" name="action" value="Select All" class="csui_button" onclick="selectall()">
										<input type="button" name="action" value="Unselect All" class="csui_button" onclick="unselectall()">
										<input type="button" name="action" value="Download" class="csui_button" onclick="openexport()">
									</div>
									</td>
								</tr>
							</thead>
							 <tbody id="chkids">
							 	<tr id="tr_">
									<td class="csui" colspan="3" style="font-weight:bold;"><font color="red">Please select required column names that you would like to export to Excel </font></td>
								</tr>
								<%if(fields!=null){
								for(i=0; i<fields.length(); i++){ 
								%>
								<% if(i%2==0){ %>
								<tr>
								<%} boolean check = false; 
									if(bookmarkFields.contains(fields.getJSONObject(i).get("id"))){
										check = true;
									} else if(bookmarkFields.size() == 0 && fields.getJSONObject(i).get("export").equals("Y")){
										check = true;
									}
								%>
									<td class="csui" colspan="2"  width="22%">
									<%if(check) { %>
									<input type="checkbox" id="<%=fields.getJSONObject(i).get("field")%>" value="<%=Operator.toTitleCase(fields.getJSONObject(i).get("text").toString()).replaceAll(" ", "_SPACE_")%>:<%=fields.getJSONObject(i).get("field")%>" checked >
									<%} else { %>
									<input type="checkbox" id="<%=fields.getJSONObject(i).get("field")%>" value="<%=Operator.toTitleCase(fields.getJSONObject(i).get("text").toString()).replaceAll(" ", "_SPACE_")%>:<%=fields.getJSONObject(i).get("field")%>">
									<% } %>
									<%=Operator.toTitleCase(fields.getJSONObject(i).get("text").toString())%>
									</td>
									<% if(i%2==1){ %>
								</tr>
								<%}}} %>
								<%
									if(fields.length() % 2 == 1) { %>
									<td class="csui" colspan="2"  width="22%">&nbsp;</td> 
									</tr>
								<%} %>
							</tbody>
							
						</table>
</body>