<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="alain.core.utils.Cartographer"%><%
Cartographer map = new Cartographer(request, response, true);
%>
<!DOCTYPE html>
<html style="width: 100%; height: 100%">
<head>
<title>City Smart- V1</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<style>
		td { font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: #000000 }
		a { color: #cccccc; text-decoration: none; font-size: 12px }
		a:hover { color: #000000 }
		a.current { font-weight: bold; color: #000000; text-decoration: none; font-size: 14px }
	</style>
</head>

<body style="width: 100%; height: 100%; padding: 0px; margin: 0px">


	<table cellpadding="30" cellspacing="0" border="0" style="width: 100%; height: 100%">
		<tr style="height: 100%">
			<td valign="top" style="width: 500px; height: 100%">

				| <a href="index.jsp">LOGIN</a> | <a href="permits.jsp">PERMITS</a> | <a href="inspections.jsp" class="current">INSPECTIONS</a> |  <a href="review.jsp">REVIEW</a> 




				<br/><br/>
			
				<form method="POST" action="apipost.jsp" target="response">
				<input type="hidden" name="<%=RequestMapper.entity%>" value="lso"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="inspections"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="permits"/>
				<input type="hidden" name="request" value="my"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">MY INSPECTIONS</td>
					</tr>
					<tr>
						<td>Token</td>
						<td><input type="text" name="token" value="" style="width: 350px"/></td>
					</tr>
			
					<tr>
						<td>IP</td>
						<td><input type="text" name="ip" value="<%= map.getRemoteIp() %>" style="width: 350px"/></td>
					</tr>
			
					<tr>
						<td colspan="2" nowrap>&nbsp;</td>
					</tr>
			
					<tr>
						<td>&nbsp;</td>
						<td><input name="action" type="submit" value="url"/>&nbsp;<input name="action" type="submit" value="request"/>&nbsp;<input name="action" type="submit" value="response"/></td>
					</tr>
			
				</table>
				</form>


				<br/><br/>
			
				<form method="POST" action="apipost.jsp" target="response">
				<input type="hidden" name="<%=RequestMapper.entity%>" value="lso"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="inspections"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="permits"/>
				<input type="hidden" name="request" value="activities"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">INSPECTABLE ACTIVITIES</td>
					</tr>
					<tr>
						<td>Token</td>
						<td><input type="text" name="token" value="" style="width: 350px"/></td>
					</tr>
			
					<tr>
						<td>IP</td>
						<td><input type="text" name="ip" value="<%= map.getRemoteIp() %>" style="width: 350px"/></td>
					</tr>
			
					<tr>
						<td colspan="2" nowrap>&nbsp;</td>
					</tr>
			
					<tr>
						<td>&nbsp;</td>
						<td><input name="action" type="submit" value="url"/>&nbsp;<input name="action" type="submit" value="request"/>&nbsp;<input name="action" type="submit" value="response"/></td>
					</tr>
			
				</table>
				</form>




				<br/><br/>
			
				<form method="POST" action="apipost.jsp" target="response">
				<input type="hidden" name="<%=RequestMapper.entity%>" value="lso"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="inspections"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="permits"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">INSPECTION TYPES</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="types">list inspection types</option>
								<option value="my">list all my inspections</option>
							</select>
						</td>
					</tr>

					<tr>
						<td>Permit Number</td>
						<td><input type="text" name="<%= RequestMapper.reference %>" value="BS1205552" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>Token</td>
						<td><input type="text" name="token" value="" style="width: 350px"/></td>
					</tr>
			
					<tr>
						<td>IP</td>
						<td><input type="text" name="ip" value="<%= map.getRemoteIp() %>" style="width: 350px"/></td>
					</tr>
			
					<tr>
						<td colspan="2" nowrap>&nbsp;</td>
					</tr>
			
					<tr>
						<td>&nbsp;</td>
						<td><input name="action" type="submit" value="url"/>&nbsp;<input name="action" type="submit" value="request"/>&nbsp;<input name="action" type="submit" value="response"/></td>
					</tr>
			
				</table>
				</form>
			
				<br/><br/>
			
				<form method="POST" action="apipost.jsp" target="response">
				<input type="hidden" name="<%=RequestMapper.entity%>" value="lso"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="inspections"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="activity"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">AVAILABILITY</td>
					</tr>
					<tr>
						<td>Inspection Type ID</td>
						<td>Use id from the result of an inspection type request above<br/><input type="text" name="<%= RequestMapper.apptsubtypeid %>" value="" style="width: 350px"/></td>
					</tr>

					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="availability">Start Date to End Date</option>
								<option value="month">Month of Start Date</option>
								<option value="day">Day of Start Date</option>
							</select>
						</td>
					</tr>


<%
	Timekeeper s = new Timekeeper();
	s.setDay(1);
	Timekeeper e = new Timekeeper();
	e.setDay(e.DAYS_IN_MONTH());

%>
					<tr>
						<td>Start Date</td>
						<td><input type="text" name="<%= RequestMapper.startdate %>" value="<%= s.getString("YYYY/MM/DD") %>" style="width: 350px" placeholder="YYYY/MM/DD"/></td>
					</tr>
					<tr>
						<td>End Date</td>
						<td><input type="text" name="<%= RequestMapper.enddate %>" value="<%= e.getString("YYYY/MM/DD") %>" style="width: 350px" placeholder="YYYY/MM/DD"/></td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2" align="right">Permit</td>
					</tr>
					<tr>
						<td>Permit Number</td>
						<td><input type="text" name="<%= RequestMapper.reference %>" value="BS1205552" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>... or Permit ID</td>
						<td><input type="text" name="<%= RequestMapper.typeid %>" value="" style="width: 350px"/></td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td>Token</td>
						<td><input type="text" name="token" value="" style="width: 350px"/></td>
					</tr>
			
					<tr>
						<td>IP</td>
						<td><input type="text" name="ip" value="<%= map.getRemoteIp() %>" style="width: 350px"/></td>
					</tr>
			
			
					<tr>
						<td colspan="2" nowrap>&nbsp;</td>
					</tr>
			
					<tr>
						<td>&nbsp;</td>
						<td><input name="action" type="submit" value="url"/>&nbsp;<input name="action" type="submit" value="request"/>&nbsp;<input name="action" type="submit" value="response"/></td>
					</tr>
			
				</table>
				</form>
			

				<br/><br/>
			
				<form method="POST" action="apipost.jsp" target="response">
				<input type="hidden" name="<%=RequestMapper.entity%>" value="lso"/>
				<input type="hidden" name="request" value="save"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="inspections"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="activity"/>
				<table cellpadding="5" cellspacing="0" border="0">

					<tr>
						<td colspan="2">SAVE</td>
					</tr>
					<tr>
						<td>Permit</td>
						<td><input type="text" name="<%= RequestMapper.reference %>" value="BS1205552" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>Inspection Type ID *</td>
						<td>Use id from the result of an inspection type request above<br/><input type="text" name="REVIEW_ID" value="" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>Subject</td>
						<td><input type="text" name="SUBJECT" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>Date *</td>
						<td><input type="text" name="DATE" style="width: 350px" placeholder="YYYY/MM/DD"/></td>
					</tr>
					<tr>
						<td>Time ID *</td>
						<td>Use id from the result of an availability request above<br/><input type="text" name="TIME" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>Token</td>
						<td><input type="text" name="token" value="" style="width: 350px"/></td>
					</tr>
			
					<tr>
						<td>IP</td>
						<td><input type="text" name="ip" value="<%= map.getRemoteIp() %>" style="width: 350px"/></td>
					</tr>
			
			
					<tr>
						<td colspan="2" nowrap>&nbsp;</td>
					</tr>
			
					<tr>
						<td>&nbsp;</td>
						<td><input name="action" type="submit" value="url"/>&nbsp;<input name="action" type="submit" value="request"/>&nbsp;<input name="action" type="submit" value="response"/></td>
					</tr>

				</table>
				</form>
			
				<br/><br/>

				<form method="POST" action="apipost.jsp" target="response">
				<input type="hidden" name="<%=RequestMapper.entity%>" value="lso"/>
				<input type="hidden" name="request" value="delete"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="inspections"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="activity"/>
				<table cellpadding="5" cellspacing="0" border="0">

					<tr>
						<td colspan="2">CANCEL</td>
					</tr>
					<tr>
						<td>Comboreview Review ID</td>
						<td><input type="text" name="<%= RequestMapper.id %>" value="" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>Notes</td>
						<td><input type="text" name="NOTES" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>Token</td>
						<td><input type="text" name="token" value="" style="width: 350px"/></td>
					</tr>
			
					<tr>
						<td>IP</td>
						<td><input type="text" name="ip" value="<%= map.getRemoteIp() %>" style="width: 350px"/></td>
					</tr>
			
			
					<tr>
						<td colspan="2" nowrap>&nbsp;</td>
					</tr>
			
					<tr>
						<td>&nbsp;</td>
						<td><input name="action" type="submit" value="url"/>&nbsp;<input name="action" type="submit" value="request"/>&nbsp;<input name="action" type="submit" value="response"/></td>
					</tr>

				</table>
				</form>
			


			</td>
			<td valign="top" style="height: 100%">
				<iframe src="white.html" name="response" style="width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px"></iframe>
			</td>


		</tr>
	</table>

</body>
</html>




















