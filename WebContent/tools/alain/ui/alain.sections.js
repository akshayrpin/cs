
var down = "/images/space.gif";

(function($){

	$.fn.sections = function(options) {

		var defaults = {
	  	};  

		var opts = $.extend(defaults, options);
		var size = this.length;
		var count = 1;
		var prev = null;
		var odd = true;

		return this.each(function(i) {
			var org = $(this);
			var id = org.attr('id');
			var loc = org.attr('location');
			var but = org.attr('button');
			if (hasValue(loc) && loc != 'alternating') {
				org.addClass(loc);
			}
			else {
				if (count == 1) {
					org.addClass('first');
				}
				else if (count == size) {
					org.addClass('last');
				}
				else if (odd) {
					org.addClass('odd');
				}
				else {
					org.addClass('even');
				}
			}
			var link = sectionLink(prev, id, but);
			var menu = sectionMenu(org);
			if (count == size) {
			}
			prev = $(this);
			if (odd) {
				odd = false;
			}
			else {
				odd = true;
			}
			count++;
		});
	};

})(jQuery);


function sectionLink(elem, nextid, button) {
	if (!hasValue(button) || button == 'Default') {
		button = 'sectionnav';
	}
	if (hasValue(elem) && hasValue(nextid)) {
		var cont = $('<div/>');
		cont.addClass(button);

		var lnk = $('<a/>');
		lnk.attr('href','#'+nextid);
		lnk.addClass(button);

		var img = $('<img/>');
		img.attr('src', down);
		img.addClass(button);

		lnk.append(img);
		lnk.on('click',function (e) {
			e.preventDefault();

			var target = this.hash;
			var $target = $(target);

			$('html, body').stop().animate({
				'scrollTop': $target.offset().top
			}, 900, 'swing', function () {
			window.location.hash = target;
			});
		});

		cont.append(lnk);
		elem.append(cont);
		return true;
	}
	return false;
}

function sectionMenu(elem) {
	var cont = $('#sectionmenu');
	if (hasValue(cont)) {
		var title = elem.attr('sectiontitle');
		if (hasValue(title)) {
			var lnk = $('<a/>');
			lnk.addClass('sectionmenu');
			lnk.attr('href','#'+elem.attr('id'));
			lnk.html(title);
			lnk.on('click',function (e) {
				e.preventDefault();

				var target = this.hash;
				var $target = $(target);

				$('html, body').stop().animate({
					'scrollTop': $target.offset().top
				}, 900, 'swing', function () {
				window.location.hash = target;
				});
			});
			cont.append(lnk);
		}
		return true;
	}
	return false;
}









