<%@page import="cs.ui.CsUiTools"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="csshared.vo.SubObjVO"%>
<%@page import="cs.common.ApiHandler"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="alain.core.utils.Cartographer"%>
<% 
	Cartographer map = new Cartographer(request,response,true);
	String entity = map.getString(RequestMapper.entity);
	int entityid = map.getInt(RequestMapper.entityid);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	String grp = map.getString(RequestMapper.group);
	String grpid = map.getString(RequestMapper.groupid);
	String grptype = map.getString(RequestMapper.grouptype);
	RequestVO req = RequestMapper.getRequest(map);


	SubObjVO[] res = new SubObjVO[0];
	if (map.hasValue("q")) {
		RequestVO sreq = new RequestVO();
		sreq.setEntity(entity);
		sreq.setEntityid(entityid);
		sreq.setType(type);
		sreq.setTypeid(typeid);
		sreq.setGrouptype(grptype);
		sreq.setRequest("search");
		sreq.setSearch(map.getString("q"));
		sreq.setOption(map.getString("t"));

		res = ApiHandler.searchPeople(sreq);
	}
	int l = res.length;
%>
<!DOCTYPE html>
<html>
<head>
<title>City Smart- V1</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

	<%= CsUiTools.getHTMLImports() %>

	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">

	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sticky/jquery.sticky.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>

	<script>
		function selectPeople(value, text) {
			var d = $('#div_choices');
			d.show();
			var f = $('#people_choices');
			var c = $('<input/>');
			c.attr('type','checkbox');
			c.attr('name','PEOPLE');
			c.attr('value',value);
			c.prop('checked', true);
			var tr = $('<tr/>');
			var ctd = $('<td/>');
			ctd.attr('width','1%');
			ctd.append(c);
			tr.append(ctd);
			var ttd = $('<td/>');
			ttd.attr('width','99%');
			ttd.html(text);
			tr.append(ttd);
			f.append(tr);
//			parent.$.fancybox.close();
		}

		function populateResults(data) {
			var t = $('#people_result');
			t.empty();
			var title = 'No Records Found';
			var l = data.length;
			if (l > 0) {
				if (l == 1) {
					title = '1 Record Found';
				}
				else {
					title = l + ' Records Found';
				}
			}
			var titletr = $('<tr/>');
			var titletd = $('<td/>');
			titletd.attr('colspan', '2');
			titletd.addClass('csui_defaulttitle');
			titletd.html(title);
			titletr.append(titletd);
			t.append(titletr);
			$.each(data, function(k,item) {
				var val = item.value;
				var txt = item.html
				var tr = $('<tr/>');

				var atd = $('<td/>');
				atd.attr('width','1%');
				var img = $('<img/>');
				img.attr('src','<%= CsConfig.getImage("black", "add") %>');
				atd.append(img);
				atd.css({
					'cursor':'pointer'
				})
				atd.click(function() {
					selectPeople(val,txt);
					tr.hide();
				});
				tr.append(atd);

				var ttd = $('<td/>');
				ttd.attr('width','99%');
				ttd.html(item.html);
				tr.append(ttd);
				t.append(tr);
			});
		}

		$(document).ready(function() {
			$('#peoplesearch').csform({
				callback: {
					submit: {
						response: function(e) { populateResults(e); }
					}
				}
			});
			$('#peoplesubmit').csform({
				callback: {
					submit: {
//						success: function(e) { populateResults(e); }
					}
				},
				url: {
					success: '<%=req.summaryUrl()%>'
				}
			});
			var f = $('#div_choices');
			f.sticky({ topSpacing: 0 });
			f.hide();
		});


	</script>
	<style>
		div.people_result { padding: 15px; border-bottom: 1px solid #cccccc }
		span.people_result { font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 12px; display: block }
	</style>


</head>

<body>

	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontrol">
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<td align="left">
								<table class="csui_tools">
									<tr>
										<td>
											<a href="<%= Config.fullcontexturl() %>/summary.jsp?_ent=<%= entity %>&_type=<%= type %>&_typeid=<%= typeid %>&_id=<%= typeid %>"><img src="<%= CsConfig.getImage("back") %>" height="25" width="25" border="0"/></a>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
			</div>
			<div class="csuicontent">
				<br/>
				<form method="post" action="peoplesearch.jsp" id="peoplesearch">
					<table cellpadding="5" cellspacing="0" border="0" width="100%" align="center">
						<tr>
							<td class="csui_defaulttitle" width="1%" nowrap>Search People</td>
							<td width="99%">
									<input type="text" name="q" class="cs_search"/>
							</td>
						</tr>
					</table>
					<input type="hidden" name="<%= RequestMapper.entity %>" value="<%= entity %>"/>
					<input type="hidden" name="<%= RequestMapper.entityid %>" value="<%= entityid %>"/>
					<input type="hidden" name="<%= RequestMapper.type %>" value="<%= type %>"/>
					<input type="hidden" name="<%= RequestMapper.typeid %>" value="<%= typeid %>"/>
					<input type="hidden" name="<%= RequestMapper.groupid %>" value="<%= grpid %>"/>
					<input type="hidden" name="<%= RequestMapper.group %>" value="<%= grp %>"/>
					<input type="hidden" name="<%= RequestMapper.grouptype %>" value="<%= grptype %>"/>
				</form>
				<br/><br/>
				<table cellpadding="0" cellspacing="0" border="0" align="center" width="100%">
					<tr>
						<td width="50%" valign="top">
							<table cellpadding="5" cellspacing="0" border="0" align="center" width="90%" id="people_result">
							</table>
						</td>
						<td width="50%" valign="top">
							<div id="div_choices" style="border-left: 1px solid #cccccc; padding-left: 20px">
								<form method="post" action="action.jsp" id="peoplesubmit">
									<table cellpadding="5" cellspacing="0" border="0" width="90%" id="people_choices">
										<tr>
											<td colspan="2" class="csui_defaulttitle">SELECTED</td>
										</tr>
									</table>
									<table cellpadding="5" cellspacing="0" border="0" width="100%">
										<tr>
											<td align="right"><input type="submit" name="action" value="save"></td>
										</tr>
									</table>
									<input type="hidden" name="<%= RequestMapper.entity %>" value="<%= entity %>"/>
									<input type="hidden" name="<%= RequestMapper.entityid %>" value="<%= entityid %>"/>
									<input type="hidden" name="<%= RequestMapper.type %>" value="<%= type %>"/>
									<input type="hidden" name="<%= RequestMapper.typeid %>" value="<%= typeid %>"/>

									<input type="hidden" name="<%= RequestMapper.groupid %>" value="<%= grpid %>"/>
									<input type="hidden" name="<%= RequestMapper.group %>" value="<%= grp %>"/>
									<input type="hidden" name="<%= RequestMapper.grouptype %>" value="<%= grptype %>"/>
								</form>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>

</body>

</html>




















