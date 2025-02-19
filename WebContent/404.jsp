<%@page import="alain.core.utils.Config"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="alain.core.utils.Cartographer"%>
<%

	Cartographer map = new Cartographer(request,response);
 	String current = map.getForwardUrl();
 	if(Operator.hasValue(current)){
 		if(current.endsWith("null")){
 			map.redirect(Config.fullcontexturl());

 		}
 	}
	
%>


<html>
	<head>
		<title>Error 404: File Not Found</title>
	</head>
<body width="100%" height="100%">

<div style="height: 100%; position: relative;">
	<table style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -80%);">
		<tr>
			<td align="center" style="font-family: Arial; font-size: 150px; font-weight: bold; color: #bbbbbb">404</td>
		</tr>
		<tr>
			<td align="center" style="font-family: Arial; font-size: 30px; font-weight: bold; color: #000000">FILE NOT FOUND</td>
		</tr>
		<tr>
			<td align="center" style="font-family: Arial; color: #000000">The page you are looking for can not be found</td>
		</tr>
	</table>
</div>


</body>
</html>