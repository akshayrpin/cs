 /*
 * Alain's Image Tools
 * Copyright 2013 Alain Romero
 *
 * Version 1.0   -   Updated: Jan. 20, 2013
 *
 */

(function($){
	$.fn.imgTools = function(options) {

		var defaults = {
		  	scale: 'fill',
		  	scaleWidth: '',
		  	scaleHeight: '',
		  	scaleToCenter: true,
		  	padding: 0,
		  	leftPadding: 0,
		  	rightPadding: 0,
		  	topPadding: 0,
		  	bottomPadding: 0,
		  	margin: 0,
		  	leftMargin: 0,
		  	rightMargin: 0,
		  	topMargin: 0,
		  	bottomMargin: 0,
		  	float: '',
		  	backgroundColor: '',
		  	borderStyle: '',
		  	caption: '',
		  	captionTitle: '',
		  	captionPosition: 'bottom',
		  	captionHover: 'slide',
		  	fx: '',
		  	hoverFx: '',
		  	hoverReplace: '',
		  	complete: function(){},
		  	start: function(){},
		  	end: function(){}
	  	};
	 	var opts = $.extend(defaults, options);

		opts.start.call(this);

		// Get total number of items.
		var len = this.length - 1;

		return this.each(function(i){

		  	var opts_backgroundColor = opts.backgroundColor;
		  	var opts_borderStyle = opts.borderStyle;
		  	var opts_float = opts.float;
		  	var opts_padding = opts.padding;
		  	var opts_leftPadding = opts.leftPadding;
		  	var opts_rightPadding = opts.rightPadding;
		  	var opts_topPadding = opts.leftPadding;
		  	var opts_bottomPadding = opts.bottomPadding;
		  	var opts_margin = opts.margin;
		  	var opts_leftMargin = opts.leftMargin;
		  	var opts_rightMargin = opts.rightMargin;
		  	var opts_topMargin = opts.leftMargin;
		  	var opts_bottomMargin = opts.bottomMargin;
		  	var opts_scale = opts.scale;
		  	var opts_scaleWidth = opts.scaleWidth;
		  	var opts_scaleHeight = opts.scaleHeight;
		  	var opts_scaleToCenter = opts.scaleToCenter;
		  	var opts_caption = opts.caption;
		  	var opts_captionPosition = opts.captionPosition;
		  	var opts_captionTitle = opts.captionTitle;
		  	var opts_captionHover = opts.captionHover;
		  	var opts_fx = opts.fx;
		  	var opts_hoverFx = opts.hoverFx;
		  	var opts_hoverReplace = opts.hoverReplace;
		  	var opts_complete = opts.complete;
		  	var opts_start = opts.start;
		  	var opts_end = opts.end;

			var parentWidth;
			var parentHeight;
			var parentAspect;
			var imgWidth;
			var imgHeight;
			var imgAspect;
			var imgMarginLeft;
			var imgMarginTop;
			var zoomPercent = 5;

			var current = i;
			var fxarray = {};
			var hasCaption = false;
			var href = '';
			var target = '';
			var loadWatch;
			var org_image = $(this);
			org_image.hide();
			var parent;
			var grandparent;
			var caption;
			var anchor;
			getImage();

			function getImage() {
				if(org_image[0].complete) { runTools(org_image); }
				else { loadWatch = setInterval(watch, 500); }
			}

			function watch(){
				if(org_image[0].complete){
					clearInterval(loadWatch);
					runTools(org_image);
				}
			}

			function runTools(org_image) {
				setOptions();
				getParent();
				if (parent) {
					caption = getCaption();
					style();
					if (hasValue(opts_scale)) {
						scale();
					}
					hoverFx();
					doHovers();
				}
			}

			function getParent() {
				var theCaption;
				var valid = false;
				var div_width = opts_scaleWidth;
				var div_height = opts_scaleHeight;

				if (hasValue(opts_scale) && opts_scale == 'parent') {
					valid = false;
				}
				else if (hasValue(opts_scale) && (opts_scale == 'original' || opts_scale == 'width' || opts_scale == 'height')) {
					div_height = '0px';
					div_width = '0px';
					valid = true;
				}
				else if (hasValue(opts_scaleWidth) && hasValue(opts_scaleHeight)) {
					div_height = opts_scaleHeight+'px';
					div_width = opts_scaleWidth+'px';
					valid = true;
				}
				else if (hasValue(opts_scaleHeight)) {
					div_height = opts_scaleHeight+'px';
					div_width = '100%';
					valid = true;
				}

				var org_image_parent = org_image.parent();
				if (valid) {
					var pdiv = '<div style="position: absolute; top: 0px; left: 0px; right: 0px; bottom: 0px; display: block;"/>';
					var gpdiv = '<div style="position: relative; width:'+div_width+'; height:'+div_height+'; display: inline-block; *display: inline; zoom: 1;"/>';
					if (org_image_parent.is("a")) {
						anchor = org_image_parent;
						href = anchor.attr('href');
						target = anchor.attr('target');
						theCaption = org_image_parent.children('.caption:first');
						if (!hasText(theCaption)) {
							theCaption = org_image_parent.siblings('.caption:first');
						}
						org_image_parent.wrap(pdiv);
						parent = org_image_parent.parent();
					}
					else {
						theCaption = org_image_parent.children('.caption:first');
						org_image.wrap(pdiv);
						parent = org_image.parent();
					}

					if (hasText(theCaption)) {
						parent.append(theCaption);
					}

					parent.wrap(gpdiv);
					grandparent = parent.parent();

				}
				else {
					if (org_image_parent.is("a")) {
						anchor = org_image_parent;
						href = anchor.getAttr('href');
						target = anchor.getAttr('target');
						theCaption = org_image_parent.children('.caption:first');
						if (!hasText(theCaption)) {
							theCaption = org_image_parent.siblings('.caption:first');
						}
						grandparent = org_image_parent.parent();
						var gpWidth = parseInt(grandparent.width());
						var gpHeight = parseInt(grandparent.height());
						var pdiv = '<div style="position: absolute; top: 0px; left: 0px; width:'+gpWidth+'px; height:'+gpHeight+'px; display: block;"/>';
						org_image_parent.wrap(pdiv);
						parent = org_image_parent.parent();
						if (hasText(theCaption)) {
							parent.append(theCaption);
						}
					}
					else {
						grandparent = org_image.parent();
						theCaption = grandparent.children('.caption:first');
						var gpWidth = parseInt(grandparent.width());
						var gpHeight = parseInt(grandparent.height());
						var pdiv = '<div style="position: relative; width:'+gpWidth+'px; height:'+gpHeight+'px; display: block;"/>';
						org_image.wrap(pdiv);
						parent = org_image.parent();
						if (hasText(theCaption)) {
							parent.append(theCaption);
						}
					}
				}
				if (parent.is('body')) { parent = null; }
				if (grandparent.is('body')) { grandparent = null; parent = null; }
			}

			function setPadding(size) {
				if (parseInt(size)) {
					parent.css({ margin: size+'px' });
					grandparent.css({ padding: size+'px' });
				}
			}

			function setPaddingLeft(size) {
				if (parseInt(size)) {
					parent.css({ 'margin-left': size+'px' });
					grandparent.css({ 'padding-left': size+'px' });
				}
			}

			function setPaddingRight(size) {
				if (parseInt(size)) {
					parent.css({ 'margin-right': size+'px' });
					grandparent.css({ 'padding-right': size+'px' });
				}
			}

			function setPaddingTop(size) {
				if (parseInt(size)) {
					parent.css({ 'margin-top': size+'px' });
					grandparent.css({ 'padding-top': size+'px' });
				}
			}

			function setPaddingBottom(size) {
				if (parseInt(size)) {
					parent.css({ 'margin-bottom': size+'px' });
					grandparent.css({ 'padding-bottom': size+'px' });
				}
			}


			function setOptions() {

				// scale
				var org_image_scale = org_image.attr('scale');
				var org_image_width = org_image.attr('scalewidth');
				var org_image_height = org_image.attr('scaleheight');
				var org_image_center = org_image.attr('scalecenter');
				if (hasValue(org_image_scale)) {
					opts_scale = org_image_scale;
				}
				else if (hasValue(org_image_width) || hasValue(org_image_height)) {
					opts_scale = 'fill';
				}
				if (hasValue(org_image_width)) {
					opts_scaleWidth = org_image_width;
				}
				if (hasValue(org_image_height)) {
					opts_scaleHeight = org_image_height;
				}
				if (hasValue(org_image_center) && org_image_center == 'true') {
					opts_scaleToCenter = true;
				}
				else if (hasValue(org_image_center) && org_image_center == 'false') {
					opts_scaleToCenter = false;
				}

				// caption
				var org_image_title = org_image.attr('title');
				var org_image_caption = org_image.attr('caption');
				var org_image_captionhover = org_image.attr('captionhover');
				var org_image_captionposition = org_image.attr('captionposition');
				if (hasValue(org_image_title)) {
					opts_captionTitle = org_image_title;
				}
				if (hasValue(org_image_caption)) {
					opts_caption = org_image_caption;
				}
				if (hasValue(org_image_captionhover)) {
					opts_captionHover = org_image_captionhover;
				}
				if (hasValue(org_image_captionposition)) {
					opts_captionPosition = org_image_captionposition;
				}
				if (hasValue(opts_captionHover)) {
					if (opts_captionHover == 'true') {
						opts_captionHover = 'slide';
					}
				}


				// hoverFx
				var org_image_hoverfx = org_image.attr('hoverfx');
				var org_image_hoverreplace = org_image.attr('hoverreplace');
				if (hasValue(org_image_hoverfx)) {
					opts_hoverFx = org_image_hoverfx;
				}
				if (hasValue(org_image_hoverreplace)) {
					opts_hoverReplace = org_image_hoverreplace;
				}

				// style
				var org_image_fx = org_image.attr('fx');
				var org_image_borderstyle = org_image.attr('borderstyle');
				var org_image_padding = org_image.attr('padding');
				var org_image_leftpadding = org_image.attr('leftpadding');
				var org_image_rightpadding = org_image.attr('rightpadding');
				var org_image_toppadding = org_image.attr('toppadding');
				var org_image_bottompadding = org_image.attr('bottompadding');
				var org_image_margin = org_image.attr('margin');
				var org_image_leftmargin = org_image.attr('leftmargin');
				var org_image_rightmargin = org_image.attr('rightmargin');
				var org_image_topmargin = org_image.attr('topmargin');
				var org_image_bottommargin = org_image.attr('bottommargin');
				var org_image_float = org_image.attr('float');
				var org_image_backgroundcolor = org_image.attr('backgroundcolor');
				if (hasValue(org_image_fx)) {
					opts_fx = org_image_fx;
				}
				fxarray = opts_fx.split(",");
				if (hasValue(org_image_padding)) {
					opts_padding = org_image_padding;
				}
				if (hasValue(org_image_toppadding)) {
					opts_topPadding = org_image_toppadding;
				}
				if (hasValue(org_image_bottompadding)) {
					opts_bottomPadding = org_image_bottompadding;
				}
				if (hasValue(org_image_leftpadding)) {
					opts_leftPadding = org_image_leftpadding;
				}
				if (hasValue(org_image_rightpadding)) {
					opts_rightPadding = org_image_rightpadding;
				}
				if (hasValue(org_image_margin)) {
					opts_margin = org_image_margin;
				}
				if (hasValue(org_image_topmargin)) {
					opts_topMargin = org_image_topmargin;
				}
				if (hasValue(org_image_bottommargin)) {
					opts_bottomMargin = org_image_bottommargin;
				}
				if (hasValue(org_image_leftmargin)) {
					opts_leftMargin = org_image_leftmargin;
				}
				if (hasValue(org_image_rightmargin)) {
					opts_rightMargin = org_image_rightmargin;
				}
				if (hasValue(org_image_float)) {
					opts_float = org_image_float;
				}
				if (hasValue(org_image_borderstyle)) {
					opts_borderStyle = org_image_borderstyle;
				}
				if (hasValue(org_image_backgroundcolor)) {
					opts_backgroundColor = org_image_backgroundcolor;
				}

			}

			function isFx(value) {
				try {
					if (opts_fx == value) { return true; }
				}
				catch(e) { }
				try {
					for (i=0; i<fxarray.length; i++) {
						if (fxarray[i].trim() == value) { return true; }
					}
				}
				catch(e) { }
				return false;
			}

			function hasValue(el) {
				try {
					if (!el) { return false; }
					if (el != '') { return true; }
					return false;
				}
				catch (e) { return false; }
			}

			function hasText(el) {
				try {
					if (!el) { return false; }
					if (el.text() != '') { return true; }
					return false;
				}
				catch (e) { return false; }
			}

			function hoverFx() {
				if (hasValue(opts_hoverFx) && !hasValue(opts_hoverReplace)) {
					if (opts_hoverFx == 'fadeIn') {
						org_image.css({opacity:0.5});
					}
					else if (opts_hoverFx == 'saturate') {
						org_image.addClass('fx-grayscale');
					}
					else if (opts_hoverFx == 'focus') {
						org_image.addClass('fx-blur');
					}
				}
			}

			function style() {
				org_image.css({
					border:'0px',
					display: 'block'
				});
				if (hasValue(opts_fx)) {
					for (i=0; i<fxarray.length; i++) {
						var thefx = fxarray[i];
						if (thefx == 'sepia') {
							org_image.addClass('fx-'+thefx);
						}
						else if (thefx == 'blur') {
							org_image.addClass('fx-'+thefx);
						}
						else if (thefx == 'grayscale') {
							org_image.addClass('fx-'+thefx);
						}
						else if (thefx == 'innershadow') {
							parent.addClass('fx-'+thefx);
						}
						else if (thefx == 'mat') {
							parent.addClass('fx-mat');
						}
						else if (thefx == 'letterbox') {
							parent.css({ 'background-color': '#000000' });
						}
						else if (thefx == 'border') {
							parent.css({ 'border': '2px solid #000000' });
						}
						else if (thefx == 'frame') {
							parent.css({ border: '30px solid #ffffff' });
							grandparent.css({ border: '5px solid #000000' });
						}
						else if (thefx == 'polaroid') {
							if (hasCaption) {
								grandparent.addClass('fx-polaroid');
								caption.removeClass('dyn-caption');
								caption.addClass('fx-polaroid-caption');
							}
							else {
								grandparent.addClass('fx-polaroid-nocaption');
							}
						}
						else {
							parent.addClass('fx-'+thefx);
						}
					}
				}
				if (parseInt(opts_padding)) {
					setPadding(opts_padding);
				}
				if (parseInt(opts_topPadding)) {
					setPadding(opts_topPadding);
				}
				if (parseInt(opts_bottomPadding)) {
					setPadding(opts_bottomPadding);
				}
				if (parseInt(opts_rightPadding)) {
					setPadding(opts_rightPadding);
				}
				if (parseInt(opts_leftPadding)) {
					setPadding(opts_leftPadding);
				}
				if (parseInt(opts_margin)) {
					grandparent.css({
						'margin': opts_margin+'px'
					});
				}
				if (parseInt(opts_topMargin)) {
					grandparent.css({
						'margin-top': opts_topMargin+'px'
					});
				}
				if (parseInt(opts_bottomMargin)) {
					grandparent.css({
						'margin-bottom': opts_bottomMargin+'px'
					});
				}
				if (parseInt(opts_rightMargin)) {
					grandparent.css({
						'margin-right': opts_rightMargin+'px'
					});
				}
				if (parseInt(opts_leftMargin)) {
					grandparent.css({
						'margin-left': opts_leftMargin+'px'
					});
				}
				if (hasValue(opts_float)) {
					grandparent.css({ float: opts_float });
				}
				if (hasValue(opts_borderStyle)) {
					parent.css({ border: opts_borderStyle });
				}
				if (hasValue(opts_backgroundColor)) {
					parent.css({ 'background-color': opts_backgroundColor });
				}
			}

			function getCaption() {
				var theCaption = parent.children('.caption:first');
				if (!hasText(theCaption)) {
					var displaycaption = "";
					if (hasValue(opts_captionTitle)) {
						displaycaption += '<div class="caption-title" style="display: block">';
						if (hasValue(href)) {
							displaycaption += '<a class="caption-title" href="';
							displaycaption += href;
							displaycaption += '">';
						}
						displaycaption += opts_captionTitle;
						if (hasValue(href)) {
							displaycaption += '</a>';
						}
						displaycaption += '</div>';
					}
					if (hasValue(opts_caption)) {
						displaycaption += '<div class="caption-summary" style="display: block">';
						if (hasValue(href)) {
							displaycaption += '<a class="caption" href="';
							displaycaption += href;
							displaycaption += '">';
						}
						displaycaption += opts_caption;
						if (hasValue(href)) {
							displaycaption += '</a>';
						}
						displaycaption += '</div>';
					}
					if (displaycaption != '') {
						theCaption = $('<div class="dyn-caption" style="display: block">'+displaycaption+'</div>');
						parent.append(theCaption);
					}
				}
				if (hasText(theCaption)) {
					if (hasValue(opts_captionPosition)) {
						if (opts_captionPosition == 'top') {
							theCaption.css({
								left: '0px',
								top: '0px',
								width: '100%',
								padding: '10px',
								'padding-top': '15px'
							});
						}
						else if (opts_captionPosition == 'left') {
							theCaption.css({
								left: '0px',
								top: '0px',
								height: '100%',
								padding: '10px',
								'padding-top': '15px'
							});
						}
						else if (opts_captionPosition == 'right') {
							theCaption.css({
								right: '0px',
								top: '0px',
								height: '100%',
								padding: '10px',
								'padding-top': '15px'
							});
						}
						else if (opts_captionPosition == 'full') {
							theCaption.css({
								left: '0px',
								top: '0px',
								width: '100%',
								height: '100%',
								padding: '10px',
								'padding-top': '15px'
							});
						}
						else {
							theCaption.css({
								left: '0px',
								bottom: '0px',
								width: '100%',
								padding: '10px',
								'padding-bottom': '15px'
							});
						}
					}
					if (hasValue(opts_captionHover) && opts_captionHover != 'false') { theCaption.hide(); }
					if (hasValue(opts_captionHover) && opts_captionHover != 'disabled') { org_image.removeAttr('title'); }
					hasCaption = true;
				}
				return theCaption;
			}

			function doHovers() {
				var valid = false;
				if (hasCaption && hasValue(opts_captionHover)) { valid = true; }
				if (hasValue(opts_hoverFx)) { valid = true; }
				if (hasValue(opts_hoverReplace)) {
					parent.css({
						'background-image': 'url('+opts_hoverReplace+')',
						'background-repeat': 'no-repeat',
						'background-position': 'center',
						'-webkit-background-size': 'cover',
						'-moz-background-size': 'cover',
						'-o-background-size': 'cover',
						'background-size': 'cover'
					});
					valid = true;
				}
				if (valid) {
					parent.hover(
						function() {
							if (hasValue(opts_hoverReplace)) {
								if (hasValue(opts_hoverFx) && !hasValue(href)) {
									org_image.hide(opts_hoverFx);
								}
								else {
									org_image.fadeTo('fast', 0);
								}
							}
							else if (opts_hoverFx == 'fadeIn') {
								org_image.fadeTo('fast', 1);
							}
							else if (opts_hoverFx == 'fadeOut') {
								org_image.fadeTo('fast', 0.5);
							}
							else if (opts_hoverFx == 'saturate') {
								org_image.removeClass('fx-grayscale');
							}
							else if (opts_hoverFx == 'desaturate') {
								org_image.addClass('fx-grayscale');
							}
							else if (opts_hoverFx == 'blur') {
								org_image.addClass('fx-blur');
							}
							else if (opts_hoverFx == 'focus') {
								org_image.removeClass('fx-blur');
							}
							else if (opts_hoverFx == 'zoom') {
								zoom(zoomPercent);
							}
							else if (opts_hoverFx == 'zoomFill') {
								zoomFill(zoomPercent);
							}
							else if (opts_hoverFx == 'revealFill') {
								revealFill();
							}
							else if (opts_hoverFx == 'zoomImage') {
								zoomImage(zoomPercent);
							}
							if (hasCaption && hasValue(opts_captionHover) && opts_captionHover != 'false' && opts_captionHover != 'disabled') {
								caption.show(opts_captionHover);
							}
						},
						function() {
							if (hasValue(opts_hoverReplace)) {
								if (hasValue(opts_hoverFx) && !hasValue(href)) {
									org_image.show(opts_hoverFx);
								}
								else {
									org_image.fadeTo('fast', 1);
								}
							}
							else if (opts_hoverFx == 'fadeIn') {
								org_image.fadeTo('fast', 0.5);
							}
							else if (opts_hoverFx == 'fadeOut') {
								org_image.fadeTo('fast', 1);
							}
							else if (opts_hoverFx == 'saturate') {
								org_image.addClass('fx-grayscale');
							}
							else if (opts_hoverFx == 'desaturate') {
								org_image.removeClass('fx-grayscale');
							}
							else if (opts_hoverFx == 'blur') {
								org_image.removeClass('fx-blur');
							}
							else if (opts_hoverFx == 'focus') {
								org_image.addClass('fx-blur');
							}
							else if (opts_hoverFx == 'zoom' || opts_hoverFx == 'zoomFill' || opts_hoverFx == 'revealFill') {
								resetZoom();
							}
							else if (opts_hoverFx == 'zoomImage') {
								resetZoomImage();
							}
							if (hasCaption && hasValue(opts_captionHover) && opts_captionHover != 'false' && opts_captionHover != 'disabled') {
								caption.hide(opts_captionHover);
							}
						}
					);
				}
			}


			function scale() {
				// Get image properties.
				parentWidth = parent.innerWidth();
				parentHeight = parent.innerHeight();
				parentAspect = parentWidth / parentHeight;
				org_image.removeAttr('height');
				org_image.removeAttr('width');
				imgWidth = parseInt(org_image.width());
				imgHeight = parseInt(org_image.height());
				imgAspect = imgWidth / imgHeight;
				imgMarginTop = 0;
				imgMarginLeft = 0;
				alert(parentWidth);

				var optWidth = parseInt(opts_scaleWidth);
				var optHeight = parseInt(opts_scaleHeight);

				parent.css({overflow:"hidden"});
				if(parentWidth != imgWidth || parentHeight != imgHeight){

					if(opts_scale == 'fit'){
						var cheight = parentHeight;
						var cwidth = Math.round(cheight * imgAspect);
						if (cwidth <= parentWidth) {
							org_image.css({"height": parentHeight +"px","width":"auto"});
							imgHeight = parentHeight;
							imgWidth = Math.round(imgHeight * imgAspect);
						}
						else {
							org_image.css({"width": parentWidth +"px","height":"auto"});
							imgWidth = parentWidth;
							imgHeight = Math.round(imgWidth / imgAspect);
						}
						if(imgWidth < parentWidth && opts_scaleToCenter){
							imgMarginLeft = Math.floor((parentWidth-imgWidth) / 2);
							org_image.css({"margin-left": imgMarginLeft+"px"});
						}
						if(imgHeight < parentHeight && opts_scaleToCenter){
							imgMarginTop = Math.floor((parentHeight-imgHeight) / 2);
							org_image.css({"margin-top":imgMarginTop +"px"});
						}
					}
					else if(opts_scale == 'height' && optHeight > 0){
						org_image.css({"height": optHeight +"px","width":"auto"});
						imgHeight = optHeight;
						imgWidth = Math.round(imgHeight * imgAspect);
						grandparent.css({
							width: imgWidth+'px',
							height: imgHeight+'px'
						});
						parent.css({
							width: imgWidth+'px',
							height: imgHeight+'px'
						});
					}
					else if(opts_scale == 'width' && optWidth > 0){
						org_image.css({"width": optWidth +"px","height":"auto"});
						imgWidth = optWidth;
						imgHeight = Math.round(imgWidth / imgAspect);
						grandparent.css({
							width: imgWidth+'px',
							height: imgHeight+'px'
						});
						parent.css({
							width: imgWidth+'px',
							height: imgHeight+'px'
						});
					}
					else if(opts_scale == 'crop') {
						if(imgWidth > parentWidth){
							imgMarginLeft = Math.floor((imgWidth - parentWidth) / 2) * -1;
							org_image.css({"margin-left": imgMarginLeft +"px"});
						}
						else if(imgWidth < parentWidth){
							imgMarginLeft = Math.floor((parentWidth -imgWidth) / 2);
							org_image.css({"margin-left": imgMarginLeft +"px"});
						}
						if(imgHeight > parentHeight && opts_scaleToCenter){
							imgMarginTop = Math.floor((imgHeight - parentHeight) / 2) * -1;
							org_image.css({"margin-top": imgMarginTop +"px"});
						}
						else if(imgHeight < parentHeight && opts_scaleToCenter){
							imgMarginTop = Math.floor((parentHeight - imgHeight) / 2);
							org_image.css({"margin-top": imgMarginTop +"px"});
						}
					}
					else if(opts_scale == 'original') {
						grandparent.css({
							width: imgWidth+'px',
							height: imgHeight+'px'
						});
						parent.css({
							width: imgWidth+'px',
							height: imgHeight+'px'
						});
					}
					else {
						if(parentAspect >= 1){
							org_image.css({"width": parentWidth +"px"});
							imgWidth = parentWidth;
							imgHeight = Math.round(imgWidth / imgAspect);

							if((parentWidth / imgAspect) < parentHeight){
								org_image.css({"height": parentHeight +"px","width":"auto"});
								imgHeight = parentHeight;
								imgWidth = Math.round(imgHeight * imgAspect);
							}
						}
						else {
							org_image.css({"height": parentHeight +"px"});
							imgHeight = parentHeight;
							imgWidth = Math.round(imgHeight * imgAspect);
							if((parentHeight * imgAspect) < parentWidth){
								org_image.css({"width": parentWidth +"px","height":"auto"});
								imgWidth = parentWidth;
								imgHeight = Math.round(imgWidth / imgAspect);
							}
						}
						if(imgWidth > parentWidth && opts_scaleToCenter){
							imgMarginLeft = Math.floor((imgWidth - parentWidth) / 2) * -1;
							org_image.css({"margin-left": imgMarginLeft +"px"});
						}
						if(imgHeight > parentHeight && opts_scaleToCenter){
							imgMarginTop = Math.floor((imgHeight - parentHeight) / 2) * -1;
							org_image.css({"margin-top": imgMarginTop +"px"});
						}
					}
					opts_complete.call(this);
					if(current == len){
						opts_end.call(this);
					}
				}
				if (parentWidth <= 50 && parentHeight <= 50) {
					zoomPercent = 50;
				}
				else if (parentWidth <= 100 && parentHeight <= 100) {
					zoomPercent = 25;
				}
				else if (parentWidth <= 200 && parentHeight <= 200) {
					zoomPercent = 10;
				}
				if (imgHeight > 0) {
					org_image.show();
				}
			}

			function zoom(perc) {

				var zPW = addPercentage(parentWidth, perc);
				var zPH = addPercentage(parentHeight, perc);

				var zPL = Math.round(calcPercent(parentWidth, perc)/2) * -1;
				var zPT = Math.round(calcPercent(parentHeight, perc)/2) * -1;

				var zIW = addPercentage(imgWidth, perc);
				var zIH = addPercentage(imgHeight, perc);

				var zIL = addPercentage(imgMarginLeft, perc);
				var zIT = addPercentage(imgMarginTop, perc);

				org_image.animate({
					width: zIW+'px',
					height: zIH+'px',
					'margin-left': zIL+'px',
					'margin-top': zIT+'px'
				}, 'fast');
				parent.animate({
					width: zPW+'px',
					height: zPH+'px',
					left: zPL+'px',
					top: zPT+'px',
					'z-index': 1
				}, 'fast');
			}

			function revealFill() {
				org_image.animate({
					'margin-left': '0px',
					'margin-top': '0px'
				}, 'fast');
				parent.animate({
					width: imgWidth+'px',
					height: imgHeight+'px',
					left: imgMarginLeft+'px',
					top: imgMarginTop+'px',
					'z-index': 0
				}, 'fast');
			}

			function zoomFill(perc) {
				var zIW = addPercentage(imgWidth, perc);
				var zIH = addPercentage(imgHeight, perc);

				var zPW = zIW;
				var zPH = zIH;

				var zIL = addPercentage(imgMarginLeft, perc);
				var zIT = addPercentage(imgMarginTop, perc);

				var zPL = zIL + (Math.round(calcPercent(parentWidth, perc)/2) * -1);
				var zPT = zIT + (Math.round(calcPercent(parentHeight, perc)/2) * -1);

				org_image.animate({
					width: zIW+'px',
					height: zIH+'px',
					'margin-left': '0px',
					'margin-top': '0px'
				}, 'fast');
				parent.animate({
					width: zPW+'px',
					height: zPH+'px',
					left: zPL+'px',
					top: zPT+'px',
					'z-index': 1
				}, 'fast');
			}

			function resetZoom() {
				org_image.animate({
					width: imgWidth+'px',
					height: imgHeight+'px',
					'margin-left': imgMarginLeft+'px',
					'margin-top': imgMarginTop+'px'
				}, 'fast');
				parent.animate({
					width: parentWidth+'px',
					height: parentHeight+'px',
					left: '0px',
					top: '0px',
					'z-index': 0
				}, 'fast');
			}

			function zoomImage(perc) {

				var zIW = addPercentage(imgWidth, perc);
				var zIH = addPercentage(imgHeight, perc);

				var zIL = imgMarginLeft - Math.round((zIW - imgWidth)/2);
				var zIT = imgMarginTop - Math.round((zIH - imgHeight)/2);

				org_image.animate({
					width: zIW+'px',
					height: zIH+'px',
					'margin-left': zIL+'px',
					'margin-top': zIT+'px'
				}, 'fast');
			}

			function resetZoomImage() {
				org_image.animate({
					width: imgWidth+'px',
					height: imgHeight+'px',
					'margin-left': imgMarginLeft+'px',
					'margin-top': imgMarginTop+'px'
				}, 'fast');
			}

			function addPercentage(num, perc) {
				var a = calcPercent(num, perc);
				return num+a;
			}
			function calcPercent(num, perc) {
				a = perc/100;
				b = a*num;
				return b;
			}
			function getPercent(len1, len2) {
				a = document.form1.c.value;
				b = document.form1.d.value;
				c = len1/len2;
				d = c*100;
				return d;
			}

			function getInt(string) {
				try {
					string = string.replace("px","");
		            if (typeof string == "undefined" || string == "") {
		                return 0;
		            }
		            var tempInt = parseInt(string);

		            if (!(tempInt <= 0 || tempInt > 0)) {
		                return 0;
		            }
		            return tempInt;
				}
				catch (e) { return 0; }
	        }

			function getWidth(object) {

			    if(object == null || object.length == 0) {
			        return 0;
			    }

			    var value = object.width();
			    value -= getInt(object.css("padding-left"));
			    value -= getInt(object.css("padding-right"));
			    value -= getInt(object.css("border-left-width"));
			    value -= getInt(object.css("border-right-width"));
			    return value;
			}

			function  getHeight(object) {

			    if(object == null || object.length == 0) {
			        return 0;
			    }

			    var value = object.height();
			    value -= getInt(object.css("padding-top"));
			    value -= getInt(object.css("padding-bottom"));
			    value -= getInt(object.css("border-top-width"));
			    value -= getInt(object.css("border-bottom-width"));
			    return value;
			}

		});
	};
})(jQuery);