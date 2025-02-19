<%@page import="csshared.utils.CsApi"%>
<%@page import="alain.core.security.Token"%>
<%@page import="alain.core.utils.Cartographer"%>
<%

	Cartographer map = new Cartographer(request,response);
 	Token d = CsApi.getToken(map.token(), map.getRemoteIp());


%><html>
<head>
	<link href='https://fonts.googleapis.com/css?family=Oswald:300,700' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Armata' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700' rel='stylesheet' type='text/css'>
</head>
<body>
<div style="padding: 5px; font-family: Roboto Condensed, Arial; font-size: 25px">
hello
</div>
</body>
</html>

