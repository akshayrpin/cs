
	var loadingurl = 'tools/alain/loading.gif';
	var csuidebug = true;

	$.ajaxSetup({ cache:false });
	
	$(document).ready(function() {
		$('input[itype=date], input[itype=datetime], input[itype=availability_date]').keydown(function(e) {
			e.preventDefault();
			return false;
		});
		$('a:not([target])').click(function() {  if(($(this).attr('class')!="lightbox-iframe") || ($(this).attr('tab')!="tabs") ){ showLoader(); } }   );
		$('form').submit(function() {showLoader();});
		try {
			$(".sticky").sticky();
		} catch(e) {}

		hideLoader();
	});


	function cslog(log, title, referer) {
		try{
			if (csuidebug) {
				var d = currDate();
				console.log(d + ': ' + formatTitle(title, 20) + ': ' + JSON.stringify(log));
			}
		}catch(e){};
	}

	function cswarn(log, title, referer) {
		try{
			if (csuidebug) {
				var d = currDate();
				console.warn(d + ': ' + formatTitle(title, 20) + ': ' + JSON.stringify(log));
			}
		}catch(e){};
	}

	function cserror(log, title, referer) {
		try{
			if (csuidebug) {
				var d = currDate();
				console.error(d + ': ' + formatTitle(title, 20) + ': ' + JSON.stringify(log));
			}
		}catch(e){};
	}

	function csstack() {
		try { i.dont.exist += 0; }
		catch(e) {
			cslog(e.stack);
		}
	}

	function controlLoad(id) {
		var img = $('#'+id);
		img.attr('src','/cs/images/white-loading.gif');
		return true;
	}

	function currDate() {
		var d = new Date();
		var r = d.getFullYear();
		r+= '/' 
		if (d.getMonth() < 9) { r+= '0'; }
		r+= (d.getMonth() + 1);
		r+= '/';
		if (d.getDate() < 10) { r+= '0'; }
		r+= d.getDate();
		r+= ' ';
		if (d.getHours() < 10) { r+= '0'; }
		r+= d.getHours();
		r+= ':';
		if (d.getMinutes() < 10) { r+= '0'; }
		r+= d.getMinutes();
		r+= ':';
		if (d.getSeconds() < 10) { r+= '0'; }
		r+= d.getSeconds();
		r+= ':';
		if (d.getMilliseconds() < 100) { r+= '0'; }
		if (d.getMilliseconds() < 10) { r+= '0'; }
		r+= d.getMilliseconds();
		return r;
	}

	function formatTitle(title, chars) {
		var r = '';
		if (!hasValue(title)) {
			title = '';
		}
		var n = title.length;
		r = title;
		if (n < chars) {
			var c = chars - n;
			for (i = 0; i < c; i++) {
				r += ' ';
			}
		}
		return r;
	}

	function createLoading() {
		var l = $('<div/>');
		l.addClass('loading');
		l.html('<img src="'+loadingurl+'"/>');
		return l;
	}

	function inline() {
		return {
			'display': 'inline-block',
			'*display': 'inline',
			'zoom': 1
		};
	}

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

//	function hasValue(o) {
//		try {
//			var t = jQuery.type(o);
//			if (!o)                                                 { return false; }
//			else if (o == undefined)                                { return false; }
//			else if (o == null)                                     { return false; }
//			else if (t == 'string' && o == '')                      { return false; }
//			else if (t == 'array' && o.length < 1)                  { return false; }
//			else if (t != 'boolean' && !o)                          { return false; }
////			else if (t == 'object' && (!o.length || o.length == 0)) { cslog(o.length,t); return false; }
//			else if (o.length && o.length < 1)                      { return false; }
//			return true;
//		}
//		catch(e) { return false; }
//	}

	function doAjax(urladdrss, datamap) {
		cslog(urladdrss, 'Ajax URL');
		cslog(datamap, 'Ajax Send');
		var r = undefined;
		if (hasValue(urladdrss)) {
			var a = $.ajax({
				url: urladdrss,
				async: false,
				type:'POST', 
				dataType: 'json',
				data: datamap,
				success: function(result) {
					r = result;
					cslog(r, 'Ajax Response');
				},
				error: function(xhr,status,error) {
					cslog(xhr.responseText, 'Ajax Response');
					cslog(status, 'Ajax Error');
				}
			});
		}
		return r;
	}

	function toTitleCase(str) {
		return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
	}

	function fancyAlert(message) {
		var c = '<div class="fancyalert">' + message + '</div>';
		$.fancybox(c);
	}

	function showLoader() {
		$("#loader").show();
	}

	function showProcess(title, message, pct) {
		$("#process").show();
		if (title != null && title != undefined) {
			$('#processtitle').html(title);
		}
		if (pct != null && pct != undefined) {
			$('#processpercentage').css({'width': pct+'%'});
			$('#processpercentage').html(pct+"%");
		}
		if (message != null && message != undefined) {
			$('#processmessage').html(message);
		}
	}

	function hideLoader() {
		$("#loader").fadeOut("slow");
	}

	function hideProcess() {
		$("#process").hide();
	}

	function sleep(milliseconds) {
		var start = new Date().getTime();
		for (var i = 0; i < 1e7; i++) {
			if ((new Date().getTime() - start) > milliseconds){
				break;
			}
		}
	}

	function uniqueArray(inputArray) {
		var outputArray = [];
		for (var i = 0; i < inputArray.length; i++) {
			if ((jQuery.inArray(inputArray[i], outputArray)) == -1) {
				outputArray.push(inputArray[i]);
			}
		}
		return outputArray;
	}

	function doTimedMessage(title, text, type) {
		try {
			swal({
				title: title,
				text: text,
				type: type,
				timer: 1200,
				allowOutsideClick: true,
				showConfirmButton: false
			});
		} catch(edtm) { }
	}

	function doAlert(title, text, type) {
		try {
			swal({
				title: title,
				text: text,
				type: type,
				allowOutsideClick: true,
				showConfirmButton: true
			});
		} catch(eda) { }
	}

	function alertSuccess(text) {
		doTimedMessage('Success', text, 'success');
	}

	function alertError(text) {
		doTimedMessage('Error', text, 'error');
	}

	function alertCode(code, success, error) {
		if (hasValue(code)) {
			if (code == 'cs200') { alertSuccess(success); }
			else { alertError(error); }
		}
	}

	function formatPhone(phonenum) {
		var regexObj = /^(?:\+?1[-. ]?)?(?:\(?([0-9]{3})\)?[-. ]?)?([0-9]{3})[-. ]?([0-9]{4})$/;
		if (regexObj.test(phonenum)) {
			var parts = phonenum.match(regexObj);
			var phone = "";
			if (parts[1]) { phone += "(" + parts[1] + ") "; }
			phone += parts[2] + "-" + parts[3];
			return phone;
		}
		else {
			//invalid phone number
			return phonenum;
		}
	}

	function formatThousands(str) {
		return (str + "").replace(/\b(\d+)((\.\d+)*)\b/g, function(a, b, c) {
			return (b.charAt(0) > 0 && !(c || ".").lastIndexOf(".") ? b.replace(/(\d)(?=(\d{3})+$)/g, "$1,") : b) + c;
		});
	}

	function refusersonlineaccount(id, email) {
		if (email == undefined || email == '') {
			doAlert('Error', 'Email address unavailable', 'error');
		}
		else {
			var url = '/cs/json/post.jsp?_id='+id;
			url += '&_reference='+encodeURI(email);
			url += '&_ent='+entity;
			url += '&_type='+type;
			url += '&_grp=people';
			url += '&_grptype=users';
			url += '&_request=refuseronlineaccount';
			if (id && id > 0) {
				swal({
					title: 'Create/Reset Online Account',
					text: 'Are you sure you want to create or reset this user\'s online acount? This functiion will send an email to the user with a temporary password.\n\nThe email will be sent to: '+email,
					type: "warning",
					showCancelButton: true,
					confirmButtonColor: "#DD6B55",
					confirmButtonText: 'Yes',
					cancelButtonText: 'No',
					closeOnConfirm: false,
					closeOnCancel: true
				},
				function(isConfirm) {
					if (isConfirm) {
						var r = doAjax(url);
						var msg = r.message;
						var t = r.token;
						if (t == undefined || t == '') {
							doAlert('Create/Reset Online Account', msg, 'error');
						}
						else {
							doAlert('Create/Reset Online Account', msg, 'success');
						}
					}
				});
			}
		}
	}

	function createLoader(elem) {
		var t = $('<table/>');

		var tr = $('<tr/>');
		var td = $('<td/>');

		var i = $('<img/>');
		i.attr('src', '/cs/images/loaders/gears.gif');
		td.append(i);
		tr.append(td);
		t.append(tr);
		t.css({
			'width': '100%',
			'text-align': 'center',
			'margin-top': 'auto',
			'margin-bottom': 'auto'
		});

		elem.empty();
		elem.html(t);
	}



	function loginpopup(initial, usertext, linktext, linkurl, token, ip, sesscreated, version) {

		var p = $('<div/>');
		p.addClass('plogin');

		var pi = $('<div/>');
		pi.addClass('plogininitial');
		pi.html(initial);
		p.append(pi);

		var pu = $('<div/>');
		pu.addClass('ploginusername');
		pu.html(usertext);
		p.append(pu);

		var ptbl = $('<table/>');
		ptbl.addClass('plogintable');

		if (hasValue(ip)) {
			var iptr = $('<tr/>');
			var iplbltd = $('<td/>');
			iplbltd.addClass('ploginlabeltd');
			iplbltd.html('REMOTE IP');
			iptr.append(iplbltd);

			var iptd = $('<td/>');
			iptd.addClass('plogincontenttd');
			iptd.html(ip);
			iptr.append(iptd);

			ptbl.append(iptr);
		}

		if (hasValue(sesscreated)) {
			var sctr = $('<tr/>');
			var sclbltd = $('<td/>');
			sclbltd.addClass('ploginlabeltd');
			sclbltd.html('SESSION CREATED');
			sctr.append(sclbltd);

			var sctd = $('<td/>');
			sctd.addClass('plogincontenttd');
			sctd.html(sesscreated);
			sctr.append(sctd);

			ptbl.append(sctr);
		}

		if (hasValue(version)) {
			var vetr = $('<tr/>');
			var velbltd = $('<td/>');
			velbltd.addClass('ploginlabeltd');
			velbltd.html('APP VERSION');
			vetr.append(velbltd);

			var vetd = $('<td/>');
			vetd.addClass('plogincontenttd');
			vetd.html(version);
			vetr.append(vetd);

			ptbl.append(vetr);
		}

//		var tokenurl = '/cs/json/token.jsp';
//		var result = doAjax(tokenurl);
//		var info = result['info'];
//		if (hasValue(token)) {
//			var tktr = $('<tr/>');
//			var tklbltd = $('<td/>');
//			tklbltd.addClass('ploginlabeltd');
//			tklbltd.html('TOKEN');
//			tktr.append(tklbltd);
//
//			var tktd = $('<td/>');
//			tktd.addClass('plogincontenttd');
//			tktd.html(token);
//			tktr.append(tktd);
//
//			ptbl.append(tktr);
//		}
//			if (hasValue(info)) {
//				var prls = info['ROLES'];
//				var prl = prls.split(',');
//				if (prl.length > 0) {
//					var rtr = $('<tr/>');
//					var rlbltd = $('<td/>');
//					rlbltd.addClass('ploginlabeltd');
//					rlbltd.html('ROLES');
//					rtr.append(rlbltd);
//
//					var rrltd = $('<td/>');
//					rrltd.addClass('plogincontenttd');
//					var rl = '';
//					for (i=0; i<prl.length; i++) {
//						rl += prl[i];
//						rl += '<br/>';
//					}
//					rrltd.html(rl);
//					rtr.append(rrltd);
//					ptbl.append(rtr);
//				}
//			}

		p.append(ptbl);

		var pl = $('<div/>');
		pl.addClass('ploginlinkbox');

		var pla = $('<div/>');
		pla.addClass('ploginlink');
		pla.html(linktext);
		pla.click(function() {
			window.location.href = linkurl;
		});
		pl.append(pla);

		p.append(pl);
		return p;

	}








