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
</head>

<body style="width: 100%; height: 100%; padding: 0px; margin: 0px">


	<table cellpadding="30" cellspacing="0" border="0" style="width: 100%; height: 100%">
		<tr style="height: 100%">
			<td valign="top" style="width: 500px; height: 100%">

				| LOGIN | <a href="inspections.jsp">INSPECTIONS</a> | <a href="parking.jsp" >PARKING</a> | <a href="finance.jsp" >FINANCE</a> |  <a href="review.jsp">REVIEW</a> 
				<br/><br/>

				<form method="POST" action="apiloginpost.jsp" target="response">
				<input type="hidden" name="<%=RequestMapper.entity%>" value="lso"/>
				<input type="hidden" name="<%=RequestMapper.action%>" value="login"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2" nowrap>LOGIN</td>
					</tr>
			
					<tr>
						<td>Username</td>
						<td><input type="text" name="username" value="aromero@beverlyhills.org" style="width: 350px"/></td>
					</tr>
			
					<tr>
						<td>Password</td>
						<td><input type="text" name="password" value="" style="width: 350px"/></td>
					</tr>
			
					<tr>
						<td>Requestor</td>
						<td>
							<select name="requestor" style="width: 350px">
								<option value="ft">firsttek</option>
							</select>
						</td>
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

				<form method="POST" action="apiloginpost.jsp" target="response">
				<input type="hidden" name="<%=RequestMapper.entity%>" value="lso"/>
				<input type="hidden" name="<%=RequestMapper.action%>" value="token"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2" nowrap>RETRIEVE/REFRESH TOKEN</td>
					</tr>
			
					<tr>
						<td>Token</td>
						<td><input type="text" name="token" value="" style="width: 350px"/></td>
					</tr>
			
					<tr>
						<td>Requestor</td>
						<td>
							<select name="requestor" style="width: 350px">
								<option value="ft">firsttek</option>
							</select>
						</td>
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




















