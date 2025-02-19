
(function($){
	$.fn.autoGrow = function(options) {
		return this.each(function() {
			var org = $(this);
			org.css({
				'overflow': 'hidden',
				'resize': 'none',
				'box-sizing': 'border-box'
			});
			org.keyup(function() {
				autogrow(org);
			});
			org.click(function() {
				autogrow(org);
			});
			org.change(function() {
				autogrow(org);
			});
			autogrow(org);
		});
	}
})(jQuery);

function autogrowTextarea(textareaname) {
	var ta = $('textarea[name='+taxtareaname+']');
	autogrow(ta);
}


function autogrow(textareaobj) {
	try {
		textareaobj.css('height','auto');
		textareaobj.height(textareaobj[0].scrollHeight);
	} catch(e) { }
}












