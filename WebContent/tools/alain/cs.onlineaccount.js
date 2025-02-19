
$(document).ready(function() {

	$('.refusersonlineaccount').click(function(e) {
		var refuserid = $(this).attr('refuserid');
		refusersonlineaccount(refuserid);
	});
	
	
	
});



function refusersonlineaccount(id) {
	var url = '/cs/json/post.jsp?_id='+id;
	url += '&_entity='+entity;
	url += '&_type='+type;
	url += '&_grp=people';
	url += '&_grptype=users';
	url += '&_request=refuseronlineaccount';
	var r = doAjax(url);
	var id = r.id;
	if (id && id > 0) {
		swal({
			title: 'Create/Reset Online Account',
			text: 'Are you sure you want to create or reset this user\'s online acount? This functiion will send an email to the user with a temporary password.',
			type: "warning",
			showCancelButton: true,
			confirmButtonColor: "#DD6B55",
			confirmButtonText: 'Yes',
			cancelButtonText: 'No',
			closeOnConfirm: true,
			closeOnCancel: true
		},
		function(isConfirm) {
			if (isConfirm) {
				var msg = r.message;
				swal(msg);
			}
		});
	}
}
