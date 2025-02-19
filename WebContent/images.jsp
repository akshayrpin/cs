<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.utils.CsApi"%><%@page import="cs.ui.Images"%><%@page import="cs.utils.ObjTables"%><%@page import="cs.ui.CsUi"%><%@page import="csshared.vo.DataVO"%><%@page import="alain.core.utils.Operator"%><%@page import="csshared.utils.CsConfig"%><%@page import="alain.core.utils.Config"%><%@page import="cs.utils.RequestMapper"%><%@page import="cs.utils.ObjUi"%><%@page import="csshared.vo.ObjGroupVO"%><%@page import="csshared.vo.TypeVO"%><%@page import="csshared.vo.RequestVO"%><%@page import="alain.core.utils.Cartographer"%><%

	Cartographer map = new Cartographer(request,response);
	if (!Operator.hasValue(map.token()) || !Operator.hasValue(map.username())) {
		map.logout();
	}
	RequestVO req = RequestMapper.getRequest(map);
	RequestVO nav = req.duplicate();
	nav.setRequest("summary");
	ObjGroupVO[] groups = CsApi.getGroups(nav);
	String thumbs = Images.thumbs(req, groups);
	String slides = Images.table(req, groups);

	int id = map.getInt(RequestMapper.id);

%><html>
	<head>
	
		<%= CsUiTools.getHTMLImports() %>
		<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css">
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/carouFredSel/cs.slides.css">
		<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/carouFredSel/cs.thumbs.css">


		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
	 	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
	    <script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
		<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/carouFredSel/jquery.carouFredSel-6.2.1-packed.js"></script>
		<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/carouFredSel/helper-plugins/jquery.mousewheel.min.js"></script>
		<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/carouFredSel/helper-plugins/jquery.transit.min.js"></script>
		<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/carouFredSel/helper-plugins/jquery.ba-throttle-debounce.min.js"></script>
		<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/carouFredSel/cs.carouFredSel.js"></script>
	
		<script>

			$(document).ready(function() {
				$('.thumblist').carouFredSel({
					auto: false,
					responsive: true,
					align: 'center',
					prev: '.prevthumb',
					next: '.nextthumb',
					pagination: "#slidepager",
					mousewheel: true,
					items: {
						visible: 10
					},
					scroll: {
						fx: 'directscroll',
						onBefore: function( data ) {
							data.items.visible.each(function() {
								loadThumbImage($(this));
							});
						}
					},
					onCreate: function( data ) {
						data.items.each(function() {
							loadThumbImage($(this));
						});
					},
					swipe: {
						onMouse: true,
						onTouch: true
					}
				});
				$('.slidelist').carouFredSel({
					auto: false,
					responsive: true,
					align: 'center',
					prev: '.prevnav',
					next: '.nextnav',
					pagination: "#slidepager",
					mousewheel: false,
					items: {
						visible: 1
					},
					scroll: {
						fx: 'fade',
						onAfter: function( data ) {
							data.items.visible.each(function() {
								loadTableImage($(this));
								var rel = $(this).attr('rel');
								$('.thumblist div').removeClass('selected');
//								$('.thumblist').trigger('slideTo', '#' + rel );
								$('#'+rel).addClass('selected');
							});
						}
					},
					onCreate: function( data ) {
						data.items.each(function() {
							loadTableImage($(this));
						});
					},
					swipe: {
						onMouse: true,
						onTouch: true
					}
				});
				$('.thumb').click(function() {
					var rel = $(this).attr('rel');
					$('.slidelist').trigger('slideTo', '#' + rel );
					$('.thumblist div').removeClass('selected');
					$(this).addClass('selected');
					return false;
				});
				<% if (id > 0) { %>
					$('.slidelist').trigger('slideTo', '#slide_<%=id%>');
					$('.thumblist').trigger('slideTo', '#thumb_<%=id%>');
					$('#thumb_<%=id%>').addClass('selected');
				<% } %>
			});

		</script>
	
	</head>
<body>
<div style="padding-left: 20px; padding-right: 20px;">
<%= thumbs %>
<%= slides %>
</div>
</body>
</html>

