var spritesurl = '/cs/tools/alain/sprites.png';
var altsuccessredirect = false;

(function($){
	$.fn.csform = function(options) {

		var defaults = {
			url: {
				success: '',
				error: ''
			},
			// buttons
			button: {
				type: 'arrow',
				position: 'left',
				color: 'grey',
				hovercolor: 'black'
			},
			icons: {
				email: '/cs/images/icons/input/email.png',
				phone: '/cs/images/icons/input/phone.png',
				comment: '/cs/images/icons/input/comment.png',
				datetime: '/cs/images/icons/input/datetime.png',
				date: '/cs/images/icons/input/calendar.png',
				availability_date: '/cs/images/icons/input/calendar.png',
				reviewduedate: '/cs/images/icons/input/calendar.png'
			},
			callback: {
				submit: {
					success: null,
					error: null,
					result: null,
					start: null
				}
			},
			ajaxsubmit: true

	  	};  
	 	var opts = $.extend(defaults, options);
		$.ajaxSetup({ cache:false });
	 	var scrollHandler;
		var len = this.length - 1;

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
				else if (opts.button.color == 'white') { return '-45px -190px'; }
				else if (opts.button.color == 'black') { return '-95px -190px'; }
				else { return '-195px -190px'; }
			}
			else {
				if (opts.button.color == 'none') { return '0px 0px'; }
				else if (opts.button.color == 'white') { return '-45px -140px'; }
				else if (opts.button.color == 'black') { return '-95px -140px'; }
				else { return '-195px -140px'; }
			}
		}

		function container(e) {
			var n = e.attr('name');
			var r = $('<div/>');
			r.attr('id', 'cont_'+n);
			var m = $('<div/>');
			m.attr('id', 'msg_'+n);
			m.addClass('csform_message');
			r.append(m);
			var c = $('<div/>');
			c.attr('id', 'inpt_'+n);
			r.append(c);
			c.css({
				'display': 'inline-block',
				'*display': 'inline',
				'zoom': 1
			});
			c.append(e);
			c.addClass('csform');
			if (isrequired(e) && !hasValue(e.val())) {
				c.addClass('csform_alert');
			}
			e.css({
				'border': '0px',
				'padding':'8px',
				'width':'100%',
				'outline': 'none',
				'background-color': 'transparent',
				'box-sizing':'border-box',
				'-moz-box-sizing': 'border-box',
				'-webkit-box-sizing': 'border-box'
			});
			e.focus(function() {
				c.addClass('csform_highlight');
			});
			e.blur(function() {
				if (isrequired(e) && !hasValue(e.val())) {
					c.addClass('csform_alert');
				}
				else {
					c.removeClass('csform_alert');
				}
				m.empty();
				c.removeClass('csform_highlight');
			});
			e.change(function() {
				c.removeClass('csform_error');
				if (isrequired(e) && !hasValue(e.val())) {
					c.addClass('csform_alert');
				}
				else {
					c.removeClass('csform_alert');
				}
				var label = $('#label_'+n);
				if (label.length) {
					try { label.removeClass('invalid'); } catch (e) { }
					try { label.children('div').remove(); } catch (e) { }
				}
			});
			var itype = e.attr('itype');
			var bg = opts.icons[itype];
			if (hasValue(bg)) {
				e.css({
					'background-image': 'url('+bg+')',
					'background-repeat': 'no-repeat',
					'background-position' : 'right 4px top 4px'
				});
			}
			return r;
		}

		function filecontainer(e) {
			e.css({
				'border': '0px',
				'padding':'8px',
				'width':'calc(100% - 50px)',
				'outline': 'none',
				'background-color': 'transparent',
				'box-sizing':'border-box',
				'-moz-box-sizing': 'border-box',
				'-webkit-box-sizing': 'border-box'
			});
			return e;
		}

		function selectcontainer(select) {
			var n = select.attr('name');
			var r = $('<div/>');
			r.attr('id', 'cont_'+n);
			var m = $('<div/>');
			m.attr('id', 'msg_'+n);
			m.addClass('csform_message');
			r.append(m);
			var c = $('<div/>');
			c.attr('id', 'select_'+n);
			r.append(c);
			c.css({
				'display': 'inline-block',
				'*display': 'inline',
				'zoom': 1
			});
			c.append(select);
			c.addClass('csform_select');
			var a = select.attr('auto');
			if (!hasValue(a) || a != 'false') {
				jsonSelect(select);
			}
			select.change(function() {
				m.empty();
				c.removeClass('csform_error');
				c.removeClass('csform_highlight');
				var label = $('#label_'+n);
				if (label.length) {
					try { label.removeClass('invalid'); } catch (e) { }
					try { label.children('div').remove(); } catch (e) { }
				}
			})
			return r;
		}

		function init_form(frm) {
			frm.on('submit', function(e) {
				if (frm_validate(frm)) {
					var url = frm.attr('action');
					if (opts.ajaxsubmit) {
						e.preventDefault();
						if (opts.callback.submit.start) {
							opts.callback.submit.start.call();
						}
						var data = frm.serializeArray();
						cslog(url, 'Ajax URL');
						cslog(data, 'Ajax Send');
						if (frm_post(url, data)) {}
//						else {
//							try { hideLoader(); } catch(e) { }
//						}
					}
					else {
//						cslog(url, 'POST');
					}
				}
				else {
					e.preventDefault();
					try { hideLoader(); } catch(e) { }
				}
		    });
		}

		function frm_post(url, data) {
			try {
				$.ajax({
					type:'POST', 
					url: url, 
					data: data,
					dataType: 'json',
					success: function(response) {
						frm_progress(response);
						cslog(response);
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) { 
						if (opts.error != null) {
							try { 
								var s = opts.callback.submit.error.call(s, data);
							}
							catch (e) { }
						}
						hideLoader();
						cslog(textStatus);
					}
				});
			}
			catch (e) {
				if (opts.callback.submit.error != null) {
					try { 
						var s = opts.callback.submit.error.call(s, data);
					} catch (es) { }
				}
				hideLoader();
				cslog(e.message);
			}
			return false;
		}

		function frm_progress(data) {
			var pct = data.percentcomplete;
			var dt = data.processtitle;
			var dm = data.processmessage;
			var prid = data.processid;
			showProcess(dt, dm, pct);
			if (pct != null && pct != undefined && pct < 100 && prid != null && prid != undefined && prid != '') {
				setTimeout(
					  function()  {
							var u = fullcontexturl+'/json/log.jsp';
							u += '?_ent='+entity;
							u += '&_id='+prid;
							try {
								$.ajax({
									type:'POST', 
									url: u, 
									dataType: 'json',
									success: function(response) {
										frm_progress(response);
									},
									error: function(XMLHttpRequest, textStatus, errorThrown) { 
										if (opts.error != null) {
											try { 
												var s = opts.callback.submit.error.call(s, data);
											}
											catch (e) { }
										}
										hideLoader();
										cslog(textStatus);
									}
								});
							}
							catch (e) {
								if (opts.callback.submit.error != null) {
									try { 
										var s = opts.callback.submit.error.call(s, data);
									} catch (es) { }
								}
								hideLoader();
								cslog(e.message);
							}
						},
				2000);
			}
			else {
				hideProcess();
				frm_doCommand(data);
			}
		}

		function frm_doCommand(data) {
			var r = true;
			var code = data.messagecode;
			if (code == null || code == undefined || code == '') {
				if (opts.callback.submit.response != undefined && opts.callback.submit.response != null) {
					try {
						var s = opts.callback.submit.response.call(s, data);
					} catch(e) { }
				}
				else {
					try {
						success(data);
					} catch (e) { }
				}
			}
			else if (code == 'cs200') {
				if (opts.callback.submit.success != undefined && opts.callback.submit.success != null) {
					try {
						var s = opts.callback.submit.success.call(s, data);
					}
					catch (e1) { }
				}
				else if (hasValue(opts.url.success)) {
					try {
						parent.refreshPanels();
					}
					catch(e) { }
					self.location = opts.url.success;
				}
				else {
					try {
						success(data);
					} catch (e) { }
				}
			}
			else {
				r = false;
				var msg = '';
				var hasmsg = false;
				try {
					var msgs = data.messages;
					$.each(msgs, function(idx, res) {
						msg += res + '\n';
						hasmsg = true;
					});
				} catch(e) { }
				
				var err = '';
				var haserr = false;
				try {
					var errors = data.errors;
					$.each(errors, function(idx, res) {
						var message = res.message;
						if (hasValue(message)) {
							err += message+'\n';
							haserr = true;
						}
					});
				} catch(e) { }

				var m = '';
				if (!hasmsg && !haserr) {
					if (code == 'cs400') {
						m = 'PERMISSION DENIED';
					}
					else if (code == 'cs401') {
						m = 'UNAUTHORIZED';
					}
					else if (code == 'cs402') {
						m = 'SESSION EXPIRED';
					}
					else if (code == 'cs403') {
						m = 'INVALID TOKEN';
					}
					else if (code == 'cs402') {
						m = 'METHOD NOT FOUND';
					}
					else if (code == 'cs406') {
						m = 'UNSECURED REQUEST';
					}
					else if (code == 'cs412') {
						m = 'UNMET CONDITIONS';
					}
					else if (code == 'cs500') {
						m = 'INTERNAL SERVER ERROR';
					}
				}
				else {
					if (hasmsg) { m += msg; }
					if (haserr) { m += err; }
				}
				hideLoader();
				swal(code, m, 'error');
			}
			return r;
		}

		function init(e) {
			var par = e.parent();
			var r = undefined;
			var type = e.attr('type');
			var itype = e.attr('itype');
			if (!hasValue(itype)) {
				itype = type;
			}
			if (itype == 'number' || itype == 'integer' || itype == 'decimal' || itype == 'currency') {
				r = container(e);
//				r = numerical(e);
			}
			else if (e.is('select')) {
				r = selectcontainer(e);
			}
			else if (e.is('textarea')) {
				r = container(e);
			}
			else if (e.hasClass('cs_search')) {
				
			}
			else if (hasValue(type) && type != 'submit' && type != "checkbox" && type != "radio" && type != "hidden") {
				if (type == 'file') {
					r = filecontainer(e);
				}
				else {
					r = container(e);
				}
			}
			if (hasValue(r)) {
				par.append(r);
			}
		}

		return this.each(function(i) {
			var org = $(this);
			var successurl = org.attr('success');
			var altsuccessurl = org.attr('altsuccess');
			var refresh = org.attr('refresh');
			var close = org.attr('close');
			var _entity = '';
			var _type = '';
			var _typeid = -1;
			var _group = '';
			var groupid = '';
			try { _entity = entity; } catch(e) { }
			try { _type = type; } catch(e) { }
			try { _typeid = typeid; } catch(e) { }
			try { _group = group; } catch(e) { }
			try { _groupid = groupid; } catch(e) { }
			if (hasValue(successurl)) {
				opts.callback.submit.success = function(data) {
					concludeForm(data, successurl, _entity, _type, _typeid, _group, _groupid, refresh, altsuccessurl);
				}
			}
			else if (hasValue(close) && close == 'true') {
				opts.callback.submit.success = function(data) {
					closeLightbox(refresh);
				}
			}
			var inputs = $(this).find(':input');
			inputs.each(function(){
				init($(this));
			});
			init_form(org);
		});
	};

})(jQuery);

function concludeForm(data, successurl, _entity, _type, _typeid, _group, _groupid, refresh, altsuccessurl) {
	if (hasValue(refresh) && refresh == 'true') {
		try {
			var d_entity = _entity;
			var d_typeid = _typeid;
			var d_type = _type;
	
			var datatype = data.type['type'];
			var datatypeid = data.type['typeid'];
			var dataentity = data.type['entity'];
			if (datatype != undefined && datatype != null && datatype != '' && datatypeid != undefined && datatypeid != null && datatypeid != '') {
				d_type = datatype;
				d_typeid = datatypeid;
			}
			if (dataentity != undefined && dataentity != null && dataentity != '') {
				d_entity = dataentity;
			}
			parent.getBrowsers(dataentity, d_type, d_typeid);
		} catch(e) { }
	}
	var url = '';
	if (altsuccessredirect) {
		url = replaceWithData(altsuccessurl, data, _entity, _type, _typeid, _group, _groupid);
	}
	else {
		url = replaceWithData(successurl, data, _entity, _type, _typeid, _group, _groupid);
	}
	self.location = url;
}

function closeLightbox(refresh) {
	if (hasValue(refresh) && refresh == 'true') {
		try { parent.location.reload(true); } catch (e) { }
	}
	try {
		parent.$.fancybox.close();
	} catch(e) { }
}

function replaceWithData(str, data, _entity, _type, _typeid, _group, _groupid) {
	if (data == undefined) { return str; }
	var s = str;
	try {
		var d_id = '';
		var d_entity = '';
		var d_typeid = '';
		var d_type = '';
		var d_group = '';
		var d_groupid = '';
		var d_messagecode = '';
		var d_entityid = '';

		if (data.id != undefined && data.id != null && data.id != '') { d_id = data.id; }
		if (data.messagecode != undefined && data.messagecode != null && data.messagecode != '') { d_messagecode = data.messagecode; }
		if (_entity != undefined && _entity != null && _entity != '') { d_entity = _entity; }
		if (_typeid != undefined && _typeid != null && _typeid != '') { d_typeid = _typeid; }
		if (_type != undefined && _type != null && _type != '') { d_type = _type; }
		if (_group != undefined && _group != null && _group != '') { d_group = _group; }
		if (_groupid != undefined && _groupid != null && _groupid != '') { d_groupid = _groupid; }

		var datatype = data.type['type'];
		var datatypeid = data.type['typeid'];
		var dataentityid = data.type['entityid'];
		if (datatype != undefined && datatype != null && datatype != '' && datatypeid != undefined && datatypeid != null && datatypeid != '') {
			d_type = datatype;
			d_typeid = datatypeid;
		}
		if (dataentityid != undefined && dataentityid != null && dataentityid != '') {
			d_entityid = dataentityid;
		}

		s = s.replace('data.id', encodeURIComponent(d_id));
		s = s.replace('data.messagecode', encodeURIComponent(d_messagecode));
		s = s.replace('data.entity', encodeURIComponent(d_entity));
		s = s.replace('data.entityid', encodeURIComponent(d_entityid));
		s = s.replace('data.typeid', encodeURIComponent(d_typeid));
		s = s.replace('data.type', encodeURIComponent(d_type));
		s = s.replace('data.groupid', encodeURIComponent(d_groupid));
		s = s.replace('data.group', encodeURIComponent(d_group));
	}
	catch (e) { }
	return s;
}

function replaceWithDataType(str, data) {
	if (data == undefined) { return str; }
	var s = str;
	try {
		var d_id = '';
		var d_entity = '';
		var d_entityid = '';
		var d_typeid = '';
		var d_type = '';

		if (data.id != undefined && data.id != null && data.id != '') { d_id = data.id; }
		if (data.entity != undefined && data.entity != null && data.entity != '') { d_entity = data.entity; }
		if (data.entityid != undefined && data.entityid != null && data.entityid != '') { d_entityid = data.entityid; }
		if (data.type != undefined && data.type != null && data.type != '') { d_type = data.type; }
		if (data.typeid != undefined && data.typeid != null && data.typeid != '') { d_typeid = data.typeid; }
		s = s.replace('data.id', encodeURIComponent(d_id));
		s = s.replace('data.entity', encodeURIComponent(d_entity));
		s = s.replace('data.entityid', encodeURIComponent(d_entityid));
		s = s.replace('data.typeid', encodeURIComponent(d_typeid));
		s = s.replace('data.type', encodeURIComponent(d_type));
		s = s.replace('data.id', encodeURIComponent(d_id));
		s = s.replace('data.entity', encodeURIComponent(d_entity));
		s = s.replace('data.entityid', encodeURIComponent(d_entityid));
		s = s.replace('data.typeid', encodeURIComponent(d_typeid));
		s = s.replace('data.type', encodeURIComponent(d_type));
	}
	catch (e) { }
	return s;
}

function upButton() {
	var r = $('<div/>');
	r.css({
		'padding': '0px',
		'margin': '0px',
		'width': '10px',
		'height': '15px',
		'background-image': 'url('+spritesurl+')',
		'background-repeat': 'no-repeat',
		'background-position': buttonUpPosition(),
		'cursor':'pointer'
	});
	return r;
}

function downButton() {
	var r = $('<div/>');
	r.css({
		'padding': '0px',
		'margin': '0px',
		'width': '10px',
		'height': '15px',
		'background-image': 'url('+spritesurl+')',
		'background-repeat': 'no-repeat',
		'background-position': buttonDownPosition(),
		'cursor':'pointer'
	});
	return r;
}

function button() {
	var r = $('<div/>');
	r.css({
		'margin': '0px',
		'width': '10px',
		'height': '20px',
		'vertical-align' : 'top',
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
		n = parseFloat(i);
		input.val((n + 0.01).toFixed(2)).change();
	}
	else {
		n = parseInt(i);
		n++;
		input.val(n).change();
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
		n = parseFloat(i);
		input.val((n - 0.01).toFixed(2)).change();
	}
	else {
		n = parseInt(i);
		n--;
		input.val(n).change();
	}
}

function jsonSelect(select, jurl) {
	var u = '';
	var j = select.attr('json');
	var lkup = select.attr('lkup');
	var val = select.attr('val');
	if (hasValue(j)) {
		if(!stringStartsWith(j,"http")){
			if (hasValue(jurl)) {
				u = fullcontexturl+'/json/'+jurl+'.jsp';
			}
			else {
				u = fullcontexturl+'/json/lkupchoices.jsp';
			}
			u += '?_ent='+entity+'&';
			u += j;
		}
		else {
			u = j;
		}
	}
	else if (hasValue(lkup)) {
		u = fullcontexturl+'/json/lkup.jsp?lkup='+lkup+'&_ent='+entity+'&_type='+type+'&_typeid='+typeid+'&_grp='+group+'&_grptype='+grouptype+'&_id='+val;
	}
	if (hasValue(u)) {
//		var val = select.attr('val');
		var name = select.attr('name');
		var vala = undefined;
		if (hasValue(val)) {
			vala = val.split('|');
		}
		cslog(u,"Ajax");
		var a = $.ajax({
			url: u,
			async: false,
			dataType: 'json',
			success: function(result) {
				var items = result['choices'];
				if (hasValue(items)) {
					var o = $('<option/>');
					select.append(o);
					o.attr('value', '');
					o.html(' ');
					$.each(items, function(k,item){
						var i = item['id'];
						var v = item['value'];
						var t = item['text'];
						var s = item['selected'];
						var d = item['addldata'];
						if (!hasValue(t)) { t = v; }
						var o = $('<option/>');
						o.attr('value', i);

						if (hasValue(d)) {
							$.each( d, function( dkey, dvalue ) {
								o.attr(dkey,dvalue);
							});
						}


						if (v == val) {
							o.attr('selected', true);
						}
						else if (hasValue(vala) && vala.indexOf(v) > -1) {
							o.attr('selected', true);
						}
						else if (hasValue(s) && s.toLowerCase() == 'y' ) {
							o.attr('selected', true);
						}
						else if (items.length == 1) {
							if (isrequired(select)) {
								o.attr('selected', true);
							}
						}
						o.html(toTitleCase(t));
						select.append(o);
					});
				}
			},
			error: function(xhr,status,error) {
			}
		});
	}
	try {
		select.trigger("chosen:updated");
	} catch(e) {}
	return select;
}

function jsonAvailabilityDate(dateelem, timeelem, ent, typ, typid, appttypeid, apptsubtypeid, apptstatusid) {

	if (hasValue(dateelem)) {
		var appttid = -1;
		var apptstid = -1;
		var apptsid = -1;

		try { apptid = parseInt(appttypeid); } catch (e) { }
		try { appstid = parseInt(apptsubtypeid); } catch (e) { }
		try { appsid = parseInt(apptstatusid); } catch (e) { }

		var u = fullcontexturl+'/json/availability.jsp?_ent='+ent+'&_type='+typ+'&_typeid='+typid+'&_appttypeid='+appttypeid+'&_apptsubtypeid='+apptsubtypeid+'&_apptstatusid='+apptstatusid+'&_end=365';
		dateelem.val('').change();

		var a = $.ajax({
			url: u,
			async: false,
			dataType: 'json',
			success: function(result) {
				var mindate = result.mindate;
				var maxdate = result.maxdate;
				var avid = result.id;
				var disableddates = result.disableddates;
				if (avid > 0) {
					enableAvailabilityDate(dateelem);

					dateelem.datetimepicker({
						minDate: mindate,
						maxDate: maxdate,
						disabledDates: disableddates,
						timepicker:false,
						format:'Y/m/d',
						validateOnBlur:true,
						todayButton: false,
						defaultSelect: false,
						onSelectDate: function(ct,$i) {
							if (hasValue(timeelem) && hasValue(dateelem.val())) {
//								if (avid > 0) {
									jsonAvailabilityTime(timeelem, dateelem.val(), ent, typ, typid, appttypeid, apptsubtypeid, apptstatusid);
//								}
							}
						},
						onShow: function(ct,$i) {
							if (appttypeid < 1 && apptstatusid == 0) {
								return false;
							}
						}
					});
				}
			},
			error: function(xhr,status,error) {
				cslog(xhr);
			}
		});

	}
}

function jsonAvailabilityIdDate(dateelem, timeelem, ent, availabilityid) {

	if (hasValue(dateelem)) {
		var appttid = -1;
		var apptstid = -1;
		var apptsid = -1;

		try { apptid = parseInt(appttypeid); } catch (e) { }
		try { appstid = parseInt(apptsubtypeid); } catch (e) { }
		try { appsid = parseInt(apptstatusid); } catch (e) { }

		var u = fullcontexturl+'/json/availability.jsp?_request=multiavailability&_ent='+ent+'&_type=appointment&_id='+availabilityid+'&_end=365';
		dateelem.val('').change();

		var a = $.ajax({
			url: u,
			async: false,
			dataType: 'json',
			success: function(result) {
				var mindate = result.mindate;
				var maxdate = result.maxdate;
				var avid = result.id;
				var disableddates = result.disableddates;
//				if (avid > 0) {
					enableAvailabilityDate(dateelem);

					dateelem.datetimepicker({
						minDate: mindate,
						maxDate: maxdate,
						disabledDates: disableddates,
						timepicker:false,
						format:'Y/m/d',
						validateOnBlur:true,
						todayButton: false,
						defaultSelect: false,
						onSelectDate: function(ct,$i) {
							if (hasValue(timeelem) && hasValue(dateelem.val())) {
//								if (avid > 0) {
									jsonAvailabilityIdTime(timeelem, dateelem.val(), ent, availabilityid);
//								}
							}
						},
						onShow: function(ct,$i) {
						}
					});
//				}
			},
			error: function(xhr,status,error) {
				cslog(xhr);
			}
		});

	}
}

function enableAvailabilityDate(dateelem) {
	dateelem.prop('disabled', false);
	dateelem.attr('valrequired', 'true');
	dateelem.css({
		'background-color': ''
	});
}

function enableAvailabilityTime(timeelem) {
	timeelem.attr('valrequired', 'true');
	timeelem.prop('disabled', false);
}

function disableAvailabilityDate(dateelem) {
	dateelem.prop('disabled', true);
	dateelem.attr('valrequired', 'false');
	dateelem.css({
		'background-color': '#dddddd'
	});
}

function disableAvailabilityTime(timeelem) {
	timeelem.attr('valrequired', 'false');
	timeelem.prop('disabled', true);
}

function jsonAvailabilityTime(timeelem, avdate, ent, typ, typid, appttypeid, apptsubtypeid, apptstatusid) {
	if (hasValue(timeelem)) {
		var u = fullcontexturl+'/json/availability.jsp?_ent='+ent+'&_type='+typ+'&_typeid='+typid+'&_appttypeid='+appttypeid+'&_apptsubtypeid='+apptsubtypeid+'&_apptstatusid='+apptstatusid+'&_startdate='+encodeURI(avdate)+'&_end=0';
		timeelem.empty();
		timeelem.val('').change();
		var val = timeelem.attr('val');
		var a = $.ajax({
			url: u,
			async: false,
			dataType: 'json',
			success: function(result) {
				try {
					enableAvailabilityTime(timeelem);
					var dates = result.dates;
					var mindate = result.mindate;
					var d = dates[mindate];
					var t = d.times;
					var eo = $('<option/>');
					timeelem.append(eo);
					$.each( t, function(index,value) {
						var start = value.start;
						var end = value.end;
						var seats = value.seats;
						var taken = value.taken;
						var text = value.text;
						var v = value.id;
						var c = value.customid;
						if (v < 1) { v = 0; }
						if (c < 1) { c = 0; }
						var d = value.disabled;
						var f = value.full;
						var o = $('<option/>');
						if (d == true || f == true) {
							if(val!=''){
								if (v != val) {
									o.prop('disabled', true);
								}
							}
						}
						o.attr('value', v);
						if (v == val) {
							o.attr('timeelemed', true);
						}

						var html = text;
						o.html(html);
						timeelem.append(o);
					});
					enableTime();
				}
				catch(e) { }
			},
			error: function(xhr,status,error) {
				cslog(xhr);
			}
		});
		try {
			timeelem.trigger("chosen:updated");
		} catch(e) {}
	}
}

function jsonAvailabilityIdTime(timeelem, avdate, ent, availabilityid) {
	if (hasValue(timeelem)) {
		var u = fullcontexturl+'/json/availability.jsp?_request=multiavailability&_ent='+ent+'&_type=appointment&_id='+availabilityid+'&_startdate='+encodeURI(avdate)+'&_end=0';
		timeelem.empty();
		timeelem.val('').change();
		var val = timeelem.attr('val');
		var a = $.ajax({
			url: u,
			async: false,
			dataType: 'json',
			success: function(result) {
				try {
					enableAvailabilityTime(timeelem);
					var dates = result.dates;
					var mindate = result.mindate;
					var d = dates[mindate];
					var t = d.times;
					var eo = $('<option/>');
					timeelem.append(eo);
					$.each( t, function(index,value) {
						var start = value.start;
						var end = value.end;
						var seats = value.seats;
						var taken = value.taken;
						var text = value.text;
						var v = value.id;
						var c = value.customid;
						if (v < 1) { v = 0; }
						if (c < 1) { c = 0; }
						var d = value.disabled;
						var f = value.full;
						var o = $('<option/>');
						if (d == true || f == true) {
							if (v != val) {
								o.prop('disabled', true);
							}
						}
						o.attr('value', v);
						if (v == val) {
							o.attr('timeelemed', true);
						}

						var html = text;
						o.html(html);
						timeelem.append(o);
					});
					enableTime();
				}
				catch(e) { }
			},
			error: function(xhr,status,error) {
				cslog(xhr);
			}
		});
		try {
			timeelem.trigger("chosen:updated");
		} catch(e) {}
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

function restyle(e, px) {
	e.css({
		'outline': 'none',
		'background-color': 'transparent',
		'padding':'8px',
		'width':'calc(100% - '+px+'px)',
		'box-sizing':'border-box',
		'-moz-box-sizing': 'border-box',
		'-webkit-box-sizing': 'border-box'

	});
}

function isrequired(e) {
	var req = e.attr('valrequired');
	if (hasValue(req) && (req == 'true' || req == 'required')) {
		return true;
	}
	return false;
}

function numerical(elem) {
	var r = container(elem);
	var buttons = button();
	var up = upButton();
//	up.click(function() { add(e); });
	up.mousedown(function(){
	    scrollHandler = setInterval(function() { add(elem); }, 50);
	}).mouseup(function() {
	    clearInterval(scrollHandler);
	});

	var down = downButton();
//	down.click(function() { minus(elem); });
	down.mousedown(function(){
	    scrollHandler = setInterval(function() { minus(elem); }, 50);
	}).mouseup(function() {
	    clearInterval(scrollHandler);
	});

	buttons.append(up);
	buttons.append(down);
	r.append(buttons);
	restyle(elem, 35);
	preventDblClick(down);
	preventDblClick(up);
	preventDblClick(buttons);
	return r;
}

function frm_validate(frm) {
	var r = true;
	var inputs = frm.find(':input');
	inputs.each(function(){
		var e = $(this);
//			alert(e.attr('name'));
		var val = e.val();
		if (!val_required(e)) {
			if (e.is(":hidden")) {
				cslog(e.attr('name')+' is required, but passes validation because the field is hidden.','validation');
			}
			else {
				val_alert(e, 'is required');
				r = false;
			}
		}
		if (!val_email(e)) {
			if (e.is(":hidden")) {
				cslog(e.attr('name')+' must be an email, but passes validation because the field is hidden.','validation');
			}
			else {
				val_alert(e, 'must be an email');
				r = false;
			}
		}
	});
	var slct = frm.find('select');
	slct.each(function(){
		var e = $(this);
		var name = e.attr('name');
		var val = e.val();
		if (!val_required(e)) {
			var chsn = $('#select_'+name);
			if (chsn.length && chsn.length > 0) {
				if (chsn.is(":hidden")) {
					cslog(e.attr('name')+' is required, but passes validation because the field is hidden.','validation');
				}
				else {
					val_alert(e, 'is required');
					r = false;
				}
			}
			else if (e.is(":hidden")) {
				cslog(e.attr('name')+' is required, but passes validation because the field is hidden.','validation');
			}
			else {
				val_alert(e, 'is required');
				r = false;
			}
		}
	});
	var txt = frm.find('textarea');
	txt.each(function(){
		var e = $(this);
		var val = e.val();
		if (!val_required(e)) {
			if (e.is(":hidden")) {
				cslog(e.attr('name')+' is required, but passes validation because the field is hidden.','validation');
			}
			else {
				val_alert(e, 'is required');
				r = false;
			}
		}
	});
	return r;
}

function val_required(e) {
	var val = e.val();
	if (val && val != '') { return true; }
	var b = false;
	var req = e.attr('valrequired');
	if (hasValue(req) && (req == 'true' || req == 'required')) {
		b = true;
	}
	if (e.hasClass('required')) {
		b = true;
	}

	if (b) {
		return false;
	}
	return true;
}

function val_email(e) {
	if (!e.hasClass('email')) { return true; }
	var v = e.val();
	var n = e.attr('name');
	if (v != '' && v != null && v != undefined) {
		var label = $('#label_'+n);
		if (label.length) {
			var reg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
			var tvalid = reg.test(v);
			if (tvalid == false) {
				return false;
			}
		}
	}
	return true;
}

function val_alert(e, message) {
	var field = e.attr('name');
	var label = $('#label_'+field);
	label.find('div').remove();
	if (label.length) {
		label.addClass('invalid');
		var msgcont = $('<div/>');
		msgcont.addClass('invalid');
		msgcont.html(message);
		label.append(msgcont);
	}
	else {
		var ftitle = e.attr('title');
		var f = field;
		if (hasValue(ftitle)) { f = ftitle; }
		var messagetxt = f+' '+message;
		var msg = $('#msg_'+field);
		msg.html('<div>'+messagetxt+'</div>');
		$('#inpt_'+field).addClass('csform_error');
	}
}

function remove_val_alert() {
	$('.invalid').find('div').remove();
	$('.invalid').removeClass('invalid');
}

function addPeople(ptype, fieldid, value, text, description) {
	var c = $('table[itype='+ptype+']');
	var i = $('<input/>');
	i.attr('type','checkbox');
	i.attr('name', fieldid);
	i.attr('value', value);
	i.prop('checked', true);
	i.addClass('csform_checkbox');
	var tr = $('<tr/>');
	var tdc = $('<td/>');
	tdc.addClass('csform_checkbox');
	tdc.append(i);
	tr.append(tdc);

	var tdt = $('<td/>');
	tdt.addClass('csform_checkboxtext');
	tdt.append(text);
	tr.append(tdt);

	var tdd = $('<td/>');
	tdd.addClass('csform_checkboxtext');
	tdd.append(description);
	tr.append(tdd);

	c.append(tr);
}


function stringStartsWith(string, prefix) {
    return string.slice(0, prefix.length) == prefix;
}

function updateLibrary(content, id, code, title, insp, warn, comp, req, formid) {
	if (hasValue(formid)) {
		try {
			var ta = $('#'+formid+'_reviewcomment textarea[itype=reviewcomment]');
			ta.val(content).change();
		} catch(e) { }
	}
	else {
		try {
			$('input[itype=libraryid]').val(id).change();
			
		} catch(e) { }

		try {
			var ta = $('[itype=librarydescription]');
			ta.val(content).change();
		} catch(e) { }

		try {
			$('input[itype=librarycode]').val(code).change();
			
		} catch(e) { }

		try {
			$('input[itype=librarytitle]').val(title).change();
		} catch(e) { }


		try {
			$('input[itype=inspectable]').mobileCheckbox('checked', insp.toLowerCase() == 'y');
		} catch(e) { }

		try {
			$('input[itype=warning]').mobileCheckbox('checked', warn.toLowerCase() == 'y');
		} catch(e) { }

		try {
			$('input[itype=complete]').mobileCheckbox('checked', comp.toLowerCase() == 'y');
		} catch(e) { }

		try {
			$('input[itype=required]').mobileCheckbox('checked', req.toLowerCase() == 'y');
		} catch(e) { }
	}

}





function updateValues() {
	var u = "";
	var e = true;
	var map = new Object();
	var fields = $('[updateval=Y]');
	fields.each(function() {
		var n = $(this).attr('name');
		var v = $(this).val();
		map[n] = v;
		e = false;
	});
	if (e == false) {
		var u = fullcontexturl+'/json/post.jsp';
		map['_request'] = 'updateval';
		map['_ent'] = entity;
		map['_type'] = type;
		try { map['_entid'] = entityid; } catch (e) {}
		try { map['_typeid'] = typeid; } catch (e) {}
		try { map['_grptype'] = grouptype; } catch (e) {}
		var j = doAjax(u, map);
		try {
			var oa = j['obj'];
			for (i=0; i<oa.length; i++) {
				var o = oa[i];
				var name = o['fieldid'];
				var val = o['value'];
				var input = $('[name='+name+']');
				input.val(val).change();
				try {
					input.trigger("chosen:updated");
				} catch(e) { }

			}
		}
		catch (e) { }
	}
}

function isNumber(evt, element) {
	var charCode = (evt.which) ? evt.which : event.keyCode
	if (
	(charCode != 45 || $(element).val().indexOf('-') != -1) &&      // “-” CHECK MINUS, AND ONLY ONE.
	(charCode != 46 || $(element).val().indexOf('.') != -1) &&      // “.” CHECK DOT, AND ONLY ONE.
	(charCode < 48 || charCode > 57)) {
		return false;
	}
	return true;
}



$(document).ready(function() {
	$('form.form:not([ajax=no])').csform({
	});

	$('form.form[ajax=no]').csform({
		ajaxsubmit: false
	});

	$('[updateval=Y]').change(function() {
		updateValues();
	});

	$('img[itype=library]').click(function() {
		var grid = $('[itype=librarygroup]').val();
		if (!hasValue(grid)) {
			grid = $('select[itype=librarygroup]').val();
		}
		if (!hasValue(grid) || grid < 1) {
			swal('Validation Error','Unknown library group','error');
		}
		else {
			var lurl = 'library.jsp?_ent='+entity+'&_type='+type+'&_typeid='+typeid+'&_id='+grid;
			$.fancybox({
				width				: '75%',
				height				: '75%',
				autoScale			: false,
				transitionIn		: 'none',
				transitionOut		: 'none',
				type                : 'iframe',
		        href                : lurl
		    });
		}
	});

	try {
		$('input[itype=datetime]').datetimepicker({
			formatTime:'g:i A',
			step: 1
		});
	} catch (e) { }

	try {
		$('input[itype=availability]').datetimepicker({
			timepicker:false,
			format:'Y/m/d'
		});
	} catch (e) { }

	try {
		$('input[itype=date]').datetimepicker({
			timepicker:false,
			format:'Y/m/d'
		});
	} catch (e) { }

	try {
		$('input[itype=reviewduedate]').datetimepicker({
			timepicker:false,
			format:'Y/m/d'
		});
	} catch (e) { }

	try {
		$('select:not([itype=boolean]):not([valrequired=true])').chosen({
			width:'100%',
			disable_search_threshold: 10,
			allow_single_deselect: true
		});
		$('select:not([itype=boolean])[valrequired=true]').chosen({
			width:'100%',
			disable_search_threshold: 10
		});
	} catch (e) { }

	try {
		$('input[itype=boolean]').mobileCheckbox({
			checkedText: "YES", 
			uncheckedText: "NO",
			textMargin: 10, 
			checkMargin: 10
		});
	} catch (e) { }

	try {
		$('input[itype=inspectable]').mobileCheckbox({
			checkedText: "YES", 
			uncheckedText: "NO",
			textMargin: 10, 
			checkMargin: 10
		});
	} catch (e) { }

	try {
		$('input[itype=warning]').mobileCheckbox({
			checkedText: "YES", 
			uncheckedText: "NO",
			textMargin: 10, 
			checkMargin: 10
		});
	} catch (e) { }

	try {
		$('input[itype=complete]').mobileCheckbox({
			checkedText: "YES", 
			uncheckedText: "NO",
			textMargin: 10, 
			checkMargin: 10
		});
	} catch (e) { }

	try {
		$('input[itype=required]').mobileCheckbox({
			checkedText: "YES", 
			uncheckedText: "NO",
			textMargin: 10, 
			checkMargin: 10
		});
	} catch (e) { }

	try {
		$('input[itype=active]').mobileCheckbox({
			checkedText: "ACTIVE", 
			uncheckedText: "INACTIVE",
			textMargin: 10, 
			checkMargin: 10
		});
		$('input[itype=enable]').mobileCheckbox({
			checkedText: "ENABLED", 
			uncheckedText: "DISABLED",
			textMargin: 10, 
			checkMargin: 10
		});
	} catch (e) { }

	try {
		$('input[data-id=toggleCheckbox]').mobileCheckbox();
	}
	catch(e) { }

	try {
		$('input[itype=decimal]').keypress(function (event) {
			return isNumber(event, this)
        });
		$('input[itype=integer]').keypress(function (event) {
			return isNumber(event, this)
        });
		$('input[itype=currency]').keypress(function (event) {
			return isNumber(event, this)
        });
		$('input[itype=percent]').keypress(function (event) {
			return isNumber(event, this)
        });
	} catch (e) { }

	try {
		$('textarea[itype!=richtext]').autoGrow();
	} catch (e) { }

	try {
		tinymce.init({
	    	selector: "textarea[itype=richtext]"
	    });
	} catch (e) { }

	try {
		$('input[itype=phone]').inputmask({
			"mask":"(999) 999-9999"
		});
	} catch (e) { }
//	$('textarea').tinymce();
});











