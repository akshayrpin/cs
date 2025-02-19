	
	var spritesurl = '/cs/tools/alain/sprites.png';
	var csui_url = '/cs/process';
	var csui_search_url = '/cs/br_search.jsp';
	var csui_panel_url = '/cs/br_panel.jsp';
	var csui_panels_url = '/cs/br_panels.jsp';
	var csui_children_url = '/cs/br_children.jsp';
	var csui_subpanel_url = '/cs/br_subpanel.jsp';
	var csui_menus = {};

	var csui_item_urls = {
			search: '/cs/br_search.jsp',
			root: '/cs/br_panel.jsp',
			children: '/cs/br_children.jsp'
	};

	var csui_link_urls = {
			summary: '/cs/summary.jsp',
			cart: '/cs/cart.jsp',
		
			reverse: '/cs/reverse.jsp'
	};

	function retrieve(item, requesttype) {
		
		
		var url = '';
		if (hasValue(requesttype)) {
			if (hasValue(item.action) && item.action == 'search') {
				
				url = csui_item_urls.search;
			}
			else if (hasValue(item.url)) {
				url = item.url;
			}
			else if (hasValue(csui_item_urls[requesttype])) {
				url = csui_item_urls[requesttype];
			}
			else {
				url = csui_item_urls.root;
			}
		}
		else {
//			url = csui_item_urls.root;
		}
		cslog(url, 'Retrieve');
		var r = doAjax(url, item);
		return r;
	}

	function csTree(item, treeid) {
		var r = undefined;
		if (hasValue(item)) {
			cserror(item);
			var jtitle = item['title'];
			var jimage = item['image'];
			var jalert = item['alerts'];
			if (hasValue(jtitle) || hasValue(jimage)) {
				var conttype = containerType(treeid);
				var dataid = item['dataid'];
				var jdesc = item['description'];
				var child = item['child'];
				var type = item['type'];
				var exp = item['expired'];
				if (!hasValue(child)) { child = item['type']; }

				r = $('<div/>');
				r.attr('dataid', item['dataid']);
				r.attr('type', type);
				r.attr('child', child);
				r.attr('entity', item['entity']);
				r.attr('treeid', treeid);
				r.attr('itemid', type.toLowerCase()+item['dataid']);
				r.addClass('cs_tree_box');
				r.css({
					'font-size': '0px'
				})

				var ce = $('<div/>');
				ce.attr('treeid', treeid);
				ce.css(inline());
				ce.addClass('cs_tree');
				styleTree(ce, conttype);
				if (hasValue(jalert)) {
					$.each(jalert, function(k, al){
						ce.addClass('br_'+al);
					});
				}
	
				if (hasValue(jimage)) {
					var img = $('<img/>');
					img.attr('src', jimage);

					if (hasValue(jdesc)) {
						img.attr('title', jdesc);
					}
					ce.append(img);
				}
				if (hasValue(jtitle)) {
					var fnt = $('<span/>');
					if (exp) {
						fnt.addClass('br_expired');
					}
					fnt.html(jtitle);
					fnt.attr('title', jdesc);
//					try {
//						fnt.tooltipster({
//							theme: 'tooltipster-cs',
//							side: 'right'
//						});
//					}
//					catch(e) {}
					ce.append(fnt);
				}
				if (treeid == 'menu') {
					csui_menus[dataid] = function() {
						$('.cs_highlight[treeid='+treeid+']').removeClass('cs_highlight');
						ce.addClass('cs_highlight');
						clearNext(treeid);
						setSelected(type, dataid, treeid);
						forwardPanels(treeid, item);
						minimizeTree(treeid);
					}
				}
				ce.click(function() {
					$('.cs_highlight[treeid='+treeid+']').removeClass('cs_highlight');
					ce.addClass('cs_highlight');
					clearNext(treeid);
					setSelected(type, dataid, treeid);
					forwardPanels(treeid, item);
					minimizeTree(treeid);
				});

				if (isSelected(type, dataid, treeid)) {
					$('.cs_highlight[treeid='+treeid+']').removeClass('cs_highlight');
					ce.addClass('cs_highlight');
					setSelected(type, dataid, treeid);
				}

				r.append(ce);

				if (isFollowed(type, dataid, treeid)) {
					forwardPanels(treeid, item);
					clearFollowed(treeid);
				}

				if (conttype != 'menu') {
					var jchild = item['children'];
					var nchild = 0;
					if (hasValue(jchild)) {
						try { nchild = parseInt(jchild); } catch(e) { }
					}
					if (nchild > 0) {
						treeButton(r); 
					}
					else { treeSpacing(r); }
				}

			}
		}
		return r;
	}

	function styleTree(div, conttype) {
		if (hasValue(div)) {
			if (conttype == 'menu') {
				div.css({
					'width':'100%',
					'cursor': 'pointer'
				});
			}
			else {
				div.css({
					'padding-left':'5px',
					'width':'calc(100% - 25px)',
					'cursor': 'pointer'
				});
			}
		}
	}

	function appendTree(div, item) {
		var r = false;
		if (hasValue(div)) {
			var treeid = div.attr('treeid');
			var t = csTree(item, treeid);
			if (hasValue(t)) {
				div.append(t);
				r = true;
			}
		}
		return r;
	}

	function appendTrees(div, items) {
		var r = false;
		if (hasValue(div)) {
			if (hasValue(items)) {
				var treeid = div.attr('treeid');
				$.each(items, function(k, item){
					var t = csTree(item, treeid);
					if (hasValue(t)) {
						div.append(t);
						r = true;
					}
				});
			}
		}
		return r;
	}

	function treeSpacing(e) {
		var button = $('<span/>');
		button.attr('treeid', e.attr('treeid'));
		button.css({
			'width': '20px',
			'height': '15px',
			'background-image': 'url('+spritesurl+')',
			'background-repeat': 'no-repeat',
			'background-position': '0px 0px',
			'display': 'inline-block',
			'*display': 'inline',
			'zoom': 1
		});
		e.prepend(button);
		return button;
	}

	function treeButton(e) {
		var button = undefined;
		if (hasValue(e)) {
			var treeid = e.attr('treeid');
			button = $('<div/>');
			button.attr('treeid', treeid);
			button.css({
				'width': '20px',
				'height': '15px',
				'background-image': 'url('+spritesurl+')',
				'background-repeat': 'no-repeat',
				'background-position': '-190px -240px',
				'display': 'inline-block',
				'*display': 'inline',
				'zoom': 1,
				'cursor': 'pointer',
				'vertical-align': 'top'
			});
			var d = undefined;
			button.click(function() {
				if (!d) { 
					d = activateTree(d, e, button, treeid);
					
					setExpanded(e.attr('type'), e.attr('dataid'), treeid);
				}
				else if (d) {
					if (d.is(':visible')) {
						d.hide();
						button.css({
							'background-position': '-190px -240px'
						});
						removeExpanded(e.attr('type'), e.attr('dataid'), treeid);
					}
					else {
						d.show();
						button.css({
							'background-position': '-190px -190px'
						});
						setExpanded(e.attr('type'), e.attr('dataid'), treeid);
					}
				}
			});
			if (isExpanded(e.attr('type'), e.attr('dataid'), treeid)) {
				if (!d) {
					d = activateTree(d, e, button, treeid);
				}
				d.show();
			}
			e.prepend(button);
		}
		return button;
	}

	function activateTree(div, parent, button, treeid) {
	
		if (!hasValue(div)) {
			var option = '';
			try {
				option = csui_panels[treeid].option;
			}
			catch (e) { }
			var config = {
				id: parent.attr('dataid'),
				type: parent.attr('child'),
				entity: parent.attr('entity'),
				option: option
			};
			var json = retrieve(config, 'children');
			div = $('<div/>');
			div.attr('treeid', treeid);
			var p = parent.css('padding-left');
			if (!hasValue(p)) { p = '0px'; }
			var pl = parseInt(p, 10) + 15;
			div.css({
				'padding-left': pl
			});
			button.css({
				'background-position': '-190px -190px'
			});
			appendTrees(div, json.items);
			parent.append(div);
		}
		return div;
	}

	function containerType(treeid) {
		var r = csui_panels[treeid].type;
		if (!hasValue(r)) { return 'tree'; }
		else { return r; }
	}

	function containerHide(treeid) {
		var r = csui_panels[treeid].hide;
		if (!hasValue(r) || r == 'true') { return true; }
		else { return false; }
	}

	function renderIframe(item, treeid) {
		
		var r = undefined;
		var t = item[treeid];
		
		if (hasValue(t)) {
			var url = csui_link_urls[t];
			
			if (!hasValue(url) && t.indexOf("http")<0) {
				url = '/cs/jsp/' + t.toLowerCase() + '.jsp';
			}
			if(url== undefined){
				url = t;
				cslog(url, 'IFrame-Sunz');
			}
			
			if (hasValue(url)) {
				url += '?_ent='+item['entity']+'&_type='+item['type']+'&_typeid='+item['dataid']+'&_id='+item['dataid'];
				cslog(url, 'IFrame');
				r = $('<iframe/>');
				r.attr('src', url);
				r.attr('frameBorder', '0');
				r.css({
					'width': '100%',
					'height': '100%',
					'border': '0px',
					'padding': '0px',
					'margin': '0px'
				});
			}
		}
		return r;
	}

	function linkIframe(url, treeid) {
		try {
			if (hasValue(url)) {
				cslog(url, 'IFrame');
				r = $('<iframe/>');
				r.attr('src', url);
				r.attr('frameBorder', '0');
				r.css({
					'width': '100%',
					'height': '100%',
					'border': '0px',
					'padding': '0px',
					'margin': '0px'
				});
				$('#link').html(r);
				$('#sub').hide();
			}
		}
		catch(e) { }
	}

	function createIframe(url, divid, iframeid) {
		var r = undefined;
		if (hasValue(url)) {
			r = $('<iframe/>');
			r.attr('name', iframeid);
			r.attr('id', iframeid);
			r.attr('src', url);
			r.attr('frameBorder', '0');
			r.css({
				'width': '100%',
				'height': '100%',
				'border': '0px',
				'padding': '0px',
				'margin': '0px'
			});
			var div = $('#'+divid);
			div.empty();
			div.append(r);
		}
		return r;
	}

	function renderPanel(divid, item, select) {
		var r = false;
		var div = $('#'+divid);
		var treeid = div.attr('treeid');
		if (!hasValue(treeid)) {
			treeid = divid;
			div.attr('treeid', divid);
		}
		var conttype = containerType(treeid);
		if (hasValue(div)) {
			div.empty();
			var o = jQuery.extend(true, {}, item);
			if (hasValue(o)) {
				if (conttype == 'iframe') {
					div.append(renderIframe(o, treeid));
				}
				else {
					div.addClass('cs_tree_loading');
					var c = $('<div/>');
					c.attr('treeid', treeid);
					var d = $('<div/>');
					d.attr('treeid', treeid);
					c.css({
						'position': 'relative',
						'width' : '100%',
						'height': '100%',
						'overflow-y': 'auto'
					});
					d.css({
						'position': 'absolute',
						'width' : '100%',
						'height': '100%',
						'z-index': '1'
					});
					var i = retrieve(o, 'root');
					if (hasValue(i)) {
						var header = i.header;
						if (hasValue(header)) {
							var label = i.header.label;
							if (hasValue(label)) {
								div.attr('label', label);
								d.append(renderLabel(label, treeid));
								r = true;
							}
							var options = i.header.options;
							var option = i.header.option;
							if (hasValue(options) && options.length && options.length > 0) {
								d.append(renderOptions(options, item, treeid, option));
							}
							try {
								csui_panels[treeid].option = option;
							}
							catch (e) { }
							var search = i.header.search;
							if (hasValue(search)) {
								var sdiv = renderSearch(search, treeid);
								if (hasValue(sdiv)) {
									d.append(sdiv);
								}
								r = true;
							}
							var msg = i.header.message;
							if (hasValue(msg)) {
								var mdiv = renderMessage(msg);
								if (hasValue(mdiv)) {
									d.append(mdiv);
								}
							}
							if (select) {
								var parents = i.header.parents;
								var type = i.header.type;
								var did = i.header.dataid;
								if (hasValue(parents)) {
									setParents(treeid, type, did, parents);
								}
							}
						}
						var pdid = csui_panels[treeid].item.dataid;
						var ptype = csui_panels[treeid].item.type;
						if (hasValue(ptype && pdid)) {
							setSelected(ptype, pdid, treeid);
						}
						if (appendTrees(d, i.root)) {
							r = true;
						}
					}
					c.append(d);
					c.addClass('cs_panel_content');

					div.append(c);
					div.removeClass('cs_tree_loading');
				}
			}
			if (!r && containerHide(treeid)) {
				div.hide();
			}
			else {
				div.show();
				maxTree(treeid);
			}
		}
		return r;
	}

	function renderPanels(select) {
		$.each(csui_panels, function(treeid, map) {
			cslog(map);
			renderPanel(treeid, map.item, select);
		});
	}

	function refreshPanels(treeid) {
		if (treeid == undefined || treeid == null || !hasValue(treeid)) {
			$.each(csui_panels, function(treeid, map) {
				var mnz = isMinimized(treeid);
				if (hasValue(treeid)) {
					refreshPanel(treeid)
					if (mnz) {
						minimizeTree(treeid);
					}
				}
			});
		}
		else {
			refreshNext(treeid);
		}
	}

	function refreshBrowsers(treeid) {
		if (treeid == undefined || treeid == null || !hasValue(treeid)) {
			$.each(csui_panels, function(treeid, map) {
				var ct = containerType(treeid);
				if (ct == 'menu' || ct == 'tree') {
					var mnz = isMinimized(treeid);
					if (hasValue(treeid)) {
						refreshPanel(treeid)
						if (mnz) {
							minimizeTree(treeid);
						}
					}
				}
			});
		}
		else {
			refreshNext(treeid);
		}
	}

	function renderBrowsers(select) {
		$.each(csui_panels, function(treeid, map) {
			cslog(map);
			var ct = containerType(treeid);
			if (ct == 'menu' || ct == 'tree') {
				var mnz = isMinimized(treeid);
				renderPanel(treeid, map.item, select)
				if (mnz) {
					minimizeTree(treeid);
				}
			}
		});
	}

	function refreshPanel(treeid) {
		if (hasValue(treeid)) {
			var b = false;
			var conttype = containerType(treeid);
			var i = csui_panels[treeid].item;
			renderPanel(treeid, i);
		}
	}

	function resetPanels() {
		clearSelected();
		clearFollowed();
		clearExpanded();
		resetConfig();
		renderPanels(true);
	}

	function openPanel(treeid, dataid, entity, type) {
		renderPanel(treeid, {'id':dataid,'entity':entity,'type':type});
	}

	function forwardPanels(treeid, item) {
		var b = false;
		$.each(csui_panels, function(tid, map) {
			if (b) {
				var conttype = containerType(tid);
				if (conttype == 'iframe') {
					renderPanel(tid, item);
					setPanel(item, tid);
				}
				else {
					var entity = item.entity;
					var type = item[tid];
					var id = item.dataid;
					var typeid = item.id;
					o = {
							'entity': entity,
							'type': type,
							'id': id
					}
					renderPanel(tid, o);
					setPanel(o, tid);
				}
			}
			if (treeid == tid) {
				b = true;
			}
		});
	}

	function clearNext(treeid) {
		var b = false;
		$.each(csui_panels, function(tid, map) {
			if (b) {
				clearExpanded(tid);
				clearSelected(tid);
				clearFollowed(tid);
				setPanel({}, tid);
				var div = $('[treeid='+tid+']');
				if (hasValue(div)) {
					div.empty();
					if(containerHide(tid)) {
						div.hide();
					}
				}
			}
			if (treeid == tid) {
				b = true;
			}
		});
	}

	function refreshNext(treeid) {
		var b = false;
		$.each(csui_panels, function(tid, map) {
			if (b) {
				var i = map.item;
				renderPanel(tid, i);
			}
			if (treeid == tid) {
				b = true;
			}
		});
	}

	function getPanels(entity, type, typeid, reference) {
		var p = retrievePanels(entity, type, typeid, reference);
		init(p);
		minimizeTrees();
	}

	function getBrowsers(e, t, tid, r) {
		var p = retrievePanels(e, t, tid, r);
		initBrowsers(p);
	}

	function init(panels) {
		csui_panels = jQuery.extend(true, {}, panels);
		csui_org_panels = jQuery.extend(true, {}, panels);
		renderPanels(true);
	}

	function initBrowsers(panels) {
		csui_panels = jQuery.extend(true, {}, panels);
		csui_org_panels = jQuery.extend(true, {}, panels);
		renderBrowsers(true);
	}

	function globalSearch() {
		var frm = $('#globalsearch');
		if (hasValue(frm)) {
			var inpt = $('#globalsearch_query');
			inpt.focus(function() {
				inpt.addClass('glsearch_on');
			});
			inpt.blur(function() {
				inpt.removeClass('glsearch_on');
			});
			frm.submit(function(e) {
				var q = inpt.val();
				e.preventDefault();
				hideTrees();
				var url = '/cs/search.jsp?sq='+q;
				createIframe(url, 'link', 'globalsearchresults');
		    });
		}
	}

	function publicSearch() {
		var frm = $('#publicsearch');
		if (hasValue(frm)) {
			var inpt = $('#publicsearch_query');
			inpt.focus(function() {
				inpt.addClass('glsearch_on');
			});
			inpt.blur(function() {
				inpt.removeClass('glsearch_on');
			});
			frm.submit(function(e) {
				var q = inpt.val();
				e.preventDefault();
				hideTrees();
				var url = '/cs/psearch.jsp?sq='+q;
				createIframe(url, 'link', 'publicsearchresults');
		    });
		}
	}

	$(document).ready(function() {
		globalSearch();
		publicSearch();
		var bkmrk = $('#view_bookmark');
		bkmrk.css({
			'cursor': 'pointer'
		});
		bkmrk.click(function() {
			hideTrees();
			var url = '/cs/bookmark.jsp';
			createIframe(url, 'link', 'bookmarks');
		});
	});


