<%@page import="cs.ui.CsUiTools"%>
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


	Cartographer map = new Cartographer(request,response, true);
	RequestVO req = RequestMapper.getRequest(map);
	RequestVO nav = req.duplicate();
	nav.setAction(map.getString(RequestMapper.action));
//	nav.setRequest("details");
	if (map.equalsIgnoreCase(RequestMapper.action, "add")) {
		nav.setRequest("fields");
	}
	else {
		nav.setRequest("details");
	}
	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	String group = map.getString(RequestMapper.group);
	String groupid = map.getString(RequestMapper.groupid);
	String grouptype = map.getString(RequestMapper.grouptype);
	if (!Operator.hasValue(grouptype)) {
		grouptype = type;
	}

	SubObjVO[] status = new SubObjVO[0];
	if (Operator.equalsIgnoreCase(type, "activity") && typeid > 0) {
		RequestVO stvo = req.duplicate();
		stvo.setId("-1");
		stvo.setRequest("status");
		status = ApiHandler.getChoices(stvo);
	}

	RequestVO tpvo = req.duplicate();
	tpvo.setRequest("type");
	SubObjVO[] acttypes = ApiHandler.getChoices(tpvo);

	TypeVO o = ApiHandler.getType(nav);
	if (!o.isUpdate()) {
		o = new TypeVO();
		map.forward("403.jsp");
	}
	else if (!o.isAdmin() && Operator.hasValue(o.getHold())) {
		o = new TypeVO();
		map.forward("403h.jsp");
	}

	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();

	DataVO dvo = DataVO.toDataVO(o);

	TypeVO l = new TypeVO();
	if (dvo.isHistory() && dvo.getId() > 0) {
		RequestVO list = new RequestVO();
		list = req.duplicate();
		list.setGroupid(Operator.toString(dvo.getId()));
		list.setRequest("list");
		l = ApiHandler.getType(list);
	}

	RequestVO ureq = req.duplicate();
	ureq.setGrouptype("communications");
	ureq.setRequest("recipients");
	SubObjVO[] people = ApiHandler.getChoices(ureq);

	Timekeeper today = new Timekeeper();

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
			.fee_note_highlight { background-color: #8f6662 !important; color: #ffffff !important; }
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
				$('select[itype=acttype]').change(function() {
					var select = $('select[itype=acttype]');
					var acttypeid = select.val();
					var st = $('select[itype=status]');
					if (hasValue(st)) {
						var u = '_id=' + acttypeid + '&_type=activity&_request=status';
						st.empty();
						st.attr('json', u);
						st.attr('auto','false');
						jsonSelect(st, 'choices');
						try {
							select.trigger("chosen:updated");
						} catch(e) {}
					}
					var tselect = $('select[name=LKUP_ACT_TYPE_ID] option:selected');
					tselect.each(function() {
						var txt = $(this).text();
						var vl = $(this).val();
						var pexp = $(this).attr("PERMIT_EXPIRE");
						var aexp = $(this).attr("APPLICATION_EXPIRE");
						addType(vl, txt, aexp, pexp)
					});
					removeTypes();

//  					var pexp = tselect.attr("PERMIT_EXPIRE");
//  					var aexp = tselect.attr("APPLICATION_EXPIRE");
//  					var pinp = $('[name=EXP_DATE]');
//  					var ainp = $('[name=APPLICATION_EXP_DATE]');
//  					pinp.val(pexp);
//  					ainp.val(aexp);
				});
				$('select[name=LKUP_ACT_STATUS_ID]').change(function() {
					var modals = [];
					var stselect = $('select[name=LKUP_ACT_STATUS_ID] option:selected');
					try {
						var issdate = $('[name=ISSUED_DATE], [itype=issueddate]');
						if (hasValue(issdate.val())) {
							
						}
						else {
							var iss = stselect.attr("ISSUED");
							if (iss == 'Y') {
								swal({
									title: 'Issued',
									text: 'Do you want to add today\'s date to the Issued Date?',
									type: 'info',
									showCancelButton: true,
									confirmButtonColor: "#DD6B55",
									confirmButtonText: 'Yes',
									cancelButtonText: 'No',
									closeOnConfirm: true,
									closeOnCancel: true
								},
								function(isConfirm) {
									if (isConfirm) {
										issdate.val('<%=today.getString("YYYY/MM/DD")%>');
									}
								});
								
								updateDates(typeid);
							}
						}
					}
					catch(e) { cslog(e); }
					try {
						var isfdate = $('[name=FINAL_DATE], [itype=finaldate]');
						var isf = stselect.attr("FINAL");
						if (isf == 'Y') {
							swal({
								title: 'Final',
								text: 'Do you want to add today\'s date to the Final Date?',
								type: 'info',
								showCancelButton: true,
								confirmButtonColor: "#DD6B55",
								confirmButtonText: 'Yes',
								cancelButtonText: 'No',
								closeOnConfirm: true,
								closeOnCancel: true
							},
							function(isConfirm) {
								if (isConfirm) {
									isfdate.val('<%=today.getString("YYYY/MM/DD")%>');
								}
							});
						}
					}
					catch(e) { cslog(e); }
					if ($('#field_LKUP_ACT_TYPE_ID').text() == 'Certificate of Occupancy' ) {
						showPermanent();
					}
				});
				
				$('[name=EXP_DATE]').change(function () {
					showPermanent();
				});
				
				$('#SEND_EMAIL').click(function(e) {
					var div = $('#EMAILFORM');
					if ($('#SEND_EMAIL').is(':checked')) {
						div.show();
					}
					else {
						div.hide();
					}
				});
				
				$('#field_PLAN_CHK_REQ').click(function(e) {
					var tselect = $('select[name=LKUP_ACT_TYPE_ID] option:selected');
					tselect.each(function() {
						var vl = $(this).val();
						$('#EXP_DATE_'+ vl).val('');
					});
					
				});

				<%
				if (Operator.equalsIgnoreCase(type, "activity")) {
				%>
				$('[name=VALUATION_CALCULATED]').change(function() {
					var vf = $('[name=UPDATE_FEES]');
					if(!vf.is(':checked')) {
						swal({
							title: 'Valuation has changed',
							text: 'Do you want to update the valuation based fees associated with this activity?\n\nNote: Updating fees may affect past financial transactions.',
							type: 'warning',
							showCancelButton: true,
							confirmButtonColor: "#DD6B55",
							confirmButtonText: 'Yes',
							cancelButtonText: 'No',
							closeOnConfirm: true,
							closeOnCancel: true
						},
						function(isConfirm) {
							if (isConfirm) {
								vf.mobileCheckbox("checked", true);
							}
							highlightNote();
						});
					}
				});
				$('[name=UPDATE_FEES]').change(function() {
					highlightNote();
				})
				<%
				}
				%>
			});

			 
			function showPermanent() {
				swal({
					title: 'Permanent',
					text: 'Updating this status will create a permanent record for this project. Do you wish to proceed? ',
					type: 'info',
					showCancelButton: false,
					confirmButtonColor: "#DD6B55",
					confirmButtonText: 'Yes',
					cancelButtonText: 'No',
					closeOnConfirm: true,
					closeOnCancel: true
				});
			}
			
			function highlightNote() {
				var vf = $('[name=UPDATE_FEES]');
				var fn = $('#feenote');
				if(vf.is(':checked')) {
					fn.addClass('fee_note_highlight')
				}
				else {
					fn.removeClass('fee_note_highlight')
				}
			}

			function removeTypes() {
				var select = $('select[itype=acttype]');
				var str = select.val();
				var trs = $('#addtypetbl').find('tr.addtypecell');
				trs.each(function() {
					var tid = $(this).attr('rel');
					if (str && str.length > 0) {
						if (str.indexOf(tid) == -1) {
							$(this).remove();
						}
					}
					else {
						$(this).remove();
					}
				});
				var trs = $('#addtypetbl').find('tr.addtypecell');
				if (trs.length < 1) {
					$('#addtypetbl').hide();
				}
			}

			function addType(atype, text, appexpire, exp) {
				var ex = $('#tr_'+atype);
				if (ex && ex.length > 0) {
					
				}
				else {
					var tbl = $('#addtypetbl');
					var tr = $('<tr>');
					tr.attr('id','tr_'+atype);
					tr.attr('rel',atype);
					tr.addClass('addtypecell')
					tr.append(createCell(atype, 'name', text, 'text'));
					tr.append(createInteger(atype, atype, 1, 5));
					tr.append(createCell(atype, 'APPLIED_DATE_'+atype, '<%=today.getString("YYYY/MM/DD")%>', 'date'));
					tr.append(createCell(atype, 'START_DATE_'+atype, '', 'date'));
					tr.append(createCell(atype, 'ISSUED_DATE_'+atype, '', 'issueddate'));
					tr.append(createCell(atype, 'APPLICATION_EXP_DATE_'+atype, appexpire, 'date'));
					tr.append(createCell(atype, 'EXP_DATE_'+atype, exp, 'date'));
					tr.append(createCell(atype, 'FINAL_DATE_'+atype, '', 'finaldate'));
					tbl.append(tr);
					tbl.show();
				}
			}

			function createCell(id, name, value, itype) {
				var td = $('<td/>');
				td.addClass('csui');
				if (itype == 'text') {
					td.html(value);
				}
				else {
					var inp = $('<input/>');
					inp.attr('type','text');
					inp.attr('itype', itype);
					inp.attr('name', name);
					inp.attr('id', name);
					inp.val(value);
					inp.addClass('csform');
					inp.css({
						'border': '1px solid #cccccc',
						'padding':'8px',
						'width':'100%',
						'outline': 'none',
						'background-color': 'transparent',
						'box-sizing':'border-box',
						'-moz-box-sizing': 'border-box',
						'-webkit-box-sizing': 'border-box'
					});
					if (itype == 'date' || itype == 'issueddate') {
						inp.css({
							'background-image': 'url(/cs/images/icons/input/calendar.png)',
							'background-repeat': 'no-repeat',
							'background-position' : 'right 4px top 4px'
						})
						inp.datetimepicker({
							timepicker:false,
							format:'Y/m/d'
						});
					}
					td.html(inp);
				}
				return td;
			}

			function createInteger(id, name, value, max) {
				var td = $('<td/>');
				td.addClass('csui');
				var s = $('<select/>');
				s.attr('name', id);
				s.attr('id', id);
				for (i=0; i<max; i++) {
					var o = $('<option/>');
					o.attr('value', i+1);
					o.html(i+1);
					if (i+1 == value) {
						o.prop('selected', true);
					}
					s.append(o);
				}
				s.css({
					'border': '1px solid #cccccc',
					'padding':'8px',
					'width':'100%',
					'outline': 'none',
					'background-color': 'transparent',
					'box-sizing':'border-box',
					'-moz-box-sizing': 'border-box',
					'-webkit-box-sizing': 'border-box'
				});
				td.html(s);
				return td;
			}
			
			function updateDates(typeid){
				var method = "getupdatedates";
				var ty ="{}";
				$.ajax({
					  type: "POST",
					  url: "action.jsp?_act="+method,
					  dataType: 'json',		  
					  data: { 
						 _ent : "lso",
						 _type : "activity",
						 _typeid : typeid
					    },
					    success: function(output) {
					    	output = JSON.stringify(output);
					    	output = JSON.parse(output);
					    	var addldata = output['choices'][0]['addldata'];
					    	var adate = $('[name=APPLICATION_EXP_DATE], [itype=appexpdate]');
					    	adate.val(addldata['APPLICATION_EXPIRE']);
					    	var edate = $('[name=EXP_DATE], [itype=expdate]');
					    	edate.val(addldata['PERMIT_EXPIRE']);
					    },
				    error: function(data) {
				        swal('Your request was not processed. Please check your input data.');
				    }
				});
			}

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
			<div class="csuicontrol csuialert" alert="<%= alert %>">
				<div id="csuicontrol" class="csuicontrol csuialert" alert="<%= alert %>">
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<td align="left">
								<table class="csui_tools">
									<tr>
										<td class="csui_tools">
											<a href="<%= Config.fullcontexturl() %>/summary.jsp?_ent=<%= entity %>&_type=<%= type %>&_typeid=<%= typeid %>&_id=<%= typeid %>"><img src="<%= CsConfig.getImage("back") %>" height="25" width="25" border="0"/></a>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>

			</div>
			<div class="csuicontent">
				<table cellpadding="10" cellspacing="0" border="0" width="100%">
					<tr>
						<td align="left" id="title"><%= title %></td>
						<td align="right" id="subtitle"><%= subtitle %></td>
					</tr>
				</table>
				<div id="csform_message"></div>
				<table class="csui_title csuialert" alert="<%=alert%>">
					<tr>
						<td class="csui_title" nowrap>Activity</td>
					</tr>
				</table>
				<form class="form" action="action.jsp" method="post" success="<%=req.actionUrl()%>" refresh="true">
					<input type="hidden" name="_ent" value="<%= entity %>">
					<input type="hidden" name="_type" value="<%= type %>">
					<input type="hidden" name="_typeid" value="<%= typeid %>">
					<input type="hidden" name="_grpid" value="activity">
					<input type="hidden" name="_grp" value="activity">
					<input type="hidden" name="_grptype" value="activity">
					<input type="hidden" name="_id" value="<%= req.getId() %>">

					<table class="csui" colnum="2" type="default">
						<tr>
							<%= ObjTables.cells("LKUP_ACT_TYPE_ID", "ACTIVITY TYPE", dvo.getString("LKUP_ACT_TYPE_ID"), "select", "acttype", true, "csui", 1, acttypes, true, !Operator.equalsIgnoreCase(type, "activity")) %>
							<%= ObjTables.cells("LKUP_ACT_STATUS_ID", "STATUS", dvo.getString("LKUP_ACT_STATUS_ID"), "select", "status", true, "csui", 1, status, false, true) %>
						</tr>
						<tr>
							<td class="csui_label" id="label_DESCRIPTION" valign="top">DESCRIPTION</td>
							<td class="csui vertical csui_field" id="field_DESCRIPTION" valign="top" colspan="3"><textarea name="DESCRIPTION" itype="textarea" style="min-height: 50px" maxlength="250" onchange="showPermanent()"><%=dvo.getString("DESCRIPTION")%></textarea></td>
						</tr>
						<tr>
							<%= ObjTables.cells("PLAN_CHK_REQ", "PLAN CHECK REQUIRED", dvo.getString("PLAN_CHK_REQ"), "boolean", "boolean", false, "csui", true) %>
							<%= ObjTables.cells("VALUATION_DECLARED", "VALUATION DECLARED", dvo.getString("VALUATION_DECLARED"), "currency", "currency", false, "csui", true) %>
						</tr>
						<tr>
							<%= ObjTables.cells("INHERIT", "INHERIT", dvo.getString("INHERIT"), "boolean", "boolean", false, "csui", true) %>
							<%= ObjTables.cells("VALUATION_CALCULATED", "VALUATION CALCULATED", dvo.getString("VALUATION_CALCULATED"), "currency", "currency", false, "csui", true) %>
						</tr>
							<%
								if (Operator.equalsIgnoreCase(type, "activity")) {
							%>
									<tr>
										<%= ObjTables.cells("SENSITIVE", "SENSITIVE", dvo.getString("SENSITIVE"), "boolean", "boolean", false, "csui", true) %>
										<td class="csui_label" id="label_UPDATE_FEES" valign="top">UPDATE FEE VALUATION</td>
										<td class="csui vertical csui_field" id="field_UPDATE_FEES" valign="top">
											<table cellpadding="0" cellspacing="0" border="0" width="100%">
												<tr>
													<td width="1%" nowrap>
														<div><input name="UPDATE_FEES" type="checkbox" itype="boolean" value="Y" data-id="toggleCheckbox"></div>
													</td>
													<td width="99%" class="csui" id="feenote">Note: checking this value will affect fees and payments for this activity</td>
												</tr>
											</table>
										</td>
									</tr>
							<%
								} else {
							%>
								<tr>
									<%= ObjTables.cells("SENSITIVE", "SENSITIVE", dvo.getString("SENSITIVE"), "boolean", "boolean", false, "csui", true) %>
									<%= ObjTables.cells("CODE_ENFORCEMENT", "CODE ENFORCEMENT", dvo.getString("CODE_ENFORCEMENT"), "boolean", "boolean", false, "csui", true) %>
								</tr>
							<%
								}
							%>

							<%
								if (Operator.equalsIgnoreCase(type, "activity")) {
							%>
									<tr>
										<%= ObjTables.cells("APPLIED_DATE", "APPLIED DATE", dvo.getString("APPLIED_DATE"), "date", "date", 1, false, "csui", true) %>
										<%= ObjTables.cells("APPLICATION_EXP_DATE", "APPLICATION EXPIRATION DATE", dvo.getString("APPLICATION_EXP_DATE"), "date", "date", 1, false, "csui", true) %>
									</tr>
									<tr>
										<%= ObjTables.cells("START_DATE", "START DATE", dvo.getString("START_DATE"), "date", "date", 1, false, "csui", true) %>
										<%= ObjTables.cells("EXP_DATE", "PERMIT EXPIRATION DATE", dvo.getString("EXP_DATE"), "date", "date", 1, false, "csui", true) %>
									</tr>
									<tr>
										<%= ObjTables.cells("ISSUED_DATE", "ISSUED DATE", dvo.getString("ISSUED_DATE"), "date", "date", 1, false, "csui", true) %>
										<%= ObjTables.cells("FINAL_DATE", "FINAL DATE", dvo.getString("FINAL_DATE"), "date", "date", 1, false, "csui", true) %>
									</tr>
									<tr>
							<%
									if (people.length < 1) {
							%>
										<td class="csui_label">SEND EMAIL</td>
										<td class="csui vertical csui_field">No People records are associated with this activity</td>
							<%
									}
									else {
							%>
										<td class="csui_label">SEND EMAIL</td>
										<td class="csui vertical csui_field"><input type="checkbox" id="SEND_EMAIL" name="SEND_EMAIL" value="Y"/></td>
							<%
									}
							%>
										<%= ObjTables.cells("CODE_ENFORCEMENT", "CODE ENFORCEMENT", dvo.getString("CODE_ENFORCEMENT"), "boolean", "boolean", false, "csui", true) %>
									</tr>
							<%
								}
							%>
					</table>

					<%
						if (!Operator.equalsIgnoreCase(type, "activity")) {
					%>
					<br/>
					<table class="csui" alert="<%=alert%>" id="addtypetbl" style="display:none">
						<tr>
							<td class="csui_label">Activity Type</td>
							<td class="csui_label" type="short">Quantity</td>
							<td class="csui_label" type="short">Applied Date</td>
							<td class="csui_label" type="short">Start Date</td>
							<td class="csui_label" type="short">Issued Date</td>
							<td class="csui_label" type="short">Application Expiration</td>
							<td class="csui_label" type="short">Permit Expiration</td>
							<td class="csui_label" type="short">Final Date</td>
						</tr>
					</table>
					<%
						}
					%>

					<div id="EMAILFORM" style="display: none">
					<table class="csuisub_title" alert="<%=alert%>">
						<tr>
							<td class="csuisub_title" nowrap>Send Email Notification</td>
						</tr>
					</table>
					<table cellpadding="2" cellspacing="0" border="0" class="csui" type="horizontal" width="100%">
						<tr>
							<td class="csui_label" type="short">&nbsp;</td>
							<td class="csui_label" type="short">Primary</td>
							<td class="csui_label" type="short">User Type</td>
							<td class="csui_label">Recipient Name</td>
							<td class="csui_label" type="short">Recipient Email</td>
						</tr>
						<%
							StringBuilder nsb = new StringBuilder();
							for (int i=0; i<people.length; i++) {
								SubObjVO uvo = people[i];
								if (Operator.hasValue(uvo.getDescription())) {
									nsb.append("<tr>\n");
									nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csui\" type=\"short\"><input type=\"checkbox\" name=\"NOTIFY\" value=\"").append(uvo.getValue()).append("\" class=\"csform_checkbox\"/></td>");
									nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csui\">").append(uvo.getAddldata().get("PRIMARY_CONTACT")).append("</td>");
									nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csui\" type=\"short\">").append(uvo.getAddldata().get("TYPE")).append("</td>");
									nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"98%\" class=\"csui\">").append(uvo.getText()).append("</td>");
									nsb.append("<td style=\"border-top: 1px solid #eeeeee\" width=\"1%\" nowrap class=\"csui\" type=\"short\" align=\"right\">").append(uvo.getDescription()).append("</td>");
									nsb.append("</tr>");
								}
							}
						%>
						<%= nsb.toString() %>
					</table>
					<table cellpadding="2" cellspacing="0" border="0" class="csui" type="horizontal" width="100%">
						<tr>
							<td class="csui_label">Add Comment</td>
						</tr>
						<tr>
							<td class="csui"><textarea name="COMMENT" style=""></textarea></td>
						</tr>
					</table>
					</div>

					<div class="csui_divider"></div>
					<div class="csui_buttons"><input type="submit" name="action" value="save" class="csui_button"></div>


				</form>
			</div>
		</div>
	</div>
	</div>


</body>
</html>

