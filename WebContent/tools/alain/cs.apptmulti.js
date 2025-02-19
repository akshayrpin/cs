
(function($){
	$.fn.apptmultiform = function(options) {

		var defaults = {
			add: true,
			ajaxsubmit: true
	  	};  

		var opts = $.extend(defaults, options);
		$.ajaxSetup({ cache:false });
	 	var scrollHandler;
		var len = this.length - 1;

		initTime();
		initNotes();
		initTeam();
		enableDate();
	};

})(jQuery);


/*  GET ELEMENT */

function getDate() {
	var st = $('input[itype=availability_date]');
	return st;
}

function getTime() {
	var st = $('select[itype=availability_time]');
	return st;
}

function getNotes() {
	var st = $('textarea[itype=notes]');
	return st;
}

function getTeam() {
	var st = $('select[itype=team]');
	return st;
}


/*  INIT */

function initTime() {
	var st = getTime();
	st.change(function() {
		var stv = st.val();
		if (hasValue(stv)) {
			$('#DOTIME').prop('checked', true);
		}
	});
}

function initNotes() {
	var st = getNotes();
	st.change(function() {
		var stv = st.val();
		if (hasValue(stv)) {
			$('#DONOTES').prop('checked', true);
		}
	});
}

function initTeam() {
	var st = getTeam();
	st.change(function() {
		var stv = st.val();
		if (hasValue(stv)) {
			$('#DOTEAM').prop('checked', true);
		}
	});
}

function enableDate() {
	var st = getDate();
	st.attr('json', '_grpid='+availabilityid);
	jsonDate();
}

function disableTime() {
	var st = getTime();
	st.prop('disabled', true);
	st.empty();
	st.trigger("chosen:updated");
}


/*  ENABLE ELEMENT */

function enableTime() {
	var sd = getDate();
	var st = getTime();
	st.prop('disabled', false);
}

/*  UPDATE/RETRIEVE ELEMENT */

function updateTime() {
	var st = getTime();
	if (hasValue(st)) {
		disableTime();
		var sd = getDate();
		st.empty();
		if (hasValue(sd)) {
			var sdid = sd.val();
			var u = '_startdate=' + encodeURI(sdid) + '&_end=0';
			st.empty();
			st.attr('json', u);
			jsonTime();
		}
	}
}

/*  UPDATE/RETRIEVE ELEMENT */

function jsonDate() {
	var elem = getDate();
	var j = elem.attr('json');
	if (hasValue(j)) {
		var u = '';
		u = fullcontexturl+'/json/availability.jsp';
		u += '?_ent='+entity+'&_type=multi&_grp=appointment&_end=365&';
		u += j;

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
		u += '?_ent='+entity+'&_type=multi&_grp=appointment&_grpid='+availabilityid+'&';
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
					var o1 = $('<option/>');
					select.append(o1);
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
					var o = $('<option/>');
					o.attr('value', val);
					o.html(txt);
					elem.append(o);
				});
				enableTeam();
			},
			error: function(xhr,status,error) {
				cslog(xhr);
			}
		});
	}
	return elem;
}

function getTeam() {
	var st = $('#team_table');
	return st;
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
		cchk.attr('type','radio');
		cchk.attr('name', 'TEAM');
		cchk.prop('checked', true);
		cchk.val(id);
		cchk.addClass('csform_checkbox');
		cchktd.append(cchk);
		ctr.append(cchktd);

		var cnametd = $('<td/>');
		cnametd.css({
			'border-top': '1px solid #eeeeee'
		});
		cnametd.addClass('csform_checkboxtext');
		cnametd.html(name);
		ctr.append(cnametd);

		var ctypetd = $('<td/>');
		ctypetd.css({
			'border-top': '1px solid #eeeeee',
			'text-align': 'right'
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



















