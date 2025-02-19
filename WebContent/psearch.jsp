<%@page import="csshared.vo.ObjVO"%><%@page import="csshared.vo.SubObjVO"%><%@page import="csshared.utils.CsApi"%><%@page import="cs.search.GlobalSearch"%><%@page import="alain.core.utils.MapSet"%><%@page import="java.util.ArrayList"%><%@page import="csshared.utils.CsConfig"%><%@page import="alain.core.utils.Operator"%><%@page import="alain.core.utils.Config"%><%@page import="org.json.JSONArray"%><%@page import="cs.address.AddressTest"%><%@page import="org.json.JSONObject"%><%@page import="alain.core.utils.Cartographer"%><% 

	Cartographer map = new Cartographer(request,response);
	String q = map.getString("sq");
	String jurl = Config.fullcontexturl() + "/json/psearch.jsp?s=" + map.getString("s") + "&q=" + Operator.urlFriendly(q)+"&PAGE=" + map.getInt("PAGE", 1);

	String c = CsApi.content("publicsearch", map.token(), map.getRemoteIp());
	
%><!DOCTYPE html>
<html>
<head>
<title>City Smart</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
	<link href='https://fonts.googleapis.com/css?family=Oswald:300,700' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Armata' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700' rel='stylesheet' type='text/css'>
	
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/ioscheckboxes/assets/css/mobileCheckbox.iOS.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/alain/cs.search.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/simplepagination/simplePagination.css">
	

	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/jquery.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/simplepagination/jquery.simplePagination.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>


<style>
#glsearch { }

		input.glsearch {
			border: 0px;
			color: #000000;
			font-family: Arial, Helvetica, sans-serif;
			font-size: 18px;
			outline: none;
			background-color: #fff;
			border-radius: 20px;
			box-shadow: inset 0px 0px 5px 0px #000000;
			padding: 15px;
			background-image: url(/cs/images/icons/dark/search.png);
			background-repeat: no-repeat;
			background-position: right 10px center;
			width: calc(100% - 50px)
		}
		input.glsearch_on { color: #000000 !important; background-color: #ffffff !important }

		div.search-header {
			font-family: "Oswald";
			background-color: #ccc;
			color: #000 !important;
			font-weight: bold;
			letter-spacing: 2px;
			margin-left: auto;
			margin-right: auto;
			text-align: center;
			padding: 20px;
			font-size: 25px;
			text-transform: uppercase;
		}
		.search-section {
			padding: 50px;
		}
		.search1 {
			border: 1px solid #000;
			border-radius: 20px;
			background-color: #fff;
			background-image: url(/cs/images/icons/dark/search.png);
			background-repeat: no-repeat;
			background-position: right 10px center;
			box-shadow: inset 0px 0px 5px 0px #000000; 
		}


</style>
	<script>
		$(document).ready(function() {
			var elem = $('.result');
			
			
			
			
			<%if(map.hasValue("sq")){ %>
				uiAjax(elem);
			<%} %>
			
			
		});

		function uiAjax(elem) {
			$('#publicsearch_query').val("<%=q%>");
			createLoader(elem);
			var r = undefined;
			$.ajax({
				url: '<%=jurl%>',
				type:'POST', 
				dataType: 'json',
				success: function(result) {
					elem.empty();
					r = result;
					
					var table = r['table'];
					var records = r['noofrecords'];
					
					elem.html(table);
					$('.cmessage').html('');
					
						
					if(records==0 ){
						$('.result').html('<div style="font-size: 25px;font-weight: bold; text-align: center;color:#97473F;"> NO RESULTS FOUND</div>');
						
					}
					
					
					
				},
				error: function(xhr,status,error) {
				}
			});
			return r;
		}
	</script>

</head>

<body>
<div class="search-header">Search</div>

<div class="search-section">
	<div class="search">
		<form name="idx" id="publicsearch">
			<input class="glsearch" id="publicsearch_query" type="text" name="sq" placeholder="Search by Permit #, APN, Address " value="<%=map.getString("q") %>" />
		</form> 
	</div>
</div>


<div class="result">
</div>

<%if(Operator.hasValue(c)){ %>
<div class="cmessage" style="padding:40px; align:center;">
</br>
</br>
<%=c %>
</div>
<%}%>
</body>

</html>




















