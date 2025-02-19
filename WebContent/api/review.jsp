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

				| <a href="index.jsp">LOGIN</a> | <a href="permits.jsp">PERMITS</a> | <a href="inspections.jsp">INSPECTIONS</a> | <a href="parking.jsp" >PARKING</a> | <a href="finance.jsp" >FINANCE</a> | <a href="review.jsp" class="current">REVIEW</a> |
				<br/><br/>
			
			
			
			
			
				<form method="POST" action="apipost.jsp" target="response">
				<input type="hidden" name="<%=RequestMapper.entity%>" value="lso"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="activity"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">REVIEW DETAILS</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="details">details</option>
								
							</select>
						</td>
					</tr>
					<tr>
						<td>CYCLE ID</td>
						<td><input type="text" name="_id" value="868940" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>PERMIT ID</td>
						<td><input type="text" name="_typeid" value="3316488" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>GROUP</td>
						<td><input type="text" name="_grp" value="" style="width: 350px"/></td>
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
				<input type="hidden" name="<%=RequestMapper.entity%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="activity"/>

				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">CYCLE CREATE</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="create">create</option>
								
								
							</select>
						</td>
					</tr>
					<tr>
						<td>PERMIT ID</td>
						<td><input type="text" name="_typeid" value="3316488" style="width: 350px"/></td>
					</tr>
					
					<tr>
						<td>GROUP</td>
						<td><input type="text" name="_grp" value="Multi-Agency Plan Review" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>GROUP ID </td>
						<td><input type="text" name="_grpid" value="509" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>TITLE </td>
						<td><input type="text" name="TITLE" value="" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>Start Date</td>
						<td><input type="text" name="START_DATE" value="<%= k.getString("YYYY/MM/DD") %>" style="width: 350px" placeholder="YYYY/MM/DD"/></td>
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
				<input type="hidden" name="<%=RequestMapper.entity%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="activity"/>

				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">CYCLE UPDATE</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="update">update</option>
							
							</select>
						</td>
					</tr>
				
					<tr>
						<td>CYCLE ID</td>
						<td><input type="text" name="_id" value="868944" style="width: 350px"/></td>
					</tr>
					
					<tr>
						<td>TITLE </td>
						<td><input type="text" name="TITLE" value="" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>Start Date</td>
						<td><input type="text" name="START_DATE" value="<%= k.getString("YYYY/MM/DD") %>" style="width: 350px" placeholder="YYYY/MM/DD"/></td>
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
				<input type="hidden" name="<%=RequestMapper.entity%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="activity"/>

				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">ADD</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="add">add</option>
								</select>
						</td>
					</tr>
					<tr>
						<td>PERMIT ID</td>
						<td><input type="text" name="_typeid" value="3316488" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>CYCLE ID</td>
						<td><input type="text" name="_id" value="868950" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>GROUP</td>
						<td><input type="text" name="_grp" value="Multi-Agency Plan Review" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>GROUP ID </td>
						<td><input type="text" name="_grpid" value="509" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>REVIEW ID </td>
						<td><input type="text" name="REVIEW_ID" value="1481" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>LKUP REVIEW STATUS ID </td>
						<td><input type="text" name="LKUP_REVIEW_STATUS_ID" value="774" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>DUE DATE</td>
						<td><input type="text" name="DUE_DATE" value="<%= k.getString("YYYY/MM/DD") %>" style="width: 350px" placeholder="YYYY/MM/DD"/></td>
					</tr>
					<tr>
						<td>REVIEW COMMENTS </td>
						<td><input type="text" name="REVIEW_COMMENTS" value="" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>ATTACHMENT TITLE </td>
						<td><input type="text" name="ATTACHMENT_TITLE" value="" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>ATTACHMENT TYPE ID </td>
						<td><input type="text" name="ATTACHMENT_TYPE_ID" value="3" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>ATTACHMENT DESCRIPTION </td>
						<td><input type="text" name="ATTACHMENT_DESCRIPTION" value="" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>ATTACHMENT </td>
						<td><input type="file" name="ATTACHMENT" value="" style="width: 350px"/></td>
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
				<input type="hidden" name="<%=RequestMapper.entity%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="activity"/>

				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">SAVE TEAM</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="saveteam">saveteam</option>
								</select>
						</td>
					</tr>
					<tr>
						<td>PERMIT ID</td>
						<td><input type="text" name="_typeid" value="3316488" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>CYCLE ID</td>
						<td><input type="text" name="_id" value="868950" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>REVIEW REF ID </td>
						<td><input type="text" name="_revrefid" value="311738" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>GROUP</td>
						<td><input type="text" name="_grp" value="Multi-Agency Plan Review" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>REF TEAM ID (vertical line(|) separated by value)</td>
						<td><input type="text" name="REF_TEAM_ID" value="910080" style="width: 350px"/></td>
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
				<input type="hidden" name="<%=RequestMapper.entity%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="activity"/>

				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2"> TEAM</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="team">team</option>
								</select>
						</td>
					</tr>
					<tr>
						<td>PERMIT ID</td>
						<td><input type="text" name="_typeid" value="3316488" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>CYCLE ID</td>
						<td><input type="text" name="_id" value="868950" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>REVIEW ID</td>
						<td><input type="text" name="_reviewid" value="1481" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>REVIEW REF ID </td>
						<td><input type="text" name="_revrefid" value="311736" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>GROUP</td>
						<td><input type="text" name="_grp" value="Multi-Agency Plan Review" style="width: 350px"/></td>
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
				<input type="hidden" name="<%=RequestMapper.entity%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="activity"/>

				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">CYCLE TEAM</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="comboteam">comboteam</option>
								</select>
						</td>
					</tr>
					<tr>
						<td>PERMIT ID</td>
						<td><input type="text" name="_typeid" value="3316488" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>REVIEW REF ID</td>
						<td><input type="text" name="_id" value="311736" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>REVIEW ID</td>
						<td><input type="text" name="_reviewid" value="1481" style="width: 350px"/></td>
					</tr>
					<!-- <tr>
						<td>REVIEW REF ID </td>
						<td><input type="text" name="_revrefid" value="311736" style="width: 350px"/></td>
					</tr> -->
					<tr>
						<td>GROUP</td>
						<td><input type="text" name="_grp" value="Multi-Agency Plan Review" style="width: 350px"/></td>
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
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="activity"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">REVIEW GROUP</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="types">types</option>
								
								
							</select>
						</td>
					</tr>
					<!-- <tr>
						<td>REVIEW ID</td>
						<td><input type="text" name="_id" value="868940" style="width: 350px"/></td>
					</tr> -->
					<tr>
						<td>PERMIT ID</td>
						<td><input type="text" name="_typeid" value="3316488" style="width: 350px"/></td>
					</tr>
					<tr>
						<td>GROUP</td>
						<td><input type="text" name="_grp" value="" style="width: 350px"/></td>
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
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="activity"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">REVIEW STATUS</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">								
								<option value="reviewstatus">reviewstatus</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>REVIEW ID</td>
						<td><input type="text" name="_id" value="1481" style="width: 350px"/></td>
					</tr>
					<!-- <tr>
						<td>PERMIT ID</td>
						<td><input type="text" name="_typeid" value="3316488" style="width: 350px"/></td>
					</tr> -->
					<tr>
						<td>GROUP</td>
						<td><input type="text" name="_grp" value="" style="width: 350px"/></td>
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
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="activity"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="activity"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">PERMIT INFO</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">								
								<option value="permitinfodetails">permitInfoDetails</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>PERMIT ID</td>
						<td><input type="text" name="_typeid" value="3316488" style="width: 350px"/></td>
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
				<input type="hidden" name="request" value="availability"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="review"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="review"/>
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




















