
(function($){
	$.fn.apptreassign = function(options) {

		var defaults = {
	  	};  

		var opts = $.extend(defaults, options);
		$.ajaxSetup({ cache:false });
	 	var scrollHandler;
		var len = this.length - 1;

		return this.each(function(i) {
			var org = $(this);
			org.click(function() {
				apptreassign();
			})
		});
	};

	$.fn.apptreschedule = function(options) {

		var defaults = {
	  	};  

		var opts = $.extend(defaults, options);
		$.ajaxSetup({ cache:false });
	 	var scrollHandler;
		var len = this.length - 1;

		return this.each(function(i) {
			var org = $(this);
			org.click(function() {
				apptreschedule();
			})
		});
	};

	$.fn.apptavailability = function(options) {

		var defaults = {
	  	};  

		var opts = $.extend(defaults, options);
		$.ajaxSetup({ cache:false });
	 	var scrollHandler;
		var len = this.length - 1;

		return this.each(function(i) {
			var org = $(this);
			var aid = org.attr('availabilityid');
			org.click(function() {
				toggleButtons(aid);
			})
		});
	};

})(jQuery);

$(document).ready(function() {
	var m = $('#reschedule');
	var a = $('#reassign');
	m.removeClass('enabled');
	m.addClass('disabled');
	a.removeClass('enabled');
	a.addClass('disabled');

});

function apptreassign() {
	var e = true;
	var v = '';
	var r = '';
	$('input.inspresults:checked').each(function() {
		if (e == false) {
			v += '|';
			r += '|';
		}
	    v += $(this).attr('value');
	    r += $(this).attr('reviewid');
	    e = false;
	});
	if (!hasValue(v)) {
		swal('Error','Please select the appointments you would like to edit','error');
	}
	else {
		var m = $('#reassign');
		var url = fullcontexturl+ '/apptreassign.jsp';
		url += '?';
		url += '_ent=' + m.attr('_ent');
		url += '&';
		url += '_type=' + m.attr('_type');
		url += '&';
		url += '_id=' + v;
		url += '&';
		url += 'reviewids=' + r;
	    $.fancybox({
	        type: 'iframe',
	        href: url,
			width				: '75%',
			height				: '75%',
			autoScale			: false,
			transitionIn		: 'none',
			transitionOut		: 'none',
			afterClose		    : function() { window.location.reload( true ); }
	    });
	}
}

function apptreschedule() {
	var ava = uniqueAvailability();
	if (ava.length != 1) {
		swal('Error','Please select unique appointments','error');
	}
	else {
		var av = ava[0];
		if (av == null || av == undefined || av == '') {
			swal('Error','Please select unique appointments','error');
		}
		else {
			var e = true;
			var v = '';
			$('input:checked').each(function() {
				if (e == false) {
					v += '|';
				}
			    v += $(this).attr('value');
			    e = false;
			});
			if (!hasValue(v)) {
				swal('Error','Please select the appointments you would like to edit','error');
			}
			else {
				var m = $('#reschedule');
				var url = fullcontexturl+ '/apptreschedule.jsp';
				url += '?';
				url += '_ent=' + m.attr('_ent');
				url += '&';
				url += '_type=' + m.attr('_type');
				url += '&';
				url += '_id=' + v;
				url += '&';
				url += 'availabilityid=' + av;
			    $.fancybox({
			        type: 'iframe',
			        href: url,
					width			: '75%',
					height			: '75%',
					autoScale		: false,
					transitionIn	: 'none',
					transitionOut	: 'none',
					afterClose		: function() {
						if (isFancyBoxReload()) {
							window.location.reload( true );
						}
					}
			    });
			}
		}
	}
}

function toggleButtons(aid) {
	var r = $('input.inspresults[type=checkbox][availabilityid!='+aid+']:checked');
	var c = $('input.inspresults[type=checkbox]:checked');
	var m = $('#reschedule');
	var a = $('#reassign');
	if (isUniqueAvailability()) {
//		c.prop('disabled', false);
		m.removeClass('disabled');
		m.addClass('enabled');
	}
	else {
		m.removeClass('enabled');
		m.addClass('disabled');
	}

	if (c.length > 0) {
		a.removeClass('disabled');
		a.addClass('enabled');
	}
	else {
		a.removeClass('enabled');
		a.addClass('disabled');
	}
}

function isUniqueAvailability() {
	var a = uniqueAvailability();
	if (a.length != 1) { return false; }
	else { return true; }
}

function uniqueAvailability() {
	var elem = $('input.inspresults:checked');
	var outputArray = [];
	var noav = false;
	$(elem).each(function () {
        var aid = $(this).attr('availabilityid');
        if (aid < 1) { noav = true; }
		if ((jQuery.inArray(aid, outputArray)) == -1) {
			outputArray.push(aid);
		}
	});
	if (noav) { return []; }
	return outputArray;
}

