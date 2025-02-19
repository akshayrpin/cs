
$(document).ready(function() {
	doReview();
	$('input[itype=comboreviewdate]').datetimepicker({
		timepicker:false,
		format:'Y/m/d'
	});
	$('input[itype=comboreviewdate]').change(function() {
		var sd = $(this);
	});
	$('#addreviewbutton').click(function() {
		showReviewAdd();
	});
	$('#closereviewbutton').click(function() {
		hideReviewAdd();
	});
//	$('[actionid]').click(function() {
//		var id = $(this).attr('actionid');
//		toggleReviewInfo(id);
//	});
});

function showReviewAdd() {
	var rform = $('#addreview');
	$('#addreviewbutton').hide();
	$('#closereviewbutton').show();
	rform.show('fast');
}

function hideReviewAdd() {
	var rform = $('#addreview');
	$('#addreviewbutton').show();
	$('#closereviewbutton').hide();
	rform.hide('fast');
	clearReviewForm('addform');
}

function clearReviewForm(formid) {
	remove_val_alert();
	var select = $('#'+formid+' select[itype=review]');
	select.val('');
	try { select.trigger("chosen:updated"); } catch (e) { }

	var statslct = $('#'+formid+' select[itype=reviewstatus]');
	statslct.val('');
	statslct.empty();
	try { statslct.trigger("chosen:updated"); } catch (e) { }

	var stteam = $('#'+formid+' select[itype=reviewteam]');
	stteam.val('');
	stteam.empty();
	try { stteam.trigger("chosen:updated"); } catch (e) { }
	hideReviewTeam(formid);

	var sttime = $('#'+formid+' select[itype=time]');
	sttime.val('');
	sttime.empty();
	try { sttime.trigger("chosen:updated"); } catch (e) { }

	var stavailability = $('#'+formid+' input[itype=availability]');
	stavailability.val('');

	hideReviewAvailability(formid);

	var stcomments = $('#'+formid+' textarea[name=REVIEW_COMMENTS]');
	stcomments.val('');
}


function doReview() {
	var rv = $('#addform select[itype=review]');
	rv.change(function() {
		hideReviewAvailability('addform');
		doReviewTeam('addform',rv.val());
		doReviewStatus('addform',rv.val());
		var dtd = rv.find('option:selected').attr('days_till_due');
		if (dtd == 0) {
			showDueDate('addform');
		}
		else {
			hideDueDate('addform');
		}
	});
}

function doReviewTeam(formid, reviewid) {
	var st = $('#'+formid+' select[itype=reviewteam]');
	if (hasValue(st)) {
		var u = '_id=' + reviewid + '&_type=' + type + '&_typeid=' + typeid + '&_grptype=review&_request=team';
		console.log(u);
		st.empty();
		st.attr('json', u);
		st.attr('auto','false');
		jsonSelect(st, 'choices');
		try {
			select.trigger("chosen:updated");
		} catch(e) {}
	}
}

function doInspectors(formid, reviewid) {
	var st = $('#'+formid+' select[itype=inspectors]');
	if (hasValue(st)) {
		var u = '_id=' + reviewid + '&_type=' + type + '&_typeid=' + typeid + '&_revrefid='+reviewrefid+'&_grptype=review&_request=inspectors';
		console.log(u);
		st.empty();
		st.attr('json', u);
		st.attr('auto','false');
		jsonSelect(st, 'choices');
		try {
			select.trigger("chosen:updated");
		} catch(e) {}
	}
}

function doReviewStatus(formid, reviewid, availabilityid) {
	var st = $('#'+formid+' select[itype=reviewstatus]');
	if (hasValue(st)) {
		var rv = $('#addform select[itype=review]');
		var u = '_id=' + reviewid + '&_type=' + type + '&_typeid=' + typeid + '&_grptype=review&_request=reviewstatus';
//		var u = '_id=' + reviewid + '&_type=review&_request=reviewstatus';
		st.empty();
		st.attr('json', u);
		st.attr('auto','false');
		jsonSelect(st, 'choices');
		try {
			select.trigger("chosen:updated");
		} catch(e) {}
		st.change(function() {
			var avid = rv.find('option:selected').attr('AVAILABILITY_ID');
			var lgid = st.find('option:selected').attr('library_group_id');
			var sched = st.find('option:selected').attr('schedule');
			var tm = st.find('option:selected').attr('assign');
			var att = st.find('option:selected').attr('attachment');
			var sdtd = st.find('option:selected').attr('days_till_due');
			hideReviewAvailability(formid);
			hideCollaborators(formid);
			hideReviewTeam(formid);
			hideAttachment(formid);
			hideLibrary(formid);
			if (sched == 'Y') {
				showReviewAvailability(formid, comboid, reviewid, st.val(), avid);
				showInspectors(formid, reviewid);
				showCollaborators(formid);
			}
			if (tm == 'Y') {
				showReviewTeam(formid, reviewid);
			}
			if (att == 'Y') {
				showAttachment(formid);
			}
			if (hasValue(lgid) && parseInt(lgid) > 0) {
				showLibrary(formid, lgid);
			}
			try {
				var sdtdint = parseInt(sdtd);
				if (sdtdint > 0) {
					var now = new Date();
					now.setDate(now.getDate()+sdtdint);
			        var day=now.getDate();
			        var mon=now.getMonth()+1;
			        var year=now.getFullYear();
			        var duedate = year+"/"+mon+"/"+day;
			        updateDueDate(formid, duedate)
				}
			} catch(e) { }
			
		});
	}
}

function showReviewAvailability(formid, reviewgroupid, reviewid, statusid, availabilityid) {
	var avid = parseInt(availabilityid);
	if (avid > 0) {
		jsonAvailabilityDate($('#'+formid+' [itype=availability]'), $('#'+formid+' [itype=time]'), entity, "review", comboid, parseInt(reviewgroupid)*-1, reviewid, statusid);
		$('#'+formid+'_availability').show();
	}
}

function showReviewTeam(formid, reviewid) {
	if (formid == 'addreview') {}
	else {
		$('#'+formid+'_team').show();
		$('#'+formid+' [itype=reviewteam]').addClass('required');
		doReviewTeam(formid, reviewid);
	}
}

function showInspectors(formid, reviewid) {
	if (formid == 'addreview') {}
	else {
		$('#'+formid+'_inspectors').show();
//		$('#'+formid+' [itype=inspectors]').addClass('required');
		doInspectors(formid, reviewid);
	}
}

function showAttachment(formid) {
	if (formid == 'addreview') {}
	else {
		$('#'+formid+'_attach').show();
		$('#'+formid+'_attach_desc').show();
	}
}

function showCollaborators(formid) {
	if (formid == 'addreview') {}
	else {
		$('#'+formid+'_collaborators').show();
		$('#'+formid+'_collaborators_desc').show();
	}
}

function showDueDate(formid) {
	if (formid == 'addreview') {}
	else {
		$('#'+formid+'_reviewduedate').show();
	}
}

function updateDueDate(formid, due) {
	if (formid == 'addreview') {}
	else {
		$('#'+formid+'_reviewduedate').show();
		$('input[itype=reviewduedate]').val(due);
	}
}

function hideDueDate(formid) {
	if (formid == 'addreview') {}
	else {
		$('#'+formid+'_reviewduedate').hide();
	}
}

function hideReviewAvailability(formid) {
	$('#'+formid+'_availability').hide();
}

function hideCollaborators(formid) {
	$('#'+formid+'_collaborators').hide();
}

function hideReviewTeam(formid) {
	if (formid == 'addreview') {}
	else {
		$('#'+formid+'_team').hide();
		$('#'+formid+' [itype=reviewteam]').removeClass('required');
	}
}

function hideAttachment(formid) {
	if (formid == 'addreview') {}
	else {
		$('#'+formid+'_attach').hide();
		$('#'+formid+'_attach_desc').hide();
	}
}

function toggleReviewInfo(id) {
	var i = $('#info_'+id);
	if (i.is(':hidden')) {
		i.show();
	}
	else {
		i.hide();
	}
}

function hideLibrary(formid) {
	$('#'+formid+'_reviewcomment td img').hide();
}

function showLibrary(formid, groupid) {
	if (hasValue(groupid)) {
		var lgid = parseInt(groupid);
		if (lgid > 0) {
			$('#'+formid+' input[name=LIBRARY_GROUP_ID]').val(groupid);
			var img = $('#'+formid+'_reviewcomment td img');
			img.show();
			img.click(function() {
				var grid = $('#'+formid+' input[name=LIBRARY_GROUP_ID]').val();
				if (!hasValue(grid) || grid < 1) {
					swal('Validation Error','Unknown library group','error');
				}
				else {
					var lurl = 'library.jsp?form='+formid+'&_ent='+entity+'&_type='+type+'&_typeid='+typeid+'&_id='+grid;
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

		}
	}
}













