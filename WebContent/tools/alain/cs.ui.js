
	(function($){
		$.fn.csui = function(options) {
	
			var defaults = {
		  	};  
	
			var opts = $.extend(defaults, options);
			$.ajaxSetup({ cache:false });
			var len = this.length - 1;
	
			return this.each(function(i) {
				var org = $(this);
				var url = elemUiRequestUrl(org, '');
				uiAjax(url, org);
//				setUi(org);
			});
		};
	
	})(jQuery);

	function refreshGroup(group) {
		try {
			var e = $('div[group='+group+'][ui]');
			if (e && e.length) {
				var url = getParentUiRequestUrl(e, 'refresh');
				uiAjax(url, e);
			}
		} catch (er) { }
	}

	function refreshElement(elem) {
		try {
			var e = elem.closest('[ui]');
			if (e) {
				var url = getParentUiRequestUrl(e, 'refresh');
				uiAjax(url, e);
			}
		} catch (er) { }
	}

	function elemUiRequestUrl(elem, option) {
		var u = '';
		try {
			u += fullcontexturl+'/json/ui.jsp';
			u += '?_ent='+entity;
			u += '&_type='+type;
			u += '&_typeid='+typeid;
			u += '&_grp='+elem.attr('group');
			u += '&_grptype=ui';
			u += '&_request='+elem.attr('ui');
			u += '&style='+elem.attr('uistyle');
			u += '&alert='+elem.attr('uialert');
			u += '&option='+option;
		}
		catch(e) { }
		return u;

	}

	function getParentUiRequestUrl(elem, option) {
		var p = elem.closest('[ui]')
		return elemUiRequestUrl(p, option);
	}

	function uiAjax(urladdrss, elem) {
		cslog(urladdrss, 'Ajax URL');
		var r = undefined;
		if (hasValue(urladdrss)) {
			$.ajax({
				url: urladdrss,
				type:'POST', 
				dataType: 'json',
				success: function(result) {
					elem.empty();
					r = result;
					var table = r['table'];
					var err = r['error'];
					cslog(table);
					elem.html(table);
					elem.addClass('animated fadeInLeftBig');
					cslog(r, 'Ajax Response');
					docsAct(elem);
					doRes(elem);
					doOption(elem);
					try {
						var g = r['module'];
						if (g == 'images') {
							doSlides(elem);
						}
					} catch(e) { }
					if (hasValue(err)) {
						$('#csuimessage').append('<div>Error displaying module: '+elem.attr('group')+'</div>');
						$('#csuimessage').show();
					}
				},
				error: function(xhr,status,error) {
					cslog(xhr.responseText, 'Ajax Response');
					cslog(status, 'Ajax Error');
					try {
						$('#csuimessage').append('<div>Error retrieving module: '+elem.attr('group')+'</div>');
						$('#csuimessage').show();
					}
					catch(e) { }
				}
			});
		}
		return r;
	}

	function docsAct(elem) {
		elem.find('[_action]').csact(
			{
				action: '',
				entity: entity,
				type: type,
				typeid: typeid,
				_delete: {
					appointment: {
						confirm: {
							title: 'CANCEL',
							text: 'Are you sure you want to cancel this appointment?',
							button: 'Yes',
							cancel: 'No',
							success: 'Success',
							successtext: 'The selected appointment has been cancelled.'
						},
						prompt : {
							name: 'note',
							required: true
						}
					}
				}
			}
		);
	}

	function doRes(elem) {
		elem.find('img[resid]').css({
			'cursor': 'pointer'
		});
		elem.find('img[resid]').click(function() {
			var resid = $(this).attr('resid');
			var on = $(this).attr('on');
			if (on == 'true') {
				$('tr[resid='+resid+'][partid]').hide();
				$(this).attr('on','false');
			}
			else {
				$('tr[resid='+resid+'][partid]').show();
				$(this).attr('on','true');
			}
		});
	}

	function doOption(elem) {
		elem.find('[option]').click(function() {
			var org = $(this);
			var p = org.closest('[ui]')
			if (p.length) {
				var url = elemUiRequestUrl(p, org.attr('option'));
				p.empty();
				p.html('<div class="ui_loading">Loading...</div><br/><br/>');
				uiAjax(url, p);
			}
		});
	}

	function doSlides(elem) {
		var sl = elem.find('.slidelist');
		try {
			var v = 1;
			var va = sl.attr('visible');
			if (hasValue(va)) {
				v = parseInt(va);
			}
			var au = false;
			if (v == 1) { au = true; }
			elem.find('.slidelist').carouFredSel({
				auto: au,
				responsive: true,
				align: 'center',
				prev: '.prevnav',
				next: '.nextnav',
				pagination: "#slidepager",
				mousewheel: true,
				items: {
					visible: v
				},
				scroll: {
					fx: 'directscroll',
					onBefore: function( data ) {
						data.items.visible.each(function() {
							loadSlideImage($(this));
						});
					}
				},
				onCreate: function( data ) {
					data.items.each(function() {
						loadSlideImage($(this));
					});
				},
				swipe: {
					onMouse: true,
					onTouch: true
				}
			});
		}
		catch (e) { }

	}




