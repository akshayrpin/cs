<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="alain.core.utils.Cartographer"%><%
Cartographer map = new Cartographer(request, response, true);
Timekeeper k = new Timekeeper();
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

				| <a href="index.jsp">LOGIN</a> | <a href="permits.jsp">PERMITS</a> | <a href="inspections.jsp">INSPECTIONS</a> | <a href="parking.jsp" class="current">PARKING</a> || <a href="finance.jsp" >FINANCE</a> |  <a href="review.jsp">REVIEW</a> 
				<br/><br/>
			
			<form method="POST" action="apipost.jsp" target="response">
				<input type="hidden" name="<%=RequestMapper.entity%>" value="parking"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="parking"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="parking"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">ACCOUNTS / CHOICES</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="listparkingaccounts">listParkingAccounts</option>
								<option value="listexemptiontypes">listexemptiontypes</option>
								<option value="listpermittypes">listpermittypes</option>
								<option value="parkingconfig">parkingconfig</option>
							
							</select>
						</td>
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
				<input type="hidden" name="<%=RequestMapper.entity%>" value="parking"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="parking"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="parking"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">PERMITS / EXEMPTIONS</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="listexemptions">list exemptions</option>
								<option value="listparkingpermits">list permits</option>
								<option value="listlastyeartypes">listlastyeartypes</option>
							</select>
						</td>
					</tr>

					<tr>
						<td>ACCOUNT</td>
						<td><input type="text" name="<%= RequestMapper.reference %>" value="13764" style="width: 350px"/></td>
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
				<input type="hidden" name="<%=RequestMapper.entity%>" value="parking"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="parking"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="project"/>
				<input name="APPLIED_DATE" type="hidden" itype="hidden" value="<%= k.getString("YYYY/MM/DD") %>" >
				<input name="ISSUED_DATE" type="hidden" itype="hidden" value="<%= k.getString("YYYY/MM/DD") %>" >
				<input name="VALUATION_DECLARED" type="hidden" itype="hidden" value="0" >
				<input name="VALUATION_CALCULATED" type="hidden" itype="hidden" value="0" >
				<input name="ONLINE" type="hidden" itype="hidden" value="Y" >
				<input name="SENSITIVE" type="hidden" itype="hidden" value="N" >
				<input name="PLAN_CHK_REQ" type="hidden" itype="hidden" value="N" >
				<input name="LKUP_ACT_STATUS_ID" type="hidden" itype="hidden" value="6" >
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">SAVE EXEMPTIONS / PERMIT</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="saveexemption">SAVE EXEMPTION</option>
								<option value="savepermit">SAVE PERMIT</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>TYPE ID/ PROJECT ID</td>
						<td><input type="text" name="<%= RequestMapper.typeid %>" value="" style="width: 350px" placeholder="YYYY/MM/DD"/></td>
					</tr>
					<tr>
						<td>LKUP ACT TYPE ID </td>
						<td><input type="text" name="LKUP_ACT_TYPE_ID" value="255" style="width: 350px"/></td>
					</tr>

					



					<tr>
						<td>Start Date</td>
						<td><input type="text" name="START_DATE" value="<%= k.getString("YYYY/MM/DD") %>" style="width: 350px" placeholder="YYYY/MM/DD"/></td>
					</tr>
					<tr>
						<td>End Date</td>
						<td><input type="text" name="EXP_DATE" value="<%= k.getString("YYYY/MM/DD") %>" style="width: 350px" placeholder="YYYY/MM/DD"/></td>
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
						<td>NO OF VEHICLES / QTY(FOR PERMIT)</td>
						<td><input type="text" name="QTY" value="1" style="width: 350px"/></td>
					</tr>
					
					<tr>
						<td>VEHICLE LIST SIZE (BOTTOM SECTION ONLY FOR OVERNIGHT EXEMPTION TYPE)</td>
						<td><input type="text" name="customsize" value="1" style="width: 350px"/></td>
					</tr>
					
					<tr>
						<td>LICENSE PLATE #</td>
						<td><input type="text" name="LICENSE_PLATE_0" value="5KL1234" style="width: 350px"/></td>
					</tr>
					
					<tr>
						<td>STATE</td>
						<td><input type="text" name="REG_STATE_0" value="CA" style="width: 350px"/></td>
					</tr>
					
					<tr>
						<td>MAKE</td>
						<td><input type="text" name="VEHICLE_MAKE_0" value="BMW" style="width: 350px"/></td>
					</tr>
					
					<tr>
						<td>MODEL</td>
						<td><input type="text" name="VEHICLE_MODEL_0" value="X" style="width: 350px"/></td>
					</tr>
					
					<tr>
						<td>COLOR</td>
						<td><input type="text" name="VEHICLE_COLOR_0" value="RED" style="width: 350px"/></td>
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
				<input type="hidden" name="request" value="availability"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="inspections"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="inspections"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">todo config</td>
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




















