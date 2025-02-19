 /*
 * Alain's Numeric Spinner
 * Copyright 2015 Alain Romero
 *
 * Version 1.0   -   Updated: Sep. 20, 2015
 *
 */
var spritesurl = '/cs/tools/alain/sprites.png';

(function($){
	$.fn.spinner = function(options) {

		var defaults = {
			// buttons
			button: {
				type: 'arrow',
				position: 'left',
				color: 'grey',
				hovercolor: 'black'
			},

	  	};  
	 	var opts = $.extend(defaults, options);
	 	
		var len = this.length - 1;

		function hasValue(o) {
			try {
				var t = jQuery.type(o);
				if (!o)                            { return false; }
				else if (o == undefined)           { return false; }
				else if (o == null)                { return false; }
				else if (t == 'string' && o == '') { return false; }
				else if (t != 'boolean' && !o)     { return false; }
				else if (t == 'object' && (!t.length || t.length == 0)) { return false; }
				else if (t.length && o.length < 1)             { return false; }
				return true;
			}
			catch(e) { return false; }
		}

		function buttonUpPosition() {
			if (opts.button.type == 'math') {
				if (opts.button.color == 'none') { return '0px 0px'; }
				else if (opts.button.color == 'white') { return '-45px -245px'; }
				else if (opts.button.color == 'black') { return '-95px -245px'; }
				else { return '-195px -245px'; }
			}
			else {
				if (opts.button.color == 'none') { return '0px 0px'; }
				else if (opts.button.color == 'white') { return '-45px -95px'; }
				else if (opts.button.color == 'black') { return '-95px -95px'; }
				else { return '-195px -95px'; }
			}
		}

		function buttonDownPosition() {
			if (opts.button.type == 'math') {
				if (opts.button.color == 'none') { return '0px 0px'; }
				else if (opts.button.color == 'white') { return '-45px -195px'; }
				else if (opts.button.color == 'black') { return '-95px -195px'; }
				else { return '-195px -195px'; }
			}
			else {
				if (opts.button.color == 'none') { return '0px 0px'; }
				else if (opts.button.color == 'white') { return '-45px -145px'; }
				else if (opts.button.color == 'black') { return '-95px -145px'; }
				else { return '-195px -145px'; }
			}
		}

		function upButton() {
			var r = $('<div/>');
			r.css({
				'padding': '0px',
				'margin': '0px',
				'width': '10px',
				'height': '10px',
				'background-image': 'url('+spritesurl+')',
				'background-repeat': 'no-repeat',
				'background-position': buttonUpPosition()
			});
			return r;
		}

		function downButton() {
			var r = $('<div/>');
			r.css({
				'padding': '0px',
				'margin': '0px',
				'width': '10px',
				'height': '10px',
				'background-image': 'url('+spritesurl+')',
				'background-repeat': 'no-repeat',
				'background-position': buttonDownPosition()
			});
			return r;
		}

		function button() {
			var r = $('<div/>');
			r.css({
				'padding': '0px',
				'margin': '0px',
				'width': '10px',
				'height': '20px',
				'vertical-align' : 'middle',
				'display': 'inline-block',
				'*display': 'inline',
				'zoom': 1
			});
			return r;
		}

		function container() {
			var r = $('<div/>');
			r.css({
				'display': 'inline-block',
				'*display': 'inline',
				'zoom': 1
			});
			return r;
		}

		function add(input) {
			var n = 0;
			var i = input.val();
			if (!hasValue(i) || !$.isNumeric(i)) {
				i = '0';
			}
			var itype = input.attr('itype');
			if (!hasValue(itype)) { itype = 'integer'; }
			var itlc = itype.toLowerCase();
			if (itlc == 'currency') {
				n = parseFloat(i).toFixed(2);
				input.val(n + 0.01);
			}
			else {
				n = parseInt(i);
				n++;
				input.val(n);
			}
		}

		function minus(input) {
			var n = 0;
			var i = input.val();
			if (!hasValue(i)) {
				i = '0';
			}
			var itype = input.attr('itype');
			if (!hasValue(itype)) { itype = 'integer'; }
			var itlc = itype.toLowerCase();
			if (itlc == 'currency') {
				n = parseFloat(i).toFixed(2);
				input.val(n - 0.01);
			}
			else {
				n = parseInt(i);
				n--;
				input.val(n);
			}
		}

		function preventDblClick(elem) {
			elem.css({
				'-webkit-user-select': 'none',
				'-moz-user-select': 'none',
				'-khtml-user-select': 'none',
				'-ms-user-select': 'none'				
			});

			elem.dblclick(function(e){
				e.stopPropagation();
				e.preventDefault();
				return false;
			});
		}

		function restyle(elem) {
			elem.css({
				'width':'calc(100% - 10px)'
			});
		}

		return this.each(function(i){
			var org = $(this);
			var par = org.parent();
			var cont = container();
			cont.append(org);
			cont.addClass('csform');
			var buttons = button();
			var up = upButton();
			up.click(function() { add(org); });
			var down = downButton();
			down.click(function() { minus(org); });
			buttons.append(up);
			buttons.append(down);
			cont.append(buttons);
			par.append(cont);
			restyle(org);
			preventDblClick(down);
			preventDblClick(up);
			preventDblClick(buttons);
		});		
	};

})(jQuery);
















