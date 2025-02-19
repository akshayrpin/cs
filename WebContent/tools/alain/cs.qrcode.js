    var _qrbarcode="";
    var _qrshift = false;

	$(document).ready(function() {
	    $('body').css({
	    	'background': 'url(/cs/images/qrcodedisabled.png)',
	    	'background-repeat': 'no-repeat',
	    	'background-position': 'center center',
	    	'background-color': '#cccccc'
	    });
	    $(document).keydown(function(e) {
	        var code = (e.keyCode ? e.keyCode : e.which);
	    	cslog(code);
	        if(code==13)// Enter key hit
	        {
	        	qrcodeRedirect(_qrbarcode);
	        	clearQRCode();
//	        	alert(_qrbarcode);
	        }
	        else if(code==9)// Tab key hit
	        {
	        	qrcodeRedirect(_qrbarcode);
	        	clearQRCode();
//	        	alert(_qrbarcode);
	        }
	        else
	        {
	        	var ch = "";
	        	if (_qrshift) {
	            	if (code == 55) {
	                	ch = "&";
	            	}
	            	else if (code == 186) {
	                	ch = ":";
	            	}
	            	else if (code == 191) {
	                	ch = "?";
	            	}
	            	else {
	                	ch = String.fromCharCode(code).toUpperCase();
	            	}
	            	_qrshift = false;
	        	}
	        	else {
	            	if (code == 187) {
	            		ch = "=";
	            	}
	            	else if (code == 190) {
	            		ch = ".";
	            	}
	            	else if (code == 191) {
	            		ch = "/";
	            	}
	            	else {
	                	ch = String.fromCharCode(code).toLowerCase();
	            	}
	        	}
	        	if (code == 16) {
	        		_qrshift = true;
	        	}
	        	else {
//	            	console.log(ch+" - "+code);
	                _qrbarcode=_qrbarcode+ch;
	                qrcodeUpdateStatus();
	        	}
	        }
	    });

	    $(window).focus(function() {
	        $('body').css({
	        	'background': 'url(/cs/images/animatedbarcode.gif)',
	        	'background-repeat': 'no-repeat',
	        	'background-position': 'center center',
	           	'background-color': '#f2f2f2'
	        });
	    }).blur(function() {
	        $('body').css({
	        	'background': 'url(/cs/images/qrcodedisabled.png)',
	        	'background-repeat': 'no-repeat',
	        	'background-position': 'center center',
	        	'background-color': '#cccccc'
	        });
	    });

	    $(window).focus();
	});


	function clearQRCode() {
		_qrbarcode="";
		_qrshift = false;
	}

	function qrcodeRedirect(params) {
		var success = false;

		var arr = params.split("?");
		var p = "";

		if (arr.length > 1) {
			p = arr[1];
		}
		else {
			p = arr[0];
		}
		var url = "";

		var hent = false;
		var htype = false;
		var htid = false;

		console.log(p);
		if (p != undefined && p != "") {
			var fvs = p.split("&");
			var empty = true;
			for (i = 0; i < fvs.length; i++) { 
				var fv = fvs[i];
				var fva = fv.split("=");
				if (fva.length > 1) {
					var f = fva[0];
					var v = fva[1];
					if (f == "entity") {
						if (!empty) { url += "&"; }
						url += "entity=" + encodeURI(v);
						console.log('entity: '+v);
						hent = true;
						empty = false;
					}
					else if (f == "type") {
						if (!empty) { url += "&"; }
						url += "type=" + encodeURI(v);
						console.log('type: '+v);
						htype = true;
						empty = false;
					}
					else if (f == "typeid") {
						if (!empty) { url += "&"; }
						url += "typeid=" + encodeURI(v);
						console.log('typeid: '+v);
						htid = true;
						empty = false;
					}
					else if (f == "reference") {
						if (!empty) { url += "&"; }
						url += "reference=" + encodeURI(v);
						console.log('reference: '+v);
						htid = true;
						empty = false;
					}
				}
			}
			if (hent && htype && htid) { success = true; }
		}

		if (success) {
			console.log('success');
        	clearQRCode();
        	qrcodeUpdateStatus();
	        $('body').css({
	        	'background': 'url(/cs/images/qrcode/success.png)',
	        	'background-repeat': 'no-repeat',
	        	'background-position': 'center center',
	        });
			top.location.href = "/cs?"+url;
		}
		else {
			console.log('fail');
        	clearQRCode();
        	qrcodeUpdateStatus();
	        $('body').css({
	        	'background': 'url(/cs/images/qrcode/error.png)',
	        	'background-repeat': 'no-repeat',
	        	'background-position': 'center center',
	        });
	        setTimeout(function(){
	            $('body').css({
	            	'background': 'url(/cs/images/animatedbarcode.gif)',
	            	'background-repeat': 'no-repeat',
	            	'background-position': 'center center',
	               	'background-color': '#f2f2f2'
	            });
	        }, 3000);
		}
	}

	function qrcodeUpdateStatus() {
		$('#qrcoderesult').html(_qrbarcode)
		try {
			if (_qrbarcode.indexOf("&end=y") > 0) {
	        	qrcodeRedirect(_qrbarcode);
	        	clearQRCode();
			}
		} catch(e) { }
	}





