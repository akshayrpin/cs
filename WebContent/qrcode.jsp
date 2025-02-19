<%@page import="alain.core.www.wwwUtils"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="alain.core.utils.Cartographer"%>
<html>
	<head>
		<title>QR Code</title>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	</head>

<body bgcolor="#cccccc" TOPMARGIN=0 LEFTMARGIN=0 MARGINHEIGHT=0 MARGINWIDTH=0>

<img src="http://localhost:8080/cs/alain?qrcode=http%3A%2F%2Fwww.beverlyhills.org&TYPE=URL"/>

	<table cellpadding="10" cellspacing="0" border="0" width="800" align="center" style="background-color: #ffffff; height: 100%">
		<tr>
			<td valign="top">
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td class="bhcms_table_title" style="border: 1px solid #cccccc" valign="top">
								<table cellpadding="5" cellspacing="0" border="0" width="100%" bgcolor="#2d2d2d">
									<tr>
										<td width="40">
										</td>
										<td class="bhcms_title" align="center">QR Codes</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<%= wwwUtils.qrcodeForm() %>

			</td>
		</tr>
	</table>

</body>
</html>















