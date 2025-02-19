
	var csui_expanded = { };
	var csui_selected = { };
	var csui_minimized = { };
	var csui_panels = { };
	var csui_org_panels = { };
	var csui_followed = { };
	var csui_pinned = { };
	var loading_image_url = '/cs/images/loaders/loading.gif';

	function setPanel(i, treeid) {
		
		csui_panels[treeid].item = i;
		cslog(csui_panels, 'Set Panels');
	}

	function setParents(treeid, type, id, parents, follow) {
		$.each(parents, function(id, type) {
			setExpanded(type, id, treeid);
		});
		if (hasValue(follow)) {
			setSelected(type, follow, treeid);
			setFollowed(follow, treeid);
		}
		else if (hasValue(id) && hasValue(parents)) {
//			setSelected(type, id, treeid);
//			setFollowed(id, treeid);
		}
	}

	function setPinned(treeid, elem) {
//		csui_pinned[treeid] = 'true';
		try {
			Cookies.set('pinned_'+treeid, 'true');
		}
		catch(e) { }
		elem.addClass('cs_pinned');
		cslog(csui_pinned, 'Pinned');
	}

	function removePin(treeid, elem) {
//		csui_pinned[treeid] = 'false';
		try {
			Cookies.set('pinned_'+treeid, 'true');
			Cookies.remove('pinned_'+treeid);
		} catch(e) { }
		elem.removeClass('cs_pinned');
		cslog(csui_pinned, 'Remove Pin');
	}

	function isPinned(treeid) {
//		if (csui_pinned[treeid]) {
//			if (csui_pinned[treeid] == 'true') { return true; }
//		}
		var v = '';
		try { v = Cookies.get('pinned_'+treeid); } catch(e) { }
		if (v == 'true') {
			return true;
		}
		return false;
	}

	function setMinimized(treeid) {
		csui_minimized[treeid] = 'true';
		cslog(csui_minimized, 'Minimize');
	}

	function removeMinimized(treeid) {
		csui_minimized[treeid] = 'false';
		cslog(csui_minimized, 'Remove Minimized');
	}

	function isMinimized(treeid) {
		if (csui_minimized[treeid]) {
			if (csui_minimized[treeid] == 'true') { return true; }
		}
		return false;
	}

	function clearMinimized(treeid) {
		if (!hasValue(treeid)) {
			csui_minimized = {};
		}
		else {
			csui_minimized[treeid] = undefined;
		}
	}

	function setExpanded(type, id, treeid) {
		
		if (csui_expanded[treeid]) {
			csui_expanded[treeid].push(type.toLowerCase()+id);
		}
		else {
			csui_expanded[treeid] = [type.toLowerCase()+id];
		}
		cslog(csui_expanded, 'Expanded');
	}

	function isExpanded(type, id, treeid) {
		var b = false;
		try { b = $.inArray(type.toLowerCase()+id, csui_expanded[treeid]) > -1; } catch(e) { }
		return b;
	}

	function removeExpanded(type, id, treeid) {
		if (hasValue(type) && hasValue(id) && hasValue(treeid)) {
			var e = csui_expanded[treeid];
			if (hasValue(e)) {
				var earr = [];
				$.each(e, function(idx, val) {
					if (val != type.toLowerCase()+id) {
						earr.push(val);
					}
				});
				csui_expanded[treeid] = earr;
			}
		}
		cslog(csui_expanded, 'Remove Expanded');
	}

	function clearExpanded(treeid) {
		if (!hasValue(treeid)) {
			csui_expanded = {};
		}
		else {
			csui_expanded[treeid] = undefined;
		}
	}

	function clearNextExpanded(treeid) {
		if (hasValue(treeid)) {
			var b = false;
			if (hasValue(treeid)) {
				$.each(csui_panels, function(tid, map) {
					if (b) {
						var i = map.item;
						clearExpanded(tid);
					}
					if (treeid == tid) {
						b = true;
					}
				});
			}
		}
	}

	function setSelected(type, id, treeid) {
		
		cslog(treeid + ' -> ' + type.toLowerCase()+id, 'Select');
		csui_selected[treeid] = type.toLowerCase()+id;
		cslog(csui_selected, 'Selected');
	}

	function isSelected(type, id, treeid) {
		
		var b = false;
		var s = csui_selected[treeid];
		if (hasValue(s)) {
			if (s == type.toLowerCase()+id) { b = true; }
		}
		return b;
	}

	function clearSelected(treeid) {
		if (!hasValue(treeid)) {
			csui_selected = {};
		}
		else {
			setSelected('', '', treeid);
		}
		cslog(csui_selected, 'Clear Selected');
	}

	function unSelect(treeid) {
		$('.cs_highlight[treeid='+treeid+']').removeClass('cs_highlight');
		clearSelected(treeid);
	}

	function clearNextSelected(treeid) {
		if (hasValue(treeid)) {
			var b = false;
			if (hasValue(treeid)) {
				$.each(csui_panels, function(tid, map) {
					if (b) {
						var i = map.item;
						clearSelected(tid);
					}
					if (treeid == tid) {
						b = true;
					}
				});
			}
		}
	}

	function setFollowed(type, id, treeid) {
		cslog(treeid + ' -> ' + type.toLowerCase()+id, 'Follow');
		csui_followed[treeid] = type.toLowerCase()+id;
		cslog(csui_followed, 'Followed');
	}

	function isFollowed(type, id, treeid) {
		var b = false;
		var s = csui_followed[treeid];
		if (hasValue(s)) {
			if (s == type.toLowerCase()+id) { b = true; }
		}
		return b;
	}

	function clearFollowed(treeid) {
		if (!hasValue(treeid)) {
			csui_followed = {};
		}
		else {
			setFollowed('', treeid);
		}
		cslog(csui_followed, 'Clear Followed');
	}

	function clearNextFollowed(treeid) {
		if (hasValue(treeid)) {
			var b = false;
			if (hasValue(treeid)) {
				$.each(csui_panels, function(tid, map) {
					if (b) {
						var i = map.item;
						clearFollowed(tid);
					}
					if (treeid == tid) {
						b = true;
					}
				});
			}
		}
	}

	function clearNext(treeid) {
		if (hasValue(treeid)) {
			var b = false;
			if (hasValue(treeid)) {
				$.each(csui_panels, function(tid, map) {
					if (b) {
						var i = map.item;
						clearFollowed(tid);
						clearExpanded(tid);
						clearSelected(tid);
					}
					if (treeid == tid) {
						b = true;
					}
				});
			}
		}
	}

	function resetConfig() {
		csui_panels = jQuery.extend(true, {}, csui_org_panels);
	}

	function renderOptions(options, item, treeid, current) {
		var r = undefined;
		if (hasValue(options) && options.length && options.length > 0) {
			var r = $('<div/>');
			r.addClass('cs_option_container');
			$.each(options, function(idx, option) {
				var opt = jQuery.extend(true, {}, item);
				opt.option = option;
				var o = $('<div/>');
				o.attr('treeid', treeid);
				o.addClass('cs_option');
				o.css({
					'cursor': 'pointer'
				});
				if (option.toLowerCase() == current.toLowerCase()) {
					o.addClass('cs_option_selected');
				}
				o.html(option);
				o.click(function() {
					renderPanel(treeid, opt, true);
					setPanel(opt, treeid);
				});
				r.append(o);
			});
		}
		return r;
	}

	function renderLabel(label, treeid) {
		var r = undefined;
		if (hasValue(label)) {
			r = $('<div/>');
			r.attr('treeid', treeid);
			r.attr('label', label);
			r.addClass('cs_label');
			r.html(label);
			var t = renderTools(treeid);
			if (hasValue(t)) {
				r.append(t);
			}
		}
		return r;
	}

	function renderTools(treeid) {
		var r = undefined;
		var ct = containerType(treeid);
		if (ct == 'tree') {
			r = $('<div/>');
			r.addClass('cs_label_tools');

			// pin
			var p = $('<div/>');
			p.attr('treeid', treeid);
			p.addClass('cs_label_tools_pin');
			p.css({
				'cursor': 'pointer'
			});
			
			//setPinned(treeid, p);
			
			p.click(function() {
				if (isPinned(treeid)) {
					removePin(treeid, p);
				}
				else {
					setPinned(treeid, p);
				}
			});
			if (isPinned(treeid) == true) {
				setPinned(treeid, p);
			}
			r.append(p);

			// minimize
			var m = $('<div/>');
			m.attr('treeid', treeid);
			m.addClass('cs_label_tools_min');
			m.css({
				'cursor': 'pointer'
			});
			m.click(function() {
				removePin(treeid, p);
				minimizeTree(treeid);
			});
			r.append(m);
		}
		return r;
	}

	function renderMessage(message) {
		var r = undefined;
		if (hasValue(message)) {
			r = $('<div/>');
			r.addClass('cs_message');
			r.html(message);
		}
		return r;
	}

	function renderSearch(search, treeid) {
		var r = undefined;
		if (hasValue(search)) {
			var i = { };
			var t = jQuery.type(search);
			if (t == 'string') {
				i = {
						'action': 'search',
						'url': search
					};
			}
			else {
				i = jQuery.extend(true, {}, search);
				i.action = 'search';
			}
			if (hasValue(i.url) || hasValue(i.grouptype)) {
				var ph = i.placeholder;
				r = $('<div/>');
				r.attr('treeid', treeid);
				r.addClass('cs_search');

				var sform = $('<form/>');
				var sdiv = $('<div/>');
				sdiv.addClass('cs_search_container');
				sdiv.append(searchTable(ph, treeid))
				sform.append(sdiv);
				sform.submit(function(e) {
					var d = $("#"+treeid);
					if (hasValue(d)) {
						e.preventDefault();
						var q = $('#search_'+treeid).val();
						var item = jQuery.extend(true, {}, i);
						item.search = q;
						clearSelected(treeid);
						clearFollowed(treeid);
						clearExpanded(treeid);
						clearNext(treeid);
						renderPanel(treeid, item, true);
						setPanel(item, treeid);
						$('.cs_highlight[treeid='+treeid+']').removeClass('cs_highlight');
						
					}
					return false;
				});
				r.append(sform);
			}
		}
		return r;
	}

	function searchTable(ph, treeid) {
		var stable = $('<table/>');
		stable.addClass('cs_search_table');
		var str = $('<tr/>');

		var sstd = $('<td/>');
		var input = searchInput(ph, treeid); 
		sstd.append(input);
		str.append(sstd);

		var sitd = $('<td/>');
		sitd.addClass('cs_search_button');
		var img = searchButton();
		sitd.append(img);
		str.append(sitd);

		stable.append(str);
		return stable;
	}

	function searchInput(ph, treeid) {
		var sinput = $('<input/>');
		sinput.attr('type', 'text');
		sinput.attr('treeid', treeid)
		sinput.attr('id', 'search_'+treeid);
		if (hasValue(ph)) {
			sinput.attr('placeholder', ph);
			if(ph!="Search for Address"){
				sinput.val(ph);
				 sinput.focus();  
			}
		}
		sinput.addClass('cs_search');
		sinput.click(function() {
			sinput.blur();
			sinput.focus();
			sinput.select();
		});
		return sinput;
	}

	function searchButton() {
		var b = $('<input/>');
		b.attr('type','image');
		b.attr('src','/cs/images/icons/white/search.png');
		return b;
	}

	function loadingDiv() {
		var d = $('<div/>');
		d.css({
			'text-align':'center',
			'padding-top':'50px'
		});
		var i = $('<img/>');
		i.attr('src', loading_image_url);
		d.append(i);
//		d.html('loading');
		return d;
	}

	function minimizeTrees() {
		$.each(csui_panels, function(tid, map) {
			minimizeTree(tid);
		});
	}

	function minimizeTree(treeid) {
		var ct = containerType(treeid);
		if (ct == 'tree') {
			var p = isPinned(treeid);
			if (p == false) {
				var tree = $('#'+treeid);
				var content = $('[treeid='+treeid+'].cs_panel_content');
				if (hasValue(tree)) {
					if (hasValue(content)) {
						content.hide();
					}
					tree.addClass('minTree');
					var dm = $('<div/>');
					dm.addClass('maximizeButton');
					dm.attr('treeid', treeid);
					var label = tree.attr('label');
					var dmt = $('<div/>');
					dmt.addClass('maximizeButtonText');
					dmt.html('&nbsp;&nbsp;&nbsp;&nbsp;'+label);
					dm.append(dmt);
					dm.click(function() {
						maxTree(treeid);
					});
					tree.append(dm);
					setMinimized(treeid);
				}
			}
		}
	}

	function hideTrees() {
		$.each(csui_panels, function(tid, map) {
			hideTree(tid);
		});
	}

	function hideTree(treeid) {
		var ct = containerType(treeid);
		if (ct == 'tree') {
			var tree = $('#'+treeid);
			tree.hide();
		}
	}

	
	
	
	function maxTree(treeid) {
		
		var ct = containerType(treeid);
		if (ct == 'tree') {
			var tree = $('#'+treeid);
			var content = $('[treeid='+treeid+'].cs_panel_content');
			if (hasValue(tree)) {
				if (hasValue(content)) {
					content.show();
				}
				var db = $('[treeid='+treeid+'].maximizeButton');
				db.remove();
				tree.removeClass('minTree');
				removeMinimized(treeid);
			}
		}
	}

	function retrievePanels(e, t, tid, r) {
		
		var u = csui_panels_url;
		u += '?';
		u += 'entity='+encodeURI(e);
		u += '&';
		u += 'type='+encodeURI(t);
		u += '&';
		u += 'typeid='+encodeURI(tid);
		u += '&';
		u += 'reference='+encodeURI(r);
		var p = doAjax(u);
		
		
		return p;
	}



