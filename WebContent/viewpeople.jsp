<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.utils.CsApi"%>
<%@page import="org.omg.PortableInterceptor.SYSTEM_EXCEPTION"%>
<%@page import="alain.core.utils.Timekeeper"%>
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
	String id = req.getId();
	RequestVO nav = req.duplicate();
	nav.setAction(map.getString(RequestMapper.action));
//	nav.setRequest("details");
	if (map.equalsIgnoreCase(RequestMapper.action, "add")) {
		nav.setRequest("fields");
	}
	else {
		nav.setRequest("details");
	}

	TypeVO o = ApiHandler.getType(nav);
	RequestVO ntreq = req.duplicate();
 	ntreq.setGrouptype("users");
 	ntreq.setRequest("notes");
 	SubObjVO[] notes = ApiHandler.getChoices(ntreq);
	
 	RequestVO hreq = req.duplicate();
 	hreq.setGrouptype("users");
 	hreq.setRequest("holds");
 	hreq.setType("users");
 	
 	SubObjVO[] holds = ApiHandler.getChoices(hreq);

	RequestVO ureq = req.duplicate();
	ureq.setGrouptype("users");
	ureq.setRequest("refuser");
	SubObjVO[] refuser = ApiHandler.getChoices(ureq);
	String usersId="0";
	if(refuser.length>0){
	usersId=refuser[0].getAddldata().get("USERS_ID");
	}
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	String group = map.getString(RequestMapper.group);
	String groupid = map.getString(RequestMapper.groupid);
	String grouptype = map.getString(RequestMapper.grouptype);
	if (!Operator.hasValue(grouptype)) {
		grouptype = type;
	}

	DataVO dvo = DataVO.toDataVO(o);
	
	SubObjVO[] types = ApiHandler.getLkupObj("type", entity, "people", dvo.getInt("LKUP_USERS_TYPE_ID"));
	/* RequestVO treq = new RequestVO();
	treq.setGrouptype("people");
	treq.setRequest("type"); */
	//types = ApiHandler.getChoices(treq);
	TypeVO l = new TypeVO();
	if (dvo.isHistory() && dvo.getId() > 0) {
		RequestVO list = new RequestVO();
		list = req.duplicate();
		list.setGroupid(Operator.toString(dvo.getId()));
		list.setRequest("list");
		l = ApiHandler.getType(list);
	}

%><html>
	<head>
	
		<%= CsUiTools.getHTMLImports() %>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
		<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/ioscheckboxes/assets/css/mobileCheckbox.iOS.css">
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css">
		
	
		<style>
			.csui_controls { visibility: hidden }
		</style>
	
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/toggleswitch/tinytools.toggleswitch.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/tinymce/js/tinymce/jquery.tinymce.min.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/tinymce/js/tinymce/tinymce.min.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/inputmask.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/jquery.inputmask.js"></script>
		
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/ioscheckboxes/assets/js/jquery.mobileCheckbox.js"></script>
		
	 	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
	    <script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	
		<script>
			var entity = '<%= entity %>';
			var type = '<%= type %>';
			var typeid = '<%= typeid %>';
			var group = '<%=group%>';
			var groupid = '<%=groupid%>';
			var grouptype = '<%=grouptype%>';
			var fullcontexturl = '<%=Config.fullcontexturl()%>';
			$(document).ready(function() {
				$('#editpeople').csform({
					callback: {
						submit: {
							success: function(d) { select(d); }
						}
					}
				});
				$('input[name=USERNAME]').change(function() {
					refreshData('username');
				});
				$('#verifylicense').click(function() {
					verifyLicense();
				});
				$('select[name=LKUP_USERS_TYPE_ID]').change(function() {
					refreshData('license');
					toggleLicense();
				});
				toggleLicense();
			});
			function select(d) {
				var pid = d.id;
			 	var pname = d.info['NAME'];
			 	var pemail = d.info['EMAIL'];
			 	var pusername = d.info['USERNAME'];
			 	var pgroup = ''; //d.info['group'];
			 	var paddress = d.info['ADDRESS'];
			 	var plic = ''; //d.info['license'];
			 	var ptype = d.info['TYPE'];
			 	parent.refreshGroup('people');
			 	parent.refreshGroup('peoplesummary');
			 	parent.$.fancybox.close();
			}
			function refreshData(req) {
				if (req == 'license') {
// 					$('input[name=FIRST_NAME]').val('');
// 					$('input[name=MIDDLE_NAME]').val('');
// 					$('input[name=LAST_NAME]').val('');
// 					$('input[name=PHONE_WORK]').val('');
// 					$('input[name=PHONE_CELL]').val('');
// 					$('input[name=PHONE_HOME]').val('');
// 					$('input[name=EMAIL]').val('');
// 					$('input[name=FAX]').val('');
// 					$('input[name=ADDRESS]').val('');
// 					$('input[name=CITY]').val('');
// 					$('input[name=STATE]').val('');
// 					$('input[name=ZIP]').val('');
					$('input[name=LIC_NO]').val('');
					$('input[name=LIC_EXP_DT]').val('');
					$('input[name=BUS_LIC_NO]').val('');
					$('input[name=BUS_LIC_EXP_DT]').val('');
					$('input[name=GEN_LIABILITY_DT]').val('');
					$('input[name=AUTO_LIABILITY_DT]').val('');
					$('input[name=WORK_COMP_EXP_DT]').val('');
				}
				var d = datamap(req);
				var url = '/cs/json/post.jsp';
				var r = doAjax(url, d);
				var id = r.id;
				if (id && id > 0) {
					swal({
						title: 'User Found',
						text: 'A user with the username you entered has been found. Do you want to autofill the fields with the existing information?',
						type: "warning",
						showCancelButton: true,
						confirmButtonColor: "#DD6B55",
						confirmButtonText: 'Yes',
						cancelButtonText: 'No',
						closeOnConfirm: true,
						closeOnCancel: true
					},
					function(isConfirm) {
						if (isConfirm) {
							var info = r.info;
							if (req != 'license') {
								$('input[name=FIRST_NAME]').val(info['FIRST_NAME']);
								$('input[name=MIDDLE_NAME]').val(info['MIDDLE_NAME']);
								$('input[name=LAST_NAME]').val(info['LAST_NAME']);
								$('input[name=PHONE_WORK]').val(info['PHONE_WORK']);
								$('input[name=PHONE_CELL]').val(info['PHONE_CELL']);
								$('input[name=PHONE_HOME]').val(info['PHONE_HOME']);
								$('input[name=EMAIL]').val(info['EMAIL']);
								$('input[name=FAX]').val(info['FAX']);
								$('input[name=ADDRESS]').val(info['ADDRESS']);
								$('input[name=CITY]').val(info['CITY']);
								$('input[name=STATE]').val(info['STATE']);
								$('input[name=ZIP]').val(info['ZIP']);
							}
							$('input[name=LIC_NO]').val(info['LIC_NO']);
							$('input[name=LIC_EXP_DT]').val(info['LIC_EXP_DT']);
							$('input[name=BUS_LIC_NO]').val(info['BUS_LIC_NO']);
							$('input[name=BUS_LIC_EXP_DT]').val(info['BUS_LIC_EXP_DT']);
							$('input[name=GEN_LIABILITY_DT]').val(info['GEN_LIABILITY_DT']);
							$('input[name=AUTO_LIABILITY_DT]').val(info['AUTO_LIABILITY_DT']);
							$('input[name=WORK_COMP_EXP_DT]').val(info['WORK_COMP_EXP_DT']);
						}
					});
				}
			}
			function toggleLicense() {
				var typ = $('select[name=LKUP_USERS_TYPE_ID]');
				var req = typ.find('option:selected').attr('REQUIRED_LICENSE');
				var ver = typ.find('option:selected').attr('VALIDATE_LICENSE_URL');
				try {
					var d = $('#licensediv');
					if (req == 'Y') {
						d.show();
						if (!hasValue(ver)) { $('#verifylicense').hide(); }
						else { $('#verifylicense').show(); }
					}
					else {
						d.hide();
					}
				} catch(e) { }
			}
			function verifyLicense() {
				var typ = $('select[name=LKUP_USERS_TYPE_ID]');
				var ver = typ.find('option:selected').attr('VALIDATE_LICENSE_URL');
				var lic = $('input[name=LIC_NO]').val();
				var u = ver.replace('<LIC_NO>',lic);
				window.open(u); 
			}
			function datamap(req) {
				var ref = $('input[name=USERNAME]').val();
				var typ = $('select[name=LKUP_USERS_TYPE_ID]').val();
				r = {
					'_ent': '<%=entity%>',
					'_type': '<%=type%>',
					'_typeid': '<%=typeid%>',
					'_reference': ref,
					'_grp': 'people',
					'_grptype': 'people',
					'_request': req,
					'username': ref,
					'usertype': typ
					
				}
				return r;
			}
			function deletenotes(id){
				var method = "deleteNotes";
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
							$.ajax({
					   			  type: "POST",
					   			  url: "action.jsp?_act="+method,
					   			  dataType: 'json',		  
					   			  data: { 
					   			   	  _ent : "lso",
					   			   	  _type : "<%=type%>",
					   				  _typeid : "<%=typeid%>",
					   				  _grpid : "notes",
					   				  _grp : "notes",
					   				  _grptype : "notes",
					   				  _id : id
					   				
					   			    },
					   			    success: function(output) {
					   			    		$('#tr_'+id).remove();
					   			    		swal("Deleted!", "The record has been deleted.", "success"); 
					   			    		
					   			    		
					   			    },
					   		    error: function(data) {
					   		    	swal("Problem while perfoming delete looks like the server is busy");  
					   		    }
				   			});		
						
						} 
						else {    
							swal("Cancelled", "The record is safe :)", "error");  
						} 
						refreshPage();
					});
				
			}
			function deleteholds(id){
				var method = "delete";
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
							$.ajax({
					   			  type: "POST",
					   			  url: "action.jsp?_act="+method,
					   			  dataType: 'json',		  
					   			  data: { 
					   			   	  _ent : "lso",
					   			   	  _type : "users",
					   				  _typeid : "<%=usersId%>",
					   				  _grpid : "holds",
					   				  _grp : "holds",
					   				  _grptype : "holds",
					   				  _id : id
					   				
					   			    },
					   			    success: function(output) {
					   			    		$('#tr_'+id).remove();
					   			    		swal("Deleted!", "The record has been deleted.", "success"); 
					   			    		
					   			    		
					   			    },
					   		    error: function(data) {
					   		    	swal("Problem while perfoming delete looks like the server is busy");  
					   		    }
				   			});		
						
						} 
						else {    
							swal("Cancelled", "The record is safe :)", "error");  
						} 
						refreshPage();
					});
				
			}
			function refreshPage(){
				document.location.href = "viewpeople.jsp?_ent=<%= entity %>&_type=<%= type %>&_grptype=people&_typeid=<%= typeid %>&_id=<%=id %>";
				
			}
		</script>
	
	</head>
<body>

	<div id="fullpage">
	<div id="loader"></div>
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontent">
				<table cellpadding="10" cellspacing="0" border="0" width="100%">
					<tr>
						<td align="left" id="title"><%= title %></td>
						<td align="right" id="subtitle"><%= subtitle %></td>
					</tr>
				</table>
				<div id="csform_message"></div>
		
						<table class="csui_title csuialert" alert="picked up">
							<tr>
								<td class="csui_title">USER</td>
								<td class="csui_controls">&nbsp;</td>
							</tr>
						</table>
						<table class="csui">
							<tr>
							<%= ObjTables.cells("USERNAME", "USERNAME", "", dvo.getString("USERNAME"), "String", "text", false, "csui", 1, new SubObjVO[0], false, false) %>
							<%= ObjTables.cells("LKUP_USERS_TYPE_ID", "TYPE", dvo.getString("LKUP_USERS_TYPE_ID"), "String", "text", true, "csui", 1, types, false, false) %>
							</tr>
						</table>
						<table class="csui_title csuialert" alert="picked up">
							<tr>
								<td class="csui_title">CONTACT</td>
								<td class="csui_controls">&nbsp;</td>
							</tr>
						</table>
						<table class="csui">
							<tr>
							<%= ObjTables.cells("FIRST_NAME", "FIRST NAME", dvo.getString("FIRST_NAME"), "String", "text", true, "csui", false) %>
							<%= ObjTables.cells("EMAIL", "EMAIL", dvo.getString("EMAIL"), "String", "text", false, "csui", false) %>
							</tr>
							<tr>
							<%= ObjTables.cells("MIDDLE_NAME", "MIDDLE NAME", dvo.getString("MIDDLE_NAME"), "String", "text", false, "csui", false) %>
							<%= ObjTables.cells("PHONE_WORK", "PHONE (WORK)", dvo.getString("PHONE_WORK"), "String", "phone", false, "csui", false) %>
							</tr>
							<tr>
							<%= ObjTables.cells("LAST_NAME", "LAST NAME", dvo.getString("LAST_NAME"), "String", "text", false, "csui", false) %>
							<%= ObjTables.cells("PHONE_CELL", "PHONE (CELL)", dvo.getString("PHONE_CELL"), "String", "phone", false, "csui", false) %>
							</tr>
							<tr>
							<%= ObjTables.cells("ADDRESS", "ADDRESS", dvo.getString("ADDRESS"), "String", "text", false, "csui", false) %>
							<%= ObjTables.cells("PHONE_HOME", "PHONE (HOME)", dvo.getString("PHONE_HOME"), "String", "phone", false, "csui", false) %>
							</tr>
							<tr>
							<%= ObjTables.cells("CITY", "CITY", dvo.getString("CITY"), "String", "text", false, "csui", false) %>
							<%= ObjTables.cells("FAX", "FAX", dvo.getString("FAX"), "String", "phone", false, "csui", false) %>
							</tr>
							<tr>
							<%= ObjTables.cells("STATE", "STATE", dvo.getString("STATE"), "String", "text", false, "csui", false) %>
							<%= ObjTables.cells("ZIP", "ZIP", dvo.getString("ZIP"), "String", "text", false, "csui", false) %>
							</tr>
							<tr>
							<%= ObjTables.cells("COPYAPPLICANT", "COPY AS APPLICANT", "", "Boolean", "boolean", false, "csui", false) %>
							<td class="csui_label" colspan="2">&nbsp;</td>
							</tr>
						</table>
						<div id="licensediv" style="display: none">
						<table class="csui_title csuialert" alert="picked up">
							<tr>
								<td class="csui_title">LICENSE</td>
								<td class="csui_title" id="verifylicense" style="cursor: pointer"><img src="/cs/images/icons/white/cloudverify.png" width="20" height="20" title="verify license number"/></td>
							</tr>
						</table>
						<table class="csui">
							<tr>
							<%= ObjTables.cells("LIC_NO", "LICENSE NUMBER", dvo.getString("LIC_NO"), "String", "text", false, "csui", false) %>
							<%= ObjTables.cells("LIC_EXP_DT", "EXPIRATION", dvo.getString("LIC_EXP_DT"), "String", "date", false, "csui", false) %>
							</tr>
							<tr>
							<%= ObjTables.cells("GEN_LIABILITY_DT", "GENERAL LIABILITY DATE", dvo.getString("GEN_LIABILITY_DT"), "String", "date", false, "csui", false) %>
							<%= ObjTables.cells("AUTO_LIABILITY_DT", "AUTO LIABILITY DATE", dvo.getString("AUTO_LIABILITY_DT"), "String", "date", false, "csui", false) %>
							</tr>
							<tr>
							<%= ObjTables.cells("WORK_COMP_EXP_DT", "WORKERS COMP EXPIRATION DATE", dvo.getString("WORK_COMP_EXP_DT"), "String", "date", false, "csui", false) %>
							<td class="csui_label" colspan="2">&nbsp;</td>
							</tr>
						</table>
						</div>
		
						<div class="csui_divider"></div>
						<div class="csui_buttons"><a href="updatepeople.jsp?_ent=<%= entity %>&_type=<%= type %>&_grptype=<%= grouptype %>&_id=<%= id %>&_typeid=<%= typeid %>" class="button">Edit this user</a></div>
		<br>
				</form>
				
					<div class="csui_divider"></div>
					<table class="csui_title csuialert" alert="picked up">
						<tr>
							<td class="csui_title">holds</td>
							<td class="csui_tools">
							<a  href="userholds.jsp?_ent=lso&_entid=0&_id=<%=id %>&_type=<%=type %>&_typeid=<%=typeid %>&_grpid=<%=usersId%>&users_type_id=<%=dvo.getString("LKUP_USERS_TYPE_ID") %>&_grp=holds&_grptype=holds&_act=add" ><img src="/cs/images/icons/controls/white/add.png" border="0"></a>&nbsp;</td> 
						</tr>
					</table>
					
				<%
					int hold1 = holds.length;
				
					if (hold1 > 0) {
				%>
				<table cellpadding="5" cellspacing="0" border="0" itype="holds" class="csui" width="100%" id="holds_table">
					<tr>
					<td style="border-top: 1px solid #eeeeee" width="1%" nowrap class="csui_label" valign="top">Type</td>
					<td style="border-top: 1px solid #eeeeee" width="98%" class="csui_label" valign="top">DESCRIPTION</td>
					<td style="border-top: 1px solid #eeeeee" width="98%" class="csui_label" valign="top">STATUS</td>
					<td style="border-top: 1px solid #eeeeee" width="1%" nowrap class="csui_label" valign="top">CREATED</td>
					<td style="border-top: 1px solid #eeeeee" width="1%" nowrap class="csui_label" valign="top">&nbsp;</td>
					</tr>

					<%
						StringBuilder nsb = new StringBuilder();
						for (int i = 0; i < hold1; i++) {
							SubObjVO st = holds[i];
							String cr = st.getData("CREATED_DATE");
							nsb.append("<tr>\n");
							nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csui csui_field\" valign=\"top\">").append("<a  href=\"userholds.jsp?_ent=lso&_entid=0&_id="+st.getId()+"&users_type_id="+dvo.getString("LKUP_USERS_TYPE_ID")+"&PEOPLE_ID="+id+"&_type="+type+"&_typeid="+typeid+"&_grpid="+st.getAddldata().get("HOLDS")+"&_grp=holds&_grptype=holds\" class=\"csui\" >").append(st.getAddldata().get("LKUP_HOLDS_TYPE_TEXT")).append("</a></td>");
							nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"98%\" class=\"csui csui_field\" valign=\"top\">").append("<a  href=\"userholds.jsp?_ent=lso&_entid=0&_id="+st.getId()+"&users_type_id="+dvo.getString("LKUP_USERS_TYPE_ID")+"&PEOPLE_ID="+id+"&_type="+type+"&_typeid="+typeid+"&_grpid="+st.getAddldata().get("HOLDS")+"&_grp=holds&_grptype=holds\" class=\"csui\" >").append(st.getDescription()).append("</a></td>");
							nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"98%\" class=\"csui csui_field\" valign=\"top\">").append("<a  href=\"userholds.jsp?_ent=lso&_entid=0&_id="+st.getId()+"&users_type_id="+dvo.getString("LKUP_USERS_TYPE_ID")+"&PEOPLE_ID="+id+"&_type="+type+"&_typeid="+typeid+"&_grpid="+st.getAddldata().get("HOLDS")+"&_grp=holds&_grptype=holds\" class=\"csui\" >").append(st.getAddldata().get("LKUP_HOLDS_STATUS_TEXT")).append("</a></td>");
							nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csui csui_field\" valign=\"top\">");
							nsb.append("<a  href=\"userholds.jsp?_ent=lso&_entid=0&_id="+st.getId()+"&users_type_id="+dvo.getString("LKUP_USERS_TYPE_ID")+"&PEOPLE_ID="+id+"&_type="+type+"&_typeid="+typeid+"&_grpid="+st.getAddldata().get("HOLDS")+"&_grp=holds&_grptype=holds\" class=\"csui\" >");
							if (Operator.hasValue(cr)) {
								Timekeeper d = new Timekeeper();
								d.setDate(cr);
								nsb.append(d.getString("MM-DD-YYYY @ HH:MM"));
							}
							nsb.append("</a></td>");
							nsb.append("<td class=\"csui\" width=\"1%\"><a href=\"#\" title=\"Delete\" onclick=\"deleteholds("+st.getId()+");\" ><img src=\""+Config.fullcontexturl()+"/images/icons/controls/black/delete.png\" border=\"0\"></a></td>");
							nsb.append("</tr>");
						}
						out.print(nsb.toString());
					%>
				</table>
				<% } %>
				<div class="csui_divider"></div>
				<table class="csui_title csuialert" alert="picked up">
						<tr>
							<td class="csui_title">notes</td>
							<td class="csui_tools">
							<a  href="usernotes.jsp?_ent=lso&_entid=-1&_id=<%=id %>&_type=activity&_typeid=<%=typeid %>&_grp=users&_grptype=notes&_act=add" ><img src="/cs/images/icons/controls/white/add.png" border="0"></a>&nbsp;</td>
						</tr>
					</table>
					
				<%
					int ntl = notes.length;
					if (ntl > 0) {
				%>
				<table cellpadding="5" cellspacing="0" border="0" itype="notes" class="csui" width="100%" id="notes_table">
					<tr>
					<td style="border-top: 1px solid #eeeeee" width="1%" nowrap class="csui_label" valign="top">Type</td>
					<td style="border-top: 1px solid #eeeeee" width="98%" class="csui_label" valign="top">Note</td>
					<td style="border-top: 1px solid #eeeeee" width="1%" nowrap class="csui_label" valign="top">Date</td>
					<td style="border-top: 1px solid #eeeeee" width="1%" nowrap class="csui_label" valign="top">&nbsp;</td>
					</tr>

					<%
						StringBuilder nsb = new StringBuilder();
						for (int i = 0; i < ntl; i++) {
							SubObjVO st = notes[i];
							String cr = st.getData("CREATED_DATE");
							nsb.append("<tr>\n");
							nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csui csui_field\" valign=\"top\">").append(st.getDescription()).append("</td>");
							nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"98%\" class=\"csui csui_field\" valign=\"top\">").append(st.getText()).append("</td>");
							nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csui csui_field\" valign=\"top\">");
							if (Operator.hasValue(cr)) {
								Timekeeper d = new Timekeeper();
								d.setDate(cr);
								nsb.append(d.getString("MM-DD-YYYY @ HH:MM"));
							}
							nsb.append("</td>");
							nsb.append("<td class=\"csui\" width=\"1%\"><a href=\"#\" title=\"Delete\" onclick=\"deletenotes("+st.getId()+");\" ><img src=\""+Config.fullcontexturl()+"/images/icons/controls/black/delete.png\" border=\"0\"></a></td>");
							nsb.append("</tr>");
						}
						out.print(nsb.toString());
					%>
				</table>
				<% } %>
			

				
			</div>
		</div>
	</div>
	</div>


</body>
</html>

