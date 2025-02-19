    var _qrbarcode="";
    var _qrshift = false;
    var _qrready = false;

	$(document).ready(function() {

    	QRcodeReady(true);
    	 $('#qrcodestatus').click(function() {
 	        _qrbarcode = "";
 	        qrcodeUpdateStatus();
    	 });
	      $('#qrcodestatus').css('cursor','pointer');

        $(window).keydown(function (evt) {
    		readQRcode(evt);
	    });

	    $(window).focus(function() {
	    	QRcodeReady(true);
	    }).blur(function() {
	    	QRcodeReady(false);
	    });

	    $('input[type=text]').focus(function() {
	    	QRcodeReady(false);
	    }).blur(function() {
	    	QRcodeReady(true);
	    });

	    $(window).focus();
	});

	function QRcodeReady(b) {
		if (b) {
	        $('#qrcodestatus').attr('src', '/cs/images/qrcode.png');
	        $('#qrcodestatus').attr('title','Ready to Scan');
	        _qrready = true;
	        _qrbarcode = "";
	        qrcodeUpdateStatus();
	    }
		else {
	        $('#qrcodestatus').attr('src', '/cs/images/qrcodestatus-disabled.png');
	        $('#qrcodestatus').attr('title','Click to Scan');
	        _qrready = false;
		}
	}

	function readQRcode(e) {
		if (_qrready) {
	        var code = (e.keyCode ? e.keyCode : e.which);
	    	cslog(code);
	        if(code==13)// Enter key hit
	        {
	        	qrcodeRedirect(_qrbarcode);
	        	clearQRCode();
	        }
	        else if(code==9)// Tab key hit
	        {
	        	qrcodeRedirect(_qrbarcode);
	        	clearQRCode();
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
		}
	}

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
		var htref = false;
		var _type = '';
		var _typeid = -1;

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
						_type = v;
						htype = true;
						empty = false;
					}
					else if (f == "typeid") {
						if (!empty) { url += "&"; }
						url += "typeid=" + encodeURI(v);
						console.log('typeid: '+v);
						_typeid = v;
						htid = true;
						empty = false;
					}
					else if (f == "reference") {
						if (!empty) { url += "&"; }
						url += "reference=" + encodeURI(v);
						console.log('reference: '+v);
						_reference = v;
						htid = true;
						htref = true;
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
        
        	var ref = ""
        	if(htref){
        		ref = _reference;
        	}
        	scantocart(_type, _typeid, ref);
        
//			top.location.href = "/cs?"+url;
		}
		else {
			console.log('fail');
        	clearQRCode();
        	qrcodeUpdateStatus();
        	swal('Error');
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





