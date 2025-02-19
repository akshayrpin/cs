
(function($){
	$.fn.csact = function(options) {

		var defaults = {
			ajaxurl: 'action.jsp',
			action: '',
			entity: '',
			type: '',
			typeid: '',
			_delete: {
			},
			defaults: {
				_delete: {
					confirm: {
						title: 'DELETE',
						text : 'Are you sure you want to delete this record?',
						button: 'Yes, delete it!',
						cancel: 'No, cancel action!',
						success: 'Success',
						successtext: 'The selected record has been deleted.'
					},
					prompt : {
						title: 'NOTES',
						text: 'Please enter your notes for this action.',
						required: false
					},
					remove: true
				},
				_primary: {
					confirm: {
						title: 'SET PRIMARY',
						text : 'Are you sure you want to set this as the primary contact?',
						button: 'Yes, set primary contact!',
						cancel: 'No, cancel action!',
						success: 'Success',
						successtext: 'The selected contact has been set as primary.'
					},
					remove: false,
					radio: true

				},
				_unprimary: {
					confirm: {
						title: 'REMOVE PRIMARY',
						text : 'Are you sure you want to remove this as the primary contact?',
						button: 'Yes, remove primary!',
						cancel: 'No, cancel action!',
						success: 'Success',
						successtext: 'The selected contact has been removed as primary.'
					},
					remove: false,
					radio: true

				},
				_complete: {
					confirm: {
						title: 'COMPLETE',
						text : 'Are you sure you want to mark this record complete?',
						button: 'Yes, mark it complete!',
						cancel: 'No, cancel action!',
						success: 'Success',
						successtext: 'The selected record has marked complete.'
					},
					prompt : {
						title: 'NOTES',
						text: 'Please enter your notes for this action.',
						required: false
					},
					src: '/cs/images/icons/complete.png',
					chvalue: 'Y',
					chaction: 'incomplete',
					remove: false

				},
				_incomplete: {
					confirm: {
						title: 'INCOMPLETE',
						text : 'Are you sure you want to mark this record incomplete?',
						button: 'Yes, mark it incomplete!',
						cancel: 'No, cancel action!',
						success: 'Success',
						successtext: 'The selected record has marked incomplete.'
					},
					prompt : {
						title: 'NOTES',
						text: 'Please enter your notes for this action.',
						required: false
					},
					src: '/cs/images/icons/incomplete.png',
					chvalue: 'N',
					chaction: 'complete',
					remove: false

				},
				_comply: {
					confirm: {
						title: 'COMPLY',
						text: 'Are you sure you want to mark this resolution complied?',
						button: 'Yes',
						cancel: 'No',
						success: 'Success',
						successtext: 'The selected resolution has been marked complied.'
					},
					prompt : {
						title: 'NOTES',
						text: 'Please enter your notes for this action.',
						required: false
					},
					src: '/cs/images/icons/part-complete.png',
					chvalue: 'Y',
					chaction: 'uncomply',
					yesrelsrc: '/cs/images/icons/complete.png',
					relsrc: '/cs/images/space.gif',
					remove: false

				},
				_uncomply: {
					confirm: {
						title: 'REMOVE COMPLIANCE',
						text: 'Are you sure you want to mark this resolution not complied?',
						button: 'Yes',
						cancel: 'No',
						success: 'Success',
						successtext: 'The selected resolution has been marked not complied.'
					},
					prompt : {
						title: 'NOTES',
						text: 'Please enter your notes for this action.',
						required: false
					},
					src: '/cs/images/icons/incomplete.png',
					chvalue: 'N',
					chaction: 'comply',
					relsrc: '/cs/images/space.gif',
					remove: false

				},
				_appcomply: {
					confirm: {
						title: 'APPLICATION COMPLY',
						text: 'Are you sure you want to mark this resolution complied?',
						button: 'Yes',
						cancel: 'No',
						success: 'Success',
						successtext: 'The selected resolution has been marked complied.'
					},
					prompt : {
						title: 'NOTES',
						text: 'Please enter your notes for this action.',
						required: false
					},
					src: '/cs/images/icons/part-complete.png',
					chvalue: 'Y',
					chaction: 'appuncomply',
					yesrelsrc: '/cs/images/icons/complete.png',
					relsrc: '/cs/images/space.gif',
					remove: false

				},
				_appuncomply: {
					confirm: {
						title: 'REMOVE APPLICATION COMPLIANCE',
						text: 'Are you sure you want to mark this resolution not complied?',
						button: 'Yes',
						cancel: 'No',
						success: 'Success',
						successtext: 'The selected resolution has been marked not complied.'
					},
					prompt : {
						title: 'NOTES',
						text: 'Please enter your notes for this action.',
						required: false
					},
					src: '/cs/images/icons/incomplete.png',
					chvalue: 'N',
					chaction: 'appcomply',
					relsrc: '/cs/images/space.gif',
					remove: false

				},
				_error: {
					title: 'cs500',
					text: 'An unspecified error has occured.'
				}
			},
			callback: {
				success: null,
				error: null
			},
			ajaxsubmit: true
	  	};  

		var opts = $.extend(defaults, options);
		$.ajaxSetup({ cache:false });
		var len = this.length - 1;

		return this.each(function(i) {
			var org = $(this);
			init(org);
		});

		function init(elem) {
			if (hasValue(elem)) {
				var action = elem.attr('_action');
				if (!hasValue(action)) { action = opts.action; }
				if (hasValue(action)) {
					elem.css({
						'cursor': 'pointer'
					});
					try { elem.click(function() {
						doAct(elem); });
					} catch (e) { }
				}
			}
		}

		function getValue(action, group, type, field) {
			action = '_'+action;
			var v = '';
			try { v = opts[action][group][type][field]; } catch (e) { }
			if (!hasValue(v)) {
				try { v = opts['defaults'][action][type][field]; } catch (e) { }
			}
			if (!hasValue(v)) { v = ''; }
			return v;
		}

		function getRemove(action, group) {
			action = '_'+action;
			var v = false;
			try { v = opts[action][group]['remove']; } catch (e) { }
			if (!hasValue(v)) {
				try { v = opts['defaults'][action]['remove']; } catch (e) { }
			}
			return v;
		}

		function getRadio(action, group) {
			action = '_'+action;
			var v = false;
			try { v = opts[action][group]['radio']; } catch (e) { }
			if (!hasValue(v)) {
				try { v = opts['defaults'][action]['radio']; } catch (e) { }
			}
			return v;
		}

		function getChvalue(action, group) {
			action = '_'+action;
			var v = '';
			try { v = opts[action][group]['chvalue']; } catch (e) { }
			if (!hasValue(v)) {
				try { v = opts['defaults'][action]['chvalue']; } catch (e) { }
			}
			return v;
		}

		function getChaction(action, group) {
			action = '_'+action;
			var v = '';
			try { v = opts[action][group]['chaction']; } catch (e) { }
			if (!hasValue(v)) {
				try { v = opts['defaults'][action]['chaction']; } catch (e) { }
			}
			return v;
		}

		function getSrc(action, group) {
			action = '_'+action;
			var v = '';
			try { v = opts[action][group]['src']; } catch (e) { }
			if (!hasValue(v)) {
				try { v = opts['defaults'][action]['src']; } catch (e) { }
			}
			return v;
		}

		function getRelSrc(action, group) {
			action = '_'+action;
			var v = '';
			try { v = opts[action][group]['relsrc']; } catch (e) { }
			if (!hasValue(v)) {
				try { v = opts['defaults'][action]['relsrc']; } catch (e) { }
			}
			return v;
		}

		function getYesRelSrc(action, group) {
			action = '_'+action;
			var v = '';
			try { v = opts[action][group]['yesrelsrc']; } catch (e) { }
			if (!hasValue(v)) {
				try { v = opts['defaults'][action]['yesrelsrc']; } catch (e) { }
			}
			return v;
		}

		function getAlert(action, group) {
			action = '_'+action;
			var v = '';
			try { v = opts[action][group]['alert']; } catch (e) { }
			if (!hasValue(v)) {
				try { v = opts['defaults'][action]['alert']; } catch (e) { }
			}
			return v;
		}

		function doAct(elem) {
			var _grp = elem.attr('_grp');
			if (hasValue(_grp)) {
				var action = elem.attr('_action');
				var alrt = getAlert(action, _grp);
				if (hasValue(alrt)) {
					title = alrt['title'];
					text = alrt['text'];
					swal(title, text, 'info');
				}
				else {
					swal(
						{
							title: getValue(action, _grp, 'confirm', 'title'),
							text: getValue(action, _grp, 'confirm', 'text'),
							type: "warning",
							showCancelButton: true,
							confirmButtonColor: "#DD6B55",
							confirmButtonText: getValue(action, _grp, 'confirm', 'button'),
							cancelButtonText: getValue(action, _grp, 'confirm', 'cancel'),
							closeOnConfirm: false,
							closeOnCancel: true
						},
						function(isConfirm) {
							if (isConfirm) {
								var data = null;
								var i = getValue(action, _grp, 'prompt', 'name');
								if (hasValue(i)) {
									swal(
										{
											title: getValue(action, _grp, 'prompt', 'title'),
											text: getValue(action, _grp, 'prompt', 'text'),
											type: "input",
											showCancelButton: true,
											closeOnConfirm: false,
											animation: "slide-from-top",
											inputPlaceholder: getValue(action, _grp, 'prompt', 'placeholder')
										},
										function(inputValue) {
											var r = getValue(action, _grp, 'prompt', 'required');
											if (hasValue(r) && r == true) {
												if (inputValue === false) { return false; }
												else if (inputValue === "") {
													swal.showInputError("You need to write something!");
													return false
												}
												else {
													doPost(elem, action, inputValue);
												}
											}
											else {
												doPost(elem, action, '');
											}
										}
									);
								}
								else {
									doPost(elem, action, '');
								}
							}
						}
					);
				}
			}
		}

		function doPost(elem, action, note) {
			var map = getMap(elem, action, note);
			var data = doAjax(opts.ajaxurl, map);
			var mcode = '';
			var msg = '';
			if (hasValue(data)) {
				try { mcode = data['messagecode']; } catch (e) { mcode = ''; }
				try {
					msga = data['messages'];
					if (hasValue(msga) && msga.length > 0) {
						msg = msga[0];
					}
				} catch (e) { msg = ''; }
			}
			if (!hasValue(mcode) || mcode != 'cs200') {
				if (!hasValue(mcode)) { mcode = opts.defaults._error.title; }
				if (!hasValue(msg)) { msg = opts.defaults._error.text; }
				doAlert(mcode, msg, "error");
				if (opts.callback.error != null) {
					try { 
						var s = opts.callback.error.call(s, elem, data);
					} catch (e) { }
				}
			}
			else {
				var _grp = elem.attr('_grp');
				doTimedMessage(getValue(action, _grp, 'confirm', 'success'), getValue(action, _grp, 'confirm', 'successtext'), "success");
				var rdiorow = getRadio(action, _grp);
				if (rdiorow) {
					doRadio(elem);
				}
				var rmvrow = getRemove(action, _grp);
				if (rmvrow) {
					removeRow(map);
				}
				else {
					var chvalue = getChvalue(action, _grp);
					if (hasValue(chvalue)) {
						elem.attr('_val', chvalue);
					}
					var chaction = getChaction(action, _grp);
					if (hasValue(chaction)) {
						elem.attr('_action', chaction);
					}
					var src = getSrc(action, _grp);
					if (hasValue(src)) {
						elem.attr('src', src);
					}
					var rel = elem.attr('_rel');
					if (hasValue(rel)) {
						var yrsrc = getYesRelSrc(action, _grp);
						var rsrc = getRelSrc(action, _grp);
						if (hasValue(yrsrc)) {
							var isy = true;
							var y = $('[_rel='+rel+']');
							y.each(function() {
								var v = $(this).attr('_val');
								if (v.toLowerCase() != 'y') {
									isy = false;
								}
							});
							if (isy) {
								$('[_relid='+rel+']').attr('src', yrsrc);
							}
							else if (hasValue(rsrc)) {
								$('[_relid='+rel+']').attr('src',rsrc);
							}
						}
						else if (hasValue(rsrc)) {
							$('[_relid='+rel+']').attr('src',rsrc);
						}
					}
				}
				if (opts.callback.success != null) {
					try { 
						var s = opts.callback.success.call(s, elem, data);
					} catch (e) { }
				}
			}
		}

		function doRadio(elem) {
			var v = elem.attr('_val');
			var d = elem.attr('_deflt');
			var rdio = elem.attr('_radio');
			var y = elem.attr('_yes');
			var n = elem.attr('_no');
			var igrp = $('img[_radio='+rdio+']');
			igrp.attr('_val', 'N');
			igrp.attr('_action', y);
			igrp.attr('src', '/cs/images/icons/incomplete.png');

			var dgrp = $('img[_radio='+rdio+'][_deflt=Y]');
			dgrp.attr('src', '/cs/images/icons/default-complete.png');

			if (v != 'Y') {
				elem.attr('_val', 'Y');
				elem.attr('_action', n);
				elem.attr('src', '/cs/images/icons/complete.png');
			}
		}

		function removeRow(map) {
			var d = $('#tr_'+map._grp+'_'+map._grpid+'_'+map._id);
			try {
				if (hasValue(d)) {
					d.empty();
					d.remove();
				}
			} catch (e) { }
		}


		function getMap(elem, action, note) {
			var d = {
				_act: action,
				_ent: opts.entity,
				_type: opts.type,
				_typeid: opts.typeid,
				_grp: elem.attr('_grp'),
				_grptype: elem.attr('_grp'),
				_grpid: elem.attr('_grpid'),
				_ref: elem.attr('_ref'),
				_refid: elem.attr('_refid'),
				_id: elem.attr('_id'),
				'NOTES': note
			}
			return d;
		}

	};

})(jQuery);

