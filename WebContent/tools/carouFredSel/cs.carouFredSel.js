
$(document).ready(function(){
	$('img.rotate').click(function() {
		rotate($(this));
	});
});

function loadSlideImage(data) {
	try {
		var slide = data.find('.slideimg');
		var bg = slide.css('background-image');
		bg = bg.replace('url(','').replace(')','').replace(/\"/gi, "");
		if (bg.indexOf('placeholder') > -1) {
			var nimg = slide.attr( 'data-original' );
			slide.css({'background-image':'url(' + nimg + ')'});
		}
	}
	catch(e) { }
}

function loadThumbImage(data) {
	try {
		var slide = data.find('.thumbimg');
		var bg = slide.css('background-image');
		bg = bg.replace('url(','').replace(')','').replace(/\"/gi, "");
		if (bg.indexOf('placeholder') > -1) {
			var nimg = slide.attr( 'data-original' );
			slide.css({'background-image':'url(' + nimg + ')'});
		}
	}
	catch(e) { }
}

function loadTableImage(data) {
	try {
		var slide = data.find('img[data-original]');
		var bg = slide.attr('src');
		if (bg.indexOf('placeholder') > -1) {
			var nimg = slide.attr( 'data-original' );
			slide.attr('src', nimg);
			slide.css({
				'max-width': '100%',
				'max-height': '600px'
			});
		}
	}
	catch(e) { }
}

function rotate(elem) {
	var currsrc = elem.attr('src');
	if (currsrc.indexOf('hourglass') > -1) {
		swal('Please Wait','Rotation currently in progress','info');
	}
	else {
		var id = elem.attr('rel');
		var img = $('#slideimg_'+id);
		if (img.length) {
			elem.attr('src','/cs/images/icons/controls/black/hourglass.png');
			img.attr('src','/cs/images/loaders/gears.gif');
			var rndm = Math.floor(Math.random() * 100);
			var url = '/cs/viewimg.jsp?view=rotate&_id='+id+'&rndm='+rndm;
			img.attr('src',url);
			img.load(function(){
				elem.attr('src','/cs/images/icons/controls/black/rotate.png');
				var thumb = $('#thumbimg_'+id);
				var turl = '/cs/viewimg.jsp?view=thumb&_id='+id+'&rndm='+rndm;
				thumb.css({'background-image':'url(' + turl + ')'});
			})
			.error(function(){
			});
		}
	}
}









