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

				| <a href="index.jsp">LOGIN</a> | <a href="permits.jsp">PERMITS</a> | <a href="inspections.jsp">INSPECTIONS</a> | <a href="parking.jsp" >PARKING</a> | <a href="finance.jsp" class="current">FINANCE</a> | <a href="review.jsp">REVIEW</a> |
				<br/><br/>
			
			
			
			
			
				<form method="POST" action="apipost.jsp" target="response">
				<input type="hidden" name="<%=RequestMapper.entity%>" value="finance"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="finance"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="finance"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2"> SEARCH</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="cart">cart</option>
							</select>
						</td>
					</tr>

					<tr>
						<td>PERMIT ID</td>
						<td><input type="text" name="_reference" value="1877316" style="width: 350px"/></td>
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
				<input type="hidden" name="<%=RequestMapper.entity%>" value="finance"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="finance"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="finance"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">CART/PAYMENTS</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="savecart">SAVE CART</option>
								<option value="updatecart">UPDATE CART</option>
								<option value="getcart">GET CART</option>
								<option value="deletecart">DELETE CART</option>
								<option value="mypayments">MY PAYMENTS</option>
								
							</select>
						</td>
					</tr>
					
					<tr>
						<td>CART JSON (USED WHILE SAVE/UPDATE CART)</td>
						<td><textarea  name="<%= RequestMapper.note%>">INPUT THE JSON FROM SEARCH</textarea></td>
					</tr>
					<tr>
						<td>CART ID (IF LEFT BLANK WILL RETURN THE LAST SAVED CART FROM THE USER)</td>
						<td><input type="text" name="<%= RequestMapper.reference%>" value="" style="width: 350px"/></td>
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
				<input type="hidden" name="<%=RequestMapper.entity%>" value="finance"/>
				<input type="hidden" name="<%=RequestMapper.grouptype%>" value="finance"/>
				<input type="hidden" name="<%=RequestMapper.type%>" value="finance"/>
				<table cellpadding="5" cellspacing="0" border="0">
					<tr>
						<td colspan="2">ONLINE PAYMENT</td>
					</tr>
					<tr>
						<td>Request</td>
						<td>
							<select name="request" style="width: 350px">
								<option value="payonline">payonline</option>
							</select>
						</td>
					</tr>
				
					<tr>
						<td>CART ID / REFERENCE</td>
						<td><input type="text" name="<%= RequestMapper.reference%>" value="" style="width: 350px"/></td>
					</tr>
					
					<tr>
						<td>PAYMENT METHOD</td>
						<td><input type="text" name="method" value="2" style="width: 350px"/></td>
					</tr>
					
					<tr>
						<td>PAYMENT TRANSACTION TYPE</td>
						<td><input type="text" name="transactiontype" value="1" style="width: 350px"/></td>
					</tr>
					
					
					<tr>
						<td>PAYEE ID</td>
						<td><input type="text" name="payeeid" value="" style="width: 350px"/></td>
					</tr>
					
					<tr>
						<td>AMOUNT</td>
						<td><input type="text" name="amount" value="0.00" style="width: 350px"/></td>
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




















