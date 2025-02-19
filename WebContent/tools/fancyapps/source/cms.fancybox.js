
	var fancybox_reload = false;
	function isFancyBoxReload() {
		return fancybox_reload;
	}
	$(document).ready(
		function() {
			//initialize fancybox
			var a_lightbox = $("a.lightbox");
			var a_rel_lightbox = $("a[rel='lightbox']");
			var a_target_lightbox = $("a[target='lightbox']");

			var a_lightbox_iframe = $("a.lightbox-iframe");
			var a_rel_lightbox_iframe = $("a[rel='lightbox-iframe']");
			var a_target_lightbox_iframe_700width = $("a[target='lightbox-iframe-700width']");
			var a_target_lightbox_iframe = $("a[target='lightbox-iframe']");
			var a_target_lightbox_control = $("a[target='lightbox-control']");
			var a_target_lightbox_iframe_refresh = $("a[target='lightbox-iframe-refresh']");
			var a_lightbox_control = $("a.lightbox-control");

			a_rel_lightbox.fancybox();
			a_lightbox.fancybox();

			a_target_lightbox.fancybox();

			a_rel_lightbox_iframe.fancybox({
				width				: '75%',
				height				: '75%',
				autoScale			: false,
				transitionIn		: 'none',
				transitionOut		: 'none',
				title               : null,
				type				: 'iframe',
				helpers: {
			    	overlay: {
			    		locked: false
			    	}
				}

			});

			a_target_lightbox_iframe.fancybox({
				width				: '90%',
				height				: '90%',
				autoScale			: false,
				transitionIn		: 'none',
				transitionOut		: 'none',
				type				: 'iframe',
				title               : null,
				afterClose			: function() { 
					if (isFancyBoxReload()) {
						window.location.reload( true );
					}
				},
				helpers: {
			    	overlay: {
			    		locked: false
			    	}
				}
			});

			a_target_lightbox_control.fancybox({
				width				: '75%',
				height				: '75%',
				autoScale			: false,
				transitionIn		: 'none',
				transitionOut		: 'none',
				type				: 'iframe',
				title               : null,
				afterClose		: function() { window.location.reload( true ); },
				helpers: {
			    	overlay: {
			    		locked: false
			    	}
				}

			});
			
			
			a_target_lightbox_iframe_refresh.fancybox({
				width				: '90%',
				height				: '90%',
				autoScale			: false,
				transitionIn		: 'none',
				transitionOut		: 'none',
				type				: 'iframe',
				title               : null,
				afterClose			: function() { 
					window.location.reload( true );
				},
				helpers: {
			    	overlay: {
			    		locked: false
			    	}
				}
			});

			a_lightbox_iframe.fancybox({
				width				: '90%',
				height				: '90%',
				autoScale			: false,
				transitionIn		: 'none',
				transitionOut		: 'none',
				title               : null,
				type				: 'iframe',
				helpers: {
			    	overlay: {
			    		locked: false
			    	}
				}

			});

			a_lightbox_control.fancybox({
				width				: '75%',
				height				: '75%',
				autoScale			: false,
				transitionIn		: 'none',
				transitionOut		: 'none',
				title               : null,
				type				: 'iframe',
				afterClose		: function() { window.location.reload( true ); },
				helpers: {
			    	overlay: {
			    		locked: false
			    	}
				}

			});

			a_target_lightbox_iframe_700width.fancybox({
				width				: 700,
				autoScale			: true,
				transitionIn		: 'none',
				transitionOut		: 'none',
				title               : null,
				type				: 'iframe',
				helpers: {
			    	overlay: {
			    		locked: false
			    	}
				}

			});
		}

	);
