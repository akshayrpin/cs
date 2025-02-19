
(function($){
	$.fn.apptform = function(options) {

		var defaults = {
			add: true,
			ajaxsubmit: true
	  	};  

		var opts = $.extend(defaults, options);
		$.ajaxSetup({ cache:false });
	 	var scrollHandler;
		var len = this.length - 1;

		return this.each(function(i) {
			var org = $(this);
			var inputs = $(this).find(':input');
//			inputs.each(function(){
//				init($(this));
//			});
			initAppt();
			initType();
			initSubType();
			initStatus();
		});
	};

})(jQuery);

var apptact = "";

/*  GET ELEMENT */

function getAddType() {
	var at = $('input[itype=appointment]');
	return at;
}

function getType() {
	var at = $('select[itype=appointment]');
	if (!hasValue(at) || at.length < 1) {
		at = $('input[itype=appointment]');
	}
	return at;
}

function getAddSubType() {
	var rt = $('input[itype=apptreview]');
	return rt;
}

function getSubType() {
	var rt = $('select[itype=apptreview]');
	if (!hasValue(rt) || rt.length < 1) {
		rt = $('input[itype=apptreview]');
	}
	return rt;
}

function getStatus() {
	var st = $('select[itype=status]');
	return st;
}

function getDate() {
	var st = $('input[itype=availability_date]');
	return st;
}

function getTime() {
	var st = $('select[itype=availability_time]');
	return st;
}

function getTeam() {
	var st = $('#team_table');
	return st;
}

function setApptAct(t) {
	apptact = t;
}

function isApptAct(t) {
	if (apptact == "") {
		apptact = t;
		return true;
	}
//	else if (apptact == t) {
//		return true;
//	}
	else { return false; }
}

function clearApptAct(t) {
	if (apptact == t) {
		apptact = "";
		return true;
	}
}

/*  INIT */

function initAppt(add) {
	if (hasValue(getType().val())) {
		updateSubType();
	}
	if (hasValue(getSubType()) && parseInt(getSubType().val()) > 1) {
		updateDate(false);
	}

	if (hasValue(getType().val()) || (parseInt(getSubType().val()) > 1)) {
//		updateTeam();
	}

	if (hasValue(getDate().val())) {
		updateTime();
	}

	if (!hasValue(getType().val())) {
		disableSubType();
		disableStatus();
		disableDate();
		disableTime();
//		disableTeam();
	}
	else if (parseInt(getType().val) < 1 && (!hasValue(getSubType()) || parseInt(getSubType().val) < 1)) {
		disableSubType();
		disableStatus();
		disableDate();
		disableTime();
//		disableTeam();
	}
}

function initType() {
	var e = getType();
	e.change(function() {
		setApptAct('type');
		updateSubType();
		updateStatus();
		updateDate(true);
		disableTime();
//		disableTeam();
		clearApptAct('type');
	});
}

function initSubType() {
	var e = getSubType();
	e.change(function() {
		isApptAct('subtype');
		updateStatus();
		//disableDate();
		disableTime();
		updateTeam();
		clearApptAct('subtype');
	});
}

function initStatus() {
	var e = getStatus();
	e.change(function() {
		if (isApptAct('status')) {
			updateDate(true);
			clearApptAct('status');
		}
	});
}



/*  DISABLE ELEMENT */

function disableSubType() {
	var st = getSubType();
	st.prop('disabled', true);
	st.attr('valrequired', 'false');
	st.empty();
	st.trigger("chosen:updated");
}

function disableStatus() {
	var st = getStatus();
	st.prop('disabled', true);
	st.attr('valrequired', 'false');
	st.empty();
	st.trigger("chosen:updated");
}

function disableDate() {
	var st = getDate();
	st.val('');
	st.empty();
	st.datetimepicker('destroy');
	st.datetimepicker('reset');
	st.prop('disabled', true);
	st.attr('valrequired', 'false');
	st.css({
		'background-color': '#eeeeee'
	});
}

function disableTime() {
	var st = getTime();
	st.prop('disabled', true);
	st.attr('valrequired', 'false');
	st.empty();
	st.trigger("chosen:updated");
}

function disableTeam() {
	var st = getTeam();
	st.prop('disabled', true);
	st.empty();
//	st.trigger("chosen:updated");
}



/*  ENABLE ELEMENT */

function enableSubType() {
	var st = getSubType();
	st.attr('valrequired', 'true');
	st.prop('disabled', false);
}

function enableStatus() {
	var st = getStatus();
	st.attr('valrequired', 'true');
	st.prop('disabled', false);
}

function enableDate() {
	var st = getDate();
	st.prop('disabled', false);
	st.attr('valrequired', 'true');
	st.css({
		'background-color': ''
	});
}

function enableTime() {
	var st = getTime();
	st.attr('valrequired', 'true');
	st.prop('disabled', false);
}

function enableTeam() {
	var st = getTeam();
	st.prop('disabled', false);
}



/*  UPDATE/RETRIEVE ELEMENT */

function updateSubType() {
	var t = getType();
	if (hasValue(t)) {
		var tval = parseInt(t.val());
		disableSubType();
		if (tval < 0) {
			var st = getSubType();
			if (hasValue(st)) {
				var v = tval;
				var u = '_id=' + v + '&_type=' + type + '&_typeid=' + typeid + '&_grptype=review&_request=appttype';
				st.empty();
				st.attr('json', u);
				st.attr('auto','false');
				jsonSubType();
				try {
					st.trigger("chosen:updated");
				} catch(e) {}
			}
		}
	}
}

function updateStatus() {
	var tpe = getType();
	var subt = getSubType();
	if (hasValue(tpe) && hasValue(subt)) {
		var ttid = parseInt(tpe.val());
		var rtid = parseInt(subt.val());
		disableStatus();
		if (rtid > 0 || ttid > 0) {
			var st = getStatus();
			var at = getType();
			if (hasValue(st)) {
				var atid = at.val();
				var u = '_appttypeid=' + atid + '&_apptsubtypeid=' + rtid + '&_type=' + type + '&_typeid=' + typeid + '&_grptype=appointment&_request=schedulestatus';
				st.empty();
				st.attr('json', u);
				st.attr('auto','false');
				jsonStatus();
				try {
					st.trigger("chosen:updated");
				} catch(e) {}
			}
		}
	}
}

function updateDate(clear) {
	var dt = getDate();
	if (hasValue(dt)) {
		if (clear) {
			disableDate();
		}
		var st = getStatus();
		if (hasValue(st)) {
			var stsid = st.val();
			var stid = parseInt(stsid);
//			if (!isNaN(stid) && stid < 0) {
//				updateCompleteDate();
//			}
//			else {
				var at = getType();
				var rt = getSubType();
				if (hasValue(at) && hasValue(rt)) {
					var atid = at.val();
					var rtid = rt.val();
					if (hasValue(atid) || hasValue(rtid)) {
						var u = '_appttypeid=' + atid + '&_apptsubtypeid=' + rtid + '&_type=' + type + '&_typeid=' + typeid + '&_id=' + groupid;
						if (clear) {
							dt.val('');
							dt.empty();
						}
						dt.datetimepicker('reset');
						dt.datetimepicker('destroy');
						dt.attr('json', u);
						jsonAvailabilityDate(getDate(), getTime(), entity, type, typeid, atid, rtid, stid)
//						jsonDate();
					}
				}
//			}
		}
	}
}

function updateCompleteDate() {
	var dt = getDate();
	enableDate();
	disableTime();
	dt.val('');
	dt.empty();
	dt.datetimepicker('destroy');
	dt.datetimepicker('reset');
	dt.datetimepicker({
		timepicker:true,
		format:'Y/m/d H:i',
		step: 30,
		validateOnBlur:true,
		todayButton: true
	});
}

function updateTime() {
	var st = getTime();
	if (hasValue(st)) {
		disableTime();
		var sd = getDate();
		var at = getType();
		var rt = getSubType();
		st.empty();
		if (hasValue(at) && hasValue(rt) && hasValue(sd)) {
			var atid = at.val();
			var rtid = rt.val();
			var sdid = sd.val();
			var u = '_appttypeid=' + atid + '&_apptsubtypeid=' + rtid + '&_type=' + type + '&_typeid=' + typeid + '&_startdate=' + encodeURI(sdid) + '&_id=' + groupid + '&_end=0';
			st.empty();
			st.datetimepicker('reset');
			st.attr('json', u);
			jsonTime();
		}
	}
}

function updateTeam() {
	var st = getTeam();
	if (hasValue(st)) {
//		disableTeam();
		var at = getType();
		var rt = getSubType();
		if (hasValue(at) && hasValue(rt)) {
			var atid = parseInt(at.val());
			var rtid = parseInt(rt.val());
			if (atid > 0 || rtid > 0) {
				var u = '_appttypeid=' + atid + '&_apptsubtypeid=' + rtid + '&_type=' + type + '&_typeid=' + typeid;
				st.attr('json', u);
				jsonTeam();
			}
			try {
				st.trigger("chosen:updated");
			} catch(e) {}
		}
	}
}


/*  UPDATE/RETRIEVE ELEMENT */

function jsonSubType() {
	var select = getSubType();
	var j = select.attr('json');
	if (hasValue(j)) {
		var u = fullcontexturl+'/json/choices.jsp';
		u += '?_ent='+entity+'&';
		u += j;
		var val = select.attr('val');
		var name = select.attr('name');
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
						if (!hasValue(t)) { t = v; }
						var o = $('<option/>');
						o.attr('value', i);
						if (v == val) {
							o.attr('selected', true);
						}
						else if (hasValue(s) && s.toLowerCase() == 'y' ) {
							o.attr('selected', true);
						}
						o.html(toTitleCase(t));
						select.append(o);
					});
				}
				enableSubType();
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

function jsonStatus() {
	var select = getStatus();
	var j = select.attr('json');
	if (hasValue(j)) {
		var u = fullcontexturl+'/json/choices.jsp';
		u += '?_ent='+entity+'&';
		u += j;
		var val = select.attr('val');
		var name = select.attr('name');
		var a = $.ajax({
			url: u,
			async: false,
			dataType: 'json',
			success: function(result) {
				var items = result;
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
						if (!hasValue(t)) { t = v; }
						var o = $('<option/>');
						o.attr('value', i);
						if (v == val) {
							o.attr('selected', true);
						}
						else if (hasValue(s) && s.toLowerCase() == 'y' ) {
							o.attr('selected', true);
						}
						o.html(toTitleCase(t));
						select.append(o);
					});
					enableStatus();
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


function jsonDate() {
	var elem = getDate();
	elem.val('');
	var j = elem.attr('json');
	if (hasValue(j)) {
		var u = '';
		u = fullcontexturl+'/json/availability.jsp';
		u += '?_ent='+entity+'&_end=365&';
		u += j;

		var at = getType();
		var rt = getSubType();

		var atid = -1;
		var rtid = -1;

		if (hasValue(at) || hasValue(rt)) {
			atid = parseInt(at.val());
			rtid = parseInt(rt.val());
		}

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
					enableDate();
					elem.datetimepicker({
						minDate: mindate,
						maxDate: maxdate,
						disabledDates: disableddates,
						timepicker:false,
						format:'Y/m/d',
						validateOnBlur:true,
						todayButton: false,
						defaultSelect: false,
						onSelectDate: function(ct,$i) {
							if (avid > 0) {
								updateTime();
							}
						},
						onShow: function(ct,$i) {
							if (!hasValue(atid) || (atid < 1 && !hasValue(rtid))) {
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
	return elem;
}

function jsonTime() {
	var select = getTime();
	var j = select.attr('json');
	select.empty();
	if (hasValue(j)) {
		var val = select.attr('val');
		var name = select.attr('name');
		var u = '';
		u = fullcontexturl+'/json/availability.jsp';
		u += '?_ent='+entity+'&';
		u += j;
		var a = $.ajax({
			url: u,
			async: false,
			dataType: 'json',
			success: function(result) {
				try {
					var dates = result.dates;
					var mindate = result.mindate;
					var d = dates[mindate];
					var t = d.times;
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
							o.attr('selected', true);
						}

						var html = text;
						o.html(html);
						select.append(o);
					});
					enableTime();
				}
				catch(e) { }
			},
			error: function(xhr,status,error) {
				cslog(xhr);
			}
		});
	}
	try {
		select.trigger("chosen:updated");
	} catch(e) {}
	return select;
}

function jsonTeam() {
	var elem = getTeam();
	var j = elem.attr('json');
	if (hasValue(j)) {
		var u = '';
		u = fullcontexturl+'/json/availabilityteam.jsp';
		u += '?_ent='+entity+'&';
		u += j;

		var a = $.ajax({
			url: u,
			async: false,
			dataType: 'json',
			success: function(result) {
				var o = $('<option/>');
				o.attr('value', '');
				elem.append(o);
				$.each(result, function(idx,item) {
					var val = item.value;
					var txt = item.text;
					var desc = item.description;
					populateTeam(val,txt,desc);
//					var o = $('<option/>');
//					o.attr('value', val);
//					o.html(txt);
//					elem.append(o);
				});
//				enableTeam();
			},
			error: function(xhr,status,error) {
				cslog(xhr);
			}
		});
	}
	return elem;
}

function addCollaborators(choices) {
	try {
		var parray = choices.split('|');
		for (i = 0; i < parray.length; i++) { 
			var rec = parray[i];
			var arr = rec.split('::');
			if (arr.length > 0) {
				var id = arr[0];
				if (arr.length > 1) {
					var name = arr[1];
					var email = '';
					if (arr.length > 2) {
						email = arr[2];
					}
					populateCollaborators(id, name, email);
				}
			}
		}
	} catch(e) { }
}

function addTeam(choices) {
	try {
		var parray = choices.split('|');
		for (i = 0; i < parray.length; i++) { 
			var rec = parray[i];
			var arr = rec.split('::');
			if (arr.length > 0) {
				var id = arr[0];
				if (arr.length > 1) {
					var name = arr[1];
					var type = '';
					if (arr.length > 2) {
						type = arr[2];
					}
					populateTeam(id, name, type);
				}
			}
		}
	} catch(e) { }
}

function populateTeam(id, name, type) {
	if (!containsTeam(id)) {
		var ctable = getTeam();
		var ctr = $('<tr/>');
		ctr.attr('id','team_'+id);
		var cchktd = $('<td/>');
		cchktd.css({
			'border-top': '1px solid #eeeeee',
			'width': '1%'
		});
		cchktd.addClass('csform_checkbox');
		var cchk = $('<input/>');
		cchk.attr('type','checkbox');
		cchk.attr('name', 'TEAM');
		cchk.prop('checked', true);
		cchk.val(id);
		cchk.addClass('csform_checkbox');
		cchktd.append(cchk);
		ctr.append(cchktd);

		var cnametd = $('<td/>');
		cnametd.css({
			'border-top': '1px solid #eeeeee',
			'width': '98%'
		});
		cnametd.addClass('csform_checkboxtext');
		cnametd.html(name);
		ctr.append(cnametd);

		var ctypetd = $('<td/>');
		ctypetd.css({
			'border-top': '1px solid #eeeeee',
			'width': '98%'
		});
		ctypetd.addClass('csform_checkboxtext');
		ctypetd.html(type);
		ctr.append(ctypetd);

		ctable.append(ctr);
	}
}

function containsTeam(id) {
	var t = $('#team_'+id);
	return t.length > 0;
}

function populateCollaborators(id, name, email) {
	var ctable = $('#collaborator_table');
	var ctr = $('<tr/>');
	ctr.attr('id','collaborator_'+id);
	var cchktd = $('<td/>');
	cchktd.css({
		'border-top': '1px solid #eeeeee',
		'width': '1%'
	});
	cchktd.addClass('csform_checkbox');
	var cchk = $('<input/>');
	cchk.attr('type','checkbox');
	cchk.attr('name', 'COLLABORATORS');
	cchk.prop('checked', true);
	cchk.val(id);
	cchk.addClass('csform_checkbox');
	cchktd.append(cchk);
	ctr.append(cchktd);

	var cnametd = $('<td/>');
	cnametd.css({
		'border-top': '1px solid #eeeeee',
		'width': '98%'
	});
	cnametd.addClass('csform_checkboxtext');
	cnametd.html(name);
	ctr.append(cnametd);

	var cemailtd = $('<td/>');
	cemailtd.css({
		'border-top': '1px solid #eeeeee',
		'width': '98%'
	});
	cemailtd.addClass('csform_checkboxtext');
	cemailtd.html(email);
	ctr.append(cemailtd);

	ctable.append(ctr);
}






